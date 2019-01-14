Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFA1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB99C20645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ql4tJfDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfANXeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:34:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35809 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfANXeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:34:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so569381qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7jl5/RRo1w1Y4Nd6Af7IGPCqHR+Ha/rAu0Vgu3aHMTg=;
        b=Ql4tJfDTtlb6EDAsuDNFGINDtL5qX6GChGwKFK3jj9kEcHwzGOEIWrGe+6jquIJXvh
         N26ScuiY3qn/F1geFtDQ7FRzbPGesbb7g+1hdjkakCGc5UZL4ZZ5ognKC7RUQR++wfi3
         A6PxF6UBftX+oRZdb876fQRoppCYNixnC41CkejANvHWSfIDV1i1xcprQ6Bfgc3xwWM/
         5hpKThYDgyztLc4Gv12pjMKzDHeLGA7pAQPmeP09iFz7EvV8y9wzqSsuRmNwjIlah/wY
         8A29d7zs7hY5NknEi26O7T154Nt1WxNk6VSgMNlAGo/c3+7ftwvMU6Jdh0dmzZvkZ2Pw
         UNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7jl5/RRo1w1Y4Nd6Af7IGPCqHR+Ha/rAu0Vgu3aHMTg=;
        b=uFcBGPgjpj+pUeLlWF/8F0+xLkHT1eCfytzdKtlMatQKRkRKGAcdNobtxO5b6ERjKq
         SOVQz27u+f4QZatDfkS6ZZJUVvo1lvt1FcYZxereBNEi9KtUM1c0Sps0TvjEniZBExTF
         /o1DpCpxjQ4un8EoHjlMYss0I9jRXdyUq5ztDbTh5BmBN85fIaZ+j7Oyku9yds/1bYqy
         eWOpBVNV0fE42ZD+h4X7geO/c1yCoRMrWe0NCy3rJGJn2zCg0J4f5ixZucxEKL575e8J
         0leQZOjDER6jY8hE+PWJbZi0dah31aBkik2Do7qvq8NbMLQL5fXLkj7SYWQJM/iDzN+i
         FyPA==
X-Gm-Message-State: AJcUukdxJ8YeyzYMA3Mnrvx07gaOkVk9gC3bjugKmcVNTUMga8dBf7IN
        N7Pn+YThA7XUTNUhwmp5jp6WZRw+fRNW7A==
X-Google-Smtp-Source: ALg8bN5r+OoD47PEGyeI7sDIwhgVMbqEUDysk6yF1OhT5QxPA9ejMeCrCdLFJngBYbHgqMtwZ+rkEA==
X-Received: by 2002:a37:34f:: with SMTP id 76mr688462qkd.347.1547508859628;
        Mon, 14 Jan 2019 15:34:19 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o49sm51752874qtf.60.2019.01.14.15.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 15:34:19 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH v2] page_poison: play nicely with KASAN
Date:   Mon, 14 Jan 2019 18:34:05 -0500
Message-Id: <20190114233405.67843-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <2e46c139-70d3-dc86-28c9-a9f263651b57@virtuozzo.com>
References: <2e46c139-70d3-dc86-28c9-a9f263651b57@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN does not play well with the page poisoning
(CONFIG_PAGE_POISONING). It triggers false positives in the allocation
path,

BUG: KASAN: use-after-free in memchr_inv+0x2ea/0x330
Read of size 8 at addr ffff88881f800000 by task swapper/0
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc1+ #54
Call Trace:
 dump_stack+0xe0/0x19a
 print_address_description.cold.2+0x9/0x28b
 kasan_report.cold.3+0x7a/0xb5
 __asan_report_load8_noabort+0x19/0x20
 memchr_inv+0x2ea/0x330
 kernel_poison_pages+0x103/0x3d5
 get_page_from_freelist+0x15e7/0x4d90

because KASAN has not yet unpoisoned the shadow page for allocation
before it checks memchr_inv() but only found a stale poison pattern.

Also, false positives in free path,

BUG: KASAN: slab-out-of-bounds in kernel_poison_pages+0x29e/0x3d5
Write of size 4096 at addr ffff8888112cc000 by task swapper/0/1
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc1+ #55
Call Trace:
 dump_stack+0xe0/0x19a
 print_address_description.cold.2+0x9/0x28b
 kasan_report.cold.3+0x7a/0xb5
 check_memory_region+0x22d/0x250
 memset+0x28/0x40
 kernel_poison_pages+0x29e/0x3d5
 __free_pages_ok+0x75f/0x13e0

due to KASAN adds poisoned redzones around slab objects, but the page
poisoning needs to poison the whole page.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use kasan_disable/enable_current() instead.

 mm/page_alloc.c  | 2 +-
 mm/page_poison.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..906250a9b89c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1945,8 +1945,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	arch_alloc_page(page, order);
 	kernel_map_pages(page, 1 << order, 1);
-	kernel_poison_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
+	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
 }
 
diff --git a/mm/page_poison.c b/mm/page_poison.c
index f0c15e9017c0..21d4f97cb49b 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -6,6 +6,7 @@
 #include <linux/page_ext.h>
 #include <linux/poison.h>
 #include <linux/ratelimit.h>
+#include <linux/kasan.h>
 
 static bool want_page_poisoning __read_mostly;
 
@@ -40,7 +41,10 @@ static void poison_page(struct page *page)
 {
 	void *addr = kmap_atomic(page);
 
+	/* KASAN still think the page is in-use, so skip it. */
+	kasan_disable_current();
 	memset(addr, PAGE_POISON, PAGE_SIZE);
+	kasan_enable_current();
 	kunmap_atomic(addr);
 }
 
-- 
2.17.2 (Apple Git-113)

