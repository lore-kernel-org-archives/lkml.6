Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeCFOJq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:09:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52797 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeCFOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:09:45 -0500
Message-ID: <1520345382.4095.16.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] mfd: rave-sp: Convert print_hex_dump() to
 print_hex_dump_debug()
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Mar 2018 15:09:42 +0100
In-Reply-To: <20180226150739.13457-2-andrew.smirnov@gmail.com>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
         <20180226150739.13457-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 26.02.2018, 07:07 -0800 schrieb Andrey Smirnov:
> Convert print_hex_dump() to print_hex_dump_debug() to be able to
> leverage CONFIG_DYNAMIC_DEBUG.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/mfd/rave-sp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index 9e4c83ff2aec..cec1e309b31f 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -311,8 +311,8 @@ static int rave_sp_write(struct rave_sp *sp,
> const u8 *data, u8 data_size)
>  
>  	length = dest - frame;
>  
> -	print_hex_dump(KERN_DEBUG, "rave-sp tx: ", DUMP_PREFIX_NONE,
> -		       16, 1, frame, length, false);
> +	print_hex_dump_debug("rave-sp tx: ", DUMP_PREFIX_NONE,
> +			     16, 1, frame, length, false);
>  
>  	return serdev_device_write(sp->serdev, frame, length, HZ);
>  }
> @@ -453,8 +453,8 @@ static void rave_sp_receive_frame(struct rave_sp
> *sp,
>  	struct device *dev           = &sp->serdev->dev;
>  	u8 crc_calculated[checksum_length];
>  
> -	print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
> -		       16, 1, data, length, false);
> +	print_hex_dump_debug("rave-sp rx: ", DUMP_PREFIX_NONE,
> +			     16, 1, data, length, false);
>  
>  	if (unlikely(length <= checksum_length)) {
>  		dev_warn(dev, "Dropping short frame\n");
