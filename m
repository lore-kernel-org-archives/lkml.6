Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD208C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D8E2146F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRZmqATp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D8E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeLBCrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:47:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919B42081D;
        Sat,  1 Dec 2018 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678455;
        bh=tGI7IcN5NnC1d9XfZ4jpIO5v1xuaoy/Mw2BTCh3agVw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VRZmqATpXc9Tg7U4Z+k9ixCFaR6TLIDnwrQqx3f1NQRgwC7Kz0OGVfWvEzAnmZutJ
         h8Wd14GM6T2HuuDGYXh7f6uTfMc7dVVkXEhQh440nofq3UY8RNAU4H11qNEOWifW8Q
         fvKGGjOrXtdcYObOIouQ7BnV6dp2LbcaDIL2Nxl0=
Date:   Sat, 1 Dec 2018 15:34:10 +0000
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
Subject: Re: [PATCH v3 1/7] staging:iio:ad2s90: Add device tree support
Message-ID: <20181201153410.0a62c450@archlinux>
In-Reply-To: <20181124002312.6923-2-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-2-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 22:23:06 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds device tree support to ad2s90 with standard
> device tree id table.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Joanthan

> ---
> Changes in v3:
>  - Removed of_patch_ptr from of_match_table assignment
> 
> Changes in v2:
>  - none
> 
>  drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 3e257ac46f7a..fdae067ed866 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
>  	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  
> +static const struct of_device_id ad2s90_of_match[] = {
> +	{ .compatible = "adi,ad2s90", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad2s90_of_match);
> +
>  static const struct spi_device_id ad2s90_id[] = {
>  	{ "ad2s90" },
>  	{}
> @@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
>  static struct spi_driver ad2s90_driver = {
>  	.driver = {
>  		.name = "ad2s90",
> +		.of_match_table = ad2s90_of_match,
>  	},
>  	.probe = ad2s90_probe,
>  	.id_table = ad2s90_id,

