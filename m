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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD561217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRmVSVsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbeLSRiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:38:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56256 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbeLSRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:38:04 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so10873494ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 09:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGPRSNth6iPSKAi8vQAaivAUkebwaHgP+2JHZws28fk=;
        b=iRmVSVsZ98WGq8EZk8v0Fdo8TcqRgGxUJNzUDcty4cMZYeXYDlJggpQ+epKYxN8JTM
         N6GL6Q5tDXErdfIc/e2Ss9gtNZj6hhsLaFadATQW/lDl6ezqbfWHgM8OeduCGdC4JeGP
         69GrF46gXzATbCcLe25dafJYtf9YncdZyOjHNihxmOOFPGd6u1TF5PKJtlXdiJr4PbkX
         /uRD9mzlYsGWjq0UQBFLk5nG6XIdZyiddf2Nnhgc/nz8P/3ULpKnP0VJDmSw19Ia9Uo9
         ytim2irbZMj/EllkJjKfcMY8ghVKK7w0/Ehc4d0i8vPhC+yAvhuJaLxT9Nt9t6XGxE7E
         lFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGPRSNth6iPSKAi8vQAaivAUkebwaHgP+2JHZws28fk=;
        b=HIlzkI/ni7r3nmw0foY/inbr6hkDpJKzCjakqfWxLvAmyCnPMxq9yIGKVTkd9zvZJp
         16cgWaIQm6QnNHd+g40yQs6e2qXCucEJw3hSgDwmU5vCs2Xlgl6OZkpbRbVqHE5yJQEV
         jlNy/e/papkI56yg6QbnXs5RhU8gbqOavGtd8UmNUkLsNl1GzOf/sWsxjx6Gbul/NBx+
         EopZIhZc3BoRkqhKVckUJk930Ox3mlsZIbpIPWx2377jVSOoWn/Cruy+J0AhM7tPVdaN
         U+1bpiuhZ3OtcNVHMJkTmdVt9NDKyLHeVXf2MQNmZt3rrSWZCKO2ts55TWZ1qLHTkwr4
         OHUQ==
X-Gm-Message-State: AA+aEWYIBLE6MKdNpieg5x/lQLcDVAEHz1ircWW4VvDIyXVsnncrQQit
        F7Wf6s+kfXIn3BlTU4xEFlo=
X-Google-Smtp-Source: AFSGD/Xf0h3jJ4k6s2Zr4NE7SG4Cgf9kLMhBR2J1eZ9j0yX9+WW1xwz1u3Q876n+7BNHKLI+629CHQ==
X-Received: by 2002:a02:89a4:: with SMTP id p33mr20680316jaj.0.1545241083388;
        Wed, 19 Dec 2018 09:38:03 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::7:bd3e])
        by smtp.gmail.com with ESMTPSA id a10sm3637728itc.3.2018.12.19.09.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 09:38:02 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: [PATCH 3/3] mm: show number of vmalloc pages in /proc/meminfo
Date:   Wed, 19 Dec 2018 09:37:51 -0800
Message-Id: <20181219173751.28056-4-guro@fb.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219173751.28056-1-guro@fb.com>
References: <20181219173751.28056-1-guro@fb.com>
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
 include/linux/vmalloc.h |  2 ++
 mm/vmalloc.c            | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index 398e9c95cd61..0b497408272b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -63,10 +63,12 @@ extern void vm_unmap_aliases(void);
 
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
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 042175d7d95f..efca916940e9 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -340,6 +340,13 @@ static unsigned long cached_align;
 
 static unsigned long vmap_area_pcpu_hole;
 
+static atomic_long_t nr_vmalloc_pages;
+
+unsigned long vmalloc_nr_pages(void)
+{
+	return atomic_long_read(&nr_vmalloc_pages);
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr)
 {
 	struct rb_node *n = vmap_area_root.rb_node;
@@ -1549,6 +1556,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			BUG_ON(!page);
 			__free_pages(page, 0);
 		}
+		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
 
 		kvfree(area->pages);
 	}
@@ -1717,12 +1725,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
 
 	if (map_vm_area(area, prot, pages))
 		goto fail;
-- 
2.19.2

