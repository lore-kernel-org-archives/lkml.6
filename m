Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B86C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B830B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547317348;
	bh=KTU9HeytrPIth6NO0Wfle5VKWzDAw2lsi3pguDN8ces=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E56DDXBHCJ+UsakooasmNyoTl0XnGMSpHfG3zWmhAC337FgU+kOKh5WKecMiPA6AX
	 hjZyeFCIREr26gY8zJ9yv1c9k+X7yNZkLy8AHHhz22ifHwiAKi/QKywRqlg2btSQNO
	 Wi8UcCBe4icBozSx3SW8/0Q17dMB1lP1xuPOgW78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfALSW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:22:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfALSW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:22:27 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB0D20836;
        Sat, 12 Jan 2019 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547317347;
        bh=KTU9HeytrPIth6NO0Wfle5VKWzDAw2lsi3pguDN8ces=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eJaIC/2au8+hSzfJggXOBJ/oTyg9/Fhm/ZxUC+ammFN8b/DHZmc7LFDppDUym++HU
         ZR6vQ/v/7nPU9HcKP6FNwi3YQhMRBgSqD2XrAG0wW89xLxtaW1YqOgvxZ3SUKg+iL+
         xRbQZEemGK+7O0PNK7B0utCcapOvKLdDxgh2Ju00=
Date:   Sat, 12 Jan 2019 18:22:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
Message-ID: <20190112182221.4765d287@archlinux>
In-Reply-To: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 15:53:58 -0500
Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:

> This commit allow the driver to work with device-tree.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
Minor stuff inline.

J
> ---
> v1 -> v2:
>   - add missing of.h header in bme680_spi.c
> ---
>  drivers/iio/chemical/bme680_i2c.c | 7 +++++++
>  drivers/iio/chemical/bme680_spi.c | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
> index 06d4be539d2e..94a36ebdf0b2 100644
> --- a/drivers/iio/chemical/bme680_i2c.c
> +++ b/drivers/iio/chemical/bme680_i2c.c
> @@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>  
> +static const struct of_device_id bme680_of_i2c_match[] = {
> +	{ .compatible = "bosch,bme680", },
> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
> +
>  static struct i2c_driver bme680_i2c_driver = {
>  	.driver = {
>  		.name			= "bme680_i2c",
>  		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> +		.of_match_table		= of_match_ptr(bme680_of_i2c_match),

As below. just = bme680...

>  	},
>  	.probe = bme680_i2c_probe,
>  	.id_table = bme680_i2c_id,
> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
> index c9fb05e8d0b9..caa57287a911 100644
> --- a/drivers/iio/chemical/bme680_spi.c
> +++ b/drivers/iio/chemical/bme680_spi.c
> @@ -6,9 +6,11 @@
>   */
>  #include <linux/acpi.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
>  
> +

This white space change should not be here.

>  #include "bme680.h"
>  
>  static int bme680_regmap_spi_write(void *context, const void *data,
> @@ -110,10 +112,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>  
> +static const struct of_device_id bme680_of_spi_match[] = {
> +	{ .compatible = "bosch,bme680", },
> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
> +
>  static struct spi_driver bme680_spi_driver = {
>  	.driver = {
>  		.name			= "bme680_spi",
>  		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
> +		.of_match_table		= of_match_ptr(bme680_of_spi_match),
Please don't use of_match_ptr.  We actually want this entry to be there even
if devicetree is not in use.  This is because there is a magic ACPI hid
that can use this table even from ACPI.

>  	},
>  	.probe = bme680_spi_probe,
>  	.id_table = bme680_spi_id,

