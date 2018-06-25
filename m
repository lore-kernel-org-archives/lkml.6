Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8257C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FD326293
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K60YuCwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FD326293
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755769AbeFYXHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:07:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46428 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeFYXHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:07:15 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so7519925pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Y314oyiiNmyPZcaXu7Y9D2B9E/QFhwvNSMq6xgiZiY=;
        b=K60YuCwU/i11Ov3zZBeP8KbVIGoBLTcB5GVbzuN0OFQFme3CvW46fFShogp9nxybid
         6Y6F99FOv5zGYeOn17jA/iVSRLfzE8742Qe5OmnncR0l7vnalXoKyZJ6j1SiIW6yklHi
         G/j2lh5T//8kqzYANwaiCmCNEBp05RnQZa+gO139YBHMUwvJ4mEn57w/kpEw29jRxnE8
         tKjE5Rx+kG8oam8ygnEk3fR4p1Kt173YVxPzxCJOOzR4Bh62vBta70YX6nPuHtgKq6bS
         asaQYoGDK3l8xr1Zcefq5/F7Jer+rFeNE+yB53W8s+bjXisY646Wl1G95/lh7buNDWut
         h8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Y314oyiiNmyPZcaXu7Y9D2B9E/QFhwvNSMq6xgiZiY=;
        b=Ug8OpHBDR5KLs/L71KBt3tRoIHzlYsvPocZVPp16TWmJ7VUPsAgoyw5CnaB9PhyhFw
         qX3O3H4bzmVVQghTQO1qeRFl6p/hqCiQ3+5PeuuS/95XhtomLouqCzNUk67NumhqXec9
         EBjYnC/b/kxdKhrcm8tpMiVlzwn9+neSdouxl9JwzeEygpuogpjMZ7VzFJXgk06nQXmB
         8/GYTlKYElUSkZj59qvHxZN8mMR+adhISiD5ygbNrBOMYl3ZWvxz5h6s8h3XAfEm4fkK
         d5aOmZgzTLfOJE8lE6Vih1pVBuOExdEPBtyhrPLOZOCqHFb10POl4MX4Q71f+U4H/R1g
         6/Tw==
X-Gm-Message-State: APt69E19PLBcjIAqtbSY//f5FkKxk/nOkFrCYi229g9kcjmz24oYB9nX
        cGZHtk2uHMHtNOUJ6j5rFXgx7g==
X-Google-Smtp-Source: ADUXVKJ6x5RBWdPrEHu3E3oG025Jr4l9kM9NYOnGR92zF+w+CImnxWs2ng3qXMm3b+bhRWznvJ2phA==
X-Received: by 2002:a17:902:6e09:: with SMTP id u9-v6mr472346plk.13.1529968034074;
        Mon, 25 Jun 2018 16:07:14 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id p73-v6sm116657pfa.142.2018.06.25.16.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 16:07:11 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH 2/2] fs, mm: account buffer_head to kmemcg
Date:   Mon, 25 Jun 2018 16:06:59 -0700
Message-Id: <20180625230659.139822-3-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180625230659.139822-1-shakeelb@google.com>
References: <20180625230659.139822-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer_head can consume a significant amount of system memory and
is directly related to the amount of page cache. In our production
environment we have observed that a lot of machines are spending a
significant amount of memory as buffer_head and can not be left as
system memory overhead.

Charging buffer_head is not as simple as adding __GFP_ACCOUNT to the
allocation. The buffer_heads can be allocated in a memcg different from
the memcg of the page for which buffer_heads are being allocated. One
concrete example is memory reclaim. The reclaim can trigger I/O of pages
of any memcg on the system. So, the right way to charge buffer_head is
to extract the memcg from the page for which buffer_heads are being
allocated and then use targeted memcg charging API.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v1:
- simple code cleanups

 fs/buffer.c                | 15 ++++++++++++++-
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 22 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8194e3049fc5..47682cc935fb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -45,6 +45,7 @@
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
 #include <linux/pagevec.h>
+#include <linux/sched/mm.h>
 #include <trace/events/block.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
@@ -815,10 +816,17 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS;
 	long offset;
+	struct mem_cgroup *old_memcg = NULL, *memcg;
 
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
+	memcg = get_mem_cgroup_from_page(page);
+	if (memcg) {
+		gfp |= __GFP_ACCOUNT;
+		old_memcg = memalloc_use_memcg(memcg);
+	}
+
 	head = NULL;
 	offset = PAGE_SIZE;
 	while ((offset -= size) >= 0) {
@@ -835,6 +843,11 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		/* Link the buffer to its page */
 		set_bh_page(bh, page, offset);
 	}
+out:
+	if (memcg) {
+		memalloc_unuse_memcg(old_memcg);
+		mem_cgroup_put(memcg);
+	}
 	return head;
 /*
  * In case anything failed, we just free everything we got.
@@ -848,7 +861,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		} while (head);
 	}
 
-	return NULL;
+	goto out;
 }
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c857be8a9b7..d53609978eb7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -380,6 +380,8 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
+struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -864,6 +866,11 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6b1a8f8e0a82..13d30b37935f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -713,6 +713,28 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
+/**
+ * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
+ * @page: page from which memcg should be extracted.
+ *
+ * Obtain a reference on page->memcg and returns it if successful. Otherwise
+ * NULL is returned.
+ */
+struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	struct mem_cgroup *memcg = page->mem_cgroup;
+
+	if (mem_cgroup_disabled() || !memcg)
+		return NULL;
+
+	rcu_read_lock();
+	if (!css_tryget_online(&memcg->css))
+		memcg = NULL;
+	rcu_read_unlock();
+	return memcg;
+}
+EXPORT_SYMBOL(get_mem_cgroup_from_page);
+
 /**
  * First try to obtain reference on current->active_memcg. On failure, try to
  * obtain reference on current->mm->memcg. On further failure root_mem_cgroup
-- 
2.18.0.rc2.346.g013aa6912e-goog

