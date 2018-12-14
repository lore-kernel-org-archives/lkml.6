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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D636CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01796206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi+CVtWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbeLNSH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:07:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45231 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbeLNSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:07:53 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so3018209pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cu/OfW+cnoBt6sWD0vpNz1lk+tLpOk7IYLf+TPCUhnk=;
        b=Pi+CVtWdIbcksx6L8kxgcpi+M3rxFgNK/QeCUI/Lb6gnQuuh1APN+0x7uSAK/HSWTf
         EfgNsasJujMSFkW4NYTvYyJVID6Q3zI5FKXc74vMFifI7IKRZnfCVHw2HhknVy4+4Vnn
         dUF9Xpeqbco6SScK8JjkMvinBvR0sDZi2qYHLe7OWD+XzmTM2Hk45tdVQDniDNNpzA9R
         rW7LMwDL5WIgrmM1qao08ev0nIeO2sBNHos1gqRDYAuUJWYKDwcL5xYlIeX1SDaxXMGb
         zYjfrECVPywTZbkxwRnUZ0Tvbhx7dVPfuofMfTrvtN2n402iStGfD7z8ebpYIAhn/Ek7
         vNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cu/OfW+cnoBt6sWD0vpNz1lk+tLpOk7IYLf+TPCUhnk=;
        b=R1EGsO1dkXQBl91KWSXecNFQKpWtvBeQkRApr/MtHRUx6Sjsk8FCxEZMLxOTTEAVLs
         CCFp38g+Yj6B/E3OGLaAhNNKxpK3SJFuhDQ0jY1ANHp3azbCMJ17xHq6ATrIMu4klcQ7
         fCT6NKgh7bPYbwB5GardA5epGrrEZmt6Bg8YW6FyWdQKigqkmFt0gDC+s4BY/Uxf6wCj
         V6cAZYeofucXw2FAaWwHJaCK9aY/M/Y/ccdXHPxJjHDjvaJgMdUvDWMmFjDXzogETkSx
         WixURj8o3b+Bj/5LBSzVRnKbWEbKpjQWh2vr/dgZ8JZcVW7/brXiWGj4s/l2sIT6X6az
         DYmA==
X-Gm-Message-State: AA+aEWbB3LReHNbElOubjocittj+ntNTdbYv5WYo+BnyEUUpqke2YKxj
        524q+thAvfN9Kb9JqamTihI=
X-Google-Smtp-Source: AFSGD/VD0is3Q+pAGp89nOAYixxBISYVqLojxpQohIub8YkqkUnyrB8BTcraPNhySoe4+M8XsGdobg==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr3782352pfm.253.1544810872100;
        Fri, 14 Dec 2018 10:07:52 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:3d97])
        by smtp.gmail.com with ESMTPSA id r2sm7180856pgo.18.2018.12.14.10.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 10:07:51 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [RFC 4/4] mm: show number of vmalloc pages in /proc/meminfo
Date:   Fri, 14 Dec 2018 10:07:20 -0800
Message-Id: <20181214180720.32040-5-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214180720.32040-1-guro@fb.com>
References: <20181214180720.32040-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vmalloc() is getting more and more used these days (kernel stacks,
bpf and percpu allocator are new top users), and the total %
of memory consumed by vmalloc() can be pretty significant
and changes dynamically.

/proc/meminfo is the best place to display this information:
its top goal is to show top consumers of the memory.

Since the VmallocUsed field in /proc/meminfo is not in use
for quite a long time (it has been defined to 0 by the
commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
/proc/meminfo")), let's reuse it for showing the actual
physical memory consumption of vmalloc().

Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/meminfo.c       |  2 +-
 include/linux/vmalloc.h |  3 +++
 mm/vmalloc.c            | 10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 568d90e17c17..465ea0153b2a 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -120,7 +120,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Committed_AS:   ", committed);
 	seq_printf(m, "VmallocTotal:   %8lu kB\n",
 		   (unsigned long)VMALLOC_TOTAL >> 10);
-	show_val_kb(m, "VmallocUsed:    ", 0ul);
+	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
 	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 1205f7a03b48..ea3a0fb3a60f 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -64,10 +64,12 @@ extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
 extern void __init vmalloc_init(void);
+extern unsigned long vmalloc_nr_pages(void);
 #else
 static inline void vmalloc_init(void)
 {
 }
+static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 #endif
 
 extern void *vmalloc(unsigned long size);
@@ -83,6 +85,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			unsigned long start, unsigned long end, gfp_t gfp_mask,
 			pgprot_t prot, unsigned long vm_flags, int node,
 			const void *caller);
+
 #ifndef CONFIG_MMU
 extern void *__vmalloc_node_flags(unsigned long size, int node, gfp_t flags);
 static inline void *__vmalloc_node_flags_caller(unsigned long size, int node,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index edd76953c23c..39db12fe8931 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -340,6 +340,13 @@ static unsigned long cached_align;
 
 static unsigned long vmap_area_pcpu_hole;
 
+atomic_long_t nr_vmalloc_pages;
+
+unsigned long vmalloc_nr_pages(void)
+{
+	return atomic_long_read(&nr_vmalloc_pages);
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
@@ -1594,6 +1601,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			BUG_ON(!page);
 			__free_pages(page, 0);
 		}
+		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		if (area->flags & VM_EXT_PAGES)
 			kvfree(area->pages);
@@ -1739,12 +1747,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		if (unlikely(!page)) {
 			/* Successfully allocated i pages, free them in __vunmap() */
 			area->nr_pages = i;
+			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 			goto fail;
 		}
 		area->pages[i] = page;
 		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
 			cond_resched();
 	}
+	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
 	if (map_vm_area(area, prot, area->pages))
 		goto fail;
-- 
2.19.2

