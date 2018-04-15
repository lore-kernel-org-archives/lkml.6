Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeDOTTN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 15:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeDOTTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 15:19:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837AC2177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 20:19:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        nfarnesi4@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: sca3000: Handle errors returned by
 'sca3000_configure_ring()' in 'sca3000_probe()'
Message-ID: <20180415201904.37142f8b@archlinux>
In-Reply-To: <20180408194415.18399-1-christophe.jaillet@wanadoo.fr>
References: <20180408194415.18399-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Apr 2018 21:44:15 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'sca3000_configure_ring()' can fail, so test its return value and
> propagate it if needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.  Thanks,

Jonathan

> ---
> Same as v1
> ---
>  drivers/iio/accel/sca3000.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 562f125235db..4dceb75e3586 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1481,7 +1481,9 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	sca3000_configure_ring(indio_dev);
> +	ret = sca3000_configure_ring(indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	if (spi->irq) {
>  		ret = request_threaded_irq(spi->irq,
