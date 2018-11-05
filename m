Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76FC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77EB20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="biN/DYR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77EB20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeKEL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:57:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKEL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DyR2SeRZ94QNAThppqcuJkpiccxwgkqUPSo7YcsAwFE=; b=biN/DYR3LVmRmaiR2LQHAr/lK
        xt8J8BPNz0/VxoLHqr50rVFqkjhgzHbtnOsFugVsaqh5dzQnbaa3ve32a2r7Zt85g7S2ry8XwCakg
        7za+X5IX790PfRIScfQs46qZcBVFeIS3t8dsys7ulcuXZ4v3PYYMyrdNIBm9ZpmDH4N3i01yOeZ6F
        kVhEVFglAUxIRpZRo2+fqaSFFldV5c11usADtIoZOdsqHDLJjLaBv38J+idDLgcZoozMlezFwDIoI
        ZkvDhI4GThoI9xiww3SQAQ4RwIH7uxq67k7on/G6qhxr5pDHYg3W7Uh2vwb2wBGZ2vDMoTL6L8OH8
        9RLPiZpjA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJUoJ-0004Q5-AH; Mon, 05 Nov 2018 02:40:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel/resource.c: fix new kernel-doc warnings
Message-ID: <dda2e4d8-bedd-3167-20fe-8c7d2d35b354@infradead.org>
Date:   Sun, 4 Nov 2018 18:40:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in kernel/resource.c.
The first group of warnings is caused by a "/**" kernel-doc notation
marker but the function comments are not in kernel-doc format.
Also add another error return value here.

../kernel/resource.c:337: warning: Function parameter or member 'start' not described in 'find_next_iomem_res'
../kernel/resource.c:337: warning: Function parameter or member 'end' not described in 'find_next_iomem_res'
../kernel/resource.c:337: warning: Function parameter or member 'flags' not described in 'find_next_iomem_res'
../kernel/resource.c:337: warning: Function parameter or member 'desc' not described in 'find_next_iomem_res'
../kernel/resource.c:337: warning: Function parameter or member 'first_lvl' not described in 'find_next_iomem_res'
../kernel/resource.c:337: warning: Function parameter or member 'res' not described in 'find_next_iomem_res'

Add the missing function parameter documentation for the other warnings:

../kernel/resource.c:409: warning: Function parameter or member 'arg' not described in 'walk_iomem_res_desc'
../kernel/resource.c:409: warning: Function parameter or member 'func' not described in 'walk_iomem_res_desc'

Fixes: b69c2e20f6e4 ("resource: Clean it up a bit")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
---
 kernel/resource.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- lnx-420-rc1.orig/kernel/resource.c
+++ lnx-420-rc1/kernel/resource.c
@@ -318,14 +318,14 @@ int release_resource(struct resource *ol
 
 EXPORT_SYMBOL(release_resource);
 
-/**
+/*
  * Finds the lowest iomem resource that covers part of [start..end].  The
  * caller must specify start, end, flags, and desc (which may be
  * IORES_DESC_NONE).
  *
  * If a resource is found, returns 0 and *res is overwritten with the part
  * of the resource that's within [start..end]; if none is found, returns
- * -1.
+ * -1. Returns -EINVAL for other invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
@@ -390,7 +390,9 @@ static int __walk_iomem_res_desc(resourc
 }
 
 /**
- * Walks through iomem resources and calls func() with matching resource
+ * walk_iomem_res_desc - walk through iomem resources
+ *
+ * Walks through iomem resources and calls @func() with matching resource
  * ranges. This walks through whole tree and not just first level children.
  * All the memory ranges which overlap start,end and also match flags and
  * desc are valid candidates.
@@ -399,6 +401,8 @@ static int __walk_iomem_res_desc(resourc
  * @flags: I/O resource flags
  * @start: start addr
  * @end: end addr
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
  *
  * NOTE: For a new descriptor search, define a new IORES_DESC in
  * <linux/ioport.h> and set it in 'desc' of a target resource entry.


