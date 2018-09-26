Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4408DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69BF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="FcVEV+v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69BF20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeIZSMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:12:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33890 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeIZSMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:12:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so1664273edr.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jL/Try4MLTvkdLbtOmgN7bPu7Rngi+17+4CuoKugKZ4=;
        b=FcVEV+v5/2nE185erwF7cRJfV1VRaSHtmlg+9WNxAJL2qx9RpGShX3lZ6P4hVCkk7j
         wxPbchAANI7fU5Zxx57SGXnTAhk7w0yzRO48xv8tderhaEkNe7XOiZ5Af6eIfy/6snMH
         Bvwu8f4P2MbGw38VXQDEKL1DXuezcCjybpy0yVC8LCpa2M65qwLygoKcMdEEUSzLitnp
         FRfjJF/l9TGPtHQwYeuF/EmEo8fk0qDxhpSXBxJwvK+0xAKuj5DsQANNzIhuv7vNv2OU
         qCd2bVGIGdwijfXRQlKfVDDzX+MOVUKeALBco74xtYjlzGnuIQ1E8F+VHKfFcchP/DzY
         Lpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jL/Try4MLTvkdLbtOmgN7bPu7Rngi+17+4CuoKugKZ4=;
        b=FkUtb0IEE4gJoH/UcfAhf/etAJgzkxzqD27nKOCqgK0GZCHyW0/GXDnea5za2MnmA2
         /B5zr7QAEQMMl2VtzcMtBhHENN8iaALGitNmDOsrOHGupX8jDvYYEHYXyQNTfNxH4tqO
         7oc2GcjMtldlXpYFWtcNZ2kriWsqM9+SxDVS1grB35ssrDyPWGOUUs/X9X3/iZR8lxCM
         zZbTRqpYYBfs8zaeAikugIlF4R+jwHhh9A+ALtE4aeOVDwRwSPo9RSq+PT4mUk5g999+
         I3WBjZLL6rPny7yeiuN+MSz4+k6aisib4rM4TsPnDG/M5jvCG4M0mhMetS/gimK//tFm
         jwhQ==
X-Gm-Message-State: ABuFfogKvHY8QK4xYR30cQfYWBEUxRHk7BLTx4Lav0/RXOWnMxTlnZuw
        bch2br0ebAALZokCH3efo9K0eg==
X-Google-Smtp-Source: ACcGV63vh2wXIYAoB9vCk5G4fTDoYlG8HtUO/RbqC1tYyP2Wjqbx/NTSCsmU8xBwNlptmG7yLAnowA==
X-Received: by 2002:a50:9f67:: with SMTP id b94-v6mr9157240edf.218.1537963202094;
        Wed, 26 Sep 2018 05:00:02 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([213.244.170.154])
        by smtp.gmail.com with ESMTPSA id r7-v6sm4204238eds.54.2018.09.26.05.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 05:00:01 -0700 (PDT)
Date:   Wed, 26 Sep 2018 12:59:58 +0100
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <kys@microsoft.com>,
        <haiyangz@microsoft.com>, <sthemmin@microsoft.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org
Subject: Re: [PATCH net-next] hv_netvsc: fix return type of ndo_start_xmit
 function
Message-ID: <20180926125958.4c7659c6@shemminger-XPS-13-9360>
In-Reply-To: <20180926102510.15696-1-yuehaibing@huawei.com>
References: <20180926102510.15696-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 18:25:10 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in
> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
> 
> As suggestion from Haiyang Zhang <haiyangz@microsoft.com>, if netvsc_vf_xmit
> fails, We are not sure if the error can go away after retrying, returning
> NETDEV_TX_BUSY may cause infinite retry from the upper layer.
> so just return NETDEV_TX_OK at there.
> 
> Found by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index ec69974..a1d44b4 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
>  	return rc;
>  }
>  
> -static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
> +static netdev_tx_t
> +netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  {
>  	struct net_device_context *net_device_ctx = netdev_priv(net);
>  	struct hv_netvsc_packet *packet = NULL;
> @@ -528,8 +529,10 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>  	 */
>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>  	if (vf_netdev && netif_running(vf_netdev) &&
> -	    !netpoll_tx_running(net))
> -		return netvsc_vf_xmit(net, vf_netdev, skb);
> +	    !netpoll_tx_running(net)) {
> +		netvsc_vf_xmit(net, vf_netdev, skb);
> +		return NETDEV_TX_OK;
> +	}
>  
>  	/* We will atmost need two pages to describe the rndis
>  	 * header. We can only transmit MAX_PAGE_BUFFER_COUNT number

Your patch loses the possible return values of netvsc_vf_xmit.
A suggested better fix would be to make netvsc_vf_xmit return netdev_tx_t type.
And this means the return value of dev_queue_xmit needs to be netdev_tx_t.

Please don't merge this as is.
