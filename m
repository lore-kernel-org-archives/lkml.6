Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeDFQ66 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:58:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47202 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeDFQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:58:57 -0400
From: Colin King <colin.king@canonical.com>
To: Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Michael Werner <werner@chelsio.com>, linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: chtls: remove redundant assignment to cdev->ports
Date: Fri,  6 Apr 2018 17:58:47 +0100
Message-Id: <20180406165847.29310-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a double assignment to cdev->ports, the first is redundant
as it is over-written so remove it.

Detected by CoverityScan, CID#1467432 ("Unused value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chtls/chtls_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_main.c b/drivers/crypto/chelsio/chtls/chtls_main.c
index 007c45c38fc7..984a53f19f8b 100644
--- a/drivers/crypto/chelsio/chtls/chtls_main.c
+++ b/drivers/crypto/chelsio/chtls/chtls_main.c
@@ -216,7 +216,6 @@ static void *chtls_uld_add(const struct cxgb4_lld_info *info)
 	cdev->lldi = lldi;
 	cdev->pdev = lldi->pdev;
 	cdev->tids = lldi->tids;
-	cdev->ports = (struct net_device **)(cdev + 1);
 	cdev->ports = lldi->ports;
 	cdev->mtus = lldi->mtus;
 	cdev->tids = lldi->tids;
-- 
2.15.1
