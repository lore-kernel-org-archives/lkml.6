Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB9221479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmkMtbLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB9221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeKKVTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbeKKVTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:19:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EB9208A3;
        Sun, 11 Nov 2018 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541935892;
        bh=d8HXzTS89plaIFtnD/sUtbOlye4wyMnzPFc/z/zJosU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QmkMtbLdScc5K0ukRbmC80fDp9ZTqJs/l01OjnHGaHFUO0D8Qf2jbID4vVfRNoiqN
         AFpI55xv+22wKoPxIRgSag1SNzfXEiiwPev+YU7POY7BV4GD2LELhiOgGyEayGeMy+
         TvKU6lzzXg0JEET8JGo+qY8jaWKK7IowCFbow4so=
Date:   Sun, 11 Nov 2018 11:31:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH 6/6] staging:iio:ad2s90: Move out of staging
Message-ID: <20181111113126.6ed4bab9@archlinux>
In-Reply-To: <20181109220044.24843-7-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-7-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:00:44 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> Move ad2s90 resolver driver out of staging to the main tree.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>

For a move out of staging patch, please disable move detection.
It let's us see the whole driver and perform a thorough review on list.
Note this is the only case I'm aware of where move detection should
be disabled.  I'm not sure if others have the same feeling for
such patches, but in IIO I always want to see what we are actually
moving!

Normally we then review it as if it were a  new incoming driver.
That can pick up on stuff that has previously been missed.

Thanks,

Jonathan

> ---
>  drivers/iio/resolver/Kconfig                | 10 ++++++++++
>  drivers/iio/resolver/Makefile               |  1 +
>  drivers/{staging => }/iio/resolver/ad2s90.c |  0
>  drivers/staging/iio/resolver/Kconfig        | 10 ----------
>  drivers/staging/iio/resolver/Makefile       |  1 -
>  5 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/{staging => }/iio/resolver/ad2s90.c (100%)
> 
> diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
> index 2ced9f22aa70..786801be54f6 100644
> --- a/drivers/iio/resolver/Kconfig
> +++ b/drivers/iio/resolver/Kconfig
> @@ -3,6 +3,16 @@
>  #
>  menu "Resolver to digital converters"
>  
> +config AD2S90
> +	tristate "Analog Devices ad2s90 driver"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices spi resolver
> +	  to digital converters, ad2s90, provides direct access via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad2s90.
> +
>  config AD2S1200
>  	tristate "Analog Devices ad2s1200/ad2s1205 driver"
>  	depends on SPI
> diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
> index 4e1dccae07e7..398d82d50028 100644
> --- a/drivers/iio/resolver/Makefile
> +++ b/drivers/iio/resolver/Makefile
> @@ -2,4 +2,5 @@
>  # Makefile for Resolver/Synchro drivers
>  #
>  
> +obj-$(CONFIG_AD2S90) += ad2s90.o
>  obj-$(CONFIG_AD2S1200) += ad2s1200.o
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
> similarity index 100%
> rename from drivers/staging/iio/resolver/ad2s90.c
> rename to drivers/iio/resolver/ad2s90.c
> diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> index 6a469ee6101f..4a727c17bb8f 100644
> --- a/drivers/staging/iio/resolver/Kconfig
> +++ b/drivers/staging/iio/resolver/Kconfig
> @@ -3,16 +3,6 @@
>  #
>  menu "Resolver to digital converters"
>  
> -config AD2S90
> -	tristate "Analog Devices ad2s90 driver"
> -	depends on SPI
> -	help
> -	  Say yes here to build support for Analog Devices spi resolver
> -	  to digital converters, ad2s90, provides direct access via sysfs.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called ad2s90.
> -
>  config AD2S1210
>  	tristate "Analog Devices ad2s1210 driver"
>  	depends on SPI
> diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
> index 8d901dc7500b..b2049f2ce36e 100644
> --- a/drivers/staging/iio/resolver/Makefile
> +++ b/drivers/staging/iio/resolver/Makefile
> @@ -2,5 +2,4 @@
>  # Makefile for Resolver/Synchro drivers
>  #
>  
> -obj-$(CONFIG_AD2S90) += ad2s90.o
>  obj-$(CONFIG_AD2S1210) += ad2s1210.o

