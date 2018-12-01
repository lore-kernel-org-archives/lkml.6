Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D4C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B812081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2n2yxxLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B812081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLBCrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeLBCrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:47:20 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 256572146F;
        Sat,  1 Dec 2018 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543678473;
        bh=FWwqSZtV1l22J/ZQH1mUnWy7mrNSce8vOw744zGvqEw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2n2yxxLem4vTeEZXZ9W8DvZG0Yek6757kTekjkWhwDSzEHMWMEFNcl/r+nFh2gVHK
         MgW5CLM2uc51OFlD7OKIoQAMg49aGbfgRVXVtSWa/am2HSxF/HhOvtwDYJ7EeDHg8+
         oraeZJa3O1Kwc7UfOuktysTf5aPhy0A7XMsbxVog=
Date:   Sat, 1 Dec 2018 15:34:28 +0000
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
Subject: Re: [PATCH v3 2/7] staging:iio:ad2s90: Remove spi setup that should
 be done via dt
Message-ID: <20181201153428.399caf50@archlinux>
In-Reply-To: <20181124002312.6923-3-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
        <20181124002312.6923-3-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 22:23:07 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> The ad2s90 driver currently sets some spi settings (max_speed_hz and
> mode) at ad2s90_probe. Since the maximum frequency is a required element
> in DT binding for spi slave devices and because the spi mode for the
> device can be either (0,0) or (1,1), these settings should be handled
> via device tree, not in the driver's code. This patch removes them from
> the probe function.
> 
> Note: The way in which the mentioned spi settings need to be specified
> on the ad2s90's node of a device tree will be documented in the future
> patch "dt-bindings:iio:resolver: Add docs for ad2s90".
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>

Applied,

Thanks,

Jonathan

> ---
> Changes in v3:
>  - none
> 
> Changes in v2:
>  - Rewritten patch message to better explain why the code snippet in
>  question should be removed.
> 
>  drivers/staging/iio/resolver/ad2s90.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index fdae067ed866..abb9b9147ee6 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
> -	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	/* need 600ns between CS and the first falling edge of SCLK */
> -	spi->max_speed_hz = 830000;
> -	spi->mode = SPI_MODE_3;
> -	ret = spi_setup(spi);
> -
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "spi_setup failed!\n");
> -		return ret;
> -	}
> -
>  	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  

