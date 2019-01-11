Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E698C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135DA2177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzFAotY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfAKFNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:13:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33348 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfAKFNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:13:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so6253277plo.0;
        Thu, 10 Jan 2019 21:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HyITMNdELPclxNoKcR1zVio3u+9JmLHOG25CjPlIULI=;
        b=YzFAotY+NwCnyRx28zQm2g9r3fmR7pCjWvfroJkraJswxUAdRRZ3wswDAug/7D59rL
         OcWULBgD5QWfA8kg2RcGMOk5TS5W5AJVPaKtuV20MwIueNXJIuGF9XBCaS9rx1Onb4Lq
         FYIxRx4oe7IL0rqgK7eAkqukFsispBSCEpJEXtTWIlMipIpMcB2CJ9fFoOVZvf61AqWR
         LI++l2sYxQL3hRHseTnz33T4U9gutvkdkmFCI3vcd7Im7W8FIJhnN5wkPoGKEXjeuHDr
         kBLmbgH4mBdsPxXKacs3HRy8u2xHlzPJLM8oQQ/qaud6Q/BL65/zInLq8YApNIs/eJbA
         ub0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HyITMNdELPclxNoKcR1zVio3u+9JmLHOG25CjPlIULI=;
        b=SY1ELj5zPzelcdwk+bk/XvExPtFcySgw9PMz4dXphgI4T234UlAIefCbLqfuJ/fKix
         dNi9w9tqaHzFvPr+bftkn0Jayk2drHYgmiDP05g7fkgxxq6Lsfu0/w1bohiXRFfok4ba
         zx8c0+8nP2DJa3sXY8i6FSiDn05F9BUmY/lYp8pXmjrB+JLRFVj2AcQ5FH53Bm/Ec2Zt
         651ZzMpXkyEoeIJnG/7yIJBECtu9ZXq9+9+1yWM0eR5OoZtlWUbh2Z7hE+p5Z8vRXPtQ
         xtoKgCQ7XKLFz909fbvCpbtP+QBxKL/HyDyEAItvLNrKPZz7BoJnOBIsa1G80q6gHLi8
         U2Bg==
X-Gm-Message-State: AJcUukfYj7AL4VdAblexXmXVy+7LXnnFw/ofLJHir0vyKcxbc6dZl8ze
        ltJeT57EmSQAWthkKZEeEX8MuOYARFpb
X-Google-Smtp-Source: ALg8bN7Dh/zgZ+YLM8araolSDXBBTDY8kyLtFO6bcLu5ojQxeeEy88HPlwMpDDXIALPqfSiTGOIk3w==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr13234631plz.110.1547183633911;
        Thu, 10 Jan 2019 21:13:53 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q7sm93490471pgp.40.2019.01.10.21.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 21:13:53 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCHv2 5/7] x86/mm: set allowed range for memblock allocator
Date:   Fri, 11 Jan 2019 13:12:55 +0800
Message-Id: <1547183577-20309-6-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the incoming divergence of x86_32 and x86_64, there is requirement
to set the allowed allocating range at the early boot stage.
This patch also includes minor change to remove redundat cond check, refer
to memblock_find_in_range_node(), memblock_find_in_range() has already
protect itself from the case: start > end.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: x86@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-mm@kvack.org
---
 arch/x86/mm/init.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ef99f38..385b9cd 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -76,6 +76,14 @@ static unsigned long min_pfn_mapped;
 
 static bool __initdata can_use_brk_pgt = true;
 
+static unsigned long min_pfn_allowed;
+static unsigned long max_pfn_allowed;
+void set_alloc_range(unsigned long low, unsigned long high)
+{
+	min_pfn_allowed = low;
+	max_pfn_allowed = high;
+}
+
 /*
  * Pages returned are already directly mapped.
  *
@@ -100,12 +108,10 @@ __ref void *alloc_low_pages(unsigned int num)
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
 		unsigned long ret = 0;
 
-		if (min_pfn_mapped < max_pfn_mapped) {
-			ret = memblock_find_in_range(
-					min_pfn_mapped << PAGE_SHIFT,
-					max_pfn_mapped << PAGE_SHIFT,
-					PAGE_SIZE * num , PAGE_SIZE);
-		}
+		ret = memblock_find_in_range(
+			min_pfn_allowed << PAGE_SHIFT,
+			max_pfn_allowed << PAGE_SHIFT,
+			PAGE_SIZE * num, PAGE_SIZE);
 		if (ret)
 			memblock_reserve(ret, PAGE_SIZE * num);
 		else if (can_use_brk_pgt)
@@ -588,14 +594,17 @@ static void __init memory_map_top_down(unsigned long map_start,
 			start = map_start;
 		mapped_ram_size += init_range_memory_mapping(start,
 							last_start);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		last_start = start;
 		min_pfn_mapped = last_start >> PAGE_SHIFT;
 		if (mapped_ram_size >= step_size)
 			step_size = get_new_step_size(step_size);
 	}
 
-	if (real_end < map_end)
+	if (real_end < map_end) {
 		init_range_memory_mapping(real_end, map_end);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+	}
 }
 
 /**
@@ -636,6 +645,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 		}
 
 		mapped_ram_size += init_range_memory_mapping(start, next);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		start = next;
 
 		if (mapped_ram_size >= step_size)
-- 
2.7.4

