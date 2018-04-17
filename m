Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2220351-1523981436-2-2983148252616048963
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981433; b=aqIFqvecZTB4UktR2vVoZaRK+MNbixLKeRRcfbbLz36fYLDEO+
    vMcbVLhleK78VzBvdKLAedPnQse1ftjAbXVWdEUia33bzkWASibHT5FOXy/tjVv9
    GEf/x5GCV50hyo1lauxZOtlRxsxTEXELmhOfFoI6BpQlZq+rxc6uwGpQvqr07BYg
    YkIpGVQUfHqtK6KQSI6coW2TK7TAaPwVpFFDjA9bWRfJ+38zLNpj97R5/KgeQEuh
    qzXyadHZeKUaVPJCHfEvOL7dMAtgDkKdXpa2l05njJpS+fyc31oRRNPrPwdPEAwI
    7AZSkVZgGsS14p6tqkhoPnn8320kVqwCAIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981433; bh=7H/BShoOjiR0DutAihJ7yLYiYv6UCT
    pHNFLI2ILhEZ0=; b=XeMF40tAbXSLiMMJ6SEfuPDf3RexYKAEEcfeBHD0Fh9jt7
    lj0Eey8G40OPdssKHsUnFQ6mKmJ0b0x6QHZxS7SsMYVEteJGL/g3u8IF+0I+gf9B
    9ci4agd+kqZP5tPagfyVfekE4wKztMcTMx2V23QVMJXXaKXyKlVevjdso9SdpFAL
    iOZZf28uIxDj8TAy3YO0BcCAZLUGSZufrfRev825x+Tc2zBrPAxenfolk43q33aO
    4/7+b/7TmJ236AwC1hz6FhEiUmWbY/bEjfyccI/JWYp4uxhjlJCzWKwVFDK0Px6P
    lzhUB2QXv33pFiaxdyBmEMoHdfTFAbS5vEk6RCSw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfHbbGbPUNduiq68llmk1CetAFMf8orVAUkvlyus5WCgtffnu8iW3a4DXym84r64JMkdccjR5sA70ZJ14xvgLPc1vPaQ7WMv7i24eNXTiTbopzZtMvFF5
    iSoxIT7Gs2/PFUYqzKiZW4jhkFmNW9Bpdh3q1ZfvV9RETBu+r9oUmrB1PK8/Z66FV2EBmMLACiWdohOBF0CZQIFr7zB23SXWbXlKuMwppw/IpOKY7MxGwUpX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=drOt6m5kAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=2mOOifH8u5EECxIMPxYA:9
    a=pJxnJ5vO3RysYamt:21 a=0mWPGmnHVDgINNCZ:21 a=QEXdDO2ut3YA:10
    a=RMMjzBEyIzXRtoq5n5K6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeDQQK1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:10:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeDQQK0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:10:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 58/66] getname_kernel() needs to make sure that ->name != ->iname in long case
Date: Tue, 17 Apr 2018 17:59:31 +0200
Message-Id: <20180417155648.392395989@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be upstream.

missed it in "kill struct filename.separate" several years ago.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -221,9 +221,10 @@ getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
+		const size_t size = offsetof(struct filename, iname[1]);
 		struct filename *tmp;
 
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = kmalloc(size, GFP_KERNEL);
 		if (unlikely(!tmp)) {
 			__putname(result);
 			return ERR_PTR(-ENOMEM);
