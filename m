Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeFCLtV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 07:49:21 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33914 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeFCLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 07:49:19 -0400
X-Google-Smtp-Source: ADUXVKLZoww0ilUAJ/xGkMXMHbLVKYiyHY/abwNfuMB96Zr/eBucEYUsSG01IFAOVBOvYvdpjHthqA==
From: Varsha Rao <rvarsha016@gmail.com>
To: Rasesh Mody <rasesh.mody@cavium.com>,
        Harish Patil <harish.patil@cavium.com>, Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH 1/2] net: ethernet: bnx2: Remove extra parentheses
Date: Sun,  3 Jun 2018 17:19:04 +0530
Message-Id: <49739fc1c7f725223e88b5e80259ba40bcbaf8c5.1528025569.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528025568.git.rvarsha016@gmail.com>
References: <cover.1528025568.git.rvarsha016@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following coccinelle script removes extra parentheses to fix the
clang warning of extraneous parentheses.

@disable paren@
identifier i;
expression e;
statement s;
@@
if (
-(i == e)
+i == e
 )
s

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/ethernet/broadcom/bnx2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2.c b/drivers/net/ethernet/broadcom/bnx2.c
index 9ffc4a8c5fc7..2306523778d4 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -3285,7 +3285,7 @@ bnx2_rx_int(struct bnx2 *bp, struct bnx2_napi *bnapi, int budget)
 		sw_cons = BNX2_NEXT_RX_BD(sw_cons);
 		sw_prod = BNX2_NEXT_RX_BD(sw_prod);
 
-		if ((rx_pkt == budget))
+		if (rx_pkt == budget)
 			break;
 
 		/* Refresh hw_cons to see if there is new work */
-- 
2.17.0
