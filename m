Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159921-2-6086172244108787512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159919; b=ZrjE5+BVxFyJ8B9SNqF4UvSN6c0B7ADqeUpP6e/151wZSl79mi
    qm+V7YFkCpTQvWxBFsHroOYMD+vEb4yCfxkGvtP9eDcRE3SPOYfcsIHmIkOPqju8
    +KBPaaVMfpwYoU6FgSbOKZ/joFLBXQ0FthH234EkLHOfZGyl+HFxWqZCHhuW1Vss
    sfGzvBO9IiczLWVgjm/zUos51MNur79orAwIV3p0gX7hKtC0NdUYXp031MCL5D3I
    Wfnvy9Lm7iK68O5GfqU/KT7Y5sSxHX35yzkBEOgbkw5Nd6Am/yeVAiy4ReNggXFd
    g9jBHoNnzwkEfe5k152L55Z1yDBWQPtWplGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159919; bh=eS8Xjco6QVgI5rsj9rTcECCwe6OKbD
    luy18QhCIj5P8=; b=D6vgrMKIgisNOnCSiwXfnQC4Kha8JWaZOS5mgisngDbZiJ
    tUUlQzedNrLp7JJvf3f0ZfX4RqfF5k1srkTCuzgY1WeVrb5R6hBXYIDkAvbabrZy
    TirnbJKMS5hNlwtIn4x//XS/khGbb0U815ivTIKED4hDTL7gN59gaQs2Mhco7KLo
    U10N6vGADixhmjaSvcETucSMXKP/84dTyJI4nOja0wJnMOKlbH7O3nb1Os2veMqR
    tkT3Mvd/1+t3+kBX2lC5ACXN95qT6kTm9NQzqw+bACtQ/FkRKJd3nxBeXZBqewVv
    KMNVSLRjyE6pTXjM5gaW6utfac5Eyem+e/xMrCxw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tMZRixIk x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=tMZRixIk x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNra67oeAW3KpF+mmI3TdU567FHKH3lWU5t5qDMqVh8Ci6JkLZyOeFO6e4REuAB2bvk4eb4JX2ykQzCPUdBWGK3xVfU9BPbBaMxB/oUQa2Fc1m8MuJSB
    9/2P/ZoUcDbRYfiFf4jCz2Ac5rhKZH9ur+XpYBQpbpBJdZa6NthYDztMe2EM8/cdicYRTURcHH3AMzw5pOQYqlmcP/PDIJewRKVOj1ZKwrHGdiWY6KBPrCku
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=XYAwZIGsAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=Sj3FN3u0EdFsF2kP6q4A:9 a=QEXdDO2ut3YA:10
    a=d3PnA9EDa4IxuAV0gXij:22 a=E8ToXWR_bxluHZ7gmE-Z:22 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968584AbeEXLFG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968275AbeEXJzS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 092/165] crypto: atmel-aes - fix the keys zeroing on errors
Date: Thu, 24 May 2018 11:38:18 +0200
Message-Id: <20180524093625.748737802@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 5d804a5157dbaa64872a675923ae87161165c66b ]

The Atmel AES driver uses memzero_explicit on the keys on error, but the
variable zeroed isn't the right one because of a typo. Fix this by using
the right variable.

Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to authenc(hmac(shaX), Y(aes)) modes")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-aes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2145,7 +2145,7 @@ static int atmel_aes_authenc_setkey(stru
 
 badkey:
 	crypto_aead_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
-	memzero_explicit(&key, sizeof(keys));
+	memzero_explicit(&keys, sizeof(keys));
 	return -EINVAL;
 }
 
