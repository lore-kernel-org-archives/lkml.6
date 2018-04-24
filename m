Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDXPJU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:09:20 -0400
Received: from zimbra.alphalink.fr ([217.15.80.77]:41922 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbeDXPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:09:16 -0400
Date: Tue, 24 Apr 2018 17:09:12 +0200
From: Guillaume Nault <g.nault@alphalink.fr>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        James Chapman <jchapman@katalix.com>,
        Dominik Heidler <dheidler@suse.de>, netdev@vger.kernel.org
Subject: Re: [PATCH] l2tp: fix l2tp_eth_dev_xmit()'s return type
Message-ID: <20180424150912.GE1440@alphalink.fr>
References: <20180424131855.5618-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131855.5618-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:18:53PM +0200, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  net/l2tp/l2tp_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
> index 5c366ecfa..e027f8b54 100644
> --- a/net/l2tp/l2tp_eth.c
> +++ b/net/l2tp/l2tp_eth.c
> @@ -77,7 +77,7 @@ static void l2tp_eth_dev_uninit(struct net_device *dev)
>  	 */
>  }
>  
> -static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> +static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> 
You could easily keep this line under the 80 columns limit by moving
the net_device parameter on the next line.
