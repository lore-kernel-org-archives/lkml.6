Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525EEC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A1C2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549123203;
	bh=jSbJ7e8o0yzmEsmWv0uq3QXGQHWEPq1B/hIbjgACE30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Kn7RReMy3sx3WeseGv1CxORThdh/JKsvwmC8XdTYAKn0TL+6VmeRKkplgiXdTAGC0
	 MN8FJMCA+Zc2qSBT1TZNgFELwQ3QpcD9iUDGpX7z5CJu9UzMofcuIWI/ocK/jR0kOv
	 utRKwhkbfe3aQei1ZzbCgKS8GOq9WMm26P774AXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfBBQAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfBBQAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:00:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3023220857;
        Sat,  2 Feb 2019 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549123198;
        bh=jSbJ7e8o0yzmEsmWv0uq3QXGQHWEPq1B/hIbjgACE30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMgz0tG1zz5rxNDMCcl1MSQNP27XJHiIBr4vI6LlJJmNZ/hjtFsRNM3Iw7CTjyFIr
         fWsiGwwDLT5Pj0ROrUEJBNpfRCSR34iIBMXCsCv7NjYJwbjK6I7a9j8GYZLJarFw2S
         G/tVsUZSTQtu0foOoqDmU3IkBaMNHyeMpy3pT2vw=
Date:   Sat, 2 Feb 2019 15:59:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: Fix wrong license for ADI drivers
Message-ID: <20190202155953.2b015bd8@archlinux>
In-Reply-To: <1549037072-12770-1-git-send-email-stefan.popa@analog.com>
References: <1549037072-12770-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 18:04:32 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Analog Devices drivers are typically GPL v2 only. This patch fixes the
> inconsistencies between the module license and SPDX.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hi Stefan,

This is mostly fine where it is making sure things are consistent.
However, in some cases they were consistent and said gpl v2+.
We are on dubious legal grounds no stating that wasn't the intent
and would need to check closely for any potential additional copyright
holders etc.

So, I'd much rather we just fixed the ones that were clearly
inconsistent and left the ones that were stated as gpl v2+
alone.

Sorry to be fussy about this, but it's a legal mine field
we are definitely best to avoid.

Jonathan

> ---
>  drivers/iio/accel/adxl372.c     | 4 ++--
>  drivers/iio/accel/adxl372.h     | 2 +-
>  drivers/iio/accel/adxl372_i2c.c | 4 ++--
>  drivers/iio/accel/adxl372_spi.c | 4 ++--
>  drivers/iio/adc/ad7124.c        | 4 ++--
>  drivers/iio/dac/ad5686-spi.c    | 2 +-
>  drivers/iio/dac/ad5686.c        | 2 +-
>  drivers/iio/dac/ad5686.h        | 2 +-
>  drivers/iio/dac/ad5696-i2c.c    | 2 +-
>  drivers/iio/dac/ad5758.c        | 2 +-
>  10 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 3b84cb2..c735b4c 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ADXL372 3-Axis Digital Accelerometer core driver
>   *
> @@ -972,4 +972,4 @@ EXPORT_SYMBOL_GPL(adxl372_probe);
>  
>  MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");

I would leave this alone.

> diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
> index 80a0aa9..967fddd 100644
> --- a/drivers/iio/accel/adxl372.h
> +++ b/drivers/iio/accel/adxl372.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * ADXL372 3-Axis Digital Accelerometer
>   *
> diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
> index e1affe4..f242fb1b 100644
> --- a/drivers/iio/accel/adxl372_i2c.c
> +++ b/drivers/iio/accel/adxl372_i2c.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ADXL372 3-Axis Digital Accelerometer I2C driver
>   *
> @@ -58,4 +58,4 @@ module_i2c_driver(adxl372_i2c_driver);
>  
>  MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer I2C driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
And this one...

> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index e14e655..d486d0b 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ADXL372 3-Axis Digital Accelerometer SPI driver
>   *
> @@ -49,4 +49,4 @@ module_spi_driver(adxl372_spi_driver);
>  
>  MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
And this one.
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 7d5e531..9dcbfbc 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD7124 SPI ADC driver
>   *
> @@ -681,4 +681,4 @@ module_spi_driver(ad71124_driver);
>  
>  MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 4d857c8..0188ded 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
>   * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 6dd2759..e06b29c 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
>   *

This is one of the ones that is ambiguous ones that I suggested
we clean up.  As it was marked with two disagreeing statements,
I would think we are probably fine saying it wasn't clear and
clarifying the license.


> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 4c3e171..70a7799 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * This file is part of AD5686 DAC driver
>   *
> diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
> index 7350d98..ccf794c 100644
> --- a/drivers/iio/dac/ad5696-i2c.c
> +++ b/drivers/iio/dac/ad5696-i2c.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5671R, AD5675R, AD5691R, AD5692R, AD5693, AD5693R,
>   * AD5694, AD5694R, AD5695R, AD5696, AD5696R
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> index ef41f12..2bdf1b0 100644
> --- a/drivers/iio/dac/ad5758.c
> +++ b/drivers/iio/dac/ad5758.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD5758 Digital to analog converters driver
>   *

