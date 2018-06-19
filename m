Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007B820661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007B820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754030AbeFSWcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:32:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51220 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbeFSWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:32:19 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 419N4b4FmTz1qvTq;
        Wed, 20 Jun 2018 00:32:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 419N4b2mwnz1qvTj;
        Wed, 20 Jun 2018 00:32:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id eW9L5c-Smoov; Wed, 20 Jun 2018 00:32:14 +0200 (CEST)
X-Auth-Info: Uh3cs2JNhUQoRIfTvXA/IcQ5wHsDggaN0rgl2M37QnjGFIjjvM6GseNt33bMY/+Q
Received: from igel.home (ppp-188-174-148-81.dynamic.mnet-online.de [188.174.148.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 20 Jun 2018 00:32:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 89E522C107E; Wed, 20 Jun 2018 00:32:13 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"
References: <20180615185645.8921-1-malat@debian.org>
        <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
        <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
        <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
        <m2tvq1672p.fsf@linux-m68k.org>
        <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
        <87o9g8geu0.fsf@igel.home>
        <816ef746-5278-1d51-1d9d-55593e377681@gmail.com>
        <CA+7wUszG3Tmq5qT7o7w7ttAU+bzyJfRORL_Qzk4wUG6y2gZUuw@mail.gmail.com>
        <21523399-92ee-f8da-1a3e-0561f62850b7@gmail.com>
        <dd6f13bc-c5f2-85f8-c08d-837bc024fc7c@gmail.com>
        <87po0mvbgl.fsf@igel.home>
        <e1790720-911b-4d04-2215-752ec612e3d7@gmail.com>
        <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com>
X-Yow:  I guess we can live on his POT FARM in HADES!!
Date:   Wed, 20 Jun 2018 00:32:13 +0200
In-Reply-To: <05645b90-d3bc-466d-116f-548f3ee39de9@gmail.com> (Eric Dumazet's
        message of "Tue, 19 Jun 2018 15:10:14 -0700")
Message-ID: <87lgbav24y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 19 2018, Eric Dumazet <eric.dumazet@gmail.com> wrote:

> diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
> index 7a16d40a72d13cf1d522e8a3a396c826fe76f9b9..672d6748ab44f0890e92d5ca55d6ff6834c20dc9 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -60,8 +60,7 @@
>  #include <linux/sungem_phy.h>
>  #include "sungem.h"
>  
> -/* Stripping FCS is causing problems, disabled for now */
> -#undef STRIP_FCS
> +#define STRIP_FCS
>  
>  #define DEFAULT_MSG    (NETIF_MSG_DRV          | \
>                          NETIF_MSG_PROBE        | \
> @@ -435,7 +434,7 @@ static int gem_rxmac_reset(struct gem *gp)
>         writel(desc_dma & 0xffffffff, gp->regs + RXDMA_DBLOW);
>         writel(RX_RING_SIZE - 4, gp->regs + RXDMA_KICK);
>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>         writel(val, gp->regs + RXDMA_CFG);
>         if (readl(gp->regs + GREG_BIFCFG) & GREG_BIFCFG_M66EN)
>                 writel(((5 & RXDMA_BLANK_IPKTS) |
> @@ -857,6 +856,14 @@ static int gem_rx(struct gem *gp, int work_to_do)
>  
>                 csum = (__force __sum16)htons((status & RXDCTRL_TCPCSUM) ^ 0xffff);
>                 skb->csum = csum_unfold(csum);
> +               {
> +               __wsum rsum = csum_partial(skb->data + ETH_HLEN, len - ETH_HLEN, 0);
> +               if (csum != csum_fold(rsum) && net_ratelimit())
> +                       pr_err("sungem wrong csum : %x/%x, len %u bytes\n",
> +                               csum, csum_fold(rsum), len);
> +                       print_hex_dump(KERN_ERR, "raw data: ", DUMP_PREFIX_OFFSET,
> +                                           16, 1, skb->data, len, true);
> +               }
>                 skb->ip_summed = CHECKSUM_COMPLETE;
>                 skb->protocol = eth_type_trans(skb, gp->dev);
>  
> @@ -1761,7 +1768,7 @@ static void gem_init_dma(struct gem *gp)
>         writel(0, gp->regs + TXDMA_KICK);
>  
>         val = (RXDMA_CFG_BASE | (RX_OFFSET << 10) |
> -              ((14 / 2) << 13) | RXDMA_CFG_FTHRESH_128);
> +              (ETH_HLEN << 13) | RXDMA_CFG_FTHRESH_128);
>         writel(val, gp->regs + RXDMA_CFG);
>  
>         writel(desc_dma >> 32, gp->regs + RXDMA_DBHI);

With that patch I still get the wrong csum messages, but no longer the
hw csum failure messages (tested on a PowerMac G5).

[  662.659767] sungem: sungem wrong csum : 8359/7ca6, len 86 bytes, c0000001fee9cc02
[  662.659775] raw data: 00000000: 00 0d 93 43 81 62 d4 3d 7e 4c 48 b7 86 dd 61 01  ...C.b.=~LH...a.
[  662.659778] raw data: 00000010: 1c 1e 00 20 06 40 20 01 0a 62 17 11 88 01 00 00  ... .@ ..b......
[  662.659780] raw data: 00000020: 00 00 00 00 0a 38 20 01 0a 62 17 11 88 01 00 00  .....8 ..b......
[  662.659783] raw data: 00000030: 00 00 00 00 00 07 9a 18 00 16 c1 9a 7e ea ea 44  ............~..D
[  662.659785] raw data: 00000040: fb 4a 80 10 05 93 44 08 00 00 01 01 08 0a 59 68  .J....D.......Yh
[  662.659788] raw data: 00000050: ba e2 0e bb ac ae                                ......

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
