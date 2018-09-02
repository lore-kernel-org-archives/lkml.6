Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586CFC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0148820856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zJmjrwk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0148820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeICAPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICAPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:15:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0B820843;
        Sun,  2 Sep 2018 19:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535918295;
        bh=ZL4OvZeaSGe8eSVjpBrMtJdQ98eqZp3hdNN5Mf3NWEc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zJmjrwk06KGxFZnoxQGnqkHPltMXo2NOHR8Ay8GAddVufbV+oXVlFsU/BPfwx5prv
         x90Pxfc1I/lWn6g/1nxgVfRBvNFW2jvlAB83s/rflck7Nd+N4HuO8dpa9FmHH5QTgS
         tSh5G32DOKvqJG1085rQGVX3UXanwuvr6Pdl1/E0=
Date:   Sun, 2 Sep 2018 20:58:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Rossak <embed3d@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        eugen.hristev@microchip.com, rdunlap@infradead.org,
        vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 02/30] mfd: Kconfig: Remove MFD_SUN4I_GPADC config
 option
Message-ID: <20180902205808.49cbc19a@archlinux>
In-Reply-To: <20180830154518.29507-3-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-3-embed3d@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 17:44:50 +0200
Philipp Rossak <embed3d@gmail.com> wrote:

> We are merging the mfd:sun4i-gpadc driver into the
> iio/adc/sun4i-gpadc driver. So we need to remove the MFD_SUN4I_GPADC
> config option.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Do need to separate this and patch 1 as they are really two
facets of the same thing.

Jonathan

> ---
>  drivers/mfd/Kconfig | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..c7ab57d65610 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -40,23 +40,6 @@ config MFD_ACT8945A
>  	  linear regulators, along with a complete ActivePath battery
>  	  charger.
>  
> -config MFD_SUN4I_GPADC
> -	tristate "Allwinner sunxi platforms' GPADC MFD driver"
> -	select MFD_CORE
> -	select REGMAP_MMIO
> -	select REGMAP_IRQ
> -	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on !TOUCHSCREEN_SUN4I
> -	help
> -	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
> -	  This driver will only map the hardware interrupt and registers, you
> -	  have to select individual drivers based on this MFD to be able to use
> -	  the ADC or the thermal sensor. This will try to probe the ADC driver
> -	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
> -
> -	  To compile this driver as a module, choose M here: the module will be
> -	  called sun4i-gpadc.
> -
>  config MFD_AS3711
>  	bool "AMS AS3711"
>  	select MFD_CORE

