Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F036C21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyL9R6OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F036C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKKWZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:25:13 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB8320866;
        Sun, 11 Nov 2018 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541939805;
        bh=TmfgH96Cmj2/bR/zmVykr0fId0Aen5GRUZrKrbENtEs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QyL9R6OP0O9luct66PxwZl7Mlanrv73jEIoU3pb8lMvROwf6vu3eWHBV01OmI9ACw
         0OWvy2GX7hd09Sdom5jEpelxZEkq5+e48OdAS2XYEMnuJf/VXOxmNYQrLTtCFRyIQg
         qSF9VYrDZjZgg2lHRovsBv0Ce+B7ciHnx5ykFU1U=
Date:   Sun, 11 Nov 2018 12:36:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] staging: iio: ad7816: Set RD/WR pin and CONVST
 pin as outputs.
Message-ID: <20181111123640.0195c7fd@archlinux>
In-Reply-To: <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 13:07:18 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> The RD/WR pin and CONVST pin are logical inputs to the AD78xx
> chip as per the datasheet. Hence convert them to outputs.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Hi Nishad,

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

This is the sort of patch we might want to think about backporting
for stable, but it is sufficiently complex to do that I' think we'll
wait for someone to actually request it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 3cda5cd09365..a2fead85cd46 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -369,14 +369,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		chip->oti_data[i] = 203;
>  
>  	chip->id = spi_get_device_id(spi_dev)->driver_data;
> -	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
> +	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
>  		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
>  			ret);
>  		return ret;
>  	}
> -	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
> +	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
> +					   GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->convert_pin)) {
>  		ret = PTR_ERR(chip->convert_pin);
>  		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",

