Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753747AbeCFOKI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:10:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41053 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbeCFOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:10:06 -0500
Message-ID: <1520345404.4095.17.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] mfd: rave-sp: Check received frame length before
 accepting next byte
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Mar 2018 15:10:04 +0100
In-Reply-To: <20180226150739.13457-3-andrew.smirnov@gmail.com>
References: <20180226150739.13457-1-andrew.smirnov@gmail.com>
         <20180226150739.13457-3-andrew.smirnov@gmail.com>
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
> Check received frame length _before_ accepting next byte in order to
> avoid incorrectly rejecting payloads that are RAVE_SP_RX_BUFFER_SIZE
> long.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Tested-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/mfd/rave-sp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> index cec1e309b31f..76fa32006a1b 100644
> --- a/drivers/mfd/rave-sp.c
> +++ b/drivers/mfd/rave-sp.c
> @@ -548,8 +548,6 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
> >  			/* FALLTHROUGH */
>  
> >  		case RAVE_SP_EXPECT_ESCAPED_DATA:
> > -			deframer->data[deframer->length++] = byte;
> -
> >  			if (deframer->length == sizeof(deframer->data)) {
> >  				dev_warn(dev, "Bad frame: Too long\n");
> >  				/*
> @@ -564,6 +562,8 @@ static int rave_sp_receive_buf(struct serdev_device *serdev,
> >  				goto reset_framer;
> >  			}
>  
> > +			deframer->data[deframer->length++] = byte;
> +
> >  			/*
> >  			 * We've extracted out special byte, now we
> >  			 * can go back to regular data collecting
