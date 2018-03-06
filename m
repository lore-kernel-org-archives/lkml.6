Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeCFPcv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:32:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:32:49 -0500
Date: Tue, 6 Mar 2018 16:32:47 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Colin King <colin.king@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] net: mvpp2: make function
 mvpp2_check_hw_buf_num static
Message-ID: <20180306153247.GL4321@kwain>
References: <20180306152517.2770-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180306152517.2770-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Tue, Mar 06, 2018 at 04:25:17PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function mvpp2_check_hw_buf_num is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/net/ethernet/marvell/mvpp2.c:4298:5: warning: symbol
> 'mvpp2_check_hw_buf_num' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index ac0a0dc8f157..61c6896d0d62 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -4295,7 +4295,8 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  }
>  
>  /* Check number of buffers in BM pool */
> -int mvpp2_check_hw_buf_num(struct mvpp2 *priv, struct mvpp2_bm_pool *bm_pool)
> +static int mvpp2_check_hw_buf_num(struct mvpp2 *priv,
> +				  struct mvpp2_bm_pool *bm_pool)
>  {
>  	int buf_num = 0;
>  
> -- 
> 2.15.1
> 

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
