Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1269420665
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="AncxuAb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfBWQq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:46:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38108 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfBWQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:46:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so2518144pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 08:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tqvMGNGecekmRBMhWxcCbgkjDH0E0cWlXiOAYIkicQ=;
        b=AncxuAb6VmxEHCMCfnlHnFv7ycW0twGHcjGW5aayXJk7VX1A081i2rx+NbzVer9wye
         9+iHAdSkp3a0bs6KR9qEMEU9v5XmOVYpdIRqfhyRtvtP57RAlbG8jyU1Cs+uxczrdcxt
         LCgv3QYLuk6XI+xgM9ann/5ClFZKSAxW8ziUgoTKzb52ogjF7g3k3Dm4HlS0t0bRgrOu
         8sra4eEW6nc4mAsHm+EjiSmF/ziienzj8jJ0J2E6UoUsLl3a3G7EvvnNzJuylfsI/yo6
         /malusikt+BA+DCMPMM2CUorsEXKtGYcnfDDfP7kB+g56c+ZSc96YPKsh0psoZhCfPxf
         YKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tqvMGNGecekmRBMhWxcCbgkjDH0E0cWlXiOAYIkicQ=;
        b=bnQf/PcXFcAv8uZMlvrbkLe9vwDtooF1hevnEdh7HHt9bhZZvzKz1R/a7zHBo+mBvZ
         lsw60KFjgV0uWvKn5OfRQroGJhwftrfFLnOiKqZq5d4jkZc/X/uznWLzVUcJ0hqVn8A3
         U7z3ObnJbGmPwr7Wn8w7JiCyW60hdDibuY+XRTpl3vBmSiKwr7fFby9PJajEp9JD1EkJ
         fbYmrOaZV80CayBvJy+yHPpjO5AQey6T4OAAdFd/9QSCvJ8voViT0XgV2X/ETTqZ18Hg
         2bUqRIikom3tV68Fk6Np8zSihc6ZkZCY1wW9524nKFYuPOdWqJ9iW0f8mJhMbgOKhuMZ
         D6NA==
X-Gm-Message-State: AHQUAubN1Y57/xrQo9XxdGJGCDbl4/AoDsvTPWYbsXQ6332VfMs8Hw0i
        id6NJhZ+bSAUMnO+HstyxFg0ow==
X-Google-Smtp-Source: AHgI3IaU523gIjoHB2EhTWDud8WZI/ynj1FZXghUhuprmUeB0zQI5pmnA7AVAO/70UshsdVjaIZZxw==
X-Received: by 2002:a63:7f46:: with SMTP id p6mr9565771pgn.54.1550940388010;
        Sat, 23 Feb 2019 08:46:28 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 33sm14689464pgs.81.2019.02.23.08.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 08:46:27 -0800 (PST)
Date:   Sat, 23 Feb 2019 08:46:24 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, sashal@kernel.org,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH hyperv-fixes] hv_netvsc: Fix IP header checksum for
 coalesced packets
Message-ID: <20190223084624.0d0c60a0@shemminger-XPS-13-9360>
In-Reply-To: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
References: <20190222182503.12160-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 18:25:03 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Incoming packets may have IP header checksum verified by the host.
> They may not have IP header checksum computed after coalescing.
> This patch re-compute the checksum when necessary, otherwise the
> packets may be dropped, because Linux network stack always checks it.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 256adbd044f5..cf4897043e83 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -744,6 +744,14 @@ void netvsc_linkstatus_callback(struct net_device *net,
>  	schedule_delayed_work(&ndev_ctx->dwork, 0);
>  }
>  
> +static void netvsc_comp_ipcsum(struct sk_buff *skb)
> +{
> +	struct iphdr *iph = (struct iphdr *)skb->data;

Can you use iphdr(skb) here?

> +
> +	iph->check = 0;
> +	iph->check = ip_fast_csum(iph, iph->ihl);
> +}
> +
>  static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
>  					     struct netvsc_channel *nvchan)
>  {
> @@ -770,9 +778,17 @@ static struct sk_buff *netvsc_alloc_recv_skb(struct net_device *net,
>  	/* skb is already created with CHECKSUM_NONE */
>  	skb_checksum_none_assert(skb);
>  
> -	/*
> -	 * In Linux, the IP checksum is always checked.
> -	 * Do L4 checksum offload if enabled and present.
> +	/* Incoming packets may have IP header checksum verified by the host.
> +	 * They may not have IP header checksum computed after coalescing.
> +	 * We compute it here if the flags are set, because on Linux, the IP
> +	 * checksum is always checked.
> +	 */
> +	if (csum_info && csum_info->receive.ip_checksum_value_invalid &&
> +	    csum_info->receive.ip_checksum_succeeded &&
> +	    skb->protocol == htons(ETH_P_IP))
> +		netvsc_comp_ipcsum(skb);

Does this still handle for coalesced and non-coalesced packets
which are received with bad IP checksum?  My concern is that you are
potentially correcting the checksum for a packet whose received checksum was bad.


> +	/* Do L4 checksum offload if enabled and present.
>  	 */
>  	if (csum_info && (net->features & NETIF_F_RXCSUM)) {
>  		if (csum_info->receive.tcp_checksum_succeeded ||

