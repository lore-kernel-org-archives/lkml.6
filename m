Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A03ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C292D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="f+s9HaIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C292D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGRXj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45808 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729914AbeGRXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so2683447ple.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jejP2yrNUB7zHbhkc1Ji+iKVjXdsuDSSW0aNb0+t3w4=;
        b=f+s9HaIKDBRWut27nGIZf0trUyVObUF0NZNm3n9F/WbYwoe9Qa/97x88Xsv1K+Q8sx
         7Hegh0w9kCaz+qvzuPGZels/4S2fKNl2dwvrogcKLID8QS2OM2fzSYoayafhKxG6SLv3
         oWdKJRoirkfDo6lSJsIXe12CwquoFRky13TDCcdRGgHIMkRR08w3oYO6SbI3lzmCr5iR
         u7pHMQCQmfto7ITsVtklBOYeGnVjtJkim4SBvvX2OSWQGg+5veAZhUBYupbzlnWoUfV4
         PX9WB9HihSR3pnbKl5PYj3f4al+o8fqEvLBw9qC+IygUkJkVSmHyJbcntLuuLh4aZQOV
         ox/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jejP2yrNUB7zHbhkc1Ji+iKVjXdsuDSSW0aNb0+t3w4=;
        b=uoXnWIigkNCwQ3MstFW0Sr5jBTco7n7jpTtCbspahnyXqWn6VOaLrI02fLM7/3cK1s
         byIGWPpb0Yz1opfPH3q6vEOdnKIxNbSq/vugZYAJAWcvAHSvcBY5FZg4jiXJRgbmtbjf
         bXCByBY3ukE0hiY2xpHY6AhVs5aACZZCdhnSkrFrf1ilpiwinApRPax/roh7vghiQ4Pt
         uZ/mv/+NRSLs3y7vCa+wYiyJJV1KtrPOA3+zUsj22EEFglpFd2TqTMPZVvaJefAvvsSV
         +MKp8QDvWpezAMeSbHnMfaUi2TZq7YXsJ6JLhHw/UHCZgyyfrE3q8fT2dI0w9qNNTQ7y
         NHPg==
X-Gm-Message-State: AOUpUlGTx26oHubMnA99IAzGeGC/jFvacxKxiO1CLmSlubQRgg9NwQQj
        NzXe3IxH8xUaUwTZL6du0C9EZS/HivA=
X-Google-Smtp-Source: AAOMgpdXPuDFIZOHhzyEcxMEilCk1HaJHcsSMImSWszc9RqS26Q2wZj15mKiQxXDJXxBNfTbfAATVg==
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr7907532plp.244.1531954757740;
        Wed, 18 Jul 2018 15:59:17 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 4/8] proc/kcore: fix memory hotplug vs multiple opens race
Date:   Wed, 18 Jul 2018 15:58:44 -0700
Message-Id: <6106c509998779730c12400c1b996425df7d7089.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
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
index ae43a97d511d..95aa988c5b5d 100644
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
-	if (xchg(&kcore_need_update, 0)) {
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
+	if (!xchg(&kcore_need_update, 0))
+		goto out;
+
+	ret = kcore_ram_list(&list);
+	if (ret) {
+		/* Couldn't get the RAM list, try again next time. */
+		WRITE_ONCE(kcore_need_update, 1);
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

