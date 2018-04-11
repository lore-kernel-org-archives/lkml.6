Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479076-2-5733256251983802272
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
    1523479076; b=DA6X502JTWkCW9lI4bdg1pahxlG6of4ltIFdwQbRK/GuhTNSAG
    1osL3gfiS1odYRXZkCvnvXRKH4js2IXJTL/gN1vFuBrU6Wh/SQIzNDpQrI2cp2LG
    2lMvGB7GA0pG08A798YWvMp6MBjQQKcY2gbRB7XrTTZQnSat9UXAsY5Exc2Fn9vS
    RhJ8mzPPVUsvXQvpsa0KbjpuDZ3DOFI9jrH98TLbUxQ0uS+dR6Mv1vvKqGeQbXng
    5UeN1m6ze7v0/qyUj2HLdqQICR4FvKZwABwiysZGX1/6azpaj14RXkr5P35RUQN8
    9FJnPEWaKspBwHfrfpeq75oTc9zuzQRLO5qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479076; bh=qQ8dAjv1xQgJxg38Usl84DGgKbk3eC
    4d5ahllQf5JNY=; b=Vv9dzsRe7WSrCU0sBvFmjLXsoxvQIQPY0l5p8K2TkWuEQM
    2G0e7lXoROHh8ZbrTTG5Sgvh6NebnuLcqscVdc4E+Ks4ulfb7DZNtqV42z1VcVmc
    rEHwOclCqIsVu6OWxn9Fw8hoG9bhOm01jCMr4sQaWchsNZ8bYBpoZP0n+L7KFlNE
    QnIuAp9N2+mz0fTbZ6MvQCf15GLVPeIg4XSGnMoLw9fN9xWzpPXTQB1DfwP8b5Fa
    M4SOfiMnXFm1fCGB1iIfLfZrouRmwFDWfb8pxMNlJbKeheA1zPx7Zp6OSXXc0R5Z
    y53gomHQjSNPsjIMfbwR13Sl2zmXARuCYujOIurA==
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
X-CM-Envelope: MS4wfIXu2VcOsoO5ws9vnKno+LKvQgLkx0t7V86rVK4F2w2VR3GTTTY7pl6zvru7/DJe2E4Cr2fGKOJm2Sf0RpRRSXOHjhZyCmPxixCeKbkqqkm+C66yGbVD
    0g88+sX7td4KysS1chU4ZBa7e03zrs1hEIf1oTFxLHf+znTTB8cVXU3cd7A3fIQDjN2+yIf+yuRwSeednMaBTFJdq9IrluTzCI2nIDSoJyPTIFztHbuT1hWo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=_tSFY5Edfl19zN2ddYsA:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=D0XLA9XvdZm18NrgonBM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756757AbeDKUhj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:37:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756070AbeDKSs0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 113/190] drm/omap: fix tiled buffer stride calculations
Date: Wed, 11 Apr 2018 20:35:59 +0200
Message-Id: <20180411183557.670795715@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ti.com>


[ Upstream commit cc8dd7661ccc2d8dc88921da8e6cc7c2fcdb0341 ]

omap_gem uses page alignment for buffer stride. The related calculations
are a bit off, though, as byte stride of 4096 gets aligned to 8192,
instead of 4096.

This patch changes the code to use DIV_ROUND_UP(), which fixes those
calculations and makes them more readable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -158,7 +158,7 @@ static void evict_entry(struct drm_gem_o
 	size_t size = PAGE_SIZE * n;
 	loff_t off = mmap_offset(obj) +
 			(entry->obj_pgoff << PAGE_SHIFT);
-	const int m = 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m = DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
 
 	if (m > 1) {
 		int i;
@@ -415,7 +415,7 @@ static int fault_2d(struct drm_gem_objec
 	 * into account in some of the math, so figure out virtual stride
 	 * in pages
 	 */
-	const int m = 1 + ((omap_obj->width << fmt) / PAGE_SIZE);
+	const int m = DIV_ROUND_UP(omap_obj->width << fmt, PAGE_SIZE);
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
 	pgoff = ((unsigned long)vmf->virtual_address -
