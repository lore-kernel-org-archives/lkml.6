Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E2C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2771F2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866058;
	bh=KPhGRQnJzl8KMR+LAEILhkKJLdOot7X/qQie31YqZuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0u70FtknckImu2sA4nJm1lf9q2eogu5EOt+lqxMSLekmCQue9M4wNasDOT1ndbEu
	 F+VleQtBHUHsEF9lFE3Sp05rA/o93jP+siVrmbqdUDigCB1Y8OSU9/CP8z6gCysa4H
	 MMUC6JTb6ZY7wMsFqZ/R1VxA5SjVhxXBkUBNwxuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfAGNA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfAGNAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839732089F;
        Mon,  7 Jan 2019 13:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866054;
        bh=KPhGRQnJzl8KMR+LAEILhkKJLdOot7X/qQie31YqZuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofzYlRySsVExxHM/cuWNoNrGJjpofriWDmn1js2ENV9UxL44kkjSq71cIMDyBTQcU
         wpIK1GmE+LOqg3iKJmXJxEncYW9qnTaAS3PA8OkVvAh/o1R2AObzLWmm/gOHNJKR6F
         pVcF+S55UnVNLD6bEX2TzzRj2sWSwkd3RR9uenbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 030/101] net/mlx5e: Remove the false indication of software timestamping support
Date:   Mon,  7 Jan 2019 13:32:18 +0100
Message-Id: <20190107105334.553774970@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1417,21 +1417,15 @@ static int mlx5e_set_pauseparam(struct n
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
 			      struct ethtool_ts_info *info)
 {
-	int ret;
-
-	ret = ethtool_op_get_ts_info(priv->netdev, info);
-	if (ret)
-		return ret;
-
 	info->phc_index = priv->tstamp.ptp ?
 			  ptp_clock_index(priv->tstamp.ptp) : -1;
 
 	if (!MLX5_CAP_GEN(priv->mdev, device_frequency_khz))
 		return 0;
 
-	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
-				 SOF_TIMESTAMPING_RX_HARDWARE |
-				 SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) |
 			 BIT(HWTSTAMP_TX_ON);


