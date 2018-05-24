Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159879-2-9977932121842109051
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
    1527159878; b=fc9KP2uI5euMS+1AQyL9htfuNakVus5PWHY6NN9cP1nu0bvyD/
    0ZpX1e8v3V7iVXM7DEIjUZYcQTbqVnvCwWA90ojNtJDGPjwzffq1qxd37F99mvox
    C0R7m4PFPexR/yzmgu//qrGBJwtploejoAXalSZhdb31DzGPE8lj3ae3nyafGGbD
    EcQX3kHLuFgH11ZL+EuvYX1FX6Jz2G6KK/+/dbvFnDDSyAM8OZes9JkMC5cZkkLS
    UGgwcUKpe0q2mzGUBG2FjZSmrWAGRHyxb+L907t03yr+JeReFKWtK7E/qxCvAX+Q
    MLfu5lUA9T80bDKobq5G42049fon4pPtk5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159878; bh=6+z608V0bcqzxlsRjDI8NdO5aKQ5s2
    5r9XfrS+2h9yQ=; b=Q83DmsmbXDpR0hOYx1x3mSinTckjCcEtZO/MTQW/ImFut9
    DJggn+vwLmX5JUOGZEqNLu7rtIJsEFZoSkR22LyW4CjYVTVjg0y+IGRa5kxO6tmZ
    rMJAHc5//FNx7C4yb84cKCG61fw2uwvbA0img+K3ST5q9F5CHsd1ERFolRuiT/5U
    MSEWVwLqfGo9hQ3jS+6mXCN/iN5DVUPPwKlcAw4BTrGOmjI3lwROf7L4no13xuHn
    vaEJV5CkRfcHATMpkwlDFH3qJMQ+yT9VT03uaL8UwQ3Vo8LpCKOVJ2hNdN2ddYmn
    AJAP0NS2bpqvRDBoaiFr79iGPIGM3uDQ5yX24a8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=C3vVrWDc x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=C3vVrWDc x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNYYp36R8cGWWQaeVVGpGYgeI5DBTxiV4Oankaf5WehbKZMRnTLIE7BKpFbKmhiaGOdRInXcsA5ArKqW3vLuE73knmW4wq8NMWastWNq1cSpNTnIZZEo
    +PI3Sob7V0fhtIC83W1V2nDplyeeDwyNqS1GpWd+F7v2MnXQ/y+6c9IrtTkZeht9QI0wMr8FN8FTjXDkggnvIm7iZCsmoPSEUM2athJ29J0UjPR0m19k0LAI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=c3V0M0qY3_GZ2UDVcWEA:9 a=zvW1_i8sRiYL8egx:21 a=0Vlzb08g0DAHnyRl:21
    a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968350AbeEXJz3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968361AbeEXJz0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 095/165] crypto: inside-secure - fix the cache_len computation
Date: Thu, 24 May 2018 11:38:21 +0200
Message-Id: <20180524093625.864684635@linuxfoundation.org>
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

[ Upstream commit 666a9c70b04fccabde5cea5e680ae1ae92460a62 ]

This patch fixes the cache length computation as cache_len could end up
being a negative value. The check between the queued size and the
block size is updated to reflect the caching mechanism which can cache
up to a full block size (included!).

Fixes: 809778e02cd4 ("crypto: inside-secure - fix hash when length is a multiple of a block")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel_hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -185,7 +185,7 @@ static int safexcel_ahash_send_req(struc
 	int i, queued, len, cache_len, extra, n_cdesc = 0, ret = 0;
 
 	queued = len = req->len - req->processed;
-	if (queued < crypto_ahash_blocksize(ahash))
+	if (queued <= crypto_ahash_blocksize(ahash))
 		cache_len = queued;
 	else
 		cache_len = queued - areq->nbytes;
