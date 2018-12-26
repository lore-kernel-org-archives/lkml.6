Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06937C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C8A2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863914;
	bh=51Co4sX6oX9wzxPC+hydYUNC4678k0dcDuQgRjLEo6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zS7pzQ31t8GbHgSdlawGqgt+1kSCmdVAf9EfxwWJczCeVw5McJgtjPvkhA+FrHE0J
	 vsGRE42vJAZWNjwcQV8pcjiyBbZXMSAxrxKIcDiKyNc/+8r573h2FuVNhp6Q3yz5XR
	 yZgKKjo/JCIvKhmlKFXrjOBb/5vPm3OtVYiPfybc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbeLZWid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeLZWiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACC42218EA;
        Wed, 26 Dec 2018 22:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863901;
        bh=51Co4sX6oX9wzxPC+hydYUNC4678k0dcDuQgRjLEo6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIolhN7hCaEKmniAHO+oDd4AxsZB79z0eowSbD8FoIsgjODNaOvdu00O0lcxDwyzY
         Wyc2U8dplNYsGHe1EISBeYJM2guzrcOimISyyeFKJhGH3XdCvwDl5/LSlVckowgMoS
         f6Fm+NEP8M2vq6rdxP9O4aF7xIYsF+Mg+HP03nwY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alaa Hleihel <alaa@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 86/97] net/mlx5e: Remove the false indication of software timestamping support
Date:   Wed, 26 Dec 2018 17:35:46 -0500
Message-Id: <20181226223557.149329-86-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit 4765420439e758bfa4808392d18b0a4cb6f06065 ]

mlx5 driver falsely advertises support of software timestamping.
Fix it by removing the false indication.

Fixes: ef9814deafd0 ("net/mlx5e: Add HW timestamping (TS) support")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 98dd3e0ada72..5e5423076b03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1101,11 +1101,6 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 			      struct ethtool_ts_info *info)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
-	int ret;
-
-	ret = ethtool_op_get_ts_info(priv->netdev, info);
-	if (ret)
-		return ret;
 
 	info->phc_index = mlx5_clock_get_ptp_index(mdev);
 
@@ -1113,9 +1108,9 @@ int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 	    info->phc_index == -1)
 		return 0;
 
-	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
-				 SOF_TIMESTAMPING_RX_HARDWARE |
-				 SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			 BIT(HWTSTAMP_TX_ON);
-- 
2.19.1

