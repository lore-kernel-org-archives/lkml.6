Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A9FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80C920868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80C920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeH2NeM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:34:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46132 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2NeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:34:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E1ACB207B0; Wed, 29 Aug 2018 11:38:09 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC3B32071E;
        Wed, 29 Aug 2018 11:38:09 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162932.6015e89d@xhacker.debian>
Date:   Wed, 29 Aug 2018 11:38:09 +0200
In-Reply-To: <20180829162932.6015e89d@xhacker.debian> (Jisheng Zhang's message
        of "Wed, 29 Aug 2018 16:29:32 +0800")
Message-ID: <871sahjywu.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,
 
 On mer., août 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> The code and HW supports NETIF_F_RXCSUM, so let's enable it by
> default.

Same as the previous one, it should go to net-next and

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 06634d4f9b94..7d98f7828a30 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4591,7 +4591,8 @@ static int mvneta_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
> +	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> +			NETIF_F_TSO | NETIF_F_RXCSUM;
>  	dev->hw_features |= dev->features;
>  	dev->vlan_features |= dev->features;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> -- 
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
