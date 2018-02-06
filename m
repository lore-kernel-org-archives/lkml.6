Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeBFVVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:21:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35583 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753397AbeBFVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:20:35 -0500
X-Google-Smtp-Source: AH8x226QaRUMu5++K7q1GPqnK/6G5GC59COyvhdljJRtRt/u3JXoQuBQrz9f6UiQ+DiAZ5v4rp/EoA==
From: Artem Savkov <artem.savkov@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Artem Savkov <artem.savkov@gmail.com>
Subject: [PATCH 1/2] sun4i_ss_prng: fix return value of sun4i_ss_prng_generate
Date: Tue,  6 Feb 2018 22:20:21 +0100
Message-Id: <20180206212022.1309-2-artem.savkov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to crypto/rng.h generate function should return 0 on success
and < 0 on error.

Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
index 0d01d1624252..5754e0b92fb0 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
@@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
 
 	writel(0, ss->base + SS_CTL);
 	spin_unlock(&ss->slock);
-	return dlen;
+	return 0;
 }
-- 
2.15.1
