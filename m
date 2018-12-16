Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFF6C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D528021836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544968461;
	bh=1jo1r9c4MFEHJEYkcKZKKVVsTdA6D7xWI05n9rB+cvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qLDNIuaU7Av4ytwWPJpyBE/EgWv1kQMSGv/Zm8z5jS4TI9LTzHfjhtEmtlQxHSru5
	 BP+jEZEKBQfJDtNG5ILbr3Km9W0bf/UZo9e3h5+HJpzbljeb2oI6X2T0ktWFqnBdmr
	 E3jqKxGCz2OZNDZQPCdhtv9n15KZi0qv0YCkNmMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeLPNyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbeLPNyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:54:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E162086C;
        Sun, 16 Dec 2018 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544968459;
        bh=1jo1r9c4MFEHJEYkcKZKKVVsTdA6D7xWI05n9rB+cvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIxOvGjj4Uow2Wo85CclAyYl2uw+hCg5aDPjROomTX7gC6ZBfqh2Dd+S8jAtj0snJ
         9hmWOE29pCrVYdnUcVukf1Ab/kv9FfwRG4F5i5Cgr9yrKtiSqER8aWXLjVjVD6Clfi
         aqy0Co5Sd1ONHMeE87oNhU07rJtFLAV296vVfDV4=
Date:   Sun, 16 Dec 2018 13:54:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 08/11] staging: iio: adc: ad7606: Add OF device ID table
Message-ID: <20181216135414.66e4aceb@archlinux>
In-Reply-To: <1544705183-13288-9-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-9-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:20 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The driver does not have a struct of_device_id table, but supported
> devices are registered via Device Trees. This patch adds and OF device
> ID table.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606_par.c | 10 ++++++++++
>  drivers/staging/iio/adc/ad7606_spi.c | 10 ++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 6269ee7..ac0c7b0 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -90,12 +90,22 @@ static const struct platform_device_id ad7606_driver_ids[] = {
>  
>  MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
>  
> +static const struct of_device_id ad7606_of_match[] = {
> +	{ .compatible = "adi,ad7605-4" },
> +	{ .compatible = "adi,ad7606-4" },
> +	{ .compatible = "adi,ad7606-6" },
> +	{ .compatible = "adi,ad7606-8" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7606_of_match);
> +
>  static struct platform_driver ad7606_driver = {
>  	.probe = ad7606_par_probe,
>  	.id_table = ad7606_driver_ids,
>  	.driver = {
>  		.name	 = "ad7606",
>  		.pm	 = AD7606_PM_OPS,
> +		.of_match_table = ad7606_of_match,
>  	},
>  };
>  
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index 9291598..2608d34 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -57,9 +57,19 @@ static const struct spi_device_id ad7606_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, ad7606_id);
>  
> +static const struct of_device_id ad7606_of_match[] = {
> +	{ .compatible = "adi,ad7605-4" },
> +	{ .compatible = "adi,ad7606-4" },
> +	{ .compatible = "adi,ad7606-6" },
> +	{ .compatible = "adi,ad7606-8" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ad7606_of_match);
> +
>  static struct spi_driver ad7606_driver = {
>  	.driver = {
>  		.name = "ad7606",
> +		.of_match_table = ad7606_of_match,
>  		.pm = AD7606_PM_OPS,
>  	},
>  	.probe = ad7606_spi_probe,

