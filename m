Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n28lA+hhGFtqQQAAmS7hNA
	; Wed, 06 Jun 2018 22:54:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 233DB608BA; Wed,  6 Jun 2018 22:54:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="uzkhZCtj"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F009607E4;
	Wed,  6 Jun 2018 22:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F009607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeFFWyB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:54:01 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45196 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752994AbeFFWx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:53:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so3707190pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzmeGuIcRuwejLCbixLkEuK00HHZiqlIYQYMVxQ5BuY=;
        b=uzkhZCtjGQW3kwhIby7acYqizPW/IUmasCOLWXtDB01sbKO4eYtDYtWr4D0UUqlEW2
         pS+s8zxVd4vzKVwwpKS2rNXGVCtWZ96PfN6nIW+3aCVUwnDfG5LURiR+wAv9/KSOa6Wn
         VjTBozmhuhA/rcZg0OiNdSoRBACrfcYkMthXRcaOpWS/PshpEbxkOzMiOxjos0kW2gP1
         ixqvTzdQeDo7LMCA+x+gTXu5xNl5O9VJu4WRZYoDp+qWUcvKfBQCecOLuNJvhR7bpcwC
         q3znOPCJ4rXdRHXGMe31KhqUOPyPayAejOS9kVsNGa4DNlgYH39CJhyCFetPeXmV9Q/R
         vOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzmeGuIcRuwejLCbixLkEuK00HHZiqlIYQYMVxQ5BuY=;
        b=TjW/xhNjD7bU+tN/Tqh2yf3tqGmMj39k73UPI4f/pIuqs1RBLF/r+z5qP9MQFKAYUl
         bfI6TM2H3guR5DrikmXKOIfr7vNUwKYvpq2hHPOCXsBxCPT+BOzeOsi4TFBH9ag5hqjF
         NqdCL0nvhoPPHepPaD5N1Zu3cjpkMB7pblL82hmFBzxr6Qi0SeODLlIVyEHNy/n7cMXf
         EgEazZohLUsfA8XXmQ3miCASO3o7bESEJy9K+V/oLyMV6Rjm5s3VciqFO0bE95F/E31A
         Bmp18aieBfLLU2Vn/jWTvafhdjm8zr5YqEAMXA+xyRBnZPDY41li+bs3Jg9fdaADcSM2
         QbrQ==
X-Gm-Message-State: APt69E3P7eZDePQtO6HBCbnCXL4n37CqeZQwZn359GnKQbY88pxdJzgQ
        l4POfhDTW4PmASs8ryDryotLaNnWZ5c=
X-Google-Smtp-Source: ADUXVKINaK/XalQTE1qAI07j72OLGFb8+uk4zXhac5rFSECFiGm6D6Yddq2pqrvE3Z9iNr1BSRyLWA==
X-Received: by 2002:a63:6383:: with SMTP id x125-v6mr3937702pgb.277.1528325639031;
        Wed, 06 Jun 2018 15:53:59 -0700 (PDT)
Received: from xeon-e3 (204-195-35-107.wavecable.com. [204.195.35.107])
        by smtp.gmail.com with ESMTPSA id u13-v6sm21054051pfh.147.2018.06.06.15.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 15:53:58 -0700 (PDT)
Date: Wed, 6 Jun 2018 15:53:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yidong Ren <yidren@linuxonhyperv.com>
Cc: yidren@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, davem@davemloft.net,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc: Add per-cpu ethtool stats for netvsc
Message-ID: <20180606155356.75a9378b@xeon-e3>
In-Reply-To: <20180606222700.24732-1-yidren@linuxonhyperv.com>
References: <20180606222700.24732-1-yidren@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jun 2018 15:27:00 -0700
Yidong Ren <yidren@linuxonhyperv.com> wrote:

> From: Yidong Ren <yidren@microsoft.com>
> 
> This patch implements following ethtool stats fields for netvsc:
> cpu<n>_tx/rx_packets/bytes
> cpu<n>_vf_tx/rx_packets/bytes
> 
> Corresponding per-cpu counters exist in current code. Exposing these
> counters will help troubleshooting performance issues.
> 
> Signed-off-by: Yidong Ren <yidren@microsoft.com>

