Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeBUUBx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:01:53 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:22515
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751276AbeBUUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:01:51 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515452400";
   d="scan'208";a="255670103"
Date: Wed, 21 Feb 2018 21:01:46 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
In-Reply-To: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
Message-ID: <alpine.DEB.2.20.1802212101160.2292@hadrien>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Feb 2018, Rodrigo Siqueira wrote:

> This patch fixes the checkpatch.pl warning:
>
> drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.

I haven't studied up on it in great detail, but isn't there a more
specific macro that doesn't need a permission argument at all?

julia

> ...
>
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
> Changes in v2:
>   - Make the commit message clearer.
>   - Fix just a single part of the code.
>
>  drivers/iio/dummy/iio_dummy_evgen.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index efd0005f59b4..16ea547f79f0 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -148,16 +148,16 @@ static ssize_t iio_evgen_poke(struct device *dev,
>  	return len;
>  }
>
> -static IIO_DEVICE_ATTR(poke_ev0, S_IWUSR, NULL, &iio_evgen_poke, 0);
> -static IIO_DEVICE_ATTR(poke_ev1, S_IWUSR, NULL, &iio_evgen_poke, 1);
> -static IIO_DEVICE_ATTR(poke_ev2, S_IWUSR, NULL, &iio_evgen_poke, 2);
> -static IIO_DEVICE_ATTR(poke_ev3, S_IWUSR, NULL, &iio_evgen_poke, 3);
> -static IIO_DEVICE_ATTR(poke_ev4, S_IWUSR, NULL, &iio_evgen_poke, 4);
> -static IIO_DEVICE_ATTR(poke_ev5, S_IWUSR, NULL, &iio_evgen_poke, 5);
> -static IIO_DEVICE_ATTR(poke_ev6, S_IWUSR, NULL, &iio_evgen_poke, 6);
> -static IIO_DEVICE_ATTR(poke_ev7, S_IWUSR, NULL, &iio_evgen_poke, 7);
> -static IIO_DEVICE_ATTR(poke_ev8, S_IWUSR, NULL, &iio_evgen_poke, 8);
> -static IIO_DEVICE_ATTR(poke_ev9, S_IWUSR, NULL, &iio_evgen_poke, 9);
> +static IIO_DEVICE_ATTR(poke_ev0, 0200, NULL, &iio_evgen_poke, 0);
> +static IIO_DEVICE_ATTR(poke_ev1, 0200, NULL, &iio_evgen_poke, 1);
> +static IIO_DEVICE_ATTR(poke_ev2, 0200, NULL, &iio_evgen_poke, 2);
> +static IIO_DEVICE_ATTR(poke_ev3, 0200, NULL, &iio_evgen_poke, 3);
> +static IIO_DEVICE_ATTR(poke_ev4, 0200, NULL, &iio_evgen_poke, 4);
> +static IIO_DEVICE_ATTR(poke_ev5, 0200, NULL, &iio_evgen_poke, 5);
> +static IIO_DEVICE_ATTR(poke_ev6, 0200, NULL, &iio_evgen_poke, 6);
> +static IIO_DEVICE_ATTR(poke_ev7, 0200, NULL, &iio_evgen_poke, 7);
> +static IIO_DEVICE_ATTR(poke_ev8, 0200, NULL, &iio_evgen_poke, 8);
> +static IIO_DEVICE_ATTR(poke_ev9, 0200, NULL, &iio_evgen_poke, 9);
>
>  static struct attribute *iio_evgen_attrs[] = {
>  	&iio_dev_attr_poke_ev0.dev_attr.attr,
> --
> 2.16.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
