Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE417C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F2B217D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kVt+jCs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F2B217D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934768AbeGFTcv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:32:51 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:41629 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934654AbeGFTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:48 -0400
Received: by mail-pg1-f178.google.com with SMTP id l65-v6so319292pgl.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=If2uZrQuTLVYJ8g0CUZfSQeRiZQEBbyzXaBZzmxRkb4=;
        b=kVt+jCs1d821SL1v2n89Cg0oMd7cxgJnAKV1Xl/Vyzm9f1qUm0qlcb3UgufTtjT9sC
         xlesnj5oOydk7zz3slf51LS8sN3IEdnVQdaahKDF58/PEhnuE8vdgp2aAtSxLP1Qh6Fe
         uOzmTHyA/Vck2d+mFjKwqa093LvGrd/mGjwvFMYoH+Ht1jzLhHa/XOqC0lVgwQlMKmUw
         s/menhh39J9BfzUN3P4m2sYmbUckxl8Yu8f9XEZGLvlcoY6pcmZFkFhyCeuedMvKubU5
         GbDiDO9lj2gKrel9wusSk6T9ww7G5Sv3DUIZcFHagEkQwLH3pbp3tXIstMXSi2S3h9U3
         TkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=If2uZrQuTLVYJ8g0CUZfSQeRiZQEBbyzXaBZzmxRkb4=;
        b=H2G2iONijCRV+gU061W+tWAMfPj99fCl+zyJtUUCNpuYbu7pLPJ08V6vcEV5Gh0IT4
         4+6Gld0S7+A2XAr8zhpYdTDPUVZ8qdrAZWe+Gbv6Nx+DhwJp5aOktIBAFuW7iT5jim6W
         HblSv99n9tPl5bC8/aLPT+JVeXkC8Cb9hJGQALFekM/bC5tXRsk8qz7VB43IcrLMdY/e
         dmUfp1EaOktDoZUAAKk9pk5P08I8+9nPN+jkNkmp/6millcjrCCE/DYSmMqn/5zvcAJE
         ntvUGAAfaLvneVssuEWCU9IXDlPzssIAvDyv5bO/teAPA2WGP+jcGVVKNOeLsuTZC75n
         SQUg==
X-Gm-Message-State: APt69E2sA+Q/qvp2r7RN93K9A80RSXbwE/tecIdVPkDCVuIJ/X1gORd2
        uswRISBUbjY4V8DKG7x490a3GTau/TY=
X-Google-Smtp-Source: AAOMgpc1NntupZRfXHPgQp9elHChBJEHxuLxkq9rate3OgRA89JimWeMvsebo+yiaJ4+boK7lUcLLw==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr10179041pgd.291.1530905567336;
        Fri, 06 Jul 2018 12:32:47 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:46 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 2/7] proc/kcore: replace kclist_lock rwlock with rwsem
Date:   Fri,  6 Jul 2018 12:32:33 -0700
Message-Id: <fd41165c2e3b2a64cbf329b5fb8d13f3587e4e5a.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
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
index afd1ff8c2d3f..eb1be07bdb3d 100644
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
@@ -450,11 +449,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
 
@@ -471,11 +470,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -490,7 +489,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		if (buflen == 0)
 			return acc;
 	} else
-		read_unlock(&kclist_lock);
+		up_read(&kclist_lock);
 
 	/*
 	 * Check to see if our file offset matches with any of
@@ -503,12 +502,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -561,7 +560,7 @@ static int open_kcore(struct inode *inode, struct file *filp)
 	if (!filp->private_data)
 		return -ENOMEM;
 
-	if (kcore_need_update)
+	if (atomic_read(&kcore_need_update))
 		kcore_update_ram();
 	if (i_size_read(inode) != proc_root_kcore->size) {
 		inode_lock(inode);
@@ -591,9 +590,8 @@ static int __meminit kcore_callback(struct notifier_block *self,
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

