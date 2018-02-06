Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeBFXUK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:20:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58096 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753840AbeBFXUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:20:07 -0500
From: Colin King <colin.king@canonical.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ccp - Make function ccp_get_dma_chan_attr static
Date: Tue,  6 Feb 2018 23:20:01 +0000
Message-Id: <20180206232001.14102-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function ccp_get_dma_chan_attr is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/crypto/ccp/ccp-dmaengine.c:41:14: warning: symbol
'ccp_get_dma_chan_attr' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/ccp/ccp-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
index 8b9da58459df..67155cb21636 100644
--- a/drivers/crypto/ccp/ccp-dmaengine.c
+++ b/drivers/crypto/ccp/ccp-dmaengine.c
@@ -38,7 +38,7 @@ static unsigned int dma_chan_attr = CCP_DMA_DFLT;
 module_param(dma_chan_attr, uint, 0444);
 MODULE_PARM_DESC(dma_chan_attr, "Set DMA channel visibility: 0 (default) = device defaults, 1 = make private, 2 = make public");
 
-unsigned int ccp_get_dma_chan_attr(struct ccp_device *ccp)
+static unsigned int ccp_get_dma_chan_attr(struct ccp_device *ccp)
 {
 	switch (dma_chan_attr) {
 	case CCP_DMA_DFLT:
-- 
2.15.1
