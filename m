Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeBFXMJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:12:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58010 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbeBFXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:11:56 -0500
From: Colin King <colin.king@canonical.com>
To: Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: chelsio - Make function aead_ccm_validate_input static
Date: Tue,  6 Feb 2018 23:09:20 +0000
Message-Id: <20180206230920.13764-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function aead_ccm_validate_input is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/crypto/chelsio/chcr_algo.c:2627:5: warning: symbol
'aead_ccm_validate_input' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 34a02d690548..8a67884512e4 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -2636,10 +2636,10 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 					0, dst_size);
 }
 
-int aead_ccm_validate_input(unsigned short op_type,
-			    struct aead_request *req,
-			    struct chcr_aead_ctx *aeadctx,
-			    unsigned int sub_type)
+static int aead_ccm_validate_input(unsigned short op_type,
+				   struct aead_request *req,
+				   struct chcr_aead_ctx *aeadctx,
+				   unsigned int sub_type)
 {
 	if (sub_type != CRYPTO_ALG_SUB_TYPE_AEAD_RFC4309) {
 		if (crypto_ccm_check_iv(req->iv)) {
-- 
2.15.1
