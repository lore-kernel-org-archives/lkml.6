Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD5C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6A32081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6A32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeKCAkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:40:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeKCAkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:40:55 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0WLC-1fMOBW3fcK-00wWNP; Fri, 02 Nov 2018 16:33:18 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0WLC-1fMOBW3fcK-00wWNP; Fri, 02 Nov 2018 16:33:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/mlx5e: fix high stack usage
Date:   Fri,  2 Nov 2018 16:33:03 +0100
Message-Id: <20181102153316.1492515-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OveBdAHbt3etEfEt2tNFzSr13ZOEVW+pQc9Ran1E+5d9cg4A2cF
 nmLcgYt5LX2fcDQRrk/PT+F5WfSniKYrp/dp5tT0/N1kEEHZn/shNYzxdAHEYZfYFn9YaIO
 Ak9OfxUP7Ktlc3j1mUR8LI35SwLH3DyDl+ruo5LTbY+3Kry3FNSkkQmbauamcDZQIBvfOo9
 Hc0subv3+GU2v4F0fpbKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:adzmjQazuQQ=:pARDbIFm8I6NeTnZwX+TG2
 ecKQnbdzVtuQcrc1OPBZClwy6NgL1PXts4OnJhXe4VErYi67PdlHFICy2fZYjKgUOJTTWDTmH
 Rop/uSzP51/kB0kgcdPFZ+s09Xsgc+hO1RW/29xD5Yiyqeudr0PlpqMskVU6Kz24+v5xtzOcJ
 ebBDygvnV1/q8Dvhjt7TUPb4pxKBsTI3OqHH0UGS4o2vDA7YAegmlJDsWMVpLmRVUg69CRnQ7
 nEx3z9smn8GZX49AHzZptb7/3b0iLmk6FRo6O3p4oIPbzizZ+Tun6unLsDXpnuzP7yOe2fPY2
 vQqM921BPYsIHpoPkAdZ0s4v+QLpYyEeqsm4fib7fg0wEECMSfO4fLToKljD+os9mjAQx8aoN
 szQSPKxvSTmPTHlIIF6schG1eK8IFrqgY/N4Cm29iobkcD69SuCTJ9I4ddrWgrwJz6XdUP956
 jZeCv73jw3NNKwMGO7o5SsJpW4ejSvdPuS5fCNTC5Nw/oVKmslT0sqlMP6G88JaBDe2mIife/
 KtcoH9qzUXqEQFBXelYFocZG8JU0aKrwg0ggDccaEi0xiBFrnRCIYfOoln7NEP2aKX12Kdy0K
 mchYe7Xgt/kHeTZ9brbj5g40QcMmVwkB41nzlnoiUkBSXejwZVJPf+NLJ4yZ7BGRWDh8z8y5V
 kmB8oGDHPQHrgPImQoZlrrPAL0zjqf2wFqmhZr4dO9C/xZBcJ4bedUk8SZUnU1A1GDrW+/u8k
 /IqDtbyH2ZBxQ1g8Th3FVRFDOLttSGVaUfJJd+74cXOMxzwRNeHqfBCulunlfJwr7S1GXmc/a
 bilAhuo+HYbJ4qljYyJojd7FFpLhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A patch that looks harmless causes the stack usage of the mlx5e_grp_sw_update_stats()
function to drastically increase with x86 gcc-4.9 and higher (tested up to 8.1):

drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: In function ‘mlx5e_grp_sw_update_stats’:
drivers/net/ethernet/mellanox/mlx5/core/en_stats.c:216:1: warning: the frame size of 1276 bytes is larger than 500 bytes [-Wframe-larger-than=]

By splitting out the loop body into a non-inlined function, the stack size goes
back down to under 500 bytes.

Fixes: 779d986d60de ("net/mlx5e: Do not ignore netdevice TX/RX queues number")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 168 +++++++++---------
 1 file changed, 86 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1e55b9c27ffc..c270206f3475 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -126,93 +126,97 @@ static int mlx5e_grp_sw_fill_stats(struct mlx5e_priv *priv, u64 *data, int idx)
 	return idx;
 }
 
