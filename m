Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E37217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g24Jm02l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbeLSRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:38:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52539 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbeLSRiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:38:00 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so10894147itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdqeJGh8eBs0Vxjdpc2lfQPUvzKGZN7048QD4f17sLA=;
        b=g24Jm02lTHisRulhMjdKrS2YpsweRYzgegnBG/62cvxcmiLNgIurArCftA5qWknRcr
         hoR88vnD4Exj2GKoEpY2VDrVeILyJ25fgFPGWiZggVZIFb9xM5geAPqzvRgGZtU3ABYH
         zSCKeesB9RTNLerkW83FhRA4AMaXqrotM7GKRx4p656dQa5Fwe8kew2r1IGLVWQJSLHU
         oLOgi0FK0FjsKNMd0R9LNqW++j8RloOlYkJeYXgNqwZ13Bue0/la6q8aJhjVqfPl/3aA
         ICZADCbALxPUGO6iclE+ADAmEVX5Vg7Yx57dbS1LIZPjPBPO7FsEl06kH79YYVp1hLyc
         ihvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdqeJGh8eBs0Vxjdpc2lfQPUvzKGZN7048QD4f17sLA=;
        b=qrD2egL2zGfht7/Eh8vqk68i5MfRs6quOmsDr3MnxrbnPsYnxprO+ctUdY0B7yoU/s
         nqjM7wXpqOeu7NZGBHCRs48BWlJiU8xSau1D4sG+MvCJycJuLBLjbM4xbsOuXslDnlXV
         spBsXJiqpo3ej2L60pPLZmlsDA2M76FD8fYgOuRvyYYqwV7XpTomfWhTYmr0DcXkZnGg
         vaWM2nIPPWcFkl4jvZSQWpEe4SwgKmufIQzsTqY9hZLFlY9xieK+XRTFHlVw3x18awyT
         3zw9F01TmbrXXax69RAtkLAdICeAuMPI/QL1p9GX2oSpr33EVHm3NgruihBkyFbiIDba
         P4mw==
X-Gm-Message-State: AA+aEWaUu0WwANGJZGhqG80L0EVImARj7AazNXcqNqHLpwpIHFDR1DzS
        F9wKUs15nTyiT0tZUACNXvM=
X-Google-Smtp-Source: AFSGD/X/at+ZP0D1i56JW5Q0CfBhmDQagfdlxtZeCCXMZ2r09a82BkphuHqGE17Jaii2XvlGm4rCgQ==
X-Received: by 2002:a24:25ce:: with SMTP id g197mr7454854itg.61.1545241080179;
        Wed, 19 Dec 2018 09:38:00 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:bd3e])
        by smtp.gmail.com with ESMTPSA id a10sm3637728itc.3.2018.12.19.09.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:37:59 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/3] mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
Date:   Wed, 19 Dec 2018 09:37:49 -0800
Message-Id: <20181219173751.28056-2-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219173751.28056-1-guro@fb.com>
References: <20181219173751.28056-1-guro@fb.com>
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

On my test setup, I've got up to 12% speed up on vfree()'ing 1000000
of 4-pages vmalloc blocks.

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 mm/vmalloc.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 871e41c55e23..7660e3ef4133 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1462,6 +1462,24 @@ struct vm_struct *find_vm_area(const void *addr)
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
  *	remove_vm_area  -  find and remove a continuous kernel virtual area
  *	@addr:		base address
@@ -1472,31 +1490,20 @@ struct vm_struct *find_vm_area(const void *addr)
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
@@ -1505,17 +1512,18 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vmap_area((unsigned long)addr)->vm;
-	if (unlikely(!area)) {
+	va = find_vmap_area((unsigned long)addr);
+	if (unlikely(!va || !va->vm)) {
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
 
@@ -1530,7 +1538,6 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	}
 
 	kfree(area);
-	return;
 }
 
 static inline void __vfree_deferred(const void *addr)
-- 
2.19.2

