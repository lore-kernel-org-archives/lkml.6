Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeDYCpY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 22:45:24 -0400
Received: from mx.socionext.com ([202.248.49.38]:40310 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDYCpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 22:45:22 -0400
Date: Wed, 25 Apr 2018 10:46:24 +0900
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] net: ethernet: ave: fix ave_start_xmit()'s return type
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jassi Brar <jaswinder.singh@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org
In-Reply-To: <20180424131731.4458-1-luc.vanoostenryck@gmail.com>
References: <20180424131731.4458-1-luc.vanoostenryck@gmail.com>
Message-Id: <20180425104624.4594.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Apr 2018 15:17:25 +0200
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks for fixing.
I think it's preferable to add 'Fixes'.

Fixes: 4c270b55a5af ("net: ethernet: socionext: add AVE ethernet driver")
Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,

> ---
>  drivers/net/ethernet/socionext/sni_ave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
> index 0b3b7a460..95625bca1 100644
> --- a/drivers/net/ethernet/socionext/sni_ave.c
> +++ b/drivers/net/ethernet/socionext/sni_ave.c
> @@ -1360,7 +1360,7 @@ static int ave_stop(struct net_device *ndev)
>  	return 0;
>  }
>  
> -static int ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +static netdev_tx_t ave_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct ave_private *priv = netdev_priv(ndev);
>  	u32 proc_idx, done_idx, ndesc, cmdsts;
> -- 
> 2.17.0

---
Best Regards,
Kunihiko Hayashi
