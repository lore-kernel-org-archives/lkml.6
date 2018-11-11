Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6C21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANQWbZyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E6C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeKKXWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:22:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeKKXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:22:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 155A820866;
        Sun, 11 Nov 2018 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541943218;
        bh=NzzZi8SdPmsSTkKJ6jYWV0yDi4Aoybvce/TxWf1Ev7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANQWbZyVnUgKzD57k33ruizC+1DXglP9UUpRXNztYO35mhPoKULYv3azSBUBtdBAd
         JZiGLnozhPOdcInD8tc1J5YUm98K7zQzNaAXZbnQHEvrn6I81nSohJyHXFjCBFgNv7
         N5vHP2ROVYovKPBK3bxFRpPICpaCVJ+ffZPVOEH0=
Date:   Sun, 11 Nov 2018 13:33:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@bq.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st-accel: add support for lis3de
Message-ID: <20181111133333.0d292c80@archlinux>
In-Reply-To: <20181107154521.32761-1-heiko@sntech.de>
References: <20181107154521.32761-1-heiko@sntech.de>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Nov 2018 16:45:21 +0100
Heiko Stuebner <heiko@sntech.de> wrote:

> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> This commit add support for STMicroelectronics lis3de accelerometer.
> Datasheet for this device can be found here:
> 
> https://www.st.com/resource/en/datasheet/lis3de.pdf
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  drivers/iio/accel/Kconfig                            | 2 +-
>  drivers/iio/accel/st_accel.h                         | 1 +
>  drivers/iio/accel/st_accel_core.c                    | 1 +
>  drivers/iio/accel/st_accel_i2c.c                     | 5 +++++
>  drivers/iio/accel/st_accel_spi.c                     | 5 +++++
>  include/linux/iio/common/st_sensors.h                | 2 +-
>  7 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index 6f626f73417e..01c986b84bd4 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -48,6 +48,7 @@ Accelerometers:
>  - st,lis3l02dq
>  - st,lis2dw12
>  - st,lis3dhh
> +- st,lis3de
>  
>  Gyroscopes:
>  - st,l3g4200d-gyro
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 7993a67bd351..898839ca164a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -223,7 +223,7 @@ config IIO_ST_ACCEL_3AXIS
>  	  Say yes here to build support for STMicroelectronics accelerometers:
>  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
>  	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
> -	  LNG2DM
> +	  LNG2DM, LIS3DE
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 2f931e4837e5..fd53258656ca 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -56,6 +56,7 @@ enum st_accel_type {
>  #define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
>  #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
>  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
> +#define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 3e6fd5a8ac5b..f7b471121508 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -103,6 +103,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  			[4] = LSM330DLC_ACCEL_DEV_NAME,
>  			[5] = LSM303AGR_ACCEL_DEV_NAME,
>  			[6] = LIS2DH12_ACCEL_DEV_NAME,
> +			[7] = LIS3DE_ACCEL_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>  		.odr = {
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 2ca5d1f6ade0..de8ae4327094 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -98,6 +98,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2dw12",
>  		.data = LIS2DW12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis3de",
> +		.data = LIS3DE_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -135,6 +139,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS331DL_ACCEL_DEV_NAME },
>  	{ LIS3LV02DL_ACCEL_DEV_NAME },
>  	{ LIS2DW12_ACCEL_DEV_NAME },
> +	{ LIS3DE_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index dcc9bd243a52..73bfb5d04e2b 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -90,6 +90,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis3dhh",
>  		.data = LIS3DHH_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis3de",
> +		.data = LIS3DE_ACCEL_DEV_NAME,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -143,6 +147,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>  	{ LIS3LV02DL_ACCEL_DEV_NAME },
>  	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{ LIS3DHH_ACCEL_DEV_NAME },
> +	{ LIS3DE_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_accel_id_table);
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index f9bd6e8ab138..8092b8e7f37e 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -40,7 +40,7 @@
>  #define ST_SENSORS_DEFAULT_STAT_ADDR		0x27
>  
>  #define ST_SENSORS_MAX_NAME			17
> -#define ST_SENSORS_MAX_4WAI			7
> +#define ST_SENSORS_MAX_4WAI			8
>  
>  #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>  					ch2, s, endian, rbits, sbits, addr) \

