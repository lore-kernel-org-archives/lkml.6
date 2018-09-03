Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66ACC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B110120862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B110120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeICQ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:56:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeICQ4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:56:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 46DD4BB87E014;
        Mon,  3 Sep 2018 20:36:35 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Mon, 3 Sep 2018
 20:36:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jeffrey.t.kirsher@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] i40e: remove inline directive
Date:   Mon, 3 Sep 2018 20:36:21 +0800
Message-ID: <20180903123621.8696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes follow gcc warning:

drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists

Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
index bba1cb0..0290ade 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
@@ -190,7 +190,7 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
  * Format and copy the strings described by stats into the buffer pointed at
  * by p.
  **/
-static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
+static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
 				    const unsigned int size, ...)
 {
 	unsigned int i;
-- 
2.7.0


