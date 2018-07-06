Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A87C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EFB22CA0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kmzkQ7D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EFB22CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934787AbeGFTcw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:32:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36963 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934741AbeGFTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:49 -0400
Received: by mail-pf0-f194.google.com with SMTP id h20-v6so9183260pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIfom0bteWoeSozeaDPwgTA0fOV2FhnwD4cyFdWL/0g=;
        b=kmzkQ7D7jdDNkrKq9wFOhclQP0ynRsXyEUs6KmdmlKDTWnJouRUD5zalUBlezCAvSK
         z2IHjyKSV4kRTmqpb68WTGq3mRpvnWjGbnSTX42jM/c/ZsaUB2VlFtTjXge+bzC9tGYN
         Lim0+RMXweg0ji6c+wdiZ1nIg1j9Pvu7bB6aRdlIpQXuoXRn698I71vgXjCcuqTQt8NE
         JpTt7BATUxP0mF+hSjc4cW4ZewQnmsSloS6ZjObHW4pXfWTYm/puxFB/oNgArci0bHvL
         z1P32Z81h458Bhxtdbs3TLfJdsim7Io56p0tDl0dzg2vp32oKSvItu027dCL+Ifbtrii
         iVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yIfom0bteWoeSozeaDPwgTA0fOV2FhnwD4cyFdWL/0g=;
        b=g/JjH+IGlfKpPFsU8FvOpE2oPAv/FaduYNJ6UVTBS5orIBpgPjS5ARzhQmZRW1n9lA
         rWGnGJgtHxMAaoW49UEbvOO8wLvUFdaRWRl0mhhm3x5dAYOB+Qdq1K9cZYTsVEkmsDAs
         lp4C7p/y949/5O02EUEegf2grobG5IJ4bU1/s9FZgOuuPwsxwpNvBUh3mBmjW+q1KrIL
         ZNlDMq4Osv9aFVp1nOkXJRkoid/HMe7herJu6lwn9Jr++gQiIWkCQhDe9htI60A2Zdd9
         m/anzzH91JKMYfIN6X+hJLEEzi1pSFbEMwEc4+NG35wYsLrf/UyoLpEveToWjHdkHkmT
         fyVw==
X-Gm-Message-State: APt69E2HQAa+glEKx6/aIg5zXH/M8XM+AIpot9RaniFx6FAhpVvCU867
        OfO75vLDs2aUcF+I6lb+mvbRrpxN5YY=
X-Google-Smtp-Source: AAOMgpd+CRY8s3Xj/wJKRkjDRLgWVypKeo4v2DkdCWa589Skm2CnJobbbNmP3lgrBERug6RaAkbhBA==
X-Received: by 2002:a62:e18:: with SMTP id w24-v6mr11831655pfi.145.1530905568240;
        Fri, 06 Jul 2018 12:32:48 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:47 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 3/7] proc/kcore: fix memory hotplug vs multiple opens race
Date:   Fri,  6 Jul 2018 12:32:34 -0700
Message-Id: <904e8cabeddf594c30ba5fd314e2d5b887ceb3c8.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

There's a theoretical race condition that will cause /proc/kcore to miss
a memory hotplug event:

CPU0                              CPU1
// hotplug event 1
kcore_need_update = 1

open_kcore()                      open_kcore()
    kcore_update_ram()                kcore_update_ram()
        // Walk RAM                       // Walk RAM
        __kcore_update_ram()              __kcore_update_ram()
            kcore_need_update = 0

// hotplug event 2
kcore_need_update = 1
                                              kcore_need_update = 0

Note that CPU1 set up the RAM kcore entries with the state after hotplug
event 1 but cleared the flag for hotplug event 2. The RAM entries will
therefore be stale until there is another hotplug event.

This is an extremely unlikely sequence of events, but the fix makes the
synchronization saner, anyways: we serialize the entire update sequence,
which means that whoever clears the flag will always succeed in
replacing the kcore list.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 93 +++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index eb1be07bdb3d..f335400300d3 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -98,53 +98,15 @@ static size_t get_kcore_size(int *nphdr, size_t *elf_buflen)
 	return size + *elf_buflen;
 }
 
