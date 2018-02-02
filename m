Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591322-2-8425079689953464720
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
    t=1517591321; b=UBI7ohrLXWS6Pa8pmxbB670oq1eX7E2f1DcTI4ValZ/EBcd
    F4d+H/q6GmUYU/GHEVhLSjr6d4ZVhzcUj6EYcmFGMmEcB8BXZKvRQKkyhDAC9M3s
    57xjbNmJtWP5+DmJPl/GM/6IvLXThxZCZcXg0cIIVXKZ5uH6LHAnNJQFZWMSBUFq
    rI7DQUDw+SScku3QBZpX4cWeijReNQnOAYBpC89SOfhdM6b2iMEEz8d25sG9RT2p
    KcaTf3tm+Kb0k3XvAnv8JmXpZh2mh1P+RRu+v9jpa4ZQ5KIdzUUxjXPca9C72Txe
    EQTnESdlz0KfpunN2LVQ4eo037Qr0RPJQY1qUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591321; bh=oex5dyvUbAiX7vBsEyF/ZDkvDI
    k8LGLhaESyhscRA1Q=; b=n68jGvSC0tTPWMSrp8/J4tGQWM5DmGijk2qAhOKO0h
    uWY3bJ1iZ3nFyj+9p8Dkz8jCj3gOZA4a2QxKjkGHwwUCXICCehSiYQErs+EOrfPG
    0T7W3Xn5wS6Wzk287cWIN73kijXTEO2+L+BUt9U1zZJ8Xv7tP7x2b5rKtA6fSpOW
    YsO8VfqW/GDjhUi9AX34KyT07ckC2f8m89gZe/JG4a8eQHqzjPh4Z1o5ge9g3xiS
    RNInlkRgy2Lhi0AzFDdF1CTzvfWlPVzKJYpSXWW9y+PUeCDzcH2CVdZgkQrh73tP
    8GmSRLFdHkqGo493OHOnb0E6qKl5dCu2t4ZsirBrPGpg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeBBRIj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:08:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBBRId (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:08:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 009/156] crypto: aesni - handle zero length dst buffer
Date: Fri,  2 Feb 2018 17:56:30 +0100
Message-Id: <20180202140840.748001317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit 9c674e1e2f9e24fa4392167efe343749008338e0 upstream.

GCM can be invoked with a zero destination buffer. This is possible if
the AAD and the ciphertext have zero lengths and only the tag exists in
the source buffer (i.e. a source buffer cannot be zero). In this case,
the GCM cipher only performs the authentication and no decryption
operation.

When the destination buffer has zero length, it is possible that no page
is mapped to the SG pointing to the destination. In this case,
sg_page(req->dst) is an invalid access. Therefore, page accesses should
only be allowed if the req->dst->length is non-zero which is the
indicator that a page must exist.

This fixes a crash that can be triggered by user space via AF_ALG.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -823,7 +823,7 @@ static int gcmaes_decrypt(struct aead_re
 	if (sg_is_last(req->src) &&
 	    (!PageHighMem(sg_page(req->src)) ||
 	    req->src->offset + req->src->length <= PAGE_SIZE) &&
-	    sg_is_last(req->dst) &&
+	    sg_is_last(req->dst) && req->dst->length &&
 	    (!PageHighMem(sg_page(req->dst)) ||
 	    req->dst->offset + req->dst->length <= PAGE_SIZE)) {
 		one_entry_in_sg = 1;
