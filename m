Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5BC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AEC222F0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ZaITBAs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfAEUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:53:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:52434 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfAEUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1546721585; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Noqh6VlxhdquS3mcPIx/dE8195SKbR+hRweZwaN6Lx0=;
        b=ZaITBAs87id/kC11uQ60KeKfZRGXDSrksa8hvym5WwvVPs1l42ycsYTsyoxJE4HIJ0r19J
        2sPVO8lb6OM7DMogOYljgg7v40vv3uZ1KuiOdUsK7wjujWRWxQ0/W94q+pW/Cy7H9Veb2Q
        zb2ZAdgxC1bN63KGme6B9PVWMrmtD3E=
Date:   Sat, 05 Jan 2019 17:52:46 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v9 13/27] pwm: jz4740: Use clocks from TCU driver
To:     Uwe =?iso-8859-1?q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
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
Message-Id: <1546721566.29843.0@crapouillou.net>
In-Reply-To: <20190105194559.jtwyx7th32saa6qh@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
        <20181227181319.31095-14-paul@crapouillou.net>
        <20190105194559.jtwyx7th32saa6qh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 5, 2019 at 4:45 PM, Uwe Kleine-K=F6nig=20
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>=20
> On Thu, Dec 27, 2018 at 07:13:05PM +0100, Paul Cercueil wrote:
>>  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>  index 4ed003bc3d8d..0343f0c1238e 100644
>>  --- a/drivers/pwm/Kconfig
>>  +++ b/drivers/pwm/Kconfig
>>  @@ -202,7 +202,8 @@ config PWM_IMX
>>   config PWM_JZ4740
>>   	tristate "Ingenic JZ47xx PWM support"
>>   	depends on MACH_INGENIC
>>  -	select REGMAP
>>  +	depends on COMMON_CLK
>>  +	select INGENIC_TIMER
>=20
> Did you drop REGMAP on purpose?

INGENIC_TIMER selects it, so it's still a dependency but indirectly.
Should I restore it?

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig       =20
>     |
> Industrial Linux Solutions                 |=20
> http://www.pengutronix.de/  |
=

