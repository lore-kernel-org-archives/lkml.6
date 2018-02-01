Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752886AbeBASfv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:35:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48645 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeBASfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:35:48 -0500
From: Colin King <colin.king@canonical.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ixgbevf: remove redundant initialization of variable 'dma'.
Date: Thu,  1 Feb 2018 18:35:39 +0000
Message-Id: <20180201183539.24776-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable dma is initialized with a value that is never read, later
on it is re-assigned a new value, hence the initialization is redundant
and can be removed.

Cleans up clang warning:
drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:584:13: warning: Value
stored to 'dma' during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 9b3d43d28106..be50facec93f 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -558,7 +558,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 				      struct ixgbevf_rx_buffer *bi)
 {
 	struct page *page = bi->page;
-	dma_addr_t dma = bi->dma;
+	dma_addr_t dma;
 
 	/* since we are recycling buffers we should seldom need to alloc */
 	if (likely(page))
-- 
2.15.1
