Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A5AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A4920838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XlewbJ5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A4920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLGWfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:35:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33613 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:35:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so6322159qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QDHetqdY6gL2ut6w5hBOClKGYYflCOmIf2piJSnwVCA=;
        b=XlewbJ5l6u5F0/A8cWX4s+3SHkW1ez1LG4mNrfLVy1fLIciasfhYhYb+jAjQVRhXy+
         eTwKcOqjxK3Jd1pWNMbVzm7nPJmxgmHxMKdrHrUxRN0ap1pyEx7Xnwy6PghZ/smAFkMn
         zmasFudqR6QRtvtH0S6XTo4OBlk5q3zkSKlLFmIVU17NCV4E2eIMGk5ibnJEDrcYZ3rh
         q++WnLXNmvIT9MTh9IuGjoxW0qAuFRDzyULrh6UJzsCQZWgywE4dfUpmPzrapsYVjyFQ
         ZqQZhetQ3QYEq22E8aWN9PE0t3JLgoPTogBGoNqOvM/SuMbl90dj+X1EhzX2z8Ur5rVs
         USxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QDHetqdY6gL2ut6w5hBOClKGYYflCOmIf2piJSnwVCA=;
        b=XstM+Fsw1t/VOASJXaiMpq9HoKpbcV5vW8abWn+8E546ZHVPd3HmpbZOqKbNxTP9su
         mtk9C5GvouO5qlN7UUDYlc8/1Z3kn8K1ne0nQArMOwbpR1awvGYSC0NAUYIqxKyt8kA+
         47xuyA0QMXgEymjLq2uvWU1PXnNtd2crBjjqc49fNce3tuTiMLAkY6mgiO5IHJGmsxKC
         TfI5qk8dldLiGudCHBbZwmLd9e9lCVwASuHs30ix/CphzMuTkVW4+faaeKgrFgvrcOHn
         EO+b3Mz4p9R6oES3llTXI8vWN10SEJKn7f1hIwMbYnMWmdpMh4hTKmS6fJWNe82aG9je
         rarA==
X-Gm-Message-State: AA+aEWYC2R8IYTNal6H8sloIKvMz9uGJGt0PD1b5xOOPGtRV+gBPg6w9
        o542IZwmCWrVr4s+f1ZhL43fEA==
X-Google-Smtp-Source: AFSGD/WejKshiv7QsC3sfvDuJ4bXWRhcUsf+w02H/MBeBw9vTcjUTcFmTufFIMhbdN/iZ/cqlDZs1Q==
X-Received: by 2002:ac8:280f:: with SMTP id 15mr3909192qtq.31.1544222100055;
        Fri, 07 Dec 2018 14:35:00 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v53sm2968757qtb.6.2018.12.07.14.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:34:59 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        arnd@arndb.de, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] arm64: increase stack size for KASAN_EXTRA
Date:   Fri,  7 Dec 2018 17:34:49 -0500
Message-Id: <20181207223449.38808-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly due to enable this option will set
-fstack-reuse to "none" in GCC [1]. As the results, it could trigger
stack overrun quite often with 32k stack size compiled using GCC 8. For
example, this reproducer

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/\
syscalls/madvise/madvise06.c

could trigger a "corrupted stack end detected inside scheduler" very
reliably with CONFIG_SCHED_STACK_END_CHECK enabled. Also, See other bug
reports,

https://lore.kernel.org/lkml/1542144497.12945.29.camel@gmx.us/
https://lore.kernel.org/lkml/721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us/

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks. Some noticiable ones
are,

size
7536 shrink_inactive_list
7440 shrink_page_list
6560 fscache_stats_show
3920 jbd2_journal_commit_transaction
3216 try_to_unmap_one
3072 migrate_page_move_mapping
3584 migrate_misplaced_transhuge_page
3920 ip_vs_lblcr_schedule
4304 lpfc_nvme_info_show
3888 lpfc_debugfs_nvmestat_data.constprop

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" on this machine. Hence, it is too much work
to change Makefiles for each object to compile without
-fsanitize-address-use-after-scope individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/memory.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..56562ff01076 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -76,12 +76,17 @@
 /*
  * KASAN requires 1/8th of the kernel virtual address space for the shadow
  * region. KASAN can bloat the stack significantly, so double the (minimum)
- * stack size when KASAN is in use.
+ * stack size when KASAN is in use, and then double it again if KASAN_EXTRA is
+ * on.
  */
 #ifdef CONFIG_KASAN
 #define KASAN_SHADOW_SCALE_SHIFT 3
 #define KASAN_SHADOW_SIZE	(UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_THREAD_SHIFT	2
+#else
 #define KASAN_THREAD_SHIFT	1
+#endif /* CONFIG_KASAN_EXTRA */
 #else
 #define KASAN_SHADOW_SIZE	(0)
 #define KASAN_THREAD_SHIFT	0
-- 
2.17.2 (Apple Git-113)

