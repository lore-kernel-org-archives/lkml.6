Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02470C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0DC20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoDx+e2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0DC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeKECEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:04:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbeKECEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:04:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 765562082D;
        Sun,  4 Nov 2018 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541350142;
        bh=r1oQ+rLSUfV8pm1UDZcadsRXCEgooZof446L3Be3Pig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MoDx+e2DooqG2oF5x07KD21FA19grYL5buNqOxP4uoXUrT6LzZw7qVELDSIb+2CKM
         mKzT+TSBPOBC24dqGd3Xp/WxEqWanSHUDAx76fdyecCzS74nE0QxuwJwcX3hOO1Qn3
         8g72JfuvRp2sxj4UB7HXvu2j2xXxJVsmOCXg8Pr8=
Date:   Sun, 4 Nov 2018 16:48:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>
Subject: Re: [PATCH v3 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
Message-ID: <20181104164857.119019f3@archlinux>
In-Reply-To: <20181103224948.31014-6-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
        <20181103224948.31014-6-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 19:49:47 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> implements the relative read behavior at ad2s90_read_raw.
> 
> Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Hi Matheus,

Somewhere in the process, the authorship of this patch changed from
Victor to you (From:).  Given the sign off order I've assumed this
was be accident and put it back to Victor.

For reference
git commit --amend --author="Victor Colombo <victorcolombo@gmail.com>"

Whilst the patch was modified a fair bit, the fact you have left Victor
as the first sign-off implies you think it is still substantially
Victor's patch (I agree with that).

Anyhow, shout if you disagree as still time to change it before
I push this tree out as non rebasing (probably later this week).

Whilst things are only visible in testing I can change anything,
but once I push out as togreg, I am committing to that being a stable
platform for others to base their code on so can't fix things like this.

Applied.
Thanks,
Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s90.c | 30 +++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 8f79cccf4814..9c168b7410d0 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -34,17 +34,29 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct ad2s90_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> -	ret = spi_read(st->sdev, st->rx, 2);
> -	if (ret < 0) {
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* 2 * Pi / 2^12 */
> +		*val = 6283; /* mV */
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
> +
>  		mutex_unlock(&st->lock);
> -		return ret;
> -	}
> -	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
>  
> -	mutex_unlock(&st->lock);
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
>  
> -	return IIO_VAL_INT;
> +	return -EINVAL;
>  }
>  
>  static const struct iio_info ad2s90_info = {
> @@ -55,7 +67,7 @@ static const struct iio_chan_spec ad2s90_chan = {
>  	.type = IIO_ANGL,
>  	.indexed = 1,
>  	.channel = 0,
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>  };
>  
>  static int ad2s90_probe(struct spi_device *spi)

