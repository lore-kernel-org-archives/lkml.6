Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70034C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB92083A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUSa+ROr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB92083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHST2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 15:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeHST2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 15:28:14 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B429B2083A;
        Sun, 19 Aug 2018 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534695376;
        bh=jx+uiA4PKuymLnsvrYbtw9XLYkHSB1gNm8RsKunHuhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PUSa+ROrlHAE2/qYZjAWR15H7PAyiZCHUXL2DXBeVeLX3zyEGz0DyWT9QCA/rCcB/
         ibvVaN14QEx7xoaMUeHONEcyJRgVbPn4neJpAQFbU1+ga2dIc3cOC74WHuWRlYdEd1
         kslvKnt9PQSu2Xa5z+SQ8bQTBbkI9aXlfuzEm2qM=
Date:   Sun, 19 Aug 2018 17:16:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: ms5611: remove deprecated compatible
 strings
Message-ID: <20180819171613.0f74335c@archlinux>
In-Reply-To: <20180816184915.32138-1-tduszyns@gmail.com>
References: <20180816184915.32138-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 20:49:15 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Compatible strings tend to follow manufacturer,model format.
> In case one wants to do a matching with manufacturer stripped
> off he can still do so since SPI/I2C core will try id_table
> based matching anyway.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/ms5611_i2c.c | 2 --
>  drivers/iio/pressure/ms5611_spi.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> index 55fb5fc0b6ea..0469c8ae1134 100644
> --- a/drivers/iio/pressure/ms5611_i2c.c
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -117,9 +117,7 @@ static int ms5611_i2c_remove(struct i2c_client *client)
>  #if defined(CONFIG_OF)
>  static const struct of_device_id ms5611_i2c_matches[] = {
>  	{ .compatible = "meas,ms5611" },
> -	{ .compatible = "ms5611" },
>  	{ .compatible = "meas,ms5607" },
> -	{ .compatible = "ms5607" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> index 932e05001e1a..cd11d022208e 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -119,9 +119,7 @@ static int ms5611_spi_remove(struct spi_device *spi)
>  #if defined(CONFIG_OF)
>  static const struct of_device_id ms5611_spi_matches[] = {
>  	{ .compatible = "meas,ms5611" },
> -	{ .compatible = "ms5611" },
>  	{ .compatible = "meas,ms5607" },
> -	{ .compatible = "ms5607" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ms5611_spi_matches);

