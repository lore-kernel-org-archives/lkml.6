Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA03C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795020811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E795020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLKKef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:34:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40527 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:34:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBAYSBx3948574
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 02:34:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBAYSv33948571;
        Tue, 11 Dec 2018 02:34:28 -0800
Date:   Tue, 11 Dec 2018 02:34:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-254eb5505ca0ca749d3a491fc6668b6c16647a99@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, kirill.shutemov@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20181130202328.65359-3-kirill.shutemov@linux.intel.com>
References: <20181130202328.65359-3-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/dump_pagetables: Fix LDT remap address marker
Git-Commit-ID: 254eb5505ca0ca749d3a491fc6668b6c16647a99
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  254eb5505ca0ca749d3a491fc6668b6c16647a99
Gitweb:     https://git.kernel.org/tip/254eb5505ca0ca749d3a491fc6668b6c16647a99
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 30 Nov 2018 23:23:28 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 11 Dec 2018 11:19:24 +0100

x86/dump_pagetables: Fix LDT remap address marker

The LDT remap placement has been changed. It's now placed before the direct
mapping in the kernel virtual address space for both paging modes.

Change address markers order accordingly.

Fixes: d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: hans.van.kranenburg@mendix.com
Cc: linux-mm@kvack.org
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20181130202328.65359-3-kirill.shutemov@linux.intel.com

---
 arch/x86/mm/dump_pagetables.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index dad153e5a427..abcb8d00b014 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -55,10 +55,10 @@ struct addr_marker {
 enum address_markers_idx {
 	USER_SPACE_NR = 0,
 	KERNEL_SPACE_NR,
-	LOW_KERNEL_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && defined(CONFIG_X86_5LEVEL)
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
 	LDT_NR,
 #endif
+	LOW_KERNEL_NR,
 	VMALLOC_START_NR,
 	VMEMMAP_START_NR,
 #ifdef CONFIG_KASAN
@@ -66,9 +66,6 @@ enum address_markers_idx {
 	KASAN_SHADOW_END_NR,
 #endif
 	CPU_ENTRY_AREA_NR,
-#if defined(CONFIG_MODIFY_LDT_SYSCALL) && !defined(CONFIG_X86_5LEVEL)
-	LDT_NR,
-#endif
 #ifdef CONFIG_X86_ESPFIX64
 	ESPFIX_START_NR,
 #endif
