Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D448C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F3E21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544963891;
	bh=KhFLQsot0xO71kOD5sz/O03rvRcitoQeNHwTao0KAQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2oAYD9c9kPD2s5skCJb4rW/b3+bBd33KIl6kXEG2f1dSWxAHT/qK4d/7xAS7voDLZ
	 tlvGA+wyGWDwZSuxQaUShggLmmA48u29vpGzstjFKScmsnGQ7A+wbXm7etKdVbNV/I
	 9OiwCREHP9ePO1EKDa/RQqNB+hYCZyevdA8ZAfWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbeLPMiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbeLPMiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:38:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF77217F9;
        Sun, 16 Dec 2018 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544963889;
        bh=KhFLQsot0xO71kOD5sz/O03rvRcitoQeNHwTao0KAQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I6ty1m2zF+hM7qdwDlqv4keccpkH+J4s0ZjhFoX1N8c8zZpOLnbz/emMaZGF4lJEA
         h0XZiGis4DCnXXlFf2x/KGlk4c3YPnie9pmowi6FFrTisaw0MEpRrBpjXppg/ECsMz
         nLA7SVvVkJdLxMz53PGqG4PQmALzetT8qi3LjKiY=
Date:   Sun, 16 Dec 2018 12:38:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7816: drop unnecessary initialization
 of variables
Message-ID: <20181216123804.7d5ed60d@archlinux>
In-Reply-To: <20181212175707.12513-1-hardiksingh.k@gmail.com>
References: <20181212175707.12513-1-hardiksingh.k@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 23:27:07 +0530
Hardik Singh Rathore <hardiksingh.k@gmail.com> wrote:

> Initialization is unnecessary when the variable is written before it is
> read. There were some occasions in which the driver would initialize `ret'
> during declaration without need.
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7816.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 5209651a1b25..ee50e7296795 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -65,7 +65,7 @@ enum ad7816_type {
>  static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
> -	int ret = 0;
> +	int ret;
>  	__be16 buf;
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -106,7 +106,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
> -	int ret = 0;
> +	int ret;
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> @@ -354,8 +354,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  {
>  	struct ad7816_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	int ret = 0;
> -	int i;
> +	int i, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
>  	if (!indio_dev)

