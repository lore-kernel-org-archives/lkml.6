Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E03C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB572089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB572089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeJPSlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:41:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbeJPSlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:41:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8DCC6E6C04B8A;
        Tue, 16 Oct 2018 18:51:23 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 18:51:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <igor.russkikh@aquantia.com>,
        <nikita.danilov@aquantia.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <yana.esina@aquantia.com>, <andrew@lunn.ch>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: aquantia: make function aq_fw2x_update_stats static
Date:   Tue, 16 Oct 2018 18:50:56 +0800
Message-ID: <20181016105056.16452-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c:282:5: warning:
  symbol 'aq_fw2x_update_stats' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index c056846..096ca57 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -279,7 +279,7 @@ static int aq_fw2x_get_mac_permanent(struct aq_hw_s *self, u8 *mac)
 	return err;
 }
 
-int aq_fw2x_update_stats(struct aq_hw_s *self)
+static int aq_fw2x_update_stats(struct aq_hw_s *self)
 {
 	int err = 0;
 	u32 mpi_opts = aq_hw_read_reg(self, HW_ATL_FW2X_MPI_CONTROL2_ADDR);
-- 
2.7.0


