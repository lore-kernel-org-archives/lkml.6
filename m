Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932527AbeCOPnH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:43:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60509 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752804AbeCOPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:40:31 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net
Cc: Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH 06/12] crypto: inside-secure - fix a typo in a register name
Date: Thu, 15 Mar 2018 16:38:45 +0100
Message-Id: <20180315153851.9958-7-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315153851.9958-1-antoine.tenart@bootlin.com>
References: <20180315153851.9958-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in the EIP197_HIA_xDR_WR_CTRL_BUG register name,
as it should be EIP197_HIA_xDR_WR_CTRL_BUF. This is a cosmetic only
change.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c | 2 +-
 drivers/crypto/inside-secure/safexcel.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 5fe85b9dad64..7b291068222f 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -235,7 +235,7 @@ static int safexcel_hw_setup_rdesc_rings(struct safexcel_crypto_priv *priv)
 		/* Configure DMA tx control */
 		val = EIP197_HIA_xDR_CFG_WR_CACHE(WR_CACHE_3BITS);
 		val |= EIP197_HIA_xDR_CFG_RD_CACHE(RD_CACHE_3BITS);
-		val |= EIP197_HIA_xDR_WR_RES_BUF | EIP197_HIA_xDR_WR_CTRL_BUG;
+		val |= EIP197_HIA_xDR_WR_RES_BUF | EIP197_HIA_xDR_WR_CTRL_BUF;
 		writel(val,
 		       EIP197_HIA_RDR(priv, i) + EIP197_HIA_xDR_DMA_CFG);
 
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 2b7bed3cfb75..8c139b98a580 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -135,7 +135,7 @@
 
 /* EIP197_HIA_xDR_DMA_CFG */
 #define EIP197_HIA_xDR_WR_RES_BUF		BIT(22)
-#define EIP197_HIA_xDR_WR_CTRL_BUG		BIT(23)
+#define EIP197_HIA_xDR_WR_CTRL_BUF		BIT(23)
 #define EIP197_HIA_xDR_WR_OWN_BUF		BIT(24)
 #define EIP197_HIA_xDR_CFG_WR_CACHE(n)		(((n) & 0x7) << 25)
 #define EIP197_HIA_xDR_CFG_RD_CACHE(n)		(((n) & 0x7) << 29)
-- 
2.14.3
