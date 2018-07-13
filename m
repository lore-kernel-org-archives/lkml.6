Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39612147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="GdaJopza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39612147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbeGMAVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:21:46 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33401 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387766AbeGMAVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:46 -0400
Received: by mail-pg1-f172.google.com with SMTP id r5-v6so4340530pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iES641aH5TZrbGpfBkO6jWH7ydYNqg2y0U3mVozYm6Y=;
        b=GdaJopza3OjRRmzjTqQI4ZrB7xNUarcdhpzkBysYEYXZp9cKBapeUde9sp2qljK4GX
         IwKUOxhuGHm1vr3T5tIB2rl+IKreoy0c1I83MEfqjz4bTRMeOmOdNN1LVDU7x+qQNDEy
         eOjnc9Pmx0qHnjUS9c8n2nqBKWVWKxFWuJtx73Sw0RhKisOzsuECFv+Sk3B6rqR0o1rB
         qnnUDiwkHJTVyx9ROVDD9oklzT9B3Feu5mvs+64RE7V5YNi5GDAwYEnYw5OdFeUGII43
         h1MEH61RZX21R+Zu6Lhy1PqTDaRlWhJev9NGThULI3DdD+LGc6uT7M13bDamj0WTpnak
         wLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iES641aH5TZrbGpfBkO6jWH7ydYNqg2y0U3mVozYm6Y=;
        b=BjZeRhG/ZyLbGciTFI/T81F7r90pFFuIyTqXAnGLTO/YjilGaAwdquz8GsHR8snj75
         ENd+sjGKGXSWDlNhyMeNKzsRal0CcL7SNydIbAyhzGmKYaEJSH/zOsY56G60TGe6WjjP
         7EY8jHtph9KRdEjKzedMEYCJLkKaghLM0Sh/bpHjgrIXFNkXnwNsHgfiXEVmSvDI0lHi
         +T1VkPu+IdAJIskYYi06WdUlPjs4ftMKiu6wPo0Vn1/1KpUPP/RKmaKze47OuEZYoB2r
         ALhp9CFH6GoTOhlNnSf6rP/7Zkex4gTCIvV3oM0eYm35QzHRy7eyEgN067HqPT5Y4lsj
         0thQ==
X-Gm-Message-State: AOUpUlFm6x5ke7bwz+Q9vfEuZN99U4zDxAx92wI65eggx/5Fr+//h2/I
        Z/Xg0cy3eaaY8X5a5wZoclAlQpR4f6Y=
X-Google-Smtp-Source: AAOMgpeM0x3lGpdT5TC3aqhDf+bl2oxb4ih/0RMn8BWCuatbcRgols+eyH96UeUCn6pe+FHCM17UlA==
X-Received: by 2002:a62:cc4d:: with SMTP id a74-v6mr4602311pfg.200.1531440588000;
        Thu, 12 Jul 2018 17:09:48 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 2/7] proc/kcore: replace kclist_lock rwlock with rwsem
Date:   Thu, 12 Jul 2018 17:09:34 -0700
Message-Id: <783ba3becc424db45e5d5c93559fc40ef6173f01.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now we only need kclist_lock from user context and at fs init time, and
the following changes need to sleep while holding the kclist_lock.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index ddeeb3a5a015..def92fccb167 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -59,8 +59,8 @@ struct memelfnote
 };
 
 static LIST_HEAD(kclist_head);
-static DEFINE_RWLOCK(kclist_lock);
-static int kcore_need_update = 1;
+static DECLARE_RWSEM(kclist_lock);
+static atomic_t kcore_need_update = ATOMIC_INIT(1);
 
 /* This doesn't grab kclist_lock, so it should only be used at init time. */
 void
@@ -117,8 +117,8 @@ static void __kcore_update_ram(struct list_head *list)
 	struct kcore_list *tmp, *pos;
 	LIST_HEAD(garbage);
 
-	write_lock(&kclist_lock);
-	if (kcore_need_update) {
+	down_write(&kclist_lock);
+	if (atomic_cmpxchg(&kcore_need_update, 1, 0)) {
 		list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
 			if (pos->type == KCORE_RAM
 				|| pos->type == KCORE_VMEMMAP)
@@ -127,9 +127,8 @@ static void __kcore_update_ram(struct list_head *list)
 		list_splice_tail(list, &kclist_head);
 	} else
 		list_splice(list, &garbage);
-	kcore_need_update = 0;
 	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
-	write_unlock(&kclist_lock);
+	up_write(&kclist_lock);
 
 	free_kclist_ents(&garbage);
 }
@@ -452,11 +451,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
 
@@ -473,11 +472,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -492,7 +491,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		if (buflen == 0)
 			return acc;
 	} else
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 
 	/*
 	 * Check to see if our file offset matches with any of
@@ -505,12 +504,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -563,7 +562,7 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (!filp->private_data)
 		return -ENOMEM;
 
-	if (kcore_need_update)
+	if (atomic_read(&kcore_need_update))
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
 		inode_lock(inode);
@@ -593,9 +592,8 @@ static int __meminit kcore_callback(struct notifier_block *self,
 	switch (action) {
 	case MEM_ONLINE:
 	case MEM_OFFLINE:
-		write_lock(&kclist_lock);
-		kcore_need_update = 1;
-		write_unlock(&kclist_lock);
+		atomic_set(&kcore_need_update, 1);
+		break;
 	}
 	return NOTIFY_OK;
 }
-- 
2.18.0

