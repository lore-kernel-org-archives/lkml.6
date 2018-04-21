Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDUPys (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 11:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752786AbeDUPyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 11:54:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B63214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 16:54:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Arteaga <javier@emutex.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc128s052: allow driver to be matched using
 ACPI
Message-ID: <20180421165441.0c64415d@archlinux>
In-Reply-To: <20180419132036.27493-2-javier@emutex.com>
References: <20180419132036.27493-1-javier@emutex.com>
        <20180419132036.27493-2-javier@emutex.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 14:20:35 +0100
Javier Arteaga <javier@emutex.com> wrote:

> From: Dan O'Donovan <dan@emutex.com>
> 
> Allow driver to be matched by compatible string in
> ACPI device properties.
> 
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
Hi Javier,

I don't really see the connection between the change in here
and what the description says...

If you are probing from ACPI then there is no need to ensure
a valid of table is supplied (even if we aren't building with OF)
which is what I think this patch is trying to do...

Jonathan

> ---
>  drivers/iio/adc/ti-adc128s052.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 7cf39b3e2416..56ec04d1c68f 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -202,7 +202,7 @@ MODULE_DEVICE_TABLE(spi, adc128_id);
>  static struct spi_driver adc128_driver = {
>  	.driver = {
>  		.name = "adc128s052",
> -		.of_match_table = of_match_ptr(adc128_of_match),
> +		.of_match_table = adc128_of_match,
>  	},
>  	.probe = adc128_probe,
>  	.remove = adc128_remove,
