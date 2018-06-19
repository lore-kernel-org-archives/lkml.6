Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A371BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RO8enGtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584B620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937364AbeFSFNz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:13:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33850 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937346AbeFSFNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:13:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so8600393pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xw+SjgYvIwITvP/432MUmWBrfLlGMOh9oKDuJ2FIurQ=;
        b=RO8enGtIamWi5l9P1KAPe90ParEH71qWpJjU/zOTnjbiEbEozJ56Lv0W3qFAPyK2uN
         M6UGpxDr+JrPp2uVjkoSlcmRfLBzozs9na2pP//S4dzNRDn2EGW3bLWM6r+7IrWjJDEr
         QXgevl/IbhFJBMiBL8v7A2mUCSDKd1Q8HxzZmQfenC9ZKOzw10OGdFCo7Sz1fdM3ZcKo
         TQoXea0zr6GxhquC9QSBPRodB+g/dPtLojCrW9sDJPKWQEwIXMGvoq5hMAIV6c4PUywe
         4MwGMyt4Yu12SZtJ+J73TommRFBMN01PvlfiK8ZC3uZQWmFXYd2IVbBfU5DRBsOxtxLN
         tEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xw+SjgYvIwITvP/432MUmWBrfLlGMOh9oKDuJ2FIurQ=;
        b=h84d3QyD+mp1PL8oSGsjHwvJVjTw5TPxaTsC28n8gP9k1RtD6lMBqiE8kAbi9GyM5o
         wSDtGMGhV8QJ5XvT9hBpMDrXQj63YyXt69e2YIGk1vdjWF3mLlTZL1kIGrnUGSOEJBlk
         3scfPO+fFBay711xHspXBjluC/tR+73dqxFeRO+2XPcVWnQLuO/R1O0vziDNioBN7XiL
         93nCIN4ub1yZdpwNPx0VhuTcPQYT9TGvCzwkijmNuI3NkwwGHfWgNU5N7E2r+26L3aPd
         RcZQh6drqu6n6Z6FiatAsAe4zIRcr49xalu4AVSFj0JKboee3pnyTN9FM5+J2k03RGX5
         p2xA==
X-Gm-Message-State: APt69E2LmVEaiJQSTytxRxFmfEyn3VH99do/88gDdmO20rlaKSl61/wc
        q1BAku9MQ/9ytHqZEQl5XSOKBA==
X-Google-Smtp-Source: ADUXVKLngP++HS5H86cz4AtIu7lSldmnPBWkdUz5xyPrlsUJgAcLTgiBftq+QBz/HaMn95+kFGOcfg==
X-Received: by 2002:a62:701:: with SMTP id b1-v6mr16574381pfd.252.1529385228852;
        Mon, 18 Jun 2018 22:13:48 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id a23-v6sm28390504pfj.117.2018.06.18.22.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 22:13:46 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/3] fs, mm: account buffer_head to kmemcg
Date:   Mon, 18 Jun 2018 22:13:27 -0700
Message-Id: <20180619051327.149716-4-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180619051327.149716-1-shakeelb@google.com>
References: <20180619051327.149716-1-shakeelb@google.com>
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
Cc: Jan Kara <jack@suse.cz>
Cc: Greg Thelen <gthelen@google.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/buffer.c                | 14 +++++++++++++-
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8194e3049fc5..26389b7a3cab 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -815,10 +815,17 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	struct buffer_head *bh, *head;
 	gfp_t gfp = GFP_NOFS;
 	long offset;
+	struct mem_cgroup *old_memcg;
+	struct mem_cgroup *memcg = get_mem_cgroup_from_page(page);
 
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
+	if (memcg) {
+		gfp |= __GFP_ACCOUNT;
+		old_memcg = memalloc_memcg_save(memcg);
+	}
+
 	head = NULL;
 	offset = PAGE_SIZE;
 	while ((offset -= size) >= 0) {
@@ -835,6 +842,11 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		/* Link the buffer to its page */
 		set_bh_page(bh, page, offset);
 	}
+out:
+	if (memcg) {
+		memalloc_memcg_restore(old_memcg);
+#ifdef CONFIG_MEMCG
+		css_put(&memcg->css);
+#endif
+	}
 	return head;
 /*
  * In case anything failed, we just free everything we got.
@@ -848,7 +860,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
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
index c481e661e051..f9a9a79117b9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -712,6 +712,27 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	return memcg;
 }
 
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
+
 static __always_inline struct mem_cgroup *get_mem_cgroup(
 				struct mem_cgroup *memcg, struct mm_struct *mm)
 {
-- 
2.18.0.rc1.244.gcf134e6275-goog

