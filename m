Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E969C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145BF213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9cVVz2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145BF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeK2RG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbeK2RG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:29 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 101C2213A2;
        Thu, 29 Nov 2018 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471337;
        bh=vnHw39sSLiP3aNn+SuRJ3TmeP8IWOb7Nyhs/Z49rCE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9cVVz2oKf8kmfOlncwWiCocUquj87VZyjlTBec85gg7dNgAmndrZzxgnC6Ww5Wg7
         tG3TNCam/QtBNtabtds2XNK6C+9RfOcSZDieMpZBFROTpAl/m0H7YrCiXZEDHICbM3
         5duWvtjDFQR5EPdL6B2kAEfLpkbFfnpEbDcLFeew=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 16/35] net/mlx4_core: Fix uninitialized variable compilation warning
Date:   Thu, 29 Nov 2018 01:00:50 -0500
Message-Id: <20181129060110.159878-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 3ea7e7ea53c9f6ee41cb69a29c375fe9dd9a56a7 ]

Initialize the uid variable to zero to avoid the compilation warning.

Fixes: 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index 6dabd983e7e0..94f4dc4a77e9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -337,7 +337,7 @@ void mlx4_zone_allocator_destroy(struct mlx4_zone_allocator *zone_alloc)
 static u32 __mlx4_alloc_from_zone(struct mlx4_zone_entry *zone, int count,
 				  int align, u32 skip_mask, u32 *puid)
 {
-	u32 uid;
+	u32 uid = 0;
 	u32 res;
 	struct mlx4_zone_allocator *zone_alloc = zone->allocator;
 	struct mlx4_zone_entry *curr_node;
-- 
2.17.1

