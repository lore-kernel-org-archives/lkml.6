Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbeBDLVt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 06:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeBDLVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 06:21:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84212217AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 4 Feb 2018 11:21:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf08: fix link error
 "devm_iio_triggered_buffer_setup" undefined
Message-ID: <20180204112136.6c9ad790@archlinux>
In-Reply-To: <20180201204924.GA26839@arbeit>
References: <20180201204924.GA26839@arbeit>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2018 21:49:24 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Functions for triggered buffer support are needed by this module.
> If they are not defined accidentally by another driver, there's an error
> thrown out while linking.
> 
> Add a select of IIO_BUFFER and IIO_TRIGGERED_BUFFER in the Kconfig file.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Applied to the fixes-togreg-post-rc1 branch of iio.git with a fixes
tag added.  Please always track down the patch that introduced the
problem and add a fixes tag.  It makes it much easier for the stable
trees to know when to apply the patch or not.

I put the patch that introduced the triggered support in the first
place as that seemed likely to be the place that the issue was
introduced.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index fcb1c4ba5e41..f726f9427602 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -68,6 +68,8 @@ config SX9500
>  
>  config SRF08
>  	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	depends on I2C
>  	help
>  	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
