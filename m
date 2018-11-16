Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B0FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148A2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3148A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389503AbeKPUhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:37:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727509AbeKPUhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:37:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB07FD640D55;
        Fri, 16 Nov 2018 18:25:51 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 16 Nov 2018
 18:25:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <igor.russkikh@aquantia.com>,
        <nikita.danilov@aquantia.com>, <yana.esina@aquantia.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: aquantia: cleanup err handing in hw_atl_utils_fw_rpc_wait
Date:   Fri, 16 Nov 2018 18:25:27 +0800
Message-ID: <20181116102527.13812-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'err' always be 0 in the two places.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 7def1cb..1af6606 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -454,8 +454,6 @@ int hw_atl_utils_fw_rpc_wait(struct aq_hw_s *self,
 			       (fw.val =
 				aq_hw_read_reg(self, HW_ATL_RPC_STATE_ADR),
 				fw.tid), 1000U, 100U);
-		if (err < 0)
-			goto err_exit;
 
 		if (fw.len == 0xFFFFU) {
 			err = hw_atl_utils_fw_rpc_call(self, sw.len);
@@ -463,8 +461,6 @@ int hw_atl_utils_fw_rpc_wait(struct aq_hw_s *self,
 				goto err_exit;
 		}
 	} while (sw.tid != fw.tid || 0xFFFFU == fw.len);
-	if (err < 0)
-		goto err_exit;
 
 	if (rpc) {
 		if (fw.len) {
-- 
2.7.0


