Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeETJc5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 05:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750926AbeETJcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 05:32:54 -0400
Date: Sun, 20 May 2018 10:32:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2583: correct values in
 integration_time_available
Message-ID: <20180520103248.367f21d2@archlinux>
In-Reply-To: <20180513002039.6984-1-masneyb@onstation.org>
References: <20180513002039.6984-1-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 May 2018 20:20:39 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The times reported by the in_illuminance_integration_time_available
> sysfs attribute are actually in milliseconds, not microseconds. This
> patch corrects the times with the correct unit.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hi Brian,

In future could you give me a fixes: tag for this one.
For cases where we are fixing a driver that isn't in staging
we need to make it easy for people to figure out which stable trees
the backport should be done to.
I've gone with staging move patch as backporting before that
probably doesn't matter..  I added some text to the description
on why I'd give it this fixes tag.

Fixes: f44d5c8ac399 ("staging: iio: tsl2583: move out of staging")

> ---
>  drivers/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index f2e50edaa242..4b5d9988f025 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -600,7 +600,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  
>  static IIO_CONST_ATTR(in_illuminance_calibscale_available, "1 8 16 111");
>  static IIO_CONST_ATTR(in_illuminance_integration_time_available,
> -		      "0.000050 0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400 0.000450 0.000500 0.000550 0.000600 0.000650");
> +		      "0.050 0.100 0.150 0.200 0.250 0.300 0.350 0.400 0.450 0.500 0.550 0.600 0.650");
>  static IIO_DEVICE_ATTR_RW(in_illuminance_input_target, 0);
>  static IIO_DEVICE_ATTR_WO(in_illuminance_calibrate, 0);
>  static IIO_DEVICE_ATTR_RW(in_illuminance_lux_table, 0);
