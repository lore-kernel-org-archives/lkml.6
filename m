Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452EBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0258220820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258220820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKAQZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:25:59 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:41893 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727880AbeKAQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:25:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F36351855C;
        Thu,  1 Nov 2018 07:24:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fuel30_73b153814a05
X-Filterd-Recvd-Size: 2324
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Nov 2018 07:24:09 +0000 (UTC)
Message-ID: <f14db3287b23ed8af9bdbf8001e2e2fe7ae9e43a.camel@perches.com>
Subject: [PATCH V2] mlx5: Fix formats with line continuation whitespace
From:   Joe Perches <joe@perches.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Nov 2018 00:24:08 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The line continuations unintentionally add whitespace so
instead use coalesced formats to remove the whitespace.

Signed-off-by: Joe Perches <joe@perches.com>
---

v2: Remove excess space after %u

 drivers/net/ethernet/mellanox/mlx5/core/rl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index bc86dffdc43c..377b7e65ecf1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -188,8 +188,7 @@ int mlx5_rl_add_rate(struct mlx5_core_dev *dev, u16 *index,
 		/* new rate limit */
 		err = mlx5_set_pp_rate_limit_cmd(dev, entry->index, rl);
 		if (err) {
-			mlx5_core_err(dev, "Failed configuring rate limit(err %d): \
-				      rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
+			mlx5_core_err(dev, "Failed configuring rate limit(err %d): rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
 				      err, rl->rate, rl->max_burst_sz,
 				      rl->typical_pkt_sz);
 			goto out;
@@ -218,8 +217,7 @@ void mlx5_rl_remove_rate(struct mlx5_core_dev *dev, struct mlx5_rate_limit *rl)
 	mutex_lock(&table->rl_lock);
 	entry = find_rl_entry(table, rl);
 	if (!entry || !entry->refcount) {
-		mlx5_core_warn(dev, "Rate %u, max_burst_sz %u typical_pkt_sz %u \
-			       are not configured\n",
+		mlx5_core_warn(dev, "Rate %u, max_burst_sz %u typical_pkt_sz %u are not configured\n",
 			       rl->rate, rl->max_burst_sz, rl->typical_pkt_sz);
 		goto out;
 	}

