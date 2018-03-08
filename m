Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755813AbeCHMFx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:05:53 -0500
Received: from mail.bootlin.com ([62.4.15.54]:46811 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbeCHMFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:05:51 -0500
Date: Thu, 8 Mar 2018 13:05:49 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 3/4] rtc: isl1208: add support for isl1219 with tamper
 detection
Message-ID: <20180308120549.GG20370@piout.net>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
 <1520246373-19023-4-git-send-email-Denis.Osterland@diehl.com>
 <20180306204255.GI3035@piout.net>
 <1520410754.5976.27.camel@diehl.com>
 <20180307104714.GL3035@piout.net>
 <1520509988.5415.17.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520509988.5415.17.camel@diehl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 at 11:53:09 +0000, Denis OSTERLAND wrote:
> Am Mittwoch, den 07.03.2018, 11:47 +0100 schrieb Alexandre Belloni:
> > > > > +
> > > > > +	tv64.tv_sec = rtc_tm_to_time64(&tm);
> > > > Why not using an unsigned long long directly here? time64_t is not the
> > > > correct type.
> > > Do you mean timespec64 is not the correct type here?
> > > Then yes, sould be time64_t.
> > > If you mean time64_t is not the correct type here,
> > > then can you give me some detail why there is no rtc_tm_to_u64,
> > > or something like that?
> > The rtc subsystem forbids negative times, the proper type should be
> > unsigned.
> I will add rtc_vaild_tm check.
> 
> Which sequence for time conversion would you expect?
> 
> time64_t secs = rtc_tm_to_time64(&tm);
> BUG_ON(secs < 0);
> return sprintf(buf, "%llu\n", (unsigned long long)secs);
> 
> or
> 
> return sprintf(buf, "%llu\n", (unsigned long long)rtc_tm_to_time64(&tm));

rtc_vaild_tm will already return EINVAL in case of negative time so this
is the one you should use.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
