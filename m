Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3520CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E9E20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219114;
	bh=JiH521WabtrIdlwpDsEG9N91BjdctHtzagIiEX7iKX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7Z9ouWLSx+I0LwihjPXE+6I5qZBjppHdyI2UVkE9WRNoH5iX3iQpQ8ceiyn32Gq+
	 K53IsSLGvaMy/8GZH6F1xH/javipL6iOmPeGv/yj3PApSgABKy6hyEgK6HeaF/TS27
	 nRVvVlapqKBHpBP7HQGCilRi+B981sAkizFCmQD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391886AbfAKPFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:05:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbfAKO37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E132177B;
        Fri, 11 Jan 2019 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216998;
        bh=JiH521WabtrIdlwpDsEG9N91BjdctHtzagIiEX7iKX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltuSaBkIJsZRCOBOO+wbOuwUQPb45qBXhAOEQJhHA9ecSkxFUmj+z5psNuf9S0SYw
         vfg06Xg8J4q+afb0PdaVsIVf5XfMPL2wSuRukOuhT+40390aB4kqV5jBRjai5l7i5d
         yf3wbP30nmGVFL/ffWMi+10ZhFcjxdLsZfN+Xucc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 19/63] net: hns: Incorrect offset address used for some registers.
Date:   Fri, 11 Jan 2019 15:14:22 +0100
Message-Id: <20190111131048.969809887@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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
index 8ea3d95fa483..e25206540fd7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2163,9 +2163,9 @@ void hns_dsaf_update_stats(struct dsaf_device *dsaf_dev, u32 node_num)
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



