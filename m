Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1880C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B64120664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1/LPkvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B64120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeJWCLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:11:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40726 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJWCLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:11:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id o14-v6so3650572pgv.7;
        Mon, 22 Oct 2018 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqjBvWLQriuXfiK4OhmwzPmm02QsLocU/yTs3xfXR1Y=;
        b=s1/LPkvQcsvVNkxtt3oo1GJ2vPCxFX3HH7X6ALmDVp8SeN+hYjnaYj4xVf5EpoCPk3
         JRYRlRt9KQmS0n/dxvBUuTg2OsImiL52el5DdQLaFlyaYNFm1dNIJJS6yj08jMjkX9wc
         6aRR3YbKI/1Rd0M8+zEfqh/DLLddscvWdFsMryE0e3tyWY/VSE6pfsdKSA5io57ZxoiJ
         w8i8MnEmdu780jzlx/S5tjhjCRxV6IzbSTnC0ron+KdC+VI3vMZCF3ZLpmQprN8phPrW
         Bpi4Q8aKIKlt+DP4ThsFz5yQEyfrVMqpXucrt6DdP1xOc7FcbrpyzNnmA895OGvLv5l5
         dlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqjBvWLQriuXfiK4OhmwzPmm02QsLocU/yTs3xfXR1Y=;
        b=dBtV4prlSmqtHgQYP5CXEJyoss536kLNU6Cn1Cl46OV+S7rjt/1XOMAKAp7wq6olvY
         ZvZpwFGQ1/QDL8DhGiicrLu+BGGvelteKfdw5hbTziHi5wOlr5q2TFjY3u9FDyAoFGZQ
         fNPQGjw3Fpk8gl+LT6odDwWq0OyNlGiGt+OeHFbrNp1e9TuBFnSZD1a3pKLSm63SapGv
         c5rs/DYMIi9MURDJKo8st7kxs8bOdTEWuPICedXzRoDaHjhUk+URkGuVYHg8J1bbWx/4
         UBXSwsjzbx2qGS+GDb78pW+TD7KSLrc51zxgXzu4I/CAPD6RpacfXBuPYhqmPRtMEnjG
         jGgw==
X-Gm-Message-State: ABuFfogmaDWtg3iDrnJ19/ybtjTGaPX7IOHJutOm4MoTcQVNRyEQllxF
        s0DHXiBIGTWUEAU2iMn1GHY=
X-Google-Smtp-Source: ACcGV60GzOvRjl8FtTMtF2GtlDPKoShJSGK80b8yMzMGJrf9aWF2ACmVGV9p6l6Ew1fLoysECXVGHw==
X-Received: by 2002:a63:26c1:: with SMTP id m184-v6mr21095108pgm.268.1540230742779;
        Mon, 22 Oct 2018 10:52:22 -0700 (PDT)
Received: from Shreeya-Patel ([103.212.140.132])
        by smtp.googlemail.com with ESMTPSA id z11-v6sm67611706pfd.99.2018.10.22.10.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 10:52:22 -0700 (PDT)
Message-ID: <55b8a6364a0a4d8c123a1041a07f7ed34bf45ded.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: Switch to the gpio descriptor
 interface
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 22 Oct 2018 23:22:15 +0530
In-Reply-To: <20181022171418.GA2612@nishad>
References: <20181022171418.GA2612@nishad>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 22:44 +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated old non-descriptor
> interface for ldac_pin.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---

Hi Nishad,

I have been working on implementing device tree bindings for this
driver and removing platform data from it.

I've sent a series of patches for it to Jonathan. I didn't send it 
on the mailing list as I wanted to confirm from Jonathan if we wants
something more to be done in the series. That series also includes
the change which you are proposing here.
I am really sorry that you didn't know about this.
If you are planning to send any other patches for this driver then
let me know before you start implementing it so that we can
co-ordinate before doing any work.

Thanks


>  drivers/staging/iio/addac/adt7316.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c
> b/drivers/staging/iio/addac/adt7316.c
> index 3f22d1088713..94f945ba0097 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -8,7 +8,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -177,7 +177,7 @@
>  
>  struct adt7316_chip_info {
>  	struct adt7316_bus	bus;
> -	u16			ldac_pin;
> +	struct gpio_desc	*ldac_pin;
>  	u16			int_mask;	/* 0x2f */
>  	u8			config1;
>  	u8			config2;
> @@ -950,8 +950,8 @@ static ssize_t adt7316_store_update_DAC(struct
> device *dev,
>  		if (ret)
>  			return -EIO;
>  	} else {
> -		gpio_set_value(chip->ldac_pin, 0);
> -		gpio_set_value(chip->ldac_pin, 1);
> +		gpiod_set_value(chip->ldac_pin, 0);
> +		gpiod_set_value(chip->ldac_pin, 1);
>  	}
>  
>  	return len;
> @@ -2120,7 +2120,14 @@ int adt7316_probe(struct device *dev, struct
> adt7316_bus *bus,
>  	else
>  		return -ENODEV;
>  
> -	chip->ldac_pin = adt7316_platform_data[1];
> +	chip->ldac_pin = devm_gpiod_get(dev, "ldac",
> GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->ldac_pin)) {
> +		ret = PTR_ERR(chip->ldac_pin);
> +		dev_err(dev, "Failed to request ldac GPIO: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	if (chip->ldac_pin) {
>  		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDCA;
>  		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
