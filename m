Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB57C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC11214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864597;
	bh=g20Ik0CfThEKK+SzJR8QV/hN3D5k3bUzzK8IUXc/mg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKCb/NSUpp37KO3KPAQbglJn25OlfJYNQxT6GW4yw69QGT0RZ+2QRH1f2p5Z6ZzRb
	 OZNg5baXT4+FqOt6UoxbOOhhvMPhqOp/frBu0RP33yciD++Fpm3gSZxfhUPviUtJW5
	 hRbLKFvrBCkCEt3w3tzV0fS5Li0biio5GQxnaMLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbeLZWt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:49:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbeLZWhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BD52054F;
        Wed, 26 Dec 2018 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863862;
        bh=g20Ik0CfThEKK+SzJR8QV/hN3D5k3bUzzK8IUXc/mg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVXDOTuHz9ceZpKidwuCILPpGhsKdr/wET3EPdp2SeA/heWiWALZlZUDSUwQo0f5J
         /eiP08m0w2SrwOOwR6Eze++Uj3OzSSP/Je9N5fCtsDFVuJdQpwt8eqOVYpcU3Ajv4R
         0JCn8+GV+dK8lbR8R3ymR6SC6ms+wEAM/SilIHdM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/97] net: hns: Fix ntuple-filters status error.
Date:   Wed, 26 Dec 2018 17:35:21 -0500
Message-Id: <20181226223557.149329-61-sashal@kernel.org>
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
index 8a53c82c72b4..6242249c9f4c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2374,7 +2374,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
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

