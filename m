Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB8BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CDD2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI4h2kbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CDD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbeK2RJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeK2RJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:09:28 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82ED20868;
        Thu, 29 Nov 2018 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471516;
        bh=KrasYNHhk7/tioexZCt3+EB3k3Ffn3J9s19/DCwwuSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sI4h2kbGjsDL6O5FGkPobTuEv6OPJeL9A38AcEAaXfwxFmX11ygr5jxUjZY9q97W5
         390I0S0W/0HZquIbTohfyVNhpGueGTV6sGM6DP4rPd1hip8hykxC3P7otZiKydrZ7n
         X6IyQHnV3Dm5viCDvVMZUX9bIzvCvHmAjyG4Jny8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 09/13] net/mlx4_core: Fix uninitialized variable compilation warning
Date:   Thu, 29 Nov 2018 01:04:40 -0500
Message-Id: <20181129060444.160434-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060444.160434-1-sashal@kernel.org>
References: <20181129060444.160434-1-sashal@kernel.org>
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
index 0c51c69f802f..a4912b11e54f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -339,7 +339,7 @@ void mlx4_zone_allocator_destroy(struct mlx4_zone_allocator *zone_alloc)
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