+static noinline_for_stack void
+mlx5e_grp_sw_collect_stat(struct mlx5e_priv *priv, struct mlx5e_sw_stats *s, int i)
+{
+	struct mlx5e_channel_stats *channel_stats = &priv->channel_stats[i];
+	struct mlx5e_xdpsq_stats *xdpsq_red_stats = &channel_stats->xdpsq;
+	struct mlx5e_xdpsq_stats *xdpsq_stats = &channel_stats->rq_xdpsq;
+	struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
+	struct mlx5e_ch_stats *ch_stats = &channel_stats->ch;
+	int j;
+
+	s->rx_packets	+= rq_stats->packets;
+	s->rx_bytes	+= rq_stats->bytes;
+	s->rx_lro_packets += rq_stats->lro_packets;
+	s->rx_lro_bytes	+= rq_stats->lro_bytes;
+	s->rx_ecn_mark	+= rq_stats->ecn_mark;
+	s->rx_removed_vlan_packets += rq_stats->removed_vlan_packets;
+	s->rx_csum_none	+= rq_stats->csum_none;
+	s->rx_csum_complete += rq_stats->csum_complete;
+	s->rx_csum_unnecessary += rq_stats->csum_unnecessary;
+	s->rx_csum_unnecessary_inner += rq_stats->csum_unnecessary_inner;
+	s->rx_xdp_drop     += rq_stats->xdp_drop;
+	s->rx_xdp_redirect += rq_stats->xdp_redirect;
+	s->rx_xdp_tx_xmit  += xdpsq_stats->xmit;
+	s->rx_xdp_tx_full  += xdpsq_stats->full;
+	s->rx_xdp_tx_err   += xdpsq_stats->err;
+	s->rx_xdp_tx_cqe   += xdpsq_stats->cqes;
+	s->rx_wqe_err   += rq_stats->wqe_err;
+	s->rx_mpwqe_filler_cqes    += rq_stats->mpwqe_filler_cqes;
+	s->rx_mpwqe_filler_strides += rq_stats->mpwqe_filler_strides;
+	s->rx_buff_alloc_err += rq_stats->buff_alloc_err;
+	s->rx_cqe_compress_blks += rq_stats->cqe_compress_blks;
+	s->rx_cqe_compress_pkts += rq_stats->cqe_compress_pkts;
+	s->rx_page_reuse  += rq_stats->page_reuse;
+	s->rx_cache_reuse += rq_stats->cache_reuse;
+	s->rx_cache_full  += rq_stats->cache_full;
+	s->rx_cache_empty += rq_stats->cache_empty;
+	s->rx_cache_busy  += rq_stats->cache_busy;
+	s->rx_cache_waive += rq_stats->cache_waive;
+	s->rx_congst_umr  += rq_stats->congst_umr;
+	s->rx_arfs_err    += rq_stats->arfs_err;
+	s->ch_events      += ch_stats->events;
+	s->ch_poll        += ch_stats->poll;
+	s->ch_arm         += ch_stats->arm;
+	s->ch_aff_change  += ch_stats->aff_change;
+	s->ch_eq_rearm    += ch_stats->eq_rearm;
+	/* xdp redirect */
+	s->tx_xdp_xmit    += xdpsq_red_stats->xmit;
+	s->tx_xdp_full    += xdpsq_red_stats->full;
+	s->tx_xdp_err     += xdpsq_red_stats->err;
+	s->tx_xdp_cqes    += xdpsq_red_stats->cqes;
+
+	for (j = 0; j < priv->max_opened_tc; j++) {
+		struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
+
+		s->tx_packets		+= sq_stats->packets;
+		s->tx_bytes		+= sq_stats->bytes;
+		s->tx_tso_packets	+= sq_stats->tso_packets;
+		s->tx_tso_bytes		+= sq_stats->tso_bytes;
+		s->tx_tso_inner_packets	+= sq_stats->tso_inner_packets;
+		s->tx_tso_inner_bytes	+= sq_stats->tso_inner_bytes;
+		s->tx_added_vlan_packets += sq_stats->added_vlan_packets;
+		s->tx_nop               += sq_stats->nop;
+		s->tx_queue_stopped	+= sq_stats->stopped;
+		s->tx_queue_wake	+= sq_stats->wake;
+		s->tx_udp_seg_rem	+= sq_stats->udp_seg_rem;
+		s->tx_queue_dropped	+= sq_stats->dropped;
+		s->tx_cqe_err		+= sq_stats->cqe_err;
+		s->tx_recover		+= sq_stats->recover;
+		s->tx_xmit_more		+= sq_stats->xmit_more;
+		s->tx_csum_partial_inner += sq_stats->csum_partial_inner;
+		s->tx_csum_none		+= sq_stats->csum_none;
+		s->tx_csum_partial	+= sq_stats->csum_partial;
+#ifdef CONFIG_MLX5_EN_TLS
+		s->tx_tls_ooo		+= sq_stats->tls_ooo;
+		s->tx_tls_resync_bytes	+= sq_stats->tls_resync_bytes;
+#endif
+		s->tx_cqes		+= sq_stats->cqes;
+	}
+}
+
 void mlx5e_grp_sw_update_stats(struct mlx5e_priv *priv)
 {
-	struct mlx5e_sw_stats temp, *s = &temp;
+	struct mlx5e_sw_stats s;
 	int i;
 
-	memset(s, 0, sizeof(*s));
-
-	for (i = 0; i < mlx5e_get_netdev_max_channels(priv->netdev); i++) {
-		struct mlx5e_channel_stats *channel_stats =
-			&priv->channel_stats[i];
-		struct mlx5e_xdpsq_stats *xdpsq_red_stats = &channel_stats->xdpsq;
-		struct mlx5e_xdpsq_stats *xdpsq_stats = &channel_stats->rq_xdpsq;
-		struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
-		struct mlx5e_ch_stats *ch_stats = &channel_stats->ch;
-		int j;
-
-		s->rx_packets	+= rq_stats->packets;
-		s->rx_bytes	+= rq_stats->bytes;
-		s->rx_lro_packets += rq_stats->lro_packets;
-		s->rx_lro_bytes	+= rq_stats->lro_bytes;
-		s->rx_ecn_mark	+= rq_stats->ecn_mark;
-		s->rx_removed_vlan_packets += rq_stats->removed_vlan_packets;
-		s->rx_csum_none	+= rq_stats->csum_none;
-		s->rx_csum_complete += rq_stats->csum_complete;
-		s->rx_csum_unnecessary += rq_stats->csum_unnecessary;
-		s->rx_csum_unnecessary_inner += rq_stats->csum_unnecessary_inner;
-		s->rx_xdp_drop     += rq_stats->xdp_drop;
-		s->rx_xdp_redirect += rq_stats->xdp_redirect;
-		s->rx_xdp_tx_xmit  += xdpsq_stats->xmit;
-		s->rx_xdp_tx_full  += xdpsq_stats->full;
-		s->rx_xdp_tx_err   += xdpsq_stats->err;
-		s->rx_xdp_tx_cqe   += xdpsq_stats->cqes;
-		s->rx_wqe_err   += rq_stats->wqe_err;
-		s->rx_mpwqe_filler_cqes    += rq_stats->mpwqe_filler_cqes;
-		s->rx_mpwqe_filler_strides += rq_stats->mpwqe_filler_strides;
-		s->rx_buff_alloc_err += rq_stats->buff_alloc_err;
-		s->rx_cqe_compress_blks += rq_stats->cqe_compress_blks;
-		s->rx_cqe_compress_pkts += rq_stats->cqe_compress_pkts;
-		s->rx_page_reuse  += rq_stats->page_reuse;
-		s->rx_cache_reuse += rq_stats->cache_reuse;
-		s->rx_cache_full  += rq_stats->cache_full;
-		s->rx_cache_empty += rq_stats->cache_empty;
-		s->rx_cache_busy  += rq_stats->cache_busy;
-		s->rx_cache_waive += rq_stats->cache_waive;
-		s->rx_congst_umr  += rq_stats->congst_umr;
-		s->rx_arfs_err    += rq_stats->arfs_err;
-		s->ch_events      += ch_stats->events;
-		s->ch_poll        += ch_stats->poll;
-		s->ch_arm         += ch_stats->arm;
-		s->ch_aff_change  += ch_stats->aff_change;
-		s->ch_eq_rearm    += ch_stats->eq_rearm;
-		/* xdp redirect */
-		s->tx_xdp_xmit    += xdpsq_red_stats->xmit;
-		s->tx_xdp_full    += xdpsq_red_stats->full;
-		s->tx_xdp_err     += xdpsq_red_stats->err;
-		s->tx_xdp_cqes    += xdpsq_red_stats->cqes;
-
-		for (j = 0; j < priv->max_opened_tc; j++) {
-			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[j];
-
-			s->tx_packets		+= sq_stats->packets;
-			s->tx_bytes		+= sq_stats->bytes;
-			s->tx_tso_packets	+= sq_stats->tso_packets;
-			s->tx_tso_bytes		+= sq_stats->tso_bytes;
-			s->tx_tso_inner_packets	+= sq_stats->tso_inner_packets;
-			s->tx_tso_inner_bytes	+= sq_stats->tso_inner_bytes;
-			s->tx_added_vlan_packets += sq_stats->added_vlan_packets;
-			s->tx_nop               += sq_stats->nop;
-			s->tx_queue_stopped	+= sq_stats->stopped;
-			s->tx_queue_wake	+= sq_stats->wake;
-			s->tx_udp_seg_rem	+= sq_stats->udp_seg_rem;
-			s->tx_queue_dropped	+= sq_stats->dropped;
-			s->tx_cqe_err		+= sq_stats->cqe_err;
-			s->tx_recover		+= sq_stats->recover;
-			s->tx_xmit_more		+= sq_stats->xmit_more;
-			s->tx_csum_partial_inner += sq_stats->csum_partial_inner;
-			s->tx_csum_none		+= sq_stats->csum_none;
-			s->tx_csum_partial	+= sq_stats->csum_partial;
-#ifdef CONFIG_MLX5_EN_TLS
-			s->tx_tls_ooo		+= sq_stats->tls_ooo;
-			s->tx_tls_resync_bytes	+= sq_stats->tls_resync_bytes;
-#endif
-			s->tx_cqes		+= sq_stats->cqes;
-		}
-	}
+	memset(&s, 0, sizeof(s));
+
+	for (i = 0; i < mlx5e_get_netdev_max_channels(priv->netdev); i++)
+		mlx5e_grp_sw_collect_stat(priv, &s, i);
 
-	memcpy(&priv->stats.sw, s, sizeof(*s));
+	memcpy(&priv->stats.sw, &s, sizeof(s));
 }
 
 static const struct counter_desc q_stats_desc[] = {
-- 
2.18.0

