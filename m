Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805410-2-4484454495171374007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805410; b=nsWFjwJbofocf/rrBupTpcJTVaBd/jRrmdABcHm9GETsLDU
    iIMdT/fPQixFOycnkwpak7v/xWXU2884OzkASBialGqD4XvlPRxEJ5VfcHBvqqSS
    ZzqtLVEOpR7MRv75DzMe81mHgVpSMnOcm1Gxrnk+2kiP+EHbzVuYISpjHhuC8GaJ
    Dmw0d5SNfBFMk7C+Vg37JCRUv1eJOTomuf2HWJm+Z6P+iSEd5Enx9feCsaAsXI4H
    BL3oIsCgouSvxTZ2DvE1hBVtxsVN1szouF+XgZzF8SqcIreBjoA5vMf/PzsRQ3Wk
    a1g+HPGMBfU6DDOwD8QS0T4Ls0SZ33RQj842TwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805410; bh=D/WrzbQXczNZIYcIKzPwGkPYoM
    VwYhOf8hC7b3biifQ=; b=d8cigFkRwKmR6jSnvvtOopHJxQCiYBrSbosLUcXFKP
    6YcGuFFCas1YDqYU1igzaQG5lAPh49riLeV70UkwZK8u0529CX32DFPTC1maPtdC
    DmJvfgqxni6mSUJ4MDXRAFKoeoUBQ2G54YtQdNshm/pMWSRtk1i4vfAEAnz4oXBF
    cvwLXIovGv4bjF0ktkEsn8Db73/Tx6/UXn69LBfzNWVFiwiKs/nbQjVkKO6WLEFP
    KqtAFbcZWy4jo/kCF4EvlAhVoFbCwXRjIwYAQZ0uLURG/djZbHAe6Rrk33GSB6ot
    0eVJ+QfK/AwDMp5LTgrMT7r9fcAd68sr6YWy3zOeZQWg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeCWLmw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:42:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbeCWKDm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Persson <larper@axis.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 65/77] crypto: artpec6 - set correct iv size for gcm(aes)
Date: Fri, 23 Mar 2018 10:54:39 +0100
Message-Id: <20180323094146.626804582@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars Persson <lars.persson@axis.com>


[ Upstream commit 6d6e71feb183aa588c849e20e7baa47cb162928a ]

The IV size should not include the 32 bit counter. Because we had the
IV size set as 16 the transform only worked when the IV input was zero
padded.

Fixes: a21eb94fc4d3 ("crypto: axis - add ARTPEC-6/7 crypto accelerator driver")
Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/axis/artpec6_crypto.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 
 #include <crypto/aes.h>
+#include <crypto/gcm.h>
 #include <crypto/internal/aead.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
@@ -1934,7 +1935,7 @@ static int artpec6_crypto_prepare_aead(s
 
 	memcpy(req_ctx->hw_ctx.J0, areq->iv, crypto_aead_ivsize(cipher));
 	// The HW omits the initial increment of the counter field.
-	crypto_inc(req_ctx->hw_ctx.J0+12, 4);
+	memcpy(req_ctx->hw_ctx.J0 + GCM_AES_IV_SIZE, "\x00\x00\x00\x01", 4);
 
 	ret = artpec6_crypto_setup_out_descr(common, &req_ctx->hw_ctx,
 		sizeof(struct artpec6_crypto_aead_hw_ctx), false, false);
@@ -2956,7 +2957,7 @@ static struct aead_alg aead_algos[] = {
 		.setkey = artpec6_crypto_aead_set_key,
 		.encrypt = artpec6_crypto_aead_encrypt,
 		.decrypt = artpec6_crypto_aead_decrypt,
-		.ivsize = AES_BLOCK_SIZE,
+		.ivsize = GCM_AES_IV_SIZE,
 		.maxauthsize = AES_BLOCK_SIZE,
 
 		.base = {
