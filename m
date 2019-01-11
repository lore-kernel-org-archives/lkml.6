Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129D1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217177;
	bh=uo392R8DdE3C72s1a7WtAyp2z8E58SLVYTwhGLOy7wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvW1TlMhoD5/R0FJL5Hp/nDW95GQ2Ql51p0uBrN8w6ENWLkUsouviGCo1ANNXJQ+y
	 cAwkH3EBzT7IABcnt10sDehROylIYGHEGgdx6yIK1pMHymml6hHC9x23ePGjDn13oa
	 xtGUPgX14ewW4CLobJn2Rrqd5x81wd89yvWnW/gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbfAKOc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbfAKOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1962177B;
        Fri, 11 Jan 2019 14:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217173;
        bh=uo392R8DdE3C72s1a7WtAyp2z8E58SLVYTwhGLOy7wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b60maH6RQZpk6DKoOj3/gkNnJ3bvwazHPfT6/vOl5E1tlApvMYikshSnO/456dFjx
         6hWQjem4/UKK0OmUrX6HN1ooBvvul6FJax9wPSNAQLsZ7hKgl+zjH5r9LYtedGkIcj
         h9itDAoQKySATWgdpaDQ5o32UbOvOndl0BKk7Omc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 031/105] net: hns: Incorrect offset address used for some registers.
Date:   Fri, 11 Jan 2019 15:14:02 +0100
Message-Id: <20190111131105.893663074@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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



