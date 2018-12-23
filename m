Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65DC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A7218FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeLWJd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 04:33:57 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44311
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727153AbeLWJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 04:33:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,386,1539640800"; 
   d="scan'208";a="289991764"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 23 Dec 2018 10:33:52 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] net/mlx5e: drop useless LIST_HEAD
Date:   Sun, 23 Dec 2018 09:56:57 +0100
Message-Id: <1545555435-24576-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop LIST_HEAD where the variable it declares is never used.

These became useless in 244cd96adb5f ("net_sched: remove list_head
from tc_action")

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
@@
- LIST_HEAD(x);
  ... when != x
// </smpl>

Fixes: 244cd96adb5f ("net_sched: remove list_head from tc_action")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Successfully 0-day tested on 151 configurations.

 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 4d6c9757afad..cae6c6d48984 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2183,7 +2183,6 @@ static bool modify_header_match_supported(struct mlx5_flow_spec *spec,
 {
 	const struct tc_action *a;
 	bool modify_ip_header;
-	LIST_HEAD(actions);
 	u8 htype, ip_proto;
 	void *headers_v;
 	u16 ethertype;
@@ -2272,7 +2271,6 @@ static int parse_tc_nic_actions(struct mlx5e_priv *priv, struct tcf_exts *exts,
 {
 	struct mlx5_nic_flow_attr *attr = flow->nic_attr;
 	const struct tc_action *a;
-	LIST_HEAD(actions);
 	u32 action = 0;
 	int err, i;
 
@@ -2511,7 +2509,6 @@ static int parse_tc_fdb_actions(struct mlx5e_priv *priv, struct tcf_exts *exts,
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct ip_tunnel_info *info = NULL;
 	const struct tc_action *a;
-	LIST_HEAD(actions);
 	bool encap = false;
 	u32 action = 0;
 	int err, i;

