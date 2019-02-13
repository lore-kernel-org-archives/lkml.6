Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB5C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6552175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026007;
	bh=0tmh0wvFxTd4k9xWE03YRdq7RrAQZeA4/z7qCwVhCUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J5QlcQhLisdkWAk2jHecJyi92XeWC9202cwVsWZ6aG7x3AGgaJvqvJCxVLed+cra6
	 w59cXr8MnO/nCorn0R3OSmRtogWWPnjEOHf4Q8qLzPqpKS16Q0BMrKsOjkcweiTHpS
	 tZrojNwHhjycIHTq6/iAYSQZf85jZvn0m2oy2v0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389720AbfBMCqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbfBMCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C50222CC;
        Wed, 13 Feb 2019 02:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025637;
        bh=0tmh0wvFxTd4k9xWE03YRdq7RrAQZeA4/z7qCwVhCUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzcKRiI6RTTMZuxdK2z9dCJEGgt6GdOlewPl6O3N7YZC6HKwNfO//1svB2ouOEgcE
         l5QMeHDrfg1IN1UCcg/UKFoBZHGdCxNZLpxcagoPUvCLuTcm7THeKjvpb4r+Nz0Rd9
         dGbENStHMJ9KyqcKHNy8mMtsbSwFeT5TwmwwmabY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 33/34] net/mlx5e: Fix wrong (zero) TX drop counter indication for representor
Date:   Tue, 12 Feb 2019 21:39:51 -0500
Message-Id: <20190213023952.21311-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 7fdc1adc52d3975740547a78c2df329bb207f15d ]

For representors, the TX dropped counter is not folded from the
per-ring counters. Fix it.

Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 281911698f72..e69674d38f16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -125,6 +125,7 @@ static void mlx5e_rep_update_sw_counters(struct mlx5e_priv *priv)
 
 			s->tx_packets		+= sq_stats->packets;
 			s->tx_bytes		+= sq_stats->bytes;
+			s->tx_queue_dropped	+= sq_stats->dropped;
 		}
 	}
 }
-- 
2.19.1

