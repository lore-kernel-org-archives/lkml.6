Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591240-2-675209111522668621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591239; b=l1dbLasze7XR6e3vFr0okCK7wg7izGBT0GGq5Ohc1CU2YDS
    b2HpYdmz2o1bX+wKKXc7+vtgGPzgnDOnfAV8CIIQkZC7L44jz/EMacBIYGX3N5pE
    dzPNu6xpEG+6GUg5uqgIanVRfZ0T/ub34/8/y6od8+MflDzIvySS9EOqaOkpXiF3
    sCg7KiGTTMxC6o6MIavkJsahnYLraM94TKfVhx/rhJIqZsKHfRp29G7sDYHWr6cE
    gN3jaWsYrG7dKhFmAXE0afWKOLW/yV1NHNCbAc5pPONyY7oE9K0qsZ1m3spZ9RWy
    4j+2KygVQ+8owIKswNpZWD2S2i0Io59zt0/4KHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591239; bh=OQKNqpd6S3E0IWY0FCyQwld0ec
    6OagNhNhs6InmbdRE=; b=S0Hq1qkOeU5Rc2UpeOT6nkKczysoz9JUx0l5LxyC7K
    2T17MevyIe5hKDhF3CPLE8z8LzoAh+GIoSfZAfE+MttVVBUmw73dXekqo34rELFT
    6zviP4TgIYRC5F1O+P+U1uw33uI1wCA/CEtRPJBl8IHWFY25FYvCPmYIYYHBk4z4
    rmV2jbsga3CfAwtiXxg8RLrkphNEXGjh3C8qRTs27QJBH2eS2qIBbuWeAcs9Eq0w
    WTvdalz6tsWNOoQ9c1/HtZ+X6gtgW52XGAKUfbHcvMicZ3+AjQCTpWo/RD9/rmL9
    zC6CyxJDvd9oStDGJCznGMoGeuG1ukI1UpFQIsBkCyeQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeBBRHR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:17 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeBBRHP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 011/156] crypto: gcm - add GCM IV size constant
Date: Fri,  2 Feb 2018 17:56:32 +0100
Message-Id: <20180202140840.828227610@linuxfoundation.org>
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

From: Corentin LABBE <clabbe.montjoie@gmail.com>

commit ef780324592dd639e4bfbc5b9bf8934b234b7c99 upstream.

Many GCM users use directly GCM IV size instead of using some constant.

This patch add all IV size constant used by GCM.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/crypto/gcm.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- /dev/null
+++ b/include/crypto/gcm.h
@@ -0,0 +1,8 @@
+#ifndef _CRYPTO_GCM_H
+#define _CRYPTO_GCM_H
+
+#define GCM_AES_IV_SIZE 12
+#define GCM_RFC4106_IV_SIZE 8
+#define GCM_RFC4543_IV_SIZE 8
+
+#endif
