Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeCENSX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:18:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37209 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCENST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:18:19 -0500
From: Colin King <colin.king@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: x86/des3_ede: make array des3_ede_skciphers static
Date: Mon,  5 Mar 2018 14:18:00 +0100
Message-Id: <20180305131800.26647-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The array des3_ede_skciphers is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
arch/x86/crypto/des3_ede_glue.c:407:21: warning: symbol
'des3_ede_skciphers' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/crypto/des3_ede_glue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index f9c7bdc5be5a..5c610d4ef9fc 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -404,7 +404,7 @@ static struct crypto_alg des3_ede_cipher = {
 	}
 };
 
-struct skcipher_alg des3_ede_skciphers[] = {
+static struct skcipher_alg des3_ede_skciphers[] = {
 	{
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "ecb-des3_ede-asm",
-- 
2.15.1
