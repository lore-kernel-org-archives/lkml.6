Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeFALQY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:16:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35267 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750790AbeFALQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:16:21 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <kvalo@codeaurora.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ath10k: fix incorrect size of dma_free_coherent in ath10k_ce_alloc_src_ring_64
Date: Fri, 1 Jun 2018 19:16:02 +0800
Message-ID: <20180601111602.24108-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(struct ce_desc) should be a copy-paste mistake
just use sizeof(struct ce_desc_64) to avoid mem leak

Fixes: b7ba83f7c414 ("ath10k: add support for shadow register for WNC3990")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/wireless/ath/ath10k/ce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 3b96a43..35dec2a 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1512,7 +1512,7 @@ ath10k_ce_alloc_src_ring_64(struct ath10k *ar, unsigned int ce_id,
 		ret = ath10k_ce_alloc_shadow_base(ar, src_ring, nentries);
 		if (ret) {
 			dma_free_coherent(ar->dev,
-					  (nentries * sizeof(struct ce_desc) +
+					  (nentries * sizeof(struct ce_desc64) +
 					   CE_DESC_RING_ALIGN),
 					  src_ring->base_addr_owner_space_unaligned,
 					  base_addr);
-- 
2.7.0
