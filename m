Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2C1C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6DE208A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="BtytHauA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6DE208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeGGVUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:20:00 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:36219 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754328AbeGGVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R/MMaMLKm2de/krOYuiq7iY+AguQCwcHfgvRYHYikbo=; b=BtytHauAkFxLwo1Og3JJm7x6Qb
        sfm0Rxed5Sh6HLWnIQFJXVz8tFTFG2Qeq4StG+2ya6qUI9496vLLbubPjVygetl2XQSsTEwWpByqm
        qVMXpKH3W/XkdK66VlhZZSg5breh9dZPtV8zCkiEKqzEYk4AjX8Ux0yy11T/TdddQQmpEbTQxrgd7
        X6z200hrn8GczGo6ZOfbD0j7NWzfaATVbCOXpEENPyG8Q/hCYVpOeVd0i+Eq+oZpzIWCU1+wZxON+
        RyMhmpzA6hLiT7D/HFlMH8gmz7A9cnDpeHGRuQQO4Pa8gh706atnc6iKWw7b5AsPIotOS6PIhzskj
        bDg0p9uQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43758 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fbucT-00Gf1W-MZ; Sat, 07 Jul 2018 21:19:55 +0000
Date:   Sat, 7 Jul 2018 14:19:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Tian, Baofeng" <baofeng.tian@intel.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
Message-ID: <20180707211952.GA1951@roeck-us.net>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
 <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:25:17AM +0000, Tian, Baofeng wrote:
> Hi, Roeck
> 
> This is an interface from android, with this interface, android can avoid reboot if user want to make it.
> the watchdog use space daemon you mentioned is always there in android, and if remove/disable this daemon system will reboot.
> 
> Keep this simple interface can make "disable reboot" easily.
> 

This would be required in each watchdog driver and add messy code
into the kernel just because Android userspace can not handle
the situation. NACK from my side. There has to be a better solution.

Guenter

> Thanks
> Tim
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Thursday, July 5, 2018 9:05 PM
> To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
> 
> On 07/04/2018 11:28 PM, Tian, Baofeng wrote:
> > Hi, Roeck
> > 
> > Yes, this patch is for add a parameter to TCO to prevent reboot happen 
> > if you don't want to reboot system and want to stay here to check some HW status, logs, etc for debug purpose.
> > 
> > Under some android related stability test, developer want to stay at 
> > the crash and use debug tools(LTB) to check more information, this is the purpose of this patch.
> > 
> The watchdog doesn't even start with the module parameter set.
> If the purpose is to disable the watchdog, just stop it by closing the watchdog daemon, or don't run the watchdog daemon in the first place, or blacklist the module.
> 
> Guenter
> 
> > Thanks
> > Tim
> > 
> > -----Original Message-----
> > From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter 
> > Roeck
> > Sent: Monday, July 2, 2018 9:21 PM
> > To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; 
> > linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" 
> > for iTCO
> > 
> > On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
> >> From: "Tian, Baofeng" <baofeng.tian@intel.com 
> >> <mailto:baofeng.tian@intel.com>>
> >> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for 
> >> iTCO
> >>
> >> Setting "force_no_reboot" parameter to true (y/Y/1) will have the 
> >> effect to prevent to reset the NO_REBOOT flag thus preventing the 
> >> iTCO to reboot the platform, if not set or set to false, then system 
> >> will reboot after about 30s.
> >>
> >> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com 
> >> <mailto:baofeng.tian@intel.com>>
> > 
> > Your e-mail address is messed up.
> > 
> >> ---
> >>    drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
> >>    1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/watchdog/iTCO_wdt.c 
> >> b/drivers/watchdog/iTCO_wdt.c index 347f038..255318b 100644
> >> --- a/drivers/watchdog/iTCO_wdt.c
> >> +++ b/drivers/watchdog/iTCO_wdt.c
> >> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int, 
> >> 0);
> >>    MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
> >>         "Turn off SMI clearing watchdog (depends on 
> >> TCO-version)(default=1)");
> >>
> >> +static bool force_no_reboot;
> >> +module_param(force_no_reboot, bool, 0); 
> >> +MODULE_PARM_DESC(force_no_reboot,
> >> +           "Prevents the watchdog rebooting the platform 
> >> +(default=0)");
> >> +
> >>    /*
> >>     * Some TCO specific functions
> >>     */
> >> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device
> >> *wd_dev)
> >>         struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
> >>         unsigned int val;
> >>
> >> +     /* force_no_reboot will prevent to unset NO_REBOOT bit */
> >> +     if (force_no_reboot)
> >> +           return -EIO;
> >> +
> > It seems to me that this flag prevents the watchdog from being started, and on top it would return an unreasonable error (-EIO).
> > 
> > I don't see the point of this patch, sorry.
> > 
> > Guenter
> > 
> >>         spin_lock(&p->io_lock);
> >>
> >>         iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout); @@ -250,7
> >> +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
> >>         /* disable chipset's NO_REBOOT bit */
> >>         if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
> >>               spin_unlock(&p->io_lock);
> >> -           pr_err("failed to reset NO_REBOOT flag, reboot disabled 
> >> by hardware/BIOS\n");
> >> +           pr_err("failed to reset NO_REBOOT flag, reboot disabled 
> >> +by hardware/BIOS/rc_cmd\n");
> >>               return -EIO;
> >>         }
> >>
> >> --
> >> 2.7.4
> >>
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-watchdog" in the body of a message to majordomo@vger.kernel.org 
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
