Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED30C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C242089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866541;
	bh=UpIGB/l+CXp+NcEdglo5aecU91CMEVQQOThksQjsfYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBsEVQnsDv0avdvNjq1kmwiMdHJGfEx8mAFxQ0x8pRnROboCoNd1eKeK0o+pmopwY
	 qFyzjwwddbq/XWtSi6JJ5VrSfJHSQXV0Zg2iW2by//XxubzAqk+cZoIXF+aki8VrCM
	 XlUel1GMuBWWKrJxLvuPIZwMT20aoQ0Ktx4fSaPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfAGNJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbfAGNI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679432089F;
        Mon,  7 Jan 2019 13:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866537;
        bh=UpIGB/l+CXp+NcEdglo5aecU91CMEVQQOThksQjsfYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3Zy5s+pKajyTlxQya5an6cPsizKKk/k33/fL4OhKYrmq7zA3nOu3RhpmB0q7KEuf
         f90RRkm21oox7kwT8r+ewMbclB1Ca3ZucvsJf7JpxhTLX5CxS6B/j1HwHXGf2Pt4dQ
         Nya/6NuErdg5jFeG6yYbnXV1epRCyx4EUMFsAjH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 26/71] net/mlx5e: Remove the false indication of software timestamping support
Date:   Mon,  7 Jan 2019 13:32:55 +0100
Message-Id: <20190107105334.273824922@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1167,11 +1167,6 @@ static int mlx5e_get_ts_info(struct net_
 			     struct ethtool_ts_info *info)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
-	int ret;
-
-	ret = ethtool_op_get_ts_info(dev, info);
-	if (ret)
-		return ret;
 
 	info->phc_index = priv->tstamp.ptp ?
 			  ptp_clock_index(priv->tstamp.ptp) : -1;
@@ -1179,9 +1174,9 @@ static int mlx5e_get_ts_info(struct net_
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


