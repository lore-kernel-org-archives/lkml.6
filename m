Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61123C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CE320861
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955929;
	bh=TyigfABKg8Kv0SiI1JjE06imurb/vkJ/ijc7jgQMK2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PtBqe7clQJ8ee8rjGbahFDNIeulIWM9d/Poog+b/sUQ7WquU1E+All2V2ERL9tn/x
	 TioSUqTUuv3SSp62h7GIqEPUz3lhtL5Gy4cpeDqLsrXNZ4QZ0ZOqpKybT3Qo3gxg0J
	 rqzZuA6TkSd+Kh2rYnnsmDgXqMi5BdlmIKLHGmIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfBWVF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbfBWVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5A3206B6;
        Sat, 23 Feb 2019 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955923;
        bh=TyigfABKg8Kv0SiI1JjE06imurb/vkJ/ijc7jgQMK2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piyETwZed5Nnu3p96d8jjR9CtGVW1u6rnuUEipRRf6xJZ2qz1+GPuLK0kc2Y0TpsF
         V4PhIHe+ked4JXEGjAvhyKlijVxl6jHoqbOxkGov5QKofX6SHZIw5SOGU1bVA5Ok/D
         jGNrHzGHCTZr0m9eDHaBkqLGHvDM9C4eeYPjn37s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 34/72] net: hns: Restart autoneg need return failed when autoneg off
Date:   Sat, 23 Feb 2019 16:03:44 -0500
Message-Id: <20190223210422.199966-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit ed29ca8b9592562559c64d027fb5eb126e463e2c ]

The hns driver of earlier devices, when autoneg off, restart autoneg
will return -EINVAL, so make the hns driver for the latest devices
do the same.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 774beda040a16..e2710ff48fb0f 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1157,16 +1157,18 @@ static int hns_get_regs_len(struct net_device *net_dev)
  */
 static int hns_nic_nway_reset(struct net_device *netdev)
 {
-	int ret = 0;
 	struct phy_device *phy = netdev->phydev;
 
-	if (netif_running(netdev)) {
-		/* if autoneg is disabled, don't restart auto-negotiation */
-		if (phy && phy->autoneg == AUTONEG_ENABLE)
-			ret = genphy_restart_aneg(phy);
-	}
+	if (!netif_running(netdev))
+		return 0;
 
-	return ret;
+	if (!phy)
+		return -EOPNOTSUPP;
+
+	if (phy->autoneg != AUTONEG_ENABLE)
+		return -EINVAL;
+
+	return genphy_restart_aneg(phy);
 }
 
 static u32
-- 
2.19.1

