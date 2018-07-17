Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CFCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIkrFkbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F268A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGQQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbeGQQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:40:09 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0465620849;
        Tue, 17 Jul 2018 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531843608;
        bh=W53bbQvonhTknroYbREKOUJYNmnGPBPmYUP0btUEKZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIkrFkbdRMiBOp3QnRkon9f6eEmpX4JiJ0/2gfel9guJj+EXUxvXOKma6GGlPcYbo
         PrskxgxKMd4gYkw+VQFx2xjImDdp+qNBA5kMTSynkgKrHF+3Z0u2/qnifYkQTsb5cV
         KICnnlePZ4CdnWqp1hkDQotvJ+sTlok+LJ2h3YoY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Vitaly Bordug <vbordug@ru.mvista.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@driverdev.osuosl.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] crypto: stm32_crc32 - Use existing define with polynomial
Date:   Tue, 17 Jul 2018 18:05:38 +0200
Message-Id: <20180717160541.3843-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180717160541.3843-1-krzk@kernel.org>
References: <20180717160541.3843-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not define again the polynomial but use header with existing define.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Not tested

It would be nice to get some testing. Only generic lib/crc, bunzip, xz_crc32
and Freescale's Ethernet driver were tested on HW.  Rest got just different
builds.


 drivers/crypto/stm32/stm32_crc32.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/stm32/stm32_crc32.c b/drivers/crypto/stm32/stm32_crc32.c
index 040bed5e7725..29d2095d9dfd 100644
--- a/drivers/crypto/stm32/stm32_crc32.c
+++ b/drivers/crypto/stm32/stm32_crc32.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
+#include <linux/crc32poly.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -30,10 +31,6 @@
 #define CRC_CR_REVERSE          (BIT(7) | BIT(6) | BIT(5))
 #define CRC_INIT_DEFAULT        0xFFFFFFFF
 
-/* Polynomial reversed */
-#define POLY_CRC32              0xEDB88320
-#define POLY_CRC32C             0x82F63B78
-
 #define CRC_AUTOSUSPEND_DELAY	50
 
 struct stm32_crc {
@@ -70,7 +67,7 @@ static int stm32_crc32_cra_init(struct crypto_tfm *tfm)
 	struct stm32_crc_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->key = CRC_INIT_DEFAULT;
-	mctx->poly = POLY_CRC32;
+	mctx->poly = CRC32_POLY_LE;
 	return 0;
 }
 
@@ -79,7 +76,7 @@ static int stm32_crc32c_cra_init(struct crypto_tfm *tfm)
 	struct stm32_crc_ctx *mctx = crypto_tfm_ctx(tfm);
 
 	mctx->key = CRC_INIT_DEFAULT;
-	mctx->poly = POLY_CRC32C;
+	mctx->poly = CRC32C_POLY_LE;
 	return 0;
 }
 
@@ -188,7 +185,7 @@ static int stm32_crc_final(struct shash_desc *desc, u8 *out)
 	struct stm32_crc_ctx *mctx = crypto_shash_ctx(desc->tfm);
 
 	/* Send computed CRC */
-	put_unaligned_le32(mctx->poly == POLY_CRC32C ?
+	put_unaligned_le32(mctx->poly == CRC32C_POLY_LE ?
 			   ~ctx->partial : ctx->partial, out);
 
 	return 0;
-- 
2.14.1

