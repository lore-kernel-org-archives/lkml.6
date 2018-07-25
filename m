Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E70320852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="N+/iL5fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E70320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeGZBOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:14:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33500 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeGZBNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so3964884plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyWywDrz0yNlctIEZKfvqcYdJMHey6G7QhHf0bJ4Juc=;
        b=N+/iL5fejFKJBgL86c7dIvORG0UbpLxXfzFOWXP3pvNMvfaVPbBxgHlYEEmatjRxO1
         ZYrCA2mIfw5RdzrG0/2x3YVOR4i1s1UHv00LhZnUi9F721HAX1LxuXt8dYBkJsTPsTHZ
         +JN56l4lqbeLrh84/Afh5C6UWkVeM1Xguq7P8fAoG+EiN7iTL5IxxGNTBK7LHpEwOuyY
         1cjCJHXKf7TJuxbr2FYjlRyYdDnsP1aunU6wcvZlymHIlJcFP7snq6/v12Ayl6g9Wcvs
         j7YjLhVzOK+I5/jyrA5PgtZPbycR2a9pKnKB+X6A6lFFifJfXKC7TJV1KKwcYLGraZz7
         vWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyWywDrz0yNlctIEZKfvqcYdJMHey6G7QhHf0bJ4Juc=;
        b=VvzgZrZZjVpo3/SUhSQvZVDLg9GJO7NWe+UvtV9T0ow/By2W4R8K9ac6TzDrcPxSuv
         qDiHuNdtgJtVtWkrru1cNsJVDEMcNfU2Y865Y2VJM/TEUBCYtLzq1pP6sjDw71OGoiMk
         elkihLydQSUcU4zMP6Tn5Ht3hskfIUOAbAn6NzVnanZfETbazdRDwrAXugmACksMptdB
         1GgcHKfMXVG7eCpXa2tD5bHNI+2Opvc6CkxrX1usLwwTh8EO6aG3kbBDW9Ct0st+GGaj
         ca3iKjeCgCfm2+VQDNLeyb456qzoF/G05gvzw3QL7dEYg927fJ4KY7wbLNHQYPT8Chf6
         rJZA==
X-Gm-Message-State: AOUpUlHfRURHAbbqbmQKWGBDYX6C2JVsSP0MHqofOqU+Tn74oU/ad29m
        uongjBEMaqdd3QVUqRIG5cNOvtP4T7I=
X-Google-Smtp-Source: AAOMgpdIe/Dzyo7suaCjIk7sSJ1zT4w7ASuNcgmrQ0/ilyLri8disTx0IhCoYtKuTnqRDdVHjmJImQ==
X-Received: by 2002:a17:902:9695:: with SMTP id n21-v6mr23026395plp.6.1532563170918;
        Wed, 25 Jul 2018 16:59:30 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:30 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 3/9] proc/kcore: replace kclist_lock rwlock with rwsem
Date:   Wed, 25 Jul 2018 16:59:14 -0700
Message-Id: <51ba5cba7c43ec5ddce8023054c99943fad02b6d.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now we only need kclist_lock from user context and at fs init time, and
the following changes need to sleep while holding the kclist_lock.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index e83f15a4f66d..ae43a97d511d 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -59,7 +59,7 @@ struct memelfnote
 };
 
 static LIST_HEAD(kclist_head);
-static DEFINE_RWLOCK(kclist_lock);
+static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
 
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
@@ -117,7 +117,7 @@ static void __kcore_update_ram(struct list_head *list)
 	struct kcore_list *tmp, *pos;
 	LIST_HEAD(garbage);
 
-	write_lock(&kclist_lock);
+	down_write(&kclist_lock);
 	if (xchg(&kcore_need_update, 0)) {
 		list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
 			if (pos->type == KCORE_RAM
@@ -128,7 +128,7 @@ static void __kcore_update_ram(struct list_head *list)
 	} else
 		list_splice(list, &garbage);
 	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
-	write_unlock(&kclist_lock);
+	up_write(&kclist_lock);
 
 	free_kclist_ents(&garbage);
 }
@@ -451,11 +451,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	int nphdr;
 	unsigned long start;
 
-	read_lock(&kclist_lock);
+	down_read(&kclist_lock);
 	size = get_kcore_size(&nphdr, &elf_buflen);
 
 	if (buflen == 0 || *fpos >= size) {
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 		return 0;
 	}
 
@@ -472,11 +472,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			tsz = buflen;
 		elf_buf = kzalloc(elf_buflen, GFP_ATOMIC);
 		if (!elf_buf) {
-			read_unlock(&kclist_lock);
+			up_read(&kclist_lock);
 			return -ENOMEM;
 		}
 		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
 			kfree(elf_buf);
 			return -EFAULT;
@@ -491,7 +491,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		if (buflen == 0)
 			return acc;
 	} else
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 
 	/*
 	 * Check to see if our file offset matches with any of
@@ -504,12 +504,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	while (buflen) {
 		struct kcore_list *m;
 
-		read_lock(&kclist_lock);
+		down_read(&kclist_lock);
 		list_for_each_entry(m, &kclist_head, list) {
 			if (start >= m->addr && start < (m->addr+m->size))
 				break;
 		}
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 
 		if (&m->list == &kclist_head) {
 			if (clear_user(buffer, tsz))
-- 
2.18.0

