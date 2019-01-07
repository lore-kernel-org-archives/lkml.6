Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C93C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4E720651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865287;
	bh=g/H+8MczTyBBTbE9znFRD5Vp1IIO9KfdxZ2B95Q7a+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJJkdiSwyd/ZZ2Q/KZMGQj0+vCsHYVlFuR90xR2em4SstyQwLody6tuXzfnrOEegY
	 MReZMYDYTn0dqbX7hAv/skit2bq/8T9N9hNAHnvi/MUGPyIrvF/Hxib0kdBI/JuUMj
	 7/3DiUYyh0QaL2eGHsgW7hUZtSs50wen+3q8rPrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfAGMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfAGMsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 325B020651;
        Mon,  7 Jan 2019 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865283;
        bh=g/H+8MczTyBBTbE9znFRD5Vp1IIO9KfdxZ2B95Q7a+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=engdE0jhz44KOUQA9l0sycp6Vg9w/pAM+31JFDY5S1sb5j5Suc6+DGC+LLYL7eD3v
         QxFefN9VM/tLwKUAsaV4gc6FduPwmCwhstvmEGO47CzOXiyHRgGDrJ6MLpG2YxYY62
         YaAfQUvKdzRbtXP7KOvwiCNnx4dk/utTZdbiu+i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 043/170] net/mlx5e: Remove the false indication of software timestamping support
Date:   Mon,  7 Jan 2019 13:31:10 +0100
Message-Id: <20190107104458.322722183@linuxfoundation.org>
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

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit 4765420439e758bfa4808392d18b0a4cb6f06065 ]

mlx5 driver falsely advertises support of software timestamping.
Fix it by removing the false indication.

Fixes: ef9814deafd0 ("net/mlx5e: Add HW timestamping (TS) support")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1101,11 +1101,6 @@ int mlx5e_ethtool_get_ts_info(struct mlx
 			      struct ethtool_ts_info *info)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
-	int ret;
-
-	ret = ethtool_op_get_ts_info(priv->netdev, info);
-	if (ret)
-		return ret;
 
 	info->phc_index = mlx5_clock_get_ptp_index(mdev);
 
@@ -1113,9 +1108,9 @@ int mlx5e_ethtool_get_ts_info(struct mlx
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


