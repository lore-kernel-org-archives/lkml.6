Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720139-2-7520050818960942640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720139; b=R5JcFlea8SrRg5PVNU15ocwjE4OS84E+gZgrd9pEh0SiH0W
    Ll5sqzNdVvH9o8YyZPlQy4xMEEGthfQ5BwktNCYk3E/sUT2aFNvkqvgV/fIPzdCr
    HWKF4m5/wvtC1PySzGt762UMhS4dpvMvnRz4RqJZTc+Jx8d6HlCle/u0+bnGW+CK
    cpeoQ+ml0wwr+/UZocV9Jr9UwhoQGBDFnOVLw1cuN6RKiymNlP/oRVUR70fZ/5b+
    Xy+kwHza0mgfq4rVQOY2p/sxgdMREMwqmvzwWeF13nqaFpsof3vI4T1Z7gbXq8ck
    FuvfsKDMZe7Y4wsdsCBpDrNp4uWc0Bqu/LcW/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720139; bh=r21UI0UVPHiIKEdbrQO4VgIsO5
    ynKosgFrCTyVpLM/I=; b=di+xbYHOLF26FUz1QZu5DIEPk94YdK8DhuqJGD7Q7F
    fGYFll4SBs8z/WZCw+Y+srBZo/J1t3+SIYnoHxHmFPBH0v6uI1818XEuiDpGLVFY
    wmVJe4NPDMcNeuvwdQK+j+C/koExL1aVOFOvPpZKWq5X8FGKhIme4RVIHEGvZmFk
    0fGoSwyQKD/gGNPXe2fF+5t0LpVNBOQtm48jfe2dkJoFXFMb+hOhPjWqdw7XTFRx
    uVyMunqAHSM+7mWmS/3B3k4foyYOtk1dRNfsdieNKDuD8NkTpUiXo3vYrgOHLmQy
    Q+RdpQSxQbS3E9vqTo4LqV1G3TeRj9cZFptyKNVepdvA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162688AbeBOSl6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:41:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162709AbeBOPXm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 067/108] crypto: hash - introduce crypto_hash_alg_has_setkey()
Date: Thu, 15 Feb 2018 16:17:04 +0100
Message-Id: <20180215151231.745826608@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit cd6ed77ad5d223dc6299fb58f62e0f5267f7e2ba upstream.

Templates that use an shash spawn can use crypto_shash_alg_has_setkey()
to determine whether the underlying algorithm requires a key or not.
But there was no corresponding function for ahash spawns.  Add it.

Note that the new function actually has to support both shash and ahash
algorithms, since the ahash API can be used with either.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ahash.c                 |   11 +++++++++++
 include/crypto/internal/hash.h |    2 ++
 2 files changed, 13 insertions(+)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -637,5 +637,16 @@ struct hash_alg_common *ahash_attr_alg(s
 }
 EXPORT_SYMBOL_GPL(ahash_attr_alg);
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg)
+{
+	struct crypto_alg *alg = &halg->base;
+
+	if (alg->cra_type != &crypto_ahash_type)
+		return crypto_shash_alg_has_setkey(__crypto_shash_alg(alg));
+
+	return __crypto_ahash_alg(alg)->setkey != NULL;
+}
+EXPORT_SYMBOL_GPL(crypto_hash_alg_has_setkey);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Asynchronous cryptographic hash type");
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -91,6 +91,8 @@ static inline bool crypto_shash_alg_has_
 	return alg->setkey != shash_no_setkey;
 }
 
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg);
+
 int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
