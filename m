Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841409-1519418803-2-5755099354078979081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418803; b=Of+uVpjjBSsJD4lCwicUcntqpeDA7cGNEaud9QhwcOxmU1G
    P9ocvgnwaancNznylvFS8p7peqFo6OxF/Qx7jVcHOzNsOawFBy8S4LaSAj9wk2rL
    xPgsSKlstdJOjN+RCFEm7VprSkD3nInCWGHSBIE9AVVaMRVuTlgPbczErpXar/Of
    upuEJIa87knEuTdJSghBdpOOKc4SI1eJ9Tre/Xw3/N+nODPSrYWJrb3tC/koKDsP
    5EGWi4q4CbC+LO5PzhFPy7NNolBVfILnYrip5bLQQzKnc0ocRWEe33zeNryYsifm
    UJDRODSgNLN1qTqyk6Po1xX5uR9aX32DuqKLikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418803; bh=SHlaxl7WFcUR1D6qWn9hkSAFTS
    o/weK3Ysd8tDsgSGM=; b=E2WfgTPIKtO4QUhEKkldbMlPIt1ydfjm9IsjQRWeQb
    asf1ycb5ZdQA/3y1fsOPSJl5g7ECG8c4jfNfoODk1/e6/+zTYpEYPOD/HCHY9wTc
    FIpNfhXj42JwdzulzABFZHNhOKEF/btCT5A0AkoAkYb9sGte4gUMWajNDZ+3MnGd
    u219v27ABOHgok5SBt9sFU/3+0BT6N7c16oDKq4TwgOueMRXxHKMAoCYoMEBm6/t
    2GImcUk4DA63/tw/XYjaOpR/B7brUyFBqu43pv01TAIo94ovsJDCvZ/8+d0dTDBE
    Q6VQs30Z9riecXD50n8M+FwcVA7o8hNMP0lS9P76Ci5w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeBWScY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeBWScW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:32:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kamil Konieczny <k.konieczny@partner.samsung.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 3.18 58/58] crypto: s5p-sss - Fix kernel Oops in AES-ECB mode
Date: Fri, 23 Feb 2018 19:26:57 +0100
Message-Id: <20180223170215.816304712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Konieczny <k.konieczny@partner.samsung.com>

commit c927b080c67e3e97193c81fc1d27f4251bf4e036 upstream.

In AES-ECB mode crypt is done with key only, so any use of IV
can cause kernel Oops. Use IV only in AES-CBC and AES-CTR.

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
Reported-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Cc: stable@vger.kernel.org # can be applied after commit 8f9702aad138
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/s5p-sss.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/crypto/s5p-sss.c
+++ b/drivers/crypto/s5p-sss.c
@@ -419,16 +419,21 @@ static void s5p_aes_crypt_start(struct s
 	uint32_t                    aes_control;
 	int                         err;
 	unsigned long               flags;
+	u8 *iv;
 
 	aes_control = SSS_AES_KEY_CHANGE_MODE;
 	if (mode & FLAGS_AES_DECRYPT)
 		aes_control |= SSS_AES_MODE_DECRYPT;
 
-	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC)
+	if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CBC) {
 		aes_control |= SSS_AES_CHAIN_MODE_CBC;
-	else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR)
+		iv = req->info;
+	} else if ((mode & FLAGS_AES_MODE_MASK) == FLAGS_AES_CTR) {
 		aes_control |= SSS_AES_CHAIN_MODE_CTR;
-
+		iv = req->info;
+	} else {
+		iv = NULL; /* AES_ECB */
+	}
 	if (dev->ctx->keylen == AES_KEYSIZE_192)
 		aes_control |= SSS_AES_KEY_SIZE_192;
 	else if (dev->ctx->keylen == AES_KEYSIZE_256)
@@ -458,7 +463,7 @@ static void s5p_aes_crypt_start(struct s
 		goto outdata_error;
 
 	SSS_AES_WRITE(dev, AES_CONTROL, aes_control);
-	s5p_set_aes(dev, dev->ctx->aes_key, req->info, dev->ctx->keylen);
+	s5p_set_aes(dev, dev->ctx->aes_key, iv, dev->ctx->keylen);
 
 	s5p_set_dma_indata(dev,  req->src);
 	s5p_set_dma_outdata(dev, req->dst);
