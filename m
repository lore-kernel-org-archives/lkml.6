Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDXQhA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:37:00 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41851 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDXQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:36:54 -0400
X-Google-Smtp-Source: AIpwx48BZmEo4m5GrH7hmRSTItWFTjD3K3iPZbeNkjsAicIvdwjICthwn2ChtR4zopsrSR3Zyd93Ig==
Subject: Re: [PATCH] net: sh-eth: fix sh_eth_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20180424131720.4357-1-luc.vanoostenryck@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <18573d77-d874-7864-90f4-cd4454024c7f@cogentembedded.com>
Date: Tue, 24 Apr 2018 19:36:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180424131720.4357-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/24/2018 04:17 PM, Luc Van Oostenryck wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]
> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index b6b90a631..0875a169f 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -2454,7 +2454,7 @@ static void sh_eth_tx_timeout(struct net_device *ndev)
>  }
>  
>  /* Packet transmit function */
> -static int sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +static netdev_tx_t sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)

   But aren't you violating 80-column limit?

[...]

MBR, Sergei
