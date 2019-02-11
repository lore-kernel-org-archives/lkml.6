Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D7520838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBKKxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:53:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:53:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAqkHa3499190
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:52:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAqksR3499187;
        Mon, 11 Feb 2019 02:52:46 -0800
Date:   Mon, 11 Feb 2019 02:52:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ira Weiny <tipbot@zytor.com>
Message-ID: <tip-ad8cfb9c42ef83ecf4079bc7d77e6557648e952b@git.kernel.org>
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@intel.com, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, ira.weiny@intel.com, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, ira.weiny@intel.com, hpa@zytor.com,
          torvalds@linux-foundation.org, dave.hansen@intel.com,
          akpm@linux-foundation.org, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, bp@alien8.de,
          peterz@infradead.org, mingo@kernel.org, dan.j.williams@intel.com
In-Reply-To: <20190210223424.13934-1-ira.weiny@intel.com>
References: <20190210223424.13934-1-ira.weiny@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] mm/gup: Remove the 'write' parameter from
 gup_fast_permitted()
Git-Commit-ID: ad8cfb9c42ef83ecf4079bc7d77e6557648e952b
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

Commit-ID:  ad8cfb9c42ef83ecf4079bc7d77e6557648e952b
Gitweb:     https://git.kernel.org/tip/ad8cfb9c42ef83ecf4079bc7d77e6557648e952b
Author:     Ira Weiny <ira.weiny@intel.com>
AuthorDate: Sun, 10 Feb 2019 14:34:24 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 08:20:40 +0100

mm/gup: Remove the 'write' parameter from gup_fast_permitted()

The 'write' parameter is unused in gup_fast_permitted() so remove it.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20190210223424.13934-1-ira.weiny@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_64.h | 3 +--
 mm/gup.c                          | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9c85b54bf03c..0bb566315621 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -259,8 +259,7 @@ extern void init_extra_mapping_uc(unsigned long phys, unsigned long size);
 extern void init_extra_mapping_wb(unsigned long phys, unsigned long size);
 
 #define gup_fast_permitted gup_fast_permitted
-static inline bool gup_fast_permitted(unsigned long start, int nr_pages,
-		int write)
+static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..b63e88eca31b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1786,7 +1786,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
  * Check if it's allowed to use __get_user_pages_fast() for the range, or
  * we need to fall back to the slow version:
  */
-bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
@@ -1828,7 +1828,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * block IPIs that come from THPs splitting.
 	 */
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_save(flags);
 		gup_pgd_range(start, end, write, pages, &nr);
 		local_irq_restore(flags);
@@ -1870,7 +1870,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
 		gup_pgd_range(addr, end, write, pages, &nr);
 		local_irq_enable();
