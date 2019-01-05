Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4AC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F431213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 21:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAEVTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 16:19:42 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfAEVTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 16:19:41 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gftLx-0005xk-ID; Sat, 05 Jan 2019 22:19:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gftLw-0008QG-TT; Sat, 05 Jan 2019 22:19:32 +0100
Date:   Sat, 5 Jan 2019 22:19:32 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v9 13/27] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20190105211932.yd7hgfkxmcaab3tf@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-14-paul@crapouillou.net>
 <20190105194559.jtwyx7th32saa6qh@pengutronix.de>
 <1546721566.29843.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546721566.29843.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Sat, Jan 05, 2019 at 05:52:46PM -0300, Paul Cercueil wrote:
> On Sat, Jan 5, 2019 at 4:45 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Dec 27, 2018 at 07:13:05PM +0100, Paul Cercueil wrote:
> > >  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > >  index 4ed003bc3d8d..0343f0c1238e 100644
> > >  --- a/drivers/pwm/Kconfig
> > >  +++ b/drivers/pwm/Kconfig
> > >  @@ -202,7 +202,8 @@ config PWM_IMX
> > >   config PWM_JZ4740
> > >   	tristate "Ingenic JZ47xx PWM support"
> > >   	depends on MACH_INGENIC
> > >  -	select REGMAP
> > >  +	depends on COMMON_CLK
> > >  +	select INGENIC_TIMER
> > 
> > Did you drop REGMAP on purpose?
> 
> INGENIC_TIMER selects it, so it's still a dependency but indirectly.
> Should I restore it?

I think noting this in the commit log to not make a reader think (as I
did) that it was dropped by mistake is good enough.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
