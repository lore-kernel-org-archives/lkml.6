Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCD62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545865126;
	bh=IZhs7xSNGDK33cKpcB+6TTH868gUPPp8SDKJpw0i064=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPylV3/dOVAL/YlX29aI0SwEaB305wgah5hu2PReiuZDVFxuHtq02FRnIK0ENen3o
	 8WQd5arUHlnN5LhMRIsRlHCDl7fbtQgw4gFSrTEDdpR9WMYiDYIsXoSgfPsoywdcFn
	 9OPbe/4Wvu/KcUAime13WU0831h3GoTzCJhRAFHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeLZW6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729042AbeLZW5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:57:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6172070B;
        Wed, 26 Dec 2018 22:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545865037;
        bh=IZhs7xSNGDK33cKpcB+6TTH868gUPPp8SDKJpw0i064=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKJjsLyL8UeKsWskB1NMyZjd2HhhZIAnYY++tBePlPv3IEumNiAlsBZ85NiScrhfi
         UTIbXUn3rS/ZotfoemgiSnrn1GTStLVbJvt8c5136WLHpY3Yj3wZqOaZZ3kNrmwtvj
         zKulc5NpKc2dgTd5qP4dTMksHiby1scg7oKKOfYs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/21] net: hns: Incorrect offset address used for some registers.
Date:   Wed, 26 Dec 2018 17:54:49 -0500
Message-Id: <20181226225501.151365-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226225501.151365-1-sashal@kernel.org>
References: <20181226225501.151365-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

[ Upstream commit 4e1d4be681b2c26fd874adbf584bf034573ac45d ]

According to the hip06 Datasheet:
1. The offset of INGRESS_SW_VLAN_TAG_DISC should be 0x1A00+4*all_chn_num
2. The offset of INGRESS_IN_DATA_STP_DISC should be 0x1A50+4*all_chn_num

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index b674414a4d72..6174e58f6c31 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1891,9 +1891,9 @@ void hns_dsaf_update_stats(struct dsaf_device *dsaf_dev, u32 node_num)
 		DSAF_INODE_LOCAL_ADDR_FALSE_NUM_0_REG + 0x80 * (u64)node_num);
 
 	hw_stats->vlan_drop += dsaf_read_dev(dsaf_dev,
-		DSAF_INODE_SW_VLAN_TAG_DISC_0_REG + 0x80 * (u64)node_num);
+		DSAF_INODE_SW_VLAN_TAG_DISC_0_REG + 4 * (u64)node_num);
 	hw_stats->stp_drop += dsaf_read_dev(dsaf_dev,
-		DSAF_INODE_IN_DATA_STP_DISC_0_REG + 0x80 * (u64)node_num);
+		DSAF_INODE_IN_DATA_STP_DISC_0_REG + 4 * (u64)node_num);
 
 	hw_stats->tx_pkts += dsaf_read_dev(dsaf_dev,
 		DSAF_XOD_RCVPKT_CNT_0_REG + 0x90 * (u64)node_num);
-- 
2.19.1

