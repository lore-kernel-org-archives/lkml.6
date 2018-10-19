Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC12ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678DB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syXSz+ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678DB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeJTBm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:42:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46778 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeJTBm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:42:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id p143-v6so14796140lfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QOpxQtsqnZO1O69woFc9jT6MsNTDcWqgsVf/VQ7puy8=;
        b=syXSz+rynUT0XXnSrP7QxmpOFvRr5Bfr0xP2NEUQePfz5z37UIDck093aaGr+Jxa4v
         EIInTHwHm0Q1NDl5tr94Fdjbza1caupFFHFKQVtbRprJ360q4FOBCZ13lGxR4Zf+HMxQ
         094PnyXuCxKdPliwGRChjlwkjH/W/vP9duBjC07du/+d5V8+x2QdLY3kZaPjdshVJdVP
         mh7t5Ai8b+R+dVx7nyy1No4zBKV5LFDhL/DjNTVsa9XiKP8BHHkRrRYw72bQ2wMQIHVv
         bGpn8T5tGgIOlqUQy7B5X1gv9wggtCiGwjIPj9TcxxaN8O1vYv1Sexy5i8ne01YMXcxG
         VupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QOpxQtsqnZO1O69woFc9jT6MsNTDcWqgsVf/VQ7puy8=;
        b=WLQXZElCAfJWJeObH4/n07gqH21AECqYqoOVBiycOqvl/fKvFQgO5/V4UBsDfOa5Qw
         li7UQHsRlcfCS4XdTsFsQXX6U/GHlXXI2QWgYBPhclSKRLZ6IF+sKk0OTFvhwgT/ZcZ+
         mpC1CkRv1wMYT9Q6fcmII7QjzeZTA1JiLOWWMuVyLeNKzS9waCZEGoRGZagTFQD4gvVc
         5ZmNZQdBrO0WyV3nV7GRzB4d2D0dHdn+M5dH4catv+GmnTDwyXJTQrp7MDltvazwGzgZ
         y8fEjVcldrKMIZ1h3adU4wPIfVDD2NbmCw/q/PL16kSgB/Oa3FGbYdQXMLrnzY4leKGS
         SUSQ==
X-Gm-Message-State: ABuFfojOexhyuj9nfBDYagBn9vUBK/oZvGkgu6/KJl5rW1LV4ZUADOEI
        vE7j3o3eGpDEbHd15DK2c1o=
X-Google-Smtp-Source: ACcGV61jzkETd02239M3JQrg7GcoPJDUVxeCvyghNY325cP/LpZXE8bIG+qEVdYd9SXYWUownIJSJg==
X-Received: by 2002:a19:a501:: with SMTP id o1-v6mr3480817lfe.41.1539970553327;
        Fri, 19 Oct 2018 10:35:53 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id k9-v6sm5531530lje.51.2018.10.19.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:35:52 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC PATCH 2/2] mm: add priority threshold to __purge_vmap_area_lazy()
Date:   Fri, 19 Oct 2018 19:35:38 +0200
Message-Id: <20181019173538.590-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181019173538.590-1-urezki@gmail.com>
References: <20181019173538.590-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 763b218ddfaf ("mm: add preempt points into
__purge_vmap_area_lazy()")

introduced some preempt points, one of those is making
an allocation more prioritized.

Prioritizing an allocation over freeing does not work
well all the time, i.e. it should be rather a compromise.

1) Number of lazy pages directly influence on busy list
length thus on operations like: allocation, lookup, unmap,
remove, etc.

2) Under heavy simultaneous allocations/releases there may
be a situation when memory usage grows too fast hitting
out_of_memory -> panic.

Establish a threshold passing which the freeing path is
prioritized over allocation creating a balance between both.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a7f257540a05..bbafcff6632b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1124,23 +1124,23 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	struct llist_node *valist;
 	struct vmap_area *va;
 	struct vmap_area *n_va;
-	bool do_free = false;
+	int resched_threshold;
 
 	lockdep_assert_held(&vmap_purge_lock);
 
 	valist = llist_del_all(&vmap_purge_list);
+	if (unlikely(valist == NULL))
+		return false;
+
 	llist_for_each_entry(va, valist, purge_list) {
 		if (va->va_start < start)
 			start = va->va_start;
 		if (va->va_end > end)
 			end = va->va_end;
-		do_free = true;
 	}
 
-	if (!do_free)
-		return false;
-
 	flush_tlb_kernel_range(start, end);
+	resched_threshold = (int) lazy_max_pages() << 1;
 
 	spin_lock(&vmap_area_lock);
 	llist_for_each_entry_safe(va, n_va, valist, purge_list) {
@@ -1148,7 +1148,9 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 
 		__free_vmap_area(va);
 		atomic_sub(nr, &vmap_lazy_nr);
-		cond_resched_lock(&vmap_area_lock);
+
+		if (atomic_read(&vmap_lazy_nr) < resched_threshold)
+			cond_resched_lock(&vmap_area_lock);
 	}
 	spin_unlock(&vmap_area_lock);
 	return true;
-- 
2.11.0

