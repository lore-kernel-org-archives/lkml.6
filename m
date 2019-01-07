Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D9EC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442B220859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865326;
	bh=iPqK5ARZlb/Zk8wRnJOV3VRApZslQWloF2H/71ee4Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhZxMaaBwXgnul9PaMx9P6x7UJT6Qn/SinYZmGznG6eswlOR4w4VhYvvgWEjBl1VY
	 nS9WvGd9UeJt6YMJ2GC04v6iyQwM0JQ6DOrimnif1KyaWmcF/vec3TkgUNrKbzrHA1
	 gzpuF0phbz/QPNNc5o+0mVLbRoDjTAV2pvInXkS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfAGMso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbfAGMsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A23206BB;
        Mon,  7 Jan 2019 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865320;
        bh=iPqK5ARZlb/Zk8wRnJOV3VRApZslQWloF2H/71ee4Eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2S1DWkjIU/UOyTDN9ITvjGODLLjCE4D7QbeCrVTJ0hhqooNKUcJhBbhRGGziptHpW
         hxIyyzDFUfdYfqeM0bzbhIXFS6IlQfNxsRl8Vrwq5zdQvWEAZ9HvvB+6iYXTnzzdKS
         9xsfrYsDV/sqZvcka+10/1I/Xps7VD0fz42ffWCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikhael Goikhman <migo@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 054/170] net/mlx5e: Remove unused UDP GSO remaining counter
Date:   Mon,  7 Jan 2019 13:31:21 +0100
Message-Id: <20190107104459.489380612@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhael Goikhman <migo@mellanox.com>

[ Upstream commit d13b224f431579fe2d712871d4265d7a22ca6c9c ]

Remove tx_udp_seg_rem counter from ethtool output, as it is no longer
being updated in the driver's data flow.

Fixes: 3f44899ef2ce ("net/mlx5e: Use PARTIAL_GSO for UDP segmentation")
Signed-off-by: Mikhael Goikhman <migo@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    2 --
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |    2 --
 2 files changed, 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -73,7 +73,6 @@ static const struct counter_desc sw_stat
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_recover) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_queue_wake) },
-	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_udp_seg_rem) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_cqe_err) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_xmit) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, tx_xdp_full) },
@@ -194,7 +193,6 @@ void mlx5e_grp_sw_update_stats(struct ml
 			s->tx_nop               += sq_stats->nop;
 			s->tx_queue_stopped	+= sq_stats->stopped;
 			s->tx_queue_wake	+= sq_stats->wake;
-			s->tx_udp_seg_rem	+= sq_stats->udp_seg_rem;
 			s->tx_queue_dropped	+= sq_stats->dropped;
 			s->tx_cqe_err		+= sq_stats->cqe_err;
 			s->tx_recover		+= sq_stats->recover;
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -86,7 +86,6 @@ struct mlx5e_sw_stats {
 	u64 tx_recover;
 	u64 tx_cqes;
 	u64 tx_queue_wake;
-	u64 tx_udp_seg_rem;
 	u64 tx_cqe_err;
 	u64 tx_xdp_xmit;
 	u64 tx_xdp_full;
@@ -217,7 +216,6 @@ struct mlx5e_sq_stats {
 	u64 csum_partial_inner;
 	u64 added_vlan_packets;
 	u64 nop;
-	u64 udp_seg_rem;
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_ooo;
 	u64 tls_resync_bytes;