-static void free_kclist_ents(struct list_head *head)
-{
-	struct kcore_list *tmp, *pos;
-
-	list_for_each_entry_safe(pos, tmp, head, list) {
-		list_del(&pos->list);
-		kfree(pos);
-	}
-}
-/*
- * Replace all KCORE_RAM/KCORE_VMEMMAP information with passed list.
- */
-static void __kcore_update_ram(struct list_head *list)
-{
-	int nphdr;
-	size_t size;
-	struct kcore_list *tmp, *pos;
-	LIST_HEAD(garbage);
-
-	down_write(&kclist_lock);
-	if (atomic_cmpxchg(&kcore_need_update, 1, 0)) {
-		list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
-			if (pos->type == KCORE_RAM
-				|| pos->type == KCORE_VMEMMAP)
-				list_move(&pos->list, &garbage);
-		}
-		list_splice_tail(list, &kclist_head);
-	} else
-		list_splice(list, &garbage);
-	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
-	up_write(&kclist_lock);
-
-	free_kclist_ents(&garbage);
-}
-
-
 #ifdef CONFIG_HIGHMEM
 /*
  * If no highmem, we can assume [0...max_low_pfn) continuous range of memory
  * because memory hole is not as big as !HIGHMEM case.
  * (HIGHMEM is special because part of memory is _invisible_ from the kernel.)
  */
-static int kcore_update_ram(void)
+static int kcore_ram_list(struct list_head *head)
 {
-	LIST_HEAD(head);
 	struct kcore_list *ent;
-	int ret = 0;
 
 	ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 	if (!ent)
@@ -152,9 +114,8 @@ static int kcore_update_ram(void)
 	ent->addr = (unsigned long)__va(0);
 	ent->size = max_low_pfn << PAGE_SHIFT;
 	ent->type = KCORE_RAM;
-	list_add(&ent->list, &head);
-	__kcore_update_ram(&head);
-	return ret;
+	list_add(&ent->list, head);
+	return 0;
 }
 
 #else /* !CONFIG_HIGHMEM */
@@ -253,11 +214,10 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 	return 1;
 }
 
-static int kcore_update_ram(void)
+static int kcore_ram_list(struct list_head *list)
 {
 	int nid, ret;
 	unsigned long end_pfn;
-	LIST_HEAD(head);
 
 	/* Not inialized....update now */
 	/* find out "max pfn" */
@@ -269,15 +229,50 @@ static int kcore_update_ram(void)
 			end_pfn = node_end;
 	}
 	/* scan 0 to max_pfn */
-	ret = walk_system_ram_range(0, end_pfn, &head, kclist_add_private);
-	if (ret) {
-		free_kclist_ents(&head);
+	ret = walk_system_ram_range(0, end_pfn, list, kclist_add_private);
+	if (ret)
 		return -ENOMEM;
+	return 0;
+}
+#endif /* CONFIG_HIGHMEM */
+
+static int kcore_update_ram(void)
+{
+	LIST_HEAD(list);
+	LIST_HEAD(garbage);
+	int nphdr;
+	size_t size;
+	struct kcore_list *tmp, *pos;
+	int ret = 0;
+
+	down_write(&kclist_lock);
+	if (!atomic_cmpxchg(&kcore_need_update, 1, 0))
+		goto out;
+
+	ret = kcore_ram_list(&list);
+	if (ret) {
+		/* Couldn't get the RAM list, try again next time. */
+		atomic_set(&kcore_need_update, 1);
+		list_splice_tail(&list, &garbage);
+		goto out;
+	}
+
+	list_for_each_entry_safe(pos, tmp, &kclist_head, list) {
+		if (pos->type == KCORE_RAM || pos->type == KCORE_VMEMMAP)
+			list_move(&pos->list, &garbage);
+	}
+	list_splice_tail(&list, &kclist_head);
+
+	proc_root_kcore->size = get_kcore_size(&nphdr, &size);
+
+out:
+	up_write(&kclist_lock);
+	list_for_each_entry_safe(pos, tmp, &garbage, list) {
+		list_del(&pos->list);
+		kfree(pos);
 	}
-	__kcore_update_ram(&head);
 	return ret;
 }
-#endif /* CONFIG_HIGHMEM */
 
 /*****************************************************************************/
 /*
-- 
2.18.0

