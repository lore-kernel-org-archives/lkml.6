Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeENIAE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:00:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60346 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeENIAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:00:03 -0400
Date: Mon, 14 May 2018 09:52:23 +0200
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: fix mvpp2_tx()'s return type
Message-ID: <20180514075223.GC24660@kwain>
References: <20180424131656.4054-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180424131656.4054-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Tue, Apr 24, 2018 at 03:16:53PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

I don't think this has been applied yet, so,

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
>  drivers/net/ethernet/marvell/mvpp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
> index 54a038943..355910345 100644
> --- a/drivers/net/ethernet/marvell/mvpp2.c
> +++ b/drivers/net/ethernet/marvell/mvpp2.c
> @@ -6926,7 +6926,7 @@ static int mvpp2_tx_tso(struct sk_buff *skb, struct net_device *dev,
>  }
>  
>  /* Main tx processing */
> -static int mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct mvpp2_port *port = netdev_priv(dev);
>  	struct mvpp2_tx_queue *txq, *aggr_txq;
> -- 
> 2.17.0
> 

-- 
Antoine Ténart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
