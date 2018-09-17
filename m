Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC053ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75832214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75832214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeIQWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:11:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728455AbeIQWL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:11:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BC6361BA55BCB;
        Tue, 18 Sep 2018 00:43:42 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 18 Sep 2018 00:43:41 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: bnxt: Fix a uninitialized variable warning.
Date:   Tue, 18 Sep 2018 00:31:23 +0800
Message-ID: <1537201883-2518-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c:49:5: warning: nvm_param.dir_type may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (nvm_param.dir_type == BNXT_NVM_PORT_CFG)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index f3b9fbc..ab88217 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -31,7 +31,7 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 {
 	struct hwrm_nvm_get_variable_input *req = msg;
 	void *data_addr = NULL, *buf = NULL;
-	struct bnxt_dl_nvm_param nvm_param;
+	struct bnxt_dl_nvm_param nvm_param = {0};
 	int bytesize, idx = 0, rc, i;
 	dma_addr_t data_dma_addr;
 
-- 
1.7.12.4

