Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7FAC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAB520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAB520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJ3UzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:55:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeJ3UzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:55:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gHSic-0006oX-LV; Tue, 30 Oct 2018 12:01:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: chelsio: clean up various indentation issues
Date:   Tue, 30 Oct 2018 12:01:58 +0000
Message-Id: <20181030120158.23323-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up varous indentation issue

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index db203f8be429..497c57803de7 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -1311,8 +1311,8 @@ static int chcr_aes_decrypt(struct ablkcipher_request *req)
 			return -ENOSPC;
 	}
 
-	 err = process_cipher(req, u_ctx->lldi.rxq_ids[c_ctx(tfm)->rx_qidx],
-			      &skb, CHCR_DECRYPT_OP);
+	err = process_cipher(req, u_ctx->lldi.rxq_ids[c_ctx(tfm)->rx_qidx],
+			     &skb, CHCR_DECRYPT_OP);
 	if (err || !skb)
 		return err;
 	skb->dev = u_ctx->lldi.ports[0];
@@ -2008,7 +2008,7 @@ static int chcr_ahash_export(struct ahash_request *areq, void *out)
 	memcpy(state->partial_hash, req_ctx->partial_hash,
 	       CHCR_HASH_MAX_DIGEST_SIZE);
 	chcr_init_hctx_per_wr(state);
-		return 0;
+	return 0;
 }
 
 static int chcr_ahash_import(struct ahash_request *areq, const void *in)
@@ -2249,7 +2249,7 @@ static int chcr_aead_fallback(struct aead_request *req, unsigned short op_type)
 				  req->base.complete, req->base.data);
 	aead_request_set_crypt(subreq, req->src, req->dst, req->cryptlen,
 				 req->iv);
-	 aead_request_set_ad(subreq, req->assoclen);
+	aead_request_set_ad(subreq, req->assoclen);
 	return op_type ? crypto_aead_decrypt(subreq) :
 		crypto_aead_encrypt(subreq);
 }
@@ -3118,12 +3118,12 @@ static int chcr_gcm_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 		aeadctx->mayverify = VERIFY_HW;
 		break;
 	case ICV_12:
-		 aeadctx->hmac_ctrl = CHCR_SCMD_HMAC_CTRL_IPSEC_96BIT;
-		 aeadctx->mayverify = VERIFY_HW;
+		aeadctx->hmac_ctrl = CHCR_SCMD_HMAC_CTRL_IPSEC_96BIT;
+		aeadctx->mayverify = VERIFY_HW;
 		break;
 	case ICV_14:
-		 aeadctx->hmac_ctrl = CHCR_SCMD_HMAC_CTRL_PL3;
-		 aeadctx->mayverify = VERIFY_HW;
+		aeadctx->hmac_ctrl = CHCR_SCMD_HMAC_CTRL_PL3;
+		aeadctx->mayverify = VERIFY_HW;
 		break;
 	case ICV_16:
 		aeadctx->hmac_ctrl = CHCR_SCMD_HMAC_CTRL_NO_TRUNC;
-- 
2.19.1

