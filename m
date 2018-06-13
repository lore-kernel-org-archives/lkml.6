Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 446D0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3538208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="XViAtUEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3538208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935782AbeFMVsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:48:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44139 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935528AbeFMVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:48:16 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so2267987plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQQnPL7qCWmAlQyZyYvyZMFRpIZAVMa/1zxeRW+BUTs=;
        b=XViAtUEQF3QmtOgpVCCGbmUCSxs7biNkF8p7oBfSCHiLtAfw4MuQjjfVZ5npaIWJdo
         Q3mCsbtadC4wkTIODR08YdBJzpfO17rz5StTAwm9SOtLTl5jY32ludalXDAyWNTIYUrC
         mabmuAKmS89po1Kae/Ip9azShODqX/c3+wSR0w6aMg7HJ8mdNOTZ3G/iOe1IZx4ezId5
         +2B/m5/KrIgycYxYLJDjlv5rR9ZYz0LX9DkKp07OFZZ8p9sCCVH+4cMuvd6Pl7GUOBqM
         A/mmnHVkaj/zQGF+QfKt9VqxrOK2ZTKnEtT1yiLtMIHA7+xYH92yA7/sOpLGXYJGpKKt
         uLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQQnPL7qCWmAlQyZyYvyZMFRpIZAVMa/1zxeRW+BUTs=;
        b=pDukXu3RWlntu3cTyyfkmXJHn7+Tf31/CMNy5txjwoGSp66tzRFTB5ALjpPbi6oWb0
         fLIWO54dpFSPH485WEVgJjaIYPI1XOH25Ui7XQpc427CND6HOhXtaOb4qJ8jedLZefyb
         2k/8bExbJI+Ma2gGOqHfNtK0StqN1rqKPgbCwmWTjC1DEEBZ/f5xrU3IRETTJ1oSFiyR
         /iMpskPr4fZV/Y/AftfiaVMjwW/k96AaHQ5m9rD2aidzt2j+acmfa0P9HUxDY9lCT1TY
         QeHbTKDUwD+f3EkeRrXGRP7ZTR/Dl4u0bqlwUS5FPUBVKJafHc+SlmkLkkdzVo9CfvqK
         6ApQ==
X-Gm-Message-State: APt69E02Y9Ba2EDq1frl2zF2KQvOrBTWyCx8BOyHFmNCwwz+z2UasZHL
        y2diDJsQVyiZuyAFRDMhWH7NvQ==
X-Google-Smtp-Source: ADUXVKJm5WVg9IL7Vk5u1eIIOkrhc0/u0vXUQ49FZXMd8kQyFB6N+NU2+m815t6jxHSznt6Gb1biNQ==
X-Received: by 2002:a17:902:854a:: with SMTP id d10-v6mr6870168plo.106.1528926495389;
        Wed, 13 Jun 2018 14:48:15 -0700 (PDT)
Received: from xeon-e3 (204-195-35-107.wavecable.com. [204.195.35.107])
        by smtp.gmail.com with ESMTPSA id i7-v6sm11979012pfa.34.2018.06.13.14.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 14:48:15 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:48:13 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yidong Ren <yidren@linuxonhyperv.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Message-ID: <20180613144813.708f26bf@xeon-e3>
In-Reply-To: <20180613193608.444-1-yidren@linuxonhyperv.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 12:36:08 -0700
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
> ---
> Changes in v2:
>   - Remove cpp style comment
>   - Resubmit after freeze
> 
>  drivers/net/hyperv/hyperv_net.h |  11 +++++
>  drivers/net/hyperv/netvsc_drv.c | 104 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index 23304ac..c825353 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -873,6 +873,17 @@ struct netvsc_ethtool_stats {
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
> index 7b18a8c..6803aae 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1105,6 +1105,66 @@ static void netvsc_get_vf_stats(struct net_device *net,
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
> +	/* fetch percpu stats of vf */
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
> +	/* fetch percpu stats of netvsc */
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
> @@ -1202,6 +1262,23 @@ static const struct {
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
> @@ -1213,6 +1290,9 @@ static const struct {
>  #define NETVSC_GLOBAL_STATS_LEN	ARRAY_SIZE(netvsc_stats)
>  #define NETVSC_VF_STATS_LEN	ARRAY_SIZE(vf_stats)
>  
> +/* statistics per queue (rx/tx packets/bytes) */
> +#define NETVSC_PCPU_STATS_LEN (num_present_cpus() * ARRAY_SIZE(pcpu_stats))

Even though Hyper-V/Azure does not support hot plug cpu's it might be better
to num_cpu_possible to avoid any possible future surprises.
