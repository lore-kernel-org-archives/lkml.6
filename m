Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E41620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="WguY/AZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbeGRXj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46774 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729974AbeGRXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so133181ply.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OyWywDrz0yNlctIEZKfvqcYdJMHey6G7QhHf0bJ4Juc=;
        b=WguY/AZ84m4D8XPoyVlUMQMTq3NNwODswZZM74PzEWFGMhoYexh4LTJtvuBLfVvdoa
         t+flGWQe/fIJgGXDL9wC9tQrz3VXmKI+xozKNnvupLhGMUSIXXARvkw5dnz9Ebo9OZZs
         o3WmfMbSyBe3yWM4puk+frRnpluMaXVDgwKNsijokAJEpg9+2j3lM8oMVQnEXAXXGsIn
         BXopdo9HIXH9+Dxr60GZ1H5zBS2/4C38dhiWUPRVGGipuMrYrdVx+3MhpYHK+Pv7g+3B
         ilO6aXl7+YjjwEe81c0NBzMa65U0IbdJyLYFXpTabj9HY7raQkyH/tArkm85hixFdr0s
         BYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OyWywDrz0yNlctIEZKfvqcYdJMHey6G7QhHf0bJ4Juc=;
        b=j9JvnA+8A/19nKIxqC3S2V7SsFZVtmuKjhDOn5hoT7aitqwMhFHnpQNoE6JuEagB+4
         BOEkaDBKXlEHBYKiawwgPygN8K5dJO1BSNQMYuV6cJu4hgTdziYbJjjFCLzul2qYh5zE
         PM+P8ajTFIIWb2hpKWDG1oixqnWGPmVTE5dzpEdf25O+rjI0BhVRKLx7TKBBGRfHqvrd
         85Gu5mLVXqEtddmNcMH+rKt1C6aglJLVnv1mPW1gwKb+J+uDFRZ7bbkFUXHulSKz3MzT
         sjM7v7sttNjrqFuKbetqtW8qv06eZkmGFYRSB116XgOkn3qZveFR1EXREi0ntXvzJJwT
         mRDg==
X-Gm-Message-State: AOUpUlGBjbhefRfHR4YFf0PW5NBB4vqMOqLU47Jfv60d+wqDB7okWcLg
        MKt0ZuLpa6PFw1PFHQUO+NwRm/XKtxk=
X-Google-Smtp-Source: AAOMgpeWrMiw/LFYovwyQROAg0UslI0bFua7LPcQ1chSvyRS+oXsoOwOJ7E3kiz34S7nkOKYcjVFVA==
X-Received: by 2002:a17:902:a702:: with SMTP id w2-v6mr7763319plq.41.1531954756864;
        Wed, 18 Jul 2018 15:59:16 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:16 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 3/8] proc/kcore: replace kclist_lock rwlock with rwsem
Date:   Wed, 18 Jul 2018 15:58:43 -0700
Message-Id: <521ba449ebe921d905177410fee9222d07882f0d.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
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

