Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D460AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A712520869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCGXaJM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730504AbfBLR5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:57:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44784 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729855AbfBLR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:57:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so1642056plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93OAZAKUmkpYvDgCLiiRT27o1RpTSM6guTV/d2KLbuo=;
        b=QCGXaJM2hZZokK7yOMpTLoWcdJNyPFmRc21nwx+XYJj7UgFF+4IibYRea/KVv3ZX8c
         8JX53r9R78lt/ndj5qADE9ryXZzv0gfWL9C0CDRozNeMTN3mo6D/V5Vk3KXHmiLYZJHS
         +kPGtC/3cmiCB718Tj0itOFo4U6RwAnZtulKgLIXt7eYnd17h2kjyeQ/fHvu2qSPqG9M
         +hRIsHipg4Cjpd1Wju20iuBLziYb4UH/o9hmAf/hxuy+llEbnOB1v4dwk8gm5FvWROL2
         aUmqZWfujJ7MKlJpZbi2RA8r8VlJtiSfkJFER/AA0m/HBT/8iEyWkygcjFbRLGwFmGI4
         IVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93OAZAKUmkpYvDgCLiiRT27o1RpTSM6guTV/d2KLbuo=;
        b=sQCd9X5uHgiAIgI0ff5TzIHgaOkmetmimTnEOOWAbzF7BkJGYNvw2fqSRG4HiGP+cP
         c/wf+46jGnXjQcNOIWO6Yv/YcOYgdNwgicPPZwysfTL5OU8SoC5+uIGD259B2/uKFcpI
         pocyXb05QY+rqywDl/UXVSxMXVb7AaS/21TQZqM9FD9q7OwM8WKc38qcVSDQUWESaRoF
         Xp+oRf55S88WusTcItLFrEjk6YNSsFQokdUUhXm1bLNj9Np0mGogL5PMzvIT7nVORL5K
         hB8mx5s4Z2cM+liSLMoqf4PlsqJBHzztXjfSRbAsyIRcL7870TvO/GR2Woo1qVcuBi7u
         HxzA==
X-Gm-Message-State: AHQUAubaMmY09QC9z9GzthGlWB9GltHzNLymSdecDu/QjsZoi6vJBk7d
        CDnKOeuLa73cfjtL5NlNOE8=
X-Google-Smtp-Source: AHgI3IbR1QARiQM372qVa41Na+Ijx46rJgy765Pia3Oe3eVsWoU2m3AYeLeFpsuP9V7WXRuErsrY7Q==
X-Received: by 2002:a17:902:243:: with SMTP id 61mr4968727plc.249.1549994236475;
        Tue, 12 Feb 2019 09:57:16 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id z186sm18608427pfz.119.2019.02.12.09.57.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:57:15 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 1/3] mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
Date:   Tue, 12 Feb 2019 09:56:46 -0800
Message-Id: <20190212175648.28738-2-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212175648.28738-1-guro@fb.com>
References: <20190212175648.28738-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vunmap() calls find_vm_area() twice without an obvious reason:
first directly to get the area pointer, second indirectly by calling
remove_vm_area(), which is again searching for the area.

To remove this redundancy, let's split remove_vm_area() into
__remove_vm_area(struct vmap_area *), which performs the actual area
removal, and remove_vm_area(const void *addr) wrapper, which can
be used everywhere, where it has been used before.

On my test setup, I've got 5-10% speed up on vfree()'ing 1000000
of 4-pages vmalloc blocks.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b7455d4c8c12..8f0179895fb5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1477,6 +1477,24 @@ struct vm_struct *find_vm_area(const void *addr)
 	return NULL;
 }
 
+static struct vm_struct *__remove_vm_area(struct vmap_area *va)
+{
+	struct vm_struct *vm = va->vm;
+
+	might_sleep();
+
+	spin_lock(&vmap_area_lock);
+	va->vm = NULL;
+	va->flags &= ~VM_VM_AREA;
+	va->flags |= VM_LAZY_FREE;
+	spin_unlock(&vmap_area_lock);
+
+	kasan_free_shadow(vm);
+	free_unmap_vmap_area(va);
+
+	return vm;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -1489,31 +1507,20 @@ struct vm_struct *find_vm_area(const void *addr)
  */
 struct vm_struct *remove_vm_area(const void *addr)
 {
+	struct vm_struct *vm = NULL;
 	struct vmap_area *va;
 
-	might_sleep();
-
 	va = find_vmap_area((unsigned long)addr);
-	if (va && va->flags & VM_VM_AREA) {
-		struct vm_struct *vm = va->vm;
-
-		spin_lock(&vmap_area_lock);
-		va->vm = NULL;
-		va->flags &= ~VM_VM_AREA;
-		va->flags |= VM_LAZY_FREE;
-		spin_unlock(&vmap_area_lock);
-
-		kasan_free_shadow(vm);
-		free_unmap_vmap_area(va);
+	if (va && va->flags & VM_VM_AREA)
+		vm = __remove_vm_area(va);
 
-		return vm;
-	}
-	return NULL;
+	return vm;
 }
 
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct vmap_area *va;
 
 	if (!addr)
 		return;
@@ -1522,17 +1529,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vm_area(addr);
-	if (unlikely(!area)) {
+	va = find_vmap_area((unsigned long)addr);
+	if (unlikely(!va || !(va->flags & VM_VM_AREA))) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
 		return;
 	}
 
+	area = va->vm;
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	remove_vm_area(addr);
+	__remove_vm_area(va);
 	if (deallocate_pages) {
 		int i;
 
@@ -1547,7 +1555,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	}
 
 	kfree(area);
-	return;
 }
 
 static inline void __vfree_deferred(const void *addr)
-- 
2.20.1

