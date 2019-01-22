Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35063C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35A921726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQhfa5RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfAVSjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:39:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAVSjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:39:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so11457778pga.1;
        Tue, 22 Jan 2019 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SW4sZfyX/rWo6+G2R9SWeIhtQZr5Q33r0MmBtL/GBpw=;
        b=eQhfa5REZCusdXU0RiDKjjhrC4Bh5nmq+pYduRnUYgR0DLaEdXXpLFaVUBfonVPLIx
         FQIZL/mZ1dApjXohlMbFD37ChWPwG+ublpJZXXXi+WM36J+BHoqjPFX647JsrIe9NlxR
         7tEeLpoTXFXEIvrgvBIpy8qZvUH7/7f8neSvcSz6/k1lYNuvV88zkEWoU94PDjtoT7Dx
         I10NwPpcTNHW6maeVTLOAcBlg5cQQyhvoFcln7471in/Tb60o9Yqj7pecmCgKuaray2b
         4Z7SVi66B0dmwn+btcfrMLAGIhePOWt7gZWZ02yvcxNbfRk92mZc3UOtfZyQ5BEDXgkB
         O22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SW4sZfyX/rWo6+G2R9SWeIhtQZr5Q33r0MmBtL/GBpw=;
        b=lCtVcQjCDRd9EZFL/ku3Dp9En5buqcrSFonXQKHQvSIv1em74PhgK0TjdQC8hxgBwe
         gBUu6dnipowCzML15v+jEjIRukIR3JfbEby5SyhYKhtoMXKZmKVG6CYt6/0n1Y53xG+o
         eNGsFH0/hS38UlGG2clr8s/lwAA1EcciteQgrnF98Ey8L0OsIbUloC3FvPrNGzzGH2kQ
         cuAvFt7AfCMsO+YAQyJilxY5wvqkXblVHwSDW2N0I64mZkYSq0Vc/p0PNHQqGnVwF/7C
         dwS+4NeWzWGjvx7f4iJD8g78ehV37+rjDdhUTc6b1qTCEXXvEZYQlqX2RusIvWfldrEg
         k3sw==
X-Gm-Message-State: AJcUukeKNlK96K/tGIcpNWSZm0n+QVWScNs6og6dDJGi3AjQLd5ZlsB9
        AVa6/E3RJaG+sxDT6PAnJNuev+md
X-Google-Smtp-Source: ALg8bN4r7eusdDb+96AQzapxeCV/aaqgqd9z2W3UlFmLKi1ouFZDpJI4PdkGCNKMon+HExLhCPJDmQ==
X-Received: by 2002:a63:4665:: with SMTP id v37mr33512445pgk.425.1548182371955;
        Tue, 22 Jan 2019 10:39:31 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id w128sm21741917pfw.79.2019.01.22.10.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 10:39:30 -0800 (PST)
Subject: Re: [PATCH net-next 02/12] net: hns3: add rx multicast packets
 statistic
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangdaode@hisilicon.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, linuxarm@huawei.com,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>
References: <20190122163940.7876-1-tanhuazhong@huawei.com>
 <20190122163940.7876-3-tanhuazhong@huawei.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c915dbd7-8a04-9b38-bb5f-a3e8340ce6a2@gmail.com>
Date:   Tue, 22 Jan 2019 10:39:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190122163940.7876-3-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/22/2019 08:39 AM, Huazhong Tan wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> This patch adds rx multicast packets statistic for each ring.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 9 +++++++++
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 8 ++++++++
>  drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 1 +
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 9dd8949381bc..f1ab2e4ca49e 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2572,6 +2572,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
>  			     struct sk_buff **out_skb)
>  {
>  	struct net_device *netdev = ring->tqp->handle->kinfo.netdev;
> +	enum hns3_pkt_l2t_type l2_frame_type;
>  	struct sk_buff *skb = ring->skb;
>  	struct hns3_desc_cb *desc_cb;
>  	struct hns3_desc *desc;
> @@ -2680,6 +2681,14 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
>  		return -EFAULT;
>  	}
>  
> +	l2_frame_type = hnae3_get_field(l234info, HNS3_RXD_DMAC_M,
> +					HNS3_RXD_DMAC_S);
> +	if (l2_frame_type == HNS3_L2_TYPE_MULTICAST) {
> +		u64_stats_update_begin(&ring->syncp);
> +		ring->stats.rx_multicast++;
> +		u64_stats_update_end(&ring->syncp);
> +	}
> +
>  	u64_stats_update_begin(&ring->syncp);


This is a bit suboptimal to call u64_stats_update_begin() twice.

You could rewrite the thing to be :

        u64_stats_update_begin(&ring->syncp);
        if (l2_frame_type == HNS3_L2_TYPE_MULTICAST)
             ring->stats.rx_multicast++;
           
	ring->stats.rx_pkts++;
	...

>  	ring->stats.rx_pkts++;
>  	ring->stats.rx_bytes += skb->len;
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
> index f59ab7387b1f..f3d248626ab3 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
> @@ -202,6 +202,13 @@ enum hns3_nic_state {
>  
>  #define HNS3_RING_EN_B				0
>  
> +enum hns3_pkt_l2t_type {
> +	HNS3_L2_TYPE_UNICAST,
> +	HNS3_L2_TYPE_MULTICAST,
> +	HNS3_L2_TYPE_BROADCAST,
> +	HNS3_L2_TYPE_INVALID,
> +};
> +
>  enum hns3_pkt_l3t_type {
>  	HNS3_L3T_NONE,
>  	HNS3_L3T_IPV6,
> @@ -376,6 +383,7 @@ struct ring_stats {
>  			u64 err_bd_num;
>  			u64 l2_err;
>  			u64 l3l4_csum_err;
> +			u64 rx_multicast;
>  		};
>  	};
>  };
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index e678b6939da3..abb78696d7ce 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -47,6 +47,7 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>  	HNS3_TQP_STAT("err_bd_num", err_bd_num),
>  	HNS3_TQP_STAT("l2_err", l2_err),
>  	HNS3_TQP_STAT("l3l4_csum_err", l3l4_csum_err),
> +	HNS3_TQP_STAT("multicast", rx_multicast),
>  };
>  
>  #define HNS3_RXQ_STATS_COUNT ARRAY_SIZE(hns3_rxq_stats)
> 