This patch would be targeted for net-next (davem's tree);
but net-next is currently closed until 4.19-rc1 is done.

> ---
>  drivers/net/hyperv/hyperv_net.h |  11 ++++
>  drivers/net/hyperv/netvsc_drv.c | 104 +++++++++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index 960f06141472..f8c798bf9418 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -710,6 +710,17 @@ struct netvsc_ethtool_stats {
>  	unsigned long wake_queue;
>  };
>  
> +struct netvsc_ethtool_pcpu_stats {
> +	u64     rx_packets;
> +	u64     rx_bytes;
> +	u64     tx_packets;
> +	u64     tx_bytes;
> +	u64     vf_rx_packets;
> +	u64     vf_rx_bytes;
> +	u64     vf_tx_packets;
> +	u64     vf_tx_bytes;
> +};
> +
>  struct netvsc_vf_pcpu_stats {
>  	u64     rx_packets;
>  	u64     rx_bytes;
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index da07ccdf84bf..c43e64606c1a 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1104,6 +1104,66 @@ static void netvsc_get_vf_stats(struct net_device *net,
>  	}
>  }
>  
> +static void netvsc_get_pcpu_stats(struct net_device *net,
> +				  struct netvsc_ethtool_pcpu_stats
> +					__percpu *pcpu_tot)
> +{
> +	struct net_device_context *ndev_ctx = netdev_priv(net);
> +	struct netvsc_device *nvdev = rcu_dereference_rtnl(ndev_ctx->nvdev);
> +	int i;
> +
> +	// fetch percpu stats of vf

If you ran checkpatch you would see that Linux always uses C style
comments, and not C++ style //

> +	for_each_possible_cpu(i) {
> +		const struct netvsc_vf_pcpu_stats *stats =
> +			per_cpu_ptr(ndev_ctx->vf_stats, i);
> +		struct netvsc_ethtool_pcpu_stats *this_tot =
> +			per_cpu_ptr(pcpu_tot, i);
> +		unsigned int start;
> +
> +		do {
> +			start = u64_stats_fetch_begin_irq(&stats->syncp);
> +			this_tot->vf_rx_packets = stats->rx_packets;
> +			this_tot->vf_tx_packets = stats->tx_packets;
> +			this_tot->vf_rx_bytes = stats->rx_bytes;
> +			this_tot->vf_tx_bytes = stats->tx_bytes;
> +		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
> +		this_tot->rx_packets = this_tot->vf_rx_packets;
> +		this_tot->tx_packets = this_tot->vf_tx_packets;
> +		this_tot->rx_bytes   = this_tot->vf_rx_bytes;
> +		this_tot->tx_bytes   = this_tot->vf_tx_bytes;
> +	}
> +
> +	// fetch percpu stats of netvsc
> +	for (i = 0; i < nvdev->num_chn; i++) {
> +		const struct netvsc_channel *nvchan = &nvdev->chan_table[i];
> +		const struct netvsc_stats *stats;
> +		struct netvsc_ethtool_pcpu_stats *this_tot =
> +			per_cpu_ptr(pcpu_tot, nvchan->channel->target_cpu);
> +		u64 packets, bytes;
> +		unsigned int start;
> +
> +		stats = &nvchan->tx_stats;
> +		do {
> +			start = u64_stats_fetch_begin_irq(&stats->syncp);
> +			packets = stats->packets;
> +			bytes = stats->bytes;
> +		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
> +
> +		this_tot->tx_bytes	+= bytes;
> +		this_tot->tx_packets	+= packets;
> +
> +		stats = &nvchan->rx_stats;
> +		do {
> +			start = u64_stats_fetch_begin_irq(&stats->syncp);
> +			packets = stats->packets;
> +			bytes = stats->bytes;
> +		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
> +
> +		this_tot->rx_bytes	+= bytes;
> +		this_tot->rx_packets	+= packets;
> +	}
> +}
> +
>  static void netvsc_get_stats64(struct net_device *net,
>  			       struct rtnl_link_stats64 *t)
>  {
> @@ -1201,6 +1261,23 @@ static const struct {
>  	{ "rx_no_memory", offsetof(struct netvsc_ethtool_stats, rx_no_memory) },
>  	{ "stop_queue", offsetof(struct netvsc_ethtool_stats, stop_queue) },
>  	{ "wake_queue", offsetof(struct netvsc_ethtool_stats, wake_queue) },
> +}, pcpu_stats[] = {
> +	{ "cpu%u_rx_packets",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, rx_packets) },
> +	{ "cpu%u_rx_bytes",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, rx_bytes) },
> +	{ "cpu%u_tx_packets",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, tx_packets) },
> +	{ "cpu%u_tx_bytes",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, tx_bytes) },
> +	{ "cpu%u_vf_rx_packets",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, vf_rx_packets) },
> +	{ "cpu%u_vf_rx_bytes",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, vf_rx_bytes) },
> +	{ "cpu%u_vf_tx_packets",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, vf_tx_packets) },
> +	{ "cpu%u_vf_tx_bytes",
> +		offsetof(struct netvsc_ethtool_pcpu_stats, vf_tx_bytes) },
>  }, vf_stats[] = {
>  	{ "vf_rx_packets", offsetof(struct netvsc_vf_pcpu_stats, rx_packets) },
>  	{ "vf_rx_bytes",   offsetof(struct netvsc_vf_pcpu_stats, rx_bytes) },
> @@ -1212,6 +1289,9 @@ static const struct {
>  #define NETVSC_GLOBAL_STATS_LEN	ARRAY_SIZE(netvsc_stats)
>  #define NETVSC_VF_STATS_LEN	ARRAY_SIZE(vf_stats)
>  
> +/* statistics per queue (rx/tx packets/bytes) */
> +#define NETVSC_PCPU_STATS_LEN (num_present_cpus() * ARRAY_SIZE(pcpu_stats))
> +
>  /* 4 statistics per queue (rx/tx packets/bytes) */
>  #define NETVSC_QUEUE_STATS_LEN(dev) ((dev)->num_chn * 4)
>  
> @@ -1227,6 +1307,7 @@ static int netvsc_get_sset_count(struct net_device *dev, int string_set)
>  	case ETH_SS_STATS:
>  		return NETVSC_GLOBAL_STATS_LEN
>  			+ NETVSC_VF_STATS_LEN
> +			+ NETVSC_PCPU_STATS_LEN
>  			+ NETVSC_QUEUE_STATS_LEN(nvdev);
>  	default:
>  		return -EINVAL;
> @@ -1241,9 +1322,10 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
>  	const void *nds = &ndc->eth_stats;
>  	const struct netvsc_stats *qstats;
>  	struct netvsc_vf_pcpu_stats sum;
> +	struct netvsc_ethtool_pcpu_stats __percpu *pcpu_sum;
>  	unsigned int start;
>  	u64 packets, bytes;
> -	int i, j;
> +	int i, j, cpu;
>  
>  	if (!nvdev)
>  		return;
> @@ -1255,6 +1337,17 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
>  	for (j = 0; j < NETVSC_VF_STATS_LEN; j++)
>  		data[i++] = *(u64 *)((void *)&sum + vf_stats[j].offset);
>  
> +	pcpu_sum = alloc_percpu(struct netvsc_ethtool_pcpu_stats);
> +	netvsc_get_pcpu_stats(dev, pcpu_sum);
> +	for_each_present_cpu(cpu) {
> +		struct netvsc_ethtool_pcpu_stats *this_sum =
> +			per_cpu_ptr(pcpu_sum, cpu);
> +		for (j = 0; j < ARRAY_SIZE(pcpu_stats); j++)
> +			data[i++] = *(u64 *)((void *)this_sum
> +					     + pcpu_stats[j].offset);
> +	}
> +	free_percpu(pcpu_sum);
> +
>  	for (j = 0; j < nvdev->num_chn; j++) {
>  		qstats = &nvdev->chan_table[j].tx_stats;
>  
> @@ -1282,7 +1375,7 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  	struct net_device_context *ndc = netdev_priv(dev);
>  	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
>  	u8 *p = data;
> -	int i;
> +	int i, cpu;
>  
>  	if (!nvdev)
>  		return;
> @@ -1299,6 +1392,13 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  			p += ETH_GSTRING_LEN;
>  		}
>  
> +		for_each_present_cpu(cpu) {
> +			for (i = 0; i < ARRAY_SIZE(pcpu_stats); i++) {
> +				sprintf(p, pcpu_stats[i].name, cpu);
> +				p += ETH_GSTRING_LEN;
> +			}
> +		}
> +
>  		for (i = 0; i < nvdev->num_chn; i++) {
>  			sprintf(p, "tx_queue_%u_packets", i);
>  			p += ETH_GSTRING_LEN;
