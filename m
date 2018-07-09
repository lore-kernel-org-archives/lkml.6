Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A58C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37220208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37220208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933418AbeGIAt5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:49:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:10683 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933273AbeGIAtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:49:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2018 17:49:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,327,1526367600"; 
   d="scan'208";a="244000374"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jul 2018 17:49:54 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 8 Jul 2018 17:49:54 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sun, 8 Jul 2018 17:49:54 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.173]) with mapi id 14.03.0319.002;
 Mon, 9 Jul 2018 08:49:52 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: add module parameter "force_no_reboot" for
 iTCO
Thread-Topic: [PATCH] watchdog: add module parameter "force_no_reboot" for
 iTCO
Thread-Index: AdQRzERd39h1dwuYSseIPoq6rlU1ggACTz7Q///d1oD/+zcZQIAJe3oA//5Zl8CABVVdAP/9rSUw
Date:   Mon, 9 Jul 2018 00:49:51 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E2A6A7@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
 <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
 <20180707211952.GA1951@roeck-us.net>
In-Reply-To: <20180707211952.GA1951@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGVmMjAxMTEtOGI4OC00NjdkLTljYWQtNzhmM2Y5YWMyMGRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVG1PN2VaSlpBXC9ZRXdqdTM2Q0JuaHRGeUpHU1Z0Q1UxU1VcL25JVGMyUDA5dDRlbUppck5ZTjlUa2JFZXVORUNHIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roeck

Thanks you spending time to review this patch, I accepted your conclusion.

Thanks
Tim
-----Original Message-----
From: Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Sunday, July 8, 2018 5:20 AM
To: Tian, Baofeng <baofeng.tian@intel.com>
Cc: wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO

On Fri, Jul 06, 2018 at 06:25:17AM +0000, Tian, Baofeng wrote:
> Hi, Roeck
> 
> This is an interface from android, with this interface, android can avoid reboot if user want to make it.
> the watchdog use space daemon you mentioned is always there in android, and if remove/disable this daemon system will reboot.
> 
> Keep this simple interface can make "disable reboot" easily.
> 

This would be required in each watchdog driver and add messy code into the kernel just because Android userspace can not handle the situation. NACK from my side. There has to be a better solution.

Guenter

> Thanks
> Tim
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter 
> Roeck
> Sent: Thursday, July 5, 2018 9:05 PM
> To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; 
> linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" 
> for iTCO
> 
> On 07/04/2018 11:28 PM, Tian, Baofeng wrote:
> > Hi, Roeck
> > 
> > Yes, this patch is for add a parameter to TCO to prevent reboot 
> > happen if you don't want to reboot system and want to stay here to check some HW status, logs, etc for debug purpose.
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
> >> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" 
> >> for iTCO
> >>
> >> Setting "force_no_reboot" parameter to true (y/Y/1) will have the 
> >> effect to prevent to reset the NO_REBOOT flag thus preventing the 
> >> iTCO to reboot the platform, if not set or set to false, then 
> >> system will reboot after about 30s.
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
> >> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct 
> >> watchdog_device
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
> >>         iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout); @@ 
> >> -250,7
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
> > linux-watchdog" in the body of a message to 
> > majordomo@vger.kernel.org More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > 
> 
