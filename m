Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2539AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7719205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cQj4jShJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbfAOU2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:28:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42716 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbfAOU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:28:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so4521331qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 12:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+MGHCZiDLKZYb6e21y5eRzkF0gubjj3irLeA6+jF5s=;
        b=cQj4jShJ7hek0Hv3iR7TcxAlozP9WVIRy46GfgaJ4FfsQh/ocdqsumVWhEUI6JKw7a
         2j1OKOkSbgUM+um4LvyMMOzX59Ycmh9NQyv/Z35V8pvLdTdD+6j+1LCIH61a/eAqcP42
         lUw2+9qeLSuCWUc6uf/FfN0FhwTJ8YjZSjxWjrdufZv2Cfx7llzHXRruxPNsVnN7cy2d
         TaPaHKJ4jpDB//8y8S3uQEbIXZ9vLcIdtRd/Co+mFbzUiYoEBQCbSUIevfL0gEqftmZY
         dyfNU9ov8BqpaJuwwNUFOkFefJ+G3VL8eBOkI7kMFEW+PIRHu6ocewQDvTxH0pQp9I/k
         JEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+MGHCZiDLKZYb6e21y5eRzkF0gubjj3irLeA6+jF5s=;
        b=RQVmMvbMsHHyji6OJn51DzFnxWWIltKXr9Za+adRWLXpdv1jZ74tHOgbZBT6FbdYlU
         dCXlUB+64YuoUT5xLg+ZFCtoz1zJ4pEsgn9KiJVlcJCrfPDJfjB30hhPLSffuPISBsMB
         LbRB6x8zEJOuGvEfmql3x4yx9b9jctRdSIQDu1+4k9Hghyme6/WPOVsB960BGezCZKly
         cS8SRpjj1rv/uVZCJLbcY791Vq6shrk91w0nkwQUKAAmVo92Skz2XdtTb4OTl8UigE4j
         7PWCMQhiOxIhndH7AxCjLHJcGU/Z0N4MI9pzeOl9uu8H/wWMOKzjAI3C6QHAS4OPPPuZ
         nAww==
X-Gm-Message-State: AJcUukelt2+AqXPyyEtCDEEmHhru8aH+FX/UGX3dbD6+IG62/Gto2o9s
        3n+/8jfWfMCsF3+va+AcGhrDHA==
X-Google-Smtp-Source: ALg8bN5XeB21JZEqoMmU7Pt8ta/q5lwPsAAeN5PTF0QzwvIiCi000vkxd4IUpOxcpcydBPE0wtw/5Q==
X-Received: by 2002:a0c:9a4a:: with SMTP id q10mr4323419qvd.150.1547584118648;
        Tue, 15 Jan 2019 12:28:38 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a3sm58522092qta.21.2019.01.15.12.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 12:28:38 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, Pavel.Tatashin@microsoft.com, mingo@kernel.org,
        hpa@zytor.com, mgorman@techsingularity.net, iamjoonsoo.kim@lge.com,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] Revert "mm: use early_pfn_to_nid in page_ext_init"
Date:   Tue, 15 Jan 2019 15:28:12 -0500
Message-Id: <20190115202812.75820-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190109073409.GA2027@dhcp22.suse.cz>
References: <20190109073409.GA2027@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fe53ca54270a757f0a28ee6bf3a54d952b550ed0.

When booting a system with "page_owner=on",

start_kernel
  page_ext_init
    invoke_init_callbacks
      init_section_page_ext
        init_page_owner
          init_early_allocated_pages
            init_zones_in_node
              init_pages_in_zone
                lookup_page_ext
                  page_to_nid

The issue here is that page_to_nid() will not work since some page
flags have no node information until later in page_alloc_init_late() due
to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
access with an invalid nid.

[    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
[    8.672603] index 7 is out of range for type 'zone [5]'

Also, kernel will panic since flags were poisoned earlier with,

CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_NODE_NOT_IN_PAGE_FLAGS=n

start_kernel
  setup_arch
    pagetable_init
      paging_init
        sparse_init
          sparse_init_nid
            memblock_alloc_try_nid_raw

It did not handle it well in init_pages_in_zone() which ends up calling
page_to_nid().

page:ffffea0004200000 is uninitialized and poisoned
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
page_owner info is not active (free page?)
kernel BUG at include/linux/mm.h:990!
RIP: 0010:init_page_owner+0x486/0x520

This means that assumptions behind commit fe53ca54270a ("mm: use
early_pfn_to_nid in page_ext_init") are incomplete. Therefore, revert
the commit for now. A proper way to move the page_owner initialization
to sooner is to hook into memmap initialization.

Acked-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 init/main.c   | 3 ++-
 mm/page_ext.c | 4 +---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/init/main.c b/init/main.c
index e2e80ca3165a..c86a1c8f19f4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -695,7 +695,6 @@ asmlinkage __visible void __init start_kernel(void)
 		initrd_start = 0;
 	}
 #endif
-	page_ext_init();
 	kmemleak_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
@@ -1131,6 +1130,8 @@ static noinline void __init kernel_init_freeable(void)
 	sched_init_smp();
 
 	page_alloc_init_late();
+	/* Initialize page ext after all struct pages are initialized. */
+	page_ext_init();
 
 	do_basic_setup();
 
diff --git a/mm/page_ext.c b/mm/page_ext.c
index ae44f7adbe07..8c78b8d45117 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -398,10 +398,8 @@ void __init page_ext_init(void)
 			 * We know some arch can have a nodes layout such as
 			 * -------------pfn-------------->
 			 * N0 | N1 | N2 | N0 | N1 | N2|....
-			 *
-			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
 			 */
-			if (early_pfn_to_nid(pfn) != nid)
+			if (pfn_to_nid(pfn) != nid)
 				continue;
 			if (init_section_page_ext(pfn, nid))
 				goto oom;
-- 
2.17.2 (Apple Git-113)

