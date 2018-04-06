Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022510-2-13876117352743658447
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022509; b=wJ7qZveM7dg2XhW6ooM/4PRwgNlbABey7qLjbhpAfwVXBkQZG+
    0Zov3Aq/X/mnkrZlwhfHI8FYt5L+Tvdw7d6cMYUzn21YC7QuRngVq7al0HPsuc9f
    eqnJPbkjNivjZht1Xx9Emtv4DfaiVb0KOudweAcKSDZOUJRRvc95d3ywoBWUqCtY
    4PBcmvf1CshrjhYxPiHB689YhJdxSjyC5nZ9NRsifOq1vnWjnmWhmVOjiY1vwjKq
    +uELe4TyC/cKQBQXTS8rcg1aMZ6MRmadajJT2GqwI8+b47mVYwI/kbGm8Wts24OL
    LC5DK8o4NGUDgrVDsvYmvcAAGAulsfSrmMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022509; bh=nnTQhiYUePADsOnihiDDYZ9QAdKPhC
    IGhihFbeyM1YI=; b=w7aSMXBOiyG2XFj3Pjnxp8BTh9j5XFKqwMykicNom/PaW4
    1XrpLrdbqARzLqpo6KroUh8Gx9r3kgwGMmtc5nQULQJFq2Zw++07fu9LCaiUcKDS
    vprvcdaZy/3sWCs6ZUCGZNxlwlDgzJdAQg764xwpuyc7hdmKZytp1m5oJC5x4LPf
    yiRtW9OB6SthiD8VP0B1IFBaZ8x5IsIPMjMG/RTT2nQBO/e8VnYr0n8oQMyYQHUL
    vJmQoxsEFb+Z2BqRlN1UIUSBsCiljQUolx6y7YPRYKsF2h2J7GI9EYE9FGTh5Mqw
    t3vg6AtP92Wnq6O2QAy/uVCOAnemr8rkYLnQGVNQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH1Ri50qtcLQLsaLbljQndbaoUsP+xSWsdqMwgrTMkj2jrlT8SkXgX0vPlp4G+kFkvgnZUyUj3pdU5cnXzobGqlL4/gmdDn8SkaCY5aC8RXHRWmSxaJ1
    u+KDhHLGaPQXHgYRneyT2ZOgEGIhzs/r5LtjZNHI6HijDGVQo0mjObB0rszF6x2784FkNhQmEViEJ4U6dNgwRD74TFqZP8lcAu17tUCLRMhl1EOdp/DmBpZ1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=a4QMtHrlVgIB1BqiWP4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756941AbeDFNsA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:48:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38038 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756973AbeDFNpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 30/31] Fix slab name "biovec-(1<<(21-12))"
Date: Fri,  6 Apr 2018 15:24:55 +0200
Message-Id: <20180406084344.988385539@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit bd5c4facf59648581d2f1692dad7b107bf429954 upstream.

I'm getting a slab named "biovec-(1<<(21-12))". It is caused by unintended
expansion of the macro BIO_MAX_PAGES. This patch renames it to biovec-max.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# v4.14+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -43,9 +43,9 @@
  * break badly! cannot be bigger than what you can fit into an
  * unsigned short
  */
-#define BV(x) { .nr_vecs = x, .name = "biovec-"__stringify(x) }
+#define BV(x, n) { .nr_vecs = x, .name = "biovec-"#n }
 static struct biovec_slab bvec_slabs[BVEC_POOL_NR] __read_mostly = {
-	BV(1), BV(4), BV(16), BV(64), BV(128), BV(BIO_MAX_PAGES),
+	BV(1, 1), BV(4, 4), BV(16, 16), BV(64, 64), BV(128, 128), BV(BIO_MAX_PAGES, max),
 };
 #undef BV
 
