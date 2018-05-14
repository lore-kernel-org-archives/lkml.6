Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeENS1c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:27:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48427 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbeENS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:27:30 -0400
Date: Mon, 14 May 2018 20:27:24 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/21] i2c: efm32: make use of i2c_8bit_addr_from_msg
Message-ID: <20180514182724.sw3c4xmq5av4pphf@pengutronix.de>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-8-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180514145330.4857-8-peda@axentia.se>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Mon, May 14, 2018 at 04:53:16PM +0200, Peter Rosin wrote:
> Because it looks neater.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-efm32.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
> index aa336ba89aa3..5f2bab878b2c 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -144,8 +144,7 @@ static void efm32_i2c_send_next_msg(struct efm32_i2c_ddata *ddata)
>  	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];
>  
>  	efm32_i2c_write32(ddata, REG_CMD, REG_CMD_START);
> -	efm32_i2c_write32(ddata, REG_TXDATA, cur_msg->addr << 1 |
> -			(cur_msg->flags & I2C_M_RD ? 1 : 0));
> +	efm32_i2c_write32(ddata, REG_TXDATA, i2c_8bit_addr_from_msg(cur_msg));

Nice,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
