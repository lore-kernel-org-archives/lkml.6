Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ECFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC7208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UwSZlT+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEC7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeIZSZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55022 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:25:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121216euoutp029fe1b9b38bcb4e59181dacdeebe1bc75~X8g1UY6eG1543815438euoutp02Y;
        Wed, 26 Sep 2018 12:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180926121216euoutp029fe1b9b38bcb4e59181dacdeebe1bc75~X8g1UY6eG1543815438euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963936;
        bh=AzX9htfGbaegeliqAcQBEJz9hbWdG/HLuktSIH9Xj6o=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=UwSZlT+UyiSIuGfr5trdLQ5YEForHKmP5g7fIEfnRQmitr8dyFuXmTYsZPaXMokQ0
         Xq/fSvsJ5TKZ2RcG4EF67oKrDPGfWX3bBsRh4QxKtihlVtHKurVHmCIBnsnsNoPdDz
         hSlhE5iioZcq/v7YYU2FkQEDRqwQZwXJAESOwAT0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180926121216eucas1p24e22c339325c2768810a31ec134eeda1~X8g0vtpb01487714877eucas1p2G;
        Wed, 26 Sep 2018 12:12:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6E.2E.04806.F977BAB5; Wed, 26
        Sep 2018 13:12:15 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121215eucas1p10437d5bd9db81bedbcc363d24d196ded~X8gz-Za8Q0975409754eucas1p1M;
        Wed, 26 Sep 2018 12:12:15 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-8c-5bab779f42be
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.0B.04128.F977BAB5; Wed, 26
        Sep 2018 13:12:15 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:15 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 3/7] arm64: introduce get_swbp_insn() instead of static
 assignment
Date:   Wed, 26 Sep 2018 14:12:01 +0200
Message-id: <1537963925-25313-4-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7djP87rzy1dHG6z7ZWLRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlbFy/1XGgsOCFc9n9TI1MD7k62Lk
        5JAQMJFYtfkuM4gtJLCCUWLNFNUuRi4g+zOjRGfbJhaYoqlTdrFAJJYxSmz9epENouM/o8SV
        ZwEgNpuAucT2oy1gDSICbhI3GjuYQBqYBS4zSVw+0Q3kcHAIC4RLHHqnD1LDIqAq8f/iBrA5
        vAL+EjvebWWEWCYncfNcJ9hFnAIBEoemr2AGmSMh8JpN4vu/W6wQRS4SK29vZ4KwhSVeHd/C
        DmHLSFye3A11dbnE7hM32SGaWxglpjYegGqwlvizaiLYZmYBPolJ26YzgxwnIcAr0dEmBFHi
        IbHt0ntWiI8XA4Pi8C/WCYySCxgZVjGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmgdP/
        jn/dwbjvT9IhRgEORiUeXg7bVdFCrIllxZW5hxglOJiVRHi5y1ZHC/GmJFZWpRblxxeV5qQW
        H2KU5mBREufl00qLFhJITyxJzU5NLUgtgskycXBKNTBuLv8k+uOfjuEqUcUL5ntZ4if+7lZ8
        o8QezFE24eJDBsW/LIuzXNfxep902sSqrxPzVjB5/dfYsxuestxKDJ7icvvcVYZZly/LTPzT
        euQT+1be5DAVI0GW5G6BnQvWmvjLBb1MC8kymxWQuy2yLU90xeGKCOnW84udZi/WrKxZPelh
        mN43qxolluKMREMt5qLiRADvSGVr/gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xa7rzy1dHG6x5KGLRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlbFy/1XGgsOCFc9n9TI1MD7k62Lk
        5JAQMJGYOmUXC4gtJLCEUaKv2bOLkQvIbmSS2HS+lxkkwSZgLrH9aAtYkYiAm8SNxg4mkCJm
        gctMEp8X7GXtYuTgEBYIlzj0Th+khkVAVeL/xQ1sIDavgL/EjndbGSGWyUncPNcJNpNTIEDi
        0PQVzBCL/SWunJzJMoGRZwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAAN527OeWHYxd
        74IPMQpwMCrx8HLYrooWYk0sK67MPcQowcGsJMLLXbY6Wog3JbGyKrUoP76oNCe1+BCjNAeL
        kjjveYPKKCGB9MSS1OzU1ILUIpgsEwenVANjQ/yC0vcZ0z16nzTfXtLrJ1XknVLbLOR4/qt9
        nGdIVlPdw/2StlPeBc90fKu800KcVeVuLWcD3xq3ZS87ZsiaZbhfmnnjcsLXvR8vlR//8oHl
        34OGDUe83SxiPOV4bnLcY89Ys7dGYuPDebqfApaVfxC+cuRsn3Sj1v/I1ewLQixfBej+DTil
        xFKckWioxVxUnAgA5orYTFwCAAA=
X-CMS-MailID: 20180926121215eucas1p10437d5bd9db81bedbcc363d24d196ded
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121215eucas1p10437d5bd9db81bedbcc363d24d196ded
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121215eucas1p10437d5bd9db81bedbcc363d24d196ded@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In uprobes generic code, an arch specific software breakpoint instruction
is statically assigned with a #define statement. It does not allow to
examine the context and set the proper arch on runtime, which is the case
of uprobing either a 32 or 64 bit app on a 64-bit kernel. Introduce
get_swbp_insn() with weak attribute that will allow to be redefined in
ARM64 uprobes code.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 include/linux/uprobes.h |  1 +
 kernel/events/uprobes.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index bb9d208..8c2fdd9 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -117,6 +117,7 @@ struct uprobes_state {
 
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
+extern uprobe_opcode_t get_swbp_insn(void);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
 extern bool is_trap_insn(uprobe_opcode_t *insn);
 extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3207a4d..a2c3e62 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -216,6 +216,16 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 }
 
 /**
+ * get_swbp_insn - return breakpoint instruction.
+ * Default implementation of get_swbp_insn
+ * Returns architecture-dependent breakpoint instruction opcode
+ */
+uprobe_opcode_t __weak get_swbp_insn(void)
+{
+	return UPROBE_SWBP_INSN;
+}
+
+/**
  * is_swbp_insn - check if instruction is breakpoint instruction.
  * @insn: instruction to be checked.
  * Default implementation of is_swbp_insn
@@ -1181,7 +1191,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 static struct xol_area *__create_xol_area(unsigned long vaddr)
 {
 	struct mm_struct *mm = current->mm;
-	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
+	uprobe_opcode_t insn = get_swbp_insn();
 	struct xol_area *area;
 
 	area = kmalloc(sizeof(*area), GFP_KERNEL);
-- 
2.7.4

