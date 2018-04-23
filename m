Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeDWHZt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:25:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36380 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754493AbeDWHZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 03:25:35 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] crypto: ccree: use proper printk format
Date: Mon, 23 Apr 2018 08:25:15 +0100
Message-Id: <1524468316-6606-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
References: <1524468316-6606-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix incorrect use of %pad as a printk format string for none dma_addr_t
variable.

Discovered via smatch.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 89ce013..37f2e6e 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -265,7 +265,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	}
 
 	if (rc) {
-		dev_err(dev, "Failed in dma_set_mask, mask=%pad\n", &dma_mask);
+		dev_err(dev, "Failed in dma_set_mask, mask=%llx\n", dma_mask);
 		return rc;
 	}
 
-- 
2.7.4
