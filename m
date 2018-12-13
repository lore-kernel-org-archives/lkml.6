Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBD720873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675503;
	bh=6B500M820Lqe7C+CH2xLxG6Ty4WpGqC5VFv+g8BPRSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E5n1ZAOcDndpqbzUU59y/6K4kYXe9mhDK7VeCZZheNZ9J8LwHBdWpwLLVqNABCUiX
	 fYJjhOv7gVl/G0WjuckEHnuC9W13mpSG6xklKhHIyzjDjGGH/ilkI6W6JSRtzgU3XX
	 Q6JDyJrj6enStBbCE2fS/AjBZR+aObUtX2eGDRN0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBD720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeLMEbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeLMEbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:31:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C4B20672;
        Thu, 13 Dec 2018 04:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675498;
        bh=6B500M820Lqe7C+CH2xLxG6Ty4WpGqC5VFv+g8BPRSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqDVsuNET/RcfYCnamRwCoFfRUwNKYd7+MLaoPINv70Ho1dYrUDfGIZefL6pmGpVX
         j6hvF5COw6t7n1vZCil7mI+KrDR0eSH19wkmd+GLy0waBhbwFPGMZvJpLQuMi0EqpK
         H9zdnPcH4D0tFWOxVpbguywwXCKtztxa8So/jgNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eran Ben Elisha <eranbe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/41] net/mlx4_en: Change min MTU size to ETH_MIN_MTU
Date:   Wed, 12 Dec 2018 23:30:40 -0500
Message-Id: <20181213043054.75891-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
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
index faa4bd21f148..0fb85d71c11b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3505,8 +3505,8 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
 		dev->gso_partial_features = NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
-	/* MTU range: 46 - hw-specific max */
-	dev->min_mtu = MLX4_EN_MIN_MTU;
+	/* MTU range: 68 - hw-specific max */
+	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = priv->max_mtu;
 
 	mdev->pndev[port] = dev;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 09f4764a3f39..bdd87438a354 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -157,7 +157,6 @@
 #define HEADER_COPY_SIZE       (128 - NET_IP_ALIGN)
 #define MLX4_LOOPBACK_TEST_PAYLOAD (HEADER_COPY_SIZE - ETH_HLEN)
 
-#define MLX4_EN_MIN_MTU		46
 /* VLAN_HLEN is added twice,to support skb vlan tagged with multiple
  * headers. (For example: ETH_P_8021Q and ETH_P_8021AD).
  */
-- 
2.19.1

