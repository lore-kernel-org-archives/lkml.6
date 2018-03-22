Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeCVJZB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:25:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36472 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbeCVJY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:24:58 -0400
Date: Thu, 22 Mar 2018 10:24:56 +0100
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Colin King <colin.king@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: mvpp2: use correct index on array mvpp2_pools
Message-ID: <20180322092456.GA9682@kwain>
References: <20180321173115.1820-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321173115.1820-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Wed, Mar 21, 2018 at 05:31:15PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Array mvpp2_pools is being indexed by long_log_pool, however this
> looks like a cut-n-paste bug and in fact should be short_log_pool.
> 
> Detected by CoverityScan, CID#1466113 ("Copy-paste error")
> 
> Fixes: 576193f2d579 ("net: mvpp2: jumbo frames support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 9bd35f2291d6..f8bc3d4a39ff 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -4632,7 +4632,7 @@ static int mvpp2_swf_bm_pool_init(struct mvpp2_port *port)
>  	if (!port->pool_short) {
>  		port->pool_short =
>  			mvpp2_bm_pool_use(port, short_log_pool,
> -					  mvpp2_pools[long_log_pool].pkt_size);
> +					  mvpp2_pools[short_log_pool].pkt_size);
>  		if (!port->pool_short)
>  			return -ENOMEM;
>  
> -- 
> 2.15.1
> 

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
