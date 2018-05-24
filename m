Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159865-2-10088097856440875403
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
    1527159864; b=GJy/Ko8/7Lc1gXjLGHXTwudQFnsPO8LhQ7BArBUNtrHwX9pCcZ
    A1DcWNc2TTgihV17G9ho36/f9BbXq4L4TFLGZUFmvjIjaSEJcYDbfgSZa0iO0LhZ
    v6HAFj2XtOiXkrq/wU7twd8TrKcap7/XHiqXa0fy6zCAyznYDg7+nogNRaYDKXzw
    LOtqwBojaSigdyTrixDd7Pox18urO9ClohESH37N/FipLb/40gQ46UuwlSey1+vv
    0eCRlu2rGDLJbBur9sRucQ2Rp+BT/0xX2TQgtdRupEil7JBmnx/nwmvlC/V3rUuO
    QvFt2f/zIxNnQFr7SINeVDjDNCaYxyjcNwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159864; bh=4dz9N6LktgddLd1S5og9KTW4DWzcbu
    stRShRGjf6vOw=; b=hM0UQLd2brH0cPx99IbL/c4gvYjzRXdd5acCUtBoqmmE0C
    BPlLsu0XCYITBkiID2zPp2m+3Byw4UYBtdKE8sWiWiwO1FIo/z6R5RSMoWrPdW4c
    JPi2MLeHlEhDU6mcYhgCI8IdIagaNJnosRww+xx15Wbw0Jd1522WHFBChsQ32xu3
    uZeI7QW7P7a4cJct/7kNNhFHMfjeBjk7qnZJIjxO50v41BOOd3pExdFkRLzzoEug
    Rr/SL4izHLIMkclDn//W58Ln9PweSV+/iqeKC2gCntiVUIMn9ugaqbCldfIpnm3z
    fLa2+Et1N4rNWDkXeMvFRyZvLMjbeOG2Rr0QPvJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=gvTlJrdk x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=gvTlJrdk x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKb0SWdicEHARsL9JOGk2FrWdcJTa2lAgBycdpJuGCn8lzS4KK7wLIljf6ZwgQHppcRZldeQABmlunHtdwHHWYdxZrDvdPpXUMUSAlhA9HyM/j6itq0q
    s7GPsDQcWiJH10AndWzyCnB64kpLyzyyb/yTExZz2fEcOLWro5LLu6j5yrOErYINY8XZIiDg9NN1/B7XicZVJUY7EwFX2JGy33tIwZBYpbgQlrR6Oaq3x8eg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Her4p69QUh0uQWrOsnkA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968141AbeEXLEV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968067AbeEXJz3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 096/165] crypto: inside-secure - fix the extra cache computation
Date: Thu, 24 May 2018 11:38:22 +0200
Message-Id: <20180524093625.906068230@linuxfoundation.org>
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

[ Upstream commit c1a8fa6e240ed4b99778d48ab790743565cb61c8 ]

This patch fixes the extra cache computation when the queued data is a
multiple of a block size. This fixes the hash support in some cases.

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
@@ -199,7 +199,7 @@ static int safexcel_ahash_send_req(struc
 			/* If this is not the last request and the queued data
 			 * is a multiple of a block, cache the last one for now.
 			 */
-			extra = queued - crypto_ahash_blocksize(ahash);
+			extra = crypto_ahash_blocksize(ahash);
 
 		if (extra) {
 			sg_pcopy_to_buffer(areq->src, sg_nents(areq->src),
