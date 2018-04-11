Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473408-2-12219495085814357343
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473408; b=OlscKru5PRthZjNgwVKSv4tgH95tKXM0qu6uUk3JBBdoJlXRMC
    4+wWCXHGydmwBSr5lgmwr7orgwEntG5MdWGU1x0Bsmt64LYXFe5n816d4HYq0QPs
    4lOrdPHsZjJWswJtcAWAbnY4KpQ21iZpV7uXjQyY9H1DtDPz3x7jF3mlZ/s/CD7U
    cu2ssQCB4FewVp/rJSGj0PTpg8dKNd6wIQ5ET/uiscMyuHuvNlB72wOENq/DsaDi
    nGuw0J+Jmw3bq9Tlpb1ub/cNAIXD/gEuBQGUlS6TAK2p4gBA9PVUEvy8xnhhfDNQ
    gvGRqXMnV0fD0fZH+3DBWtd2+AAXC1r5m0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473408; bh=0AT+CkXKRhwcZkz3GmxuUTAW/fkak4
    E9V/Ih65HhNAA=; b=tXB4JYOEPrnnrqYB34ziJ8g5hc0FYyl3RFkMXR1ufTpnwu
    jfawLh7JxBL1QpRwNMJ2X19rdTJRL9ErZP+fYXDyt4QOtANPNtpPgi56uL5HXkHs
    BdEa7McKRv61+NYvtDtIgxW+72TeVIWFlGy1O0KZLtNbbjCfrdJwnnemGtzT0trI
    yROLNdvvXdvEJ0GQaGLIF5P6vdn3qnN21F8T+Vax3zqeSNo817MDQcSBikHoCBED
    /RTYoezje0WnYwEzFg4T7Jt8Oqp2bfAHLgbKqG11yVzfa9d8eWXAwUrT2sj4yfYs
    knZxBWVxqZk0LNblojPPuePlpk+BN/Qrs+kqydEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBeaFkUd2LwFd3uqdsXiqyaOyvNIoSSzcghcAX2grEq2uIld3cxW0otEAD3sifGbb0hjdQqp62Yq4fDyDsvhPSFS4oAM+eRp+qXB0HI5u04VqsWBiqJp
    FpSls2PKkpPsLsEP6q+5kCx4XPzMTxoFn1l7ritCN5OVCYBTvrPP14KtICvG132KVwTcEdMJPyRFDjokn2owAkGZc0Iva8GoYmEbWtMbkQQftp4+FXlturRo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=rfhrFaoKa7VXuZdQKY8A:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933950AbeDKTDW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:03:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934625AbeDKTDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:03:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 234/310] crypto: omap-sham - buffer handling fixes for hashing later
Date: Wed, 11 Apr 2018 20:36:13 +0200
Message-Id: <20180411183632.576679237@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tero Kristo <t-kristo@ti.com>


[ Upstream commit 5d78d57ede8f9e7f656c610ed25be7be337e0529 ]

Currently, the hash later code only handles the cases when we have
either new data coming in with the request or old data in the buffer,
but not the combination when we have both. Fix this by changing the
ordering of the code a bit and handling both cases properly
simultaneously if needed. Also, fix an issue with omap_sham_update
that surfaces with this fix, so that the code checks the bufcnt
instead of total data amount against buffer length to avoid any
buffer overflows.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/omap-sham.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -873,14 +873,21 @@ static int omap_sham_prepare_request(str
 	}
 
 	if (hash_later) {
-		if (req->nbytes) {
-			scatterwalk_map_and_copy(rctx->buffer, req->src,
-						 req->nbytes - hash_later,
-						 hash_later, 0);
-		} else {
+		int offset = 0;
+
+		if (hash_later > req->nbytes) {
 			memcpy(rctx->buffer, rctx->buffer + xmit_len,
-			       hash_later);
+			       hash_later - req->nbytes);
+			offset = hash_later - req->nbytes;
+		}
+
+		if (req->nbytes) {
+			scatterwalk_map_and_copy(rctx->buffer + offset,
+						 req->src,
+						 offset + req->nbytes -
+						 hash_later, hash_later, 0);
 		}
+
 		rctx->bufcnt = hash_later;
 	} else {
 		rctx->bufcnt = 0;
@@ -1189,11 +1196,10 @@ static int omap_sham_update(struct ahash
 	if (!req->nbytes)
 		return 0;
 
-	if (ctx->total + req->nbytes < ctx->buflen) {
+	if (ctx->bufcnt + req->nbytes <= ctx->buflen) {
 		scatterwalk_map_and_copy(ctx->buffer + ctx->bufcnt, req->src,
 					 0, req->nbytes, 0);
 		ctx->bufcnt += req->nbytes;
-		ctx->total += req->nbytes;
 		return 0;
 	}
 
