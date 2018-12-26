Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0420651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864075;
	bh=Qls266RkY8OGNfz24UGO0TCvf2OrpK5jhml/p9B6CgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ifp/cLeoY/hqEB66eHqI6WOpK0Ono/vHuXmHHSB1X+cPC62TVOLjwqRzqMbj3VPBk
	 8DruWUVZJhLHUi2u/IaZUEu/zrT9jMuxbvAMc94nruN5yPH8xaBLJzuIf+LFxUTVHP
	 i5NdTQ1ZLfiGE0v0uf+K8wXDfEwjkxEt4L/e5mSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeLZWlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbeLZWlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CC462054F;
        Wed, 26 Dec 2018 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864070;
        bh=Qls266RkY8OGNfz24UGO0TCvf2OrpK5jhml/p9B6CgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zk3HGdS0IPzJq5bC3SQfnEBG1aHaY2smIs/Nt6QKi3kjY/v5JjbDecuRAlL/qdtXa
         4pUhNpzeMX57V5QmPsc00mixMi6VGjLfN5uZ3Ty66ltA4rl1tSfxFtVuNMNknnWrBz
         gSw3ezyAJ/FVri2dKW3VAfHpmZEdZkGCEccuRRaQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 40/59] net: hns: Fix ntuple-filters status error.
Date:   Wed, 26 Dec 2018 17:38:20 -0500
Message-Id: <20181226223839.150262-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 7e74a19ca522aec7c2be201a7ae1d1d57ded409b ]

The ntuple-filters features is forced on by chip.
But it shows "ntuple-filters: off [fixed]" when use ethtool.
This patch make it correct with "ntuple-filters: on [fixed]".

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index f28a639e8393..86662a14208e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2486,7 +2486,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 	ndev->min_mtu = MAC_MIN_MTU;
 	switch (priv->enet_ver) {
 	case AE_VERSION_2:
-		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6;
+		ndev->features |= NETIF_F_TSO | NETIF_F_TSO6 | NETIF_F_NTUPLE;
 		ndev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			NETIF_F_RXCSUM | NETIF_F_SG | NETIF_F_GSO |
 			NETIF_F_GRO | NETIF_F_TSO | NETIF_F_TSO6;
-- 
2.19.1

