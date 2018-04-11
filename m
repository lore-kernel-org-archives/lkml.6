Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481401-2-13347712260437825668
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
    1523481401; b=G5Ga7orVLJdXh1B7I3spH/NUHYm7Xhj/ue85NkcgCOruXyR/hd
    aO1evVxLWPy5EjaeoMbL7P3yzAACFpMygn8yLx/7fge0f7xOMwKopmNm+M0mU7d6
    qkxHteJpJaS1CXSdy/hqc7bD9EhX1/UudeEP5B0fq3ol0aMMGi5hfYjHCBMNXR+9
    8NCcQeV2pF3r6LBLrESjfWhErLye4Wr5GCpTL5PB7doPkwY8Z1AnaLFUDQum/JCO
    GB599D9GJskb8HUaLUoDsGJoWeiFyjxV43iWPCgwllkPqzaz9VX8eQ63jxxjRECp
    jDJuzT0MXPBVJMhYP0HVjh4I9E9kzr6i6dCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481401; bh=nNmJjE+wgFcOrdvZO/pgJDsJXPtXqA
    MdOb+OVgYiDmY=; b=jYKtwFqS5ZQfYcV/m1gDZLzs3fnxbnlCqdzg43pcZs+704
    2WZwP7APoDbL3/IbVamVNP+btS0y/vjpHt/ahkQjcAVfYqWk8UwPq0FDG2foFq1h
    SXVI3/il4qr5R5+9CH6zxOh6nypMIaBkwWS//xARQINVqzkBglk97YrZ8y52dqfT
    9dFbXsiDCZ95TMIHTxfg0pxY9GGLJ5u/5NEGQ54Ilqs/JTN74/cuYE4i97S9Az8N
    zt2sfb/0zK0Ysl2fkxrqLp+isHh1quCB4FcRYmGYxRJyq0KABbjGVKgwouoURF+x
    MqN9/H1OavXIF8CozxK7tTgZ+ZcVsfa99eQuNvUQ==
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
X-CM-Envelope: MS4wfHVK0nNPd72Hh2SyPwmkukgH/nClVuDAHu+Ct5jBXotwIQp38FpHEHanaGL80n2RTQN54wMiCfL9RI6we8dBYA4RUSM6duj8HbsNew/ryJnlmGh8EBVJ
    L/UYnzhwRHUacF4QhXkbFpENsUgsk3hpCFJvOCzFrPov2R5UbBoSGLEj3JEFZGNQYfzDg5oMh2yXxHTY0X3pO7OZ5w+GY5H+5GIY8Nr+Ds9PqPo/Pe8jtwlj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=_tSFY5Edfl19zN2ddYsA:9 a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=D0XLA9XvdZm18NrgonBM:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbeDKSke (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeDKSkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 064/121] drm/omap: fix tiled buffer stride calculations
Date: Wed, 11 Apr 2018 20:36:07 +0200
Message-Id: <20180411183500.119870435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
