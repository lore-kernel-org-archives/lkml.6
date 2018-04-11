Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476457-2-15331889946878794285
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
    1523476456; b=Ntk4qEbBOtoMiM2ZKSww3K335oTTJy9d49EfUtjmFPzbH67IcY
    VP6TjS97NuoKghfOg2KY6gSfFOX/aweLU7wFV/qlXZfaWS/d2PnNtwzVsY+DDlxv
    mZ7kzmHo2SpZNdTC2dm+vBkPexOTSuVSEnLXBL/5o4J6WAlJ0NEBewbhc4iSIGBq
    E60vhf6BwX3yFmnh4sARYBflwzUYv9U/M0s3kWayyMy6Ev1YYF/IgDe5EwnZR2q9
    nUnjRvAOHkEEGGuj7/ve15ruTN5wJ0ROBQyT28NXKXelm2A6eg83gtXchydWNjVL
    Ir0BZD4m3+GQ3iVoED9oKZtIy4W8g+qNhJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476456; bh=66OXXVlRIxmAsO8giXTWV+iY+m7ZyP
    5gqOUuuyhgxHw=; b=QK5aUOrGcUuyCOCTLD/HMXLgwLpbnmi1grw/inStzjbtZk
    6++Z/flY5bClI4rIyC5gsohJhYbyyiXcoDSN+n24FJV7lGdvswXEOvLm/Yd68AEG
    TEDvbAJmYfF3DL0S0AvMwuq7fxcNaqVp1IgYHCYNzuqwCZSMvd/hTh4b8h3kUzK1
    b8O1p2F8f9fdDYo9hCp4NDxzTOy7zOQLTzoS9+SZD8TTF4L6dn4d5AuqJVLIV+M7
    7Pv2Q6FoLEJDYUIanJSji1YF/G3xgXsdz6Nmk0gQRzIzUvb8L9qRJtOGJzEorKIC
    Ti1DU8SdVpcD1BlKDthG99G0xqnZVsjQaz9TW4AQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJzM2brumArL1uGVQR+K45cSNyiFdZGFgjPoX17htQ/d3OQMus/6TA9BRvELrXCnsxAetAVYhVZKtooPVVbs47oVaBES4Qww2zaPm5rWI0i4MpAJzgio
    gR4xGqqFEY1/wOiQIP3DmfffsP3VUMnhdwKl2CT+XP09iUIFK/OJPmbDLgjoSYT2nVJ4ESAzgOXgpCyM+bUsK8ydnmSisES07y9wqhd0QMXRdIxrCaQ0xPlM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=meVymXHHAAAA:8 a=Z4Rwk6OoAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=SDn0Evgz16ysR3pIT5UA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeDKS5i (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:57:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756449AbeDKS5f (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 114/310] PCI/msi: fix the pci_alloc_irq_vectors_affinity stub
Date: Wed, 11 Apr 2018 20:34:13 +0200
Message-Id: <20180411183627.083537008@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>


[ Upstream commit 83b4605b0c16cde5b00c8cf192408d51eab75402 ]

We need to return an error for any call that asks for MSI / MSI-X
vectors only, so that non-trivial fallback logic can work properly.

Also valid dev->irq and use the "correct" errno value based on feedback
from Linus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: aff17164 ("PCI: Provide sensible IRQ vector alloc/free routines")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pci.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1348,9 +1348,9 @@ static inline int pci_alloc_irq_vectors(
 		unsigned int min_vecs, unsigned int max_vecs,
 		unsigned int flags)
 {
-	if (min_vecs > 1)
-		return -EINVAL;
-	return 1;
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
+		return 1;
+	return -ENOSPC;
 }
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
