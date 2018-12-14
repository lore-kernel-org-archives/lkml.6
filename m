Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18933C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C74206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhNOnZvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbeLNSHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:07:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38988 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeLNSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:07:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so3195540pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HiZSQwm/UReDKaG3pBCGsAVn/dcBqgos7ZO2ZPxoNo=;
        b=mhNOnZvHpkLtR1ci0159pT81uVhecrQoFQMn8Ux9pYNAemWwJHJFw0JPigeXGzdcO7
         mZ93GIpSqrUBjr9dPGEn6IPmNaJKmZyeN5KDV25eWf4/hFXTCr4HBcZ/nzi5QUWm3MBq
         UbKPBPSOeX0m94pozmrw0JBrBuOT8+9EOzpHhHz4fB14muAc4Wm4/pZJvQQHAfvmcSiL
         aeuiMjExueGK9mdKUdJ0NnvupOIMNWS4XfQxvN8g2/J7Nd8N0eXuAioxmxtmLeHX91iE
         x3WZdAbV/6tJuFiKad+nlQpFgmSEJfarJ5GmDN1MWeRID70MBA5V+rk9orPNCi0fAsoh
         /CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HiZSQwm/UReDKaG3pBCGsAVn/dcBqgos7ZO2ZPxoNo=;
        b=Q9qljKtMLN2SobjU3+DUavUvssZAgEW5xIJprtnChgGm9VXXEDEhHm0XWx+T5wgqzb
         6g/dAjgzmeM2sCsvHWJe1rEl9JoC1L7syoEa2JxpxJ43cSqZNpFqJ5gLQwmJeY+C8nHu
         ma80JumU/4VOgK2vO5foRwbuA10ejqjR5mL/yT4Z7iAwTOeIOSdgM9kXdSk8lFwB7+eX
         ptVEQx091T66h8qXKSeeQm30K0uJbLwtfD3qO+0oYwr5OqqLHXG19Js73z/nuduM9b0c
         QjH4J1Ax/aM39oIc4lt4GGYfO11S3ZhyfetvsEKrj2sqgiZDffDIn6LRkZtxdnFcoXF5
         RW+Q==
X-Gm-Message-State: AA+aEWaicUM1kyX5Kv1nT2CjrLPOtmct/aTCJKXblj0NGcjXO5YSDmGS
        kyRiePnNwZfFOCi0F6JkO7c=
X-Google-Smtp-Source: AFSGD/Xf9mAIsXiLzGt9UCYFSH7fUUAPt1KYigA25sn8KiXN4CJ9IyX/x0DdDXq9vjaRcAeCTkz+1g==
X-Received: by 2002:a63:40c6:: with SMTP id n189mr3479960pga.355.1544810868651;
        Fri, 14 Dec 2018 10:07:48 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:3d97])
        by smtp.gmail.com with ESMTPSA id r2sm7180856pgo.18.2018.12.14.10.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:07:48 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [RFC 1/4] mm: refactor __vunmap() to avoid duplicated call to find_vm_area()
Date:   Fri, 14 Dec 2018 10:07:17 -0800
Message-Id: <20181214180720.32040-2-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214180720.32040-1-guro@fb.com>
References: <20181214180720.32040-1-guro@fb.com>
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
---
 mm/vmalloc.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 97d4b25d0373..24a84d584609 100644
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

