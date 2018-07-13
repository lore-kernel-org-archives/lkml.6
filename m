Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004EECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6480214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="KyJTdKSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6480214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbeGMAVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:21:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46812 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeGMAVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so21521104pfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3CKNrbqL5MSp604wgy3UdOg6ForL/ongmOzBrmUluMQ=;
        b=KyJTdKSPYy6UeZ5TZ+Zk0cFo8XfOmCc8HkTP21MumlzE9DbGiA8PjdE+gEUX16Ruz6
         1HvWeKT42njZW2vfD0mAmM79OFgTq6TYO9klFlMw+skXDxCP4TB+lGNPPkDLpB6vYZLV
         n/tk7dBeHM/umrJJmDjZ2nPKZ3vJx8AvV6nrPis5bGYY489ohgBgeRORU2wLg3B1Bfcx
         WYTBHFS7TytyIBr0Mhwy8MLJbbFrFBnVeT0Ph2Bg8QVHYqGuJk0J3yBBFKfE7gRrRb7M
         NLVhZYSrLGrOLDJPAhJiDczXpRy0ef7vy3Fp7yPdI/qI+QUx0/rA2+GAAXOLGemT9uW9
         Wgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3CKNrbqL5MSp604wgy3UdOg6ForL/ongmOzBrmUluMQ=;
        b=i1KJU66z8v2DYxaoWubxI9XD1/S4yF1tJt3M+QOiaF3YOnrBbD5ZmQtLF2MaF8efPn
         GPPkxo4dXX+NdZLmtQuP+7+0THQkFiE8hY56nSaRmFAHY04XBSL5i+fId+ETHmRvfnRc
         Wut0Fx9Am876A796fW4TTHIJaM6aaftbxAEjSnwmLmDQOcqhAWQw4jBh2AFSPARBsXZg
         T8fxzNa7W5FM/XNNXSQxqh6zvDTLsFT6wihMejRzbY2DBhVx+HYCpXW9VW1ubZ7yNhP3
         OqbFKToHr00zx6wSPsLPiTCoT/WH4iG2tv9cuUYNE3PBY2oAbYMH0B55FrvvXga3NIv1
         K8Mw==
X-Gm-Message-State: AOUpUlG4Zk6/G70kDnFEqwBfGOeZ7MRKy/7pQg51qyxCkR/faEsjstmY
        THHE//hJQDDdmOWs1Mo2RuPys29Uw28=
X-Google-Smtp-Source: AAOMgpcaAutMMWZNjqQoLffBS3XTFNjFVCEOIfy10jurBnZjq4/0Isdm6FtBtc16utOMB3KdEXgVhw==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr4603759pfg.222.1531440588940;
        Thu, 12 Jul 2018 17:09:48 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:48 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 3/7] proc/kcore: fix memory hotplug vs multiple opens race
Date:   Thu, 12 Jul 2018 17:09:35 -0700
Message-Id: <87df7359270e708d2e599ca0c9011c9347522c50.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
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
index def92fccb167..33667db6e370 100644
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

