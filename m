Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ECDC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE1020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="rSaiZYTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE1020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeGZBNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42552 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbeGZBNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so3951293plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jejP2yrNUB7zHbhkc1Ji+iKVjXdsuDSSW0aNb0+t3w4=;
        b=rSaiZYTBpJvtTfER7UyiV0vgtVPMHJvNbL0d4NHd5473ZGsxdd+dYdRIj67JFVkkyg
         Sjbsmzvmn0TZEhSBKGKWDMpD25h0vS4uhjn9vuNu0g1Ivv1z4VvRQXP5Z4dU99R58TPV
         ZOIpm+jukziTkScJrGF++3tdsbgIK5Bq8JVjHIsQLmTPdS9BadKWIS/l/+p3ZmCE80Aa
         X4KoF1xmDIzZJ+OgfWj584/TShSJ4BsUcsxl7fUHSofEUIiBgoBR7KGEWarIom7Hr/9j
         fNJsVR6QWMXu0r+vLWgkNGFoq8GWm2IuFsF4sX+d7vRLq8vX6r6eA2tYtP3p5do3ieCZ
         cznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jejP2yrNUB7zHbhkc1Ji+iKVjXdsuDSSW0aNb0+t3w4=;
        b=OFITwmZ1RHhaL1rug/0eXcCaQqDyoU7+wxQ0Qca1AT/9gy1AHClqXgujirDPIJMkj3
         smyPCI6y1S+P8cOaNefdVTrFNYqncGbJQ1/S5ZJNZhh7qRsu43aq8jbGXh045cdAmF+4
         T4mSjAZJt69Qew1EmCqaM3ZRETxIYBXxBYGFjOuR+RAeJfuXMCcJ4HOLBOogr8anX02L
         UaUd626KZfpcXdC2fMkvd958xPDaOGx1SF7Oop8cwAVUcrCHhXuCPN6EFpPcPn1p/CHI
         C9QBeYrXG32bmUgXblIEeQ1EmKFTRtYbo/YCKt00FcNRGfGOuXehuZWD30R80GxfmR1H
         cK7g==
X-Gm-Message-State: AOUpUlE9nVrq2GFYGlFtokvthLkfr3nNR10AtjlhLDt0/oegnPkEfS/Z
        Hhe4FG91fIjrE/pvKUPBuoEFsM9eMns=
X-Google-Smtp-Source: AAOMgpccLSWJN9v6HHbhkX6ZmvWKOSmfWL2cGtcOoKvSutpphfb9usi+bvhnJGyT0Q+u60aS+Ty/NA==
X-Received: by 2002:a17:902:ab90:: with SMTP id f16-v6mr23534126plr.182.1532563172107;
        Wed, 25 Jul 2018 16:59:32 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:31 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 4/9] proc/kcore: fix memory hotplug vs multiple opens race
Date:   Wed, 25 Jul 2018 16:59:15 -0700
Message-Id: <0eed0c15cf94c6869fcefccae46759d702d7118f.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
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

