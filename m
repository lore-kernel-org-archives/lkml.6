Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB64DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBD120849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676465;
	bh=ANL8LlLSgQGVbwaMHsdeMsyRXoHRy2E/sRa4yYxVPJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGtX9QBM4yRNHkVLJ+OnFj73IDepShm+0OLnguSgPZ970y6Mgz4GiZPwi8UTkKms8
	 cxSc0BV/10xb0XULqv7osvEgIaHwLUYML6M7BXJmNvosltq0gb2kpPio3bJoi3OPKF
	 L7XkAQK+yUdV/zSzDS8oO+W/SjW7nQDWeHKhrn3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBD120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeLMEro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:47:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeLMEaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A85DD20882;
        Thu, 13 Dec 2018 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675409;
        bh=ANL8LlLSgQGVbwaMHsdeMsyRXoHRy2E/sRa4yYxVPJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hsY2GHdyI9Wfmjx3RRbXLxKXvPVL8LJZFFEZdqWW/xPPX8eCyJPbLtcMRbqraMJSQ
         4ikCEtWu1jufo6nSS6PeG82hBCocYj2jKpwgSnoYp5jhGfdxnKG5imgSZf/apH2YiV
         61MgVNlcKg1Qboh/4aL7CHYgXu+xCXKO9MO1wzPc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eran Ben Elisha <eranbe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/73] net/mlx4_en: Change min MTU size to ETH_MIN_MTU
Date:   Wed, 12 Dec 2018 23:28:13 -0500
Message-Id: <20181213042838.75160-48-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Ben Elisha <eranbe@mellanox.com>

[ Upstream commit 24be19e47779d604d1492c114459dca9a92acf78 ]

NIC driver minimal MTU size shall be set to ETH_MIN_MTU, as defined in
the RFC791 and in the network stack. Remove old mlx4_en only define for
it, which was set to wrong value.

Fixes: b80f71f5816f ("ethernet/mellanox: use core min/max MTU checking")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index fe49384eba48..0d7fd3f043cf 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3494,8 +3494,8 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
-	/* MTU range: 46 - hw-specific max */
-	dev->min_mtu = MLX4_EN_MIN_MTU;
+	/* MTU range: 68 - hw-specific max */
+	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = priv->max_mtu;
 
 	mdev->pndev[port] = dev;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index c3228b89df46..240f9c9ca943 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -161,7 +161,6 @@
 #define MLX4_SELFTEST_LB_MIN_MTU (MLX4_LOOPBACK_TEST_PAYLOAD + NET_IP_ALIGN + \
 				  ETH_HLEN + PREAMBLE_LEN)
 
-#define MLX4_EN_MIN_MTU		46
 /* VLAN_HLEN is added twice,to support skb vlan tagged with multiple
  * headers. (For example: ETH_P_8021Q and ETH_P_8021AD).
  */
-- 
2.19.1

