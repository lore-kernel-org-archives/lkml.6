Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D92C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F0E21759
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBi1Dxz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F0E21759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeGGQe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754314AbeGGQey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:34:54 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDEF215F1;
        Sat,  7 Jul 2018 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530981294;
        bh=TFSIpaSGyBc2HhEkgHz4mo6NA9QBqC0JbIHjMvtxP2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OBi1Dxz8VOxhUFsBXoK+b9x8uZeg7ph3U2m6+d4tS3x+WxXkOnJaZ0F9X79gvSyMB
         oCSn76PUahQm+XHE6U7qGrzwzNAU+USQOJljKjjwIBeP4o7+OYVZgWq0HZxVqnaneQ
         Xp8X+mKbDIdrYnqSepBrDtBdS8ls0crxJiG0CjkM=
Date:   Sat, 7 Jul 2018 17:34:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of
 probe()
Message-ID: <20180707173447.56bb4d8c@archlinux>
In-Reply-To: <b990bc14d89daba5ac3b14d4b2eefb47c972d63d.1530782560.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530782560.git.nikolaus.voss@loewensteinmedical.de>
        <b990bc14d89daba5ac3b14d4b2eefb47c972d63d.1530782560.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 08:06:57 +0200
Nikolaus Voss <nikolaus.voss@loewensteinmedical.de> wrote:

> struct i2c_device_id argument of probe() is not used, so use probe_new()
> instead.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index d02298f0256c..2ca5d1f6ade0 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -139,8 +139,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>  
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -						const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev;
>  	struct st_sensor_data *adata;
> @@ -179,7 +178,7 @@ static struct i2c_driver st_accel_driver = {
>  		.of_match_table = of_match_ptr(st_accel_of_match),
>  		.acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>  	},
> -	.probe = st_accel_i2c_probe,
> +	.probe_new = st_accel_i2c_probe,
>  	.remove = st_accel_i2c_remove,
>  	.id_table = st_accel_id_table,
>  };

