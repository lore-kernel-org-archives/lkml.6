Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B226C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B59214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864242;
	bh=8TCCQBTn2IeMz7toNFpnpXe5FJUajOxn19PspHBb8sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6izaUQK8hWuenLLvb9KQV5pi86daK31o1uSkzCzvgf2ya9JYCaUbKmQiSxPQ11eY
	 nn7VRj5SJD8NaXSTQ8xCpnYzSxkRNBRnJLM9tXtc6xWi/pAq/Qyer4MypwUeOjGO3R
	 ghuIae0V4GlaZ2MKzmomIu5d3eOqzmGPKyi5wrlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeLZWkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729228AbeLZWkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B6F2054F;
        Wed, 26 Dec 2018 22:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864048;
        bh=8TCCQBTn2IeMz7toNFpnpXe5FJUajOxn19PspHBb8sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFLZOb6H2/akODLv2qk62nPEfBPd8qvrvcYzKda1QXnJzlnhrG5CTrNUGuC1zTmlK
         aRTL0io0oeXEUpuw5cJ+8stQGkj7KscrtaqqUqv7s0HHY3yAybdS9M2XChnXFjbW5m
         5LAn3lVOhTtZsCjinhaUS21cbMwcxlFJVzOYeshk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 33/59] net: hns: Incorrect offset address used for some registers.
Date:   Wed, 26 Dec 2018 17:38:13 -0500
Message-Id: <20181226223839.150262-33-sashal@kernel.org>
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
index 1f056a6b167e..bc020dddd253 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2159,9 +2159,9 @@ void hns_dsaf_update_stats(struct dsaf_device *dsaf_dev, u32 node_num)
 		DSAF_INODE_LOCAL_ADDR_FALSE_NUM_0_REG + 0x80 * (u64)node_num);
 
 	hw_stats->vlan_drop += dsaf_read_dev(dsaf_dev,
-		DSAF_INODE_SW_VLAN_TAG_DISC_0_REG + 0x80 * (u64)node_num);
+		DSAF_INODE_SW_VLAN_TAG_DISC_0_REG + 4 * (u64)node_num);
 	hw_stats->stp_drop += dsaf_read_dev(dsaf_dev,
-		DSAF_INODE_IN_DATA_STP_DISC_0_REG + 0x80 * (u64)node_num);
+		DSAF_INODE_IN_DATA_STP_DISC_0_REG + 4 * (u64)node_num);
 
 	/* pfc pause frame statistics stored in dsaf inode*/
 	if ((node_num < DSAF_SERVICE_NW_NUM) && !is_ver1) {
-- 
2.19.1

