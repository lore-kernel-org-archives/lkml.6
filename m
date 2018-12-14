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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A888206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ravbIwCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeLNSIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:08:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41698 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbeLNSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:07:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3185864pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31kslWA2pzzsHiz8Y5tC9Fd+SHDoREs2MeMPfRmzSCw=;
        b=ravbIwCCdmKf4HxtAd0LBlD5fBNIcfvIVHABcxIopOo4LAyjDT/1svBMs2w8eK1Nd0
         SXJ2E39boVT6Ne+SuVpPWKiXXPYLmLdmgw5V2NUswhpHJ6rpxBbvCYs+c2PcvPDSQEoi
         NxQoGkpL7V4rdegdU3INlnD9GYPv09+WsJ3M6KzNlV0IPBZZUbJFyAHxDJzVg+v1TVxo
         vt3p/0jsTIvDih+ftuiWNI8to8QkMJtNjycUcSNJwi0ojQ3qGIO13wzGOLR2qx3G4Yzb
         6rcv6ciVXvHiZ4b7tj7iwvQH/+x9OfWuKTHSPWGbz4FJBzJ20kGhlhkjOWfmK+fJFXkx
         3w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31kslWA2pzzsHiz8Y5tC9Fd+SHDoREs2MeMPfRmzSCw=;
        b=M4yH7izwtu/iU2VFpTiGJ37IGiLkv/D6+tI5s/9sqltv6E6toD9tOUNFX34le/PZkw
         RyZ/7g/IRQ6LfAB4OBLiTUh8C6k9keC7H3sGp1v5fMJORSi029d5ijtocSWY95OgPAk2
         iekgz9E6zUpHvhpmgEkde8WVmFihZmzh3sL/WQXIgUGxoNjI8cNCmlu9WGewwmdWF6kD
         Bc5nmYtAEDFKTQGnVCOHHmPsnD6N7oeuLy0ZCmKwNfMg3bokCPhOyJOvKWc9QbHh3kTS
         EEXr95t2KwxBVB8B0gqbu3C+UB5V30wKI8yquFeVMbcH8qC3y4Ka7bdOgvMQhNID9cBB
         a0vw==
X-Gm-Message-State: AA+aEWZo493vNmvQMiCYgzlriVBXyd1+TfllIIq+pk7ksdf1irecYvMs
        t6kHLhK9FmuVgi+NUdygAQ4=
X-Google-Smtp-Source: AFSGD/WptKbrEs3BxathmN/kR19WDH39xE5sXtHrpcKCELKN5T/tzPlLlpfYs4rFDstZclsGpMduKw==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr3686922pgs.166.1544810869674;
        Fri, 14 Dec 2018 10:07:49 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:3d97])
        by smtp.gmail.com with ESMTPSA id r2sm7180856pgo.18.2018.12.14.10.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:07:49 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [RFC 2/4] mm: separate memory allocation and actual work in alloc_vmap_area()
Date:   Fri, 14 Dec 2018 10:07:18 -0800
Message-Id: <20181214180720.32040-3-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214180720.32040-1-guro@fb.com>
References: <20181214180720.32040-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_vmap_area() is allocating memory for the vmap_area, and
performing the actual lookup of the vm area and vmap_area
initialization.

This prevents us from using a pre-allocated memory for the map_area
structure, which can be used in some cases to minimize the number
of required memory allocations.

Let's keep the memory allocation part in alloc_vmap_area() and
separate everything else into init_vmap_area().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmalloc.c | 52 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 24a84d584609..24c8ab28254d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -395,16 +395,11 @@ static void purge_vmap_area_lazy(void);
 
 static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 
-/*
- * Allocate a region of KVA of the specified size and alignment, within the
- * vstart and vend.
- */
-static struct vmap_area *alloc_vmap_area(unsigned long size,
-				unsigned long align,
-				unsigned long vstart, unsigned long vend,
-				int node, gfp_t gfp_mask)
+static int init_vmap_area(struct vmap_area *va, unsigned long size,
+			  unsigned long align, unsigned long vstart,
+			  unsigned long vend, int node, gfp_t gfp_mask)
 {
-	struct vmap_area *va;
+
 	struct rb_node *n;
 	unsigned long addr;
 	int purged = 0;
@@ -416,11 +411,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 	might_sleep();
 
-	va = kmalloc_node(sizeof(struct vmap_area),
-			gfp_mask & GFP_RECLAIM_MASK, node);
-	if (unlikely(!va))
-		return ERR_PTR(-ENOMEM);
-
 	/*
 	 * Only scan the relevant parts containing pointers to other objects
 	 * to avoid false negatives.
@@ -512,7 +502,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	return va;
+	return 0;
 
 overflow:
 	spin_unlock(&vmap_area_lock);
@@ -534,10 +524,38 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
 		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
 			size);
-	kfree(va);
-	return ERR_PTR(-EBUSY);
+
+	return -EBUSY;
+}
+
+/*
+ * Allocate a region of KVA of the specified size and alignment, within the
+ * vstart and vend.
+ */
+static struct vmap_area *alloc_vmap_area(unsigned long size,
+					 unsigned long align,
+					 unsigned long vstart,
+					 unsigned long vend,
+					 int node, gfp_t gfp_mask)
+{
+	struct vmap_area *va;
+	int ret;
+
+	va = kmalloc_node(sizeof(struct vmap_area),
+			gfp_mask & GFP_RECLAIM_MASK, node);
+	if (unlikely(!va))
+		return ERR_PTR(-ENOMEM);
+
+	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
+	if (ret) {
+		kfree(va);
+		return ERR_PTR(ret);
+	}
+
+	return va;
 }
 
+
 int register_vmap_purge_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&vmap_notify_list, nb);
-- 
2.19.2

