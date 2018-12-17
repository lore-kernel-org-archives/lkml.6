Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE303C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810E721783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388956AbeLQS02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:26:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbeLQS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:26:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBHIQ14T2563437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Dec 2018 10:26:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBHIQ1aP2563434;
        Mon, 17 Dec 2018 10:26:01 -0800
Date:   Mon, 17 Dec 2018 10:26:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-3c567356dbe0da4fc310cfcffafc39526e1ca43a@git.kernel.org>
Cc:     peterz@infradead.org, riel@surriel.com, mingo@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, bp@alien8.de,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, dave.hansen@linux.intel.com, riel@surriel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de,
          torvalds@linux-foundation.org, hpa@zytor.com, luto@kernel.org,
          tglx@linutronix.de
In-Reply-To: <20181203171043.695039210@infradead.org>
References: <20181203171043.695039210@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Rename @addrinarray to @numpages
Git-Commit-ID: 3c567356dbe0da4fc310cfcffafc39526e1ca43a
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

Commit-ID:  3c567356dbe0da4fc310cfcffafc39526e1ca43a
Gitweb:     https://git.kernel.org/tip/3c567356dbe0da4fc310cfcffafc39526e1ca43a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 3 Dec 2018 18:03:53 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Dec 2018 18:54:30 +0100

x86/mm/cpa: Rename @addrinarray to @numpages

The CPA_ARRAY interface works in single pages, and everything, except
in these 'few' locations is this variable called 'numpages'.

Remove this 'addrinarray' abberation and use 'numpages' consistently.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom.StDenis@amd.com
Cc: dave.hansen@intel.com
Link: http://lkml.kernel.org/r/20181203171043.695039210@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pageattr.c | 52 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 7d05149995dc..df4340c8e293 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1808,14 +1808,14 @@ out_err:
 }
 EXPORT_SYMBOL(set_memory_uc);
 
-static int _set_memory_array(unsigned long *addr, int addrinarray,
+static int _set_memory_array(unsigned long *addr, int numpages,
 		enum page_cache_mode new_type)
 {
 	enum page_cache_mode set_type;
 	int i, j;
 	int ret;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		ret = reserve_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE,
 					new_type, NULL);
 		if (ret)
@@ -1826,11 +1826,11 @@ static int _set_memory_array(unsigned long *addr, int addrinarray,
 	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
 				_PAGE_CACHE_MODE_UC_MINUS : new_type;
 
-	ret = change_page_attr_set(addr, addrinarray,
+	ret = change_page_attr_set(addr, numpages,
 				   cachemode2pgprot(set_type), 1);
 
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(addr, addrinarray,
+		ret = change_page_attr_set_clr(addr, numpages,
 					       cachemode2pgprot(
 						_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
@@ -1847,21 +1847,21 @@ out_free:
 	return ret;
 }
 
-int set_memory_array_uc(unsigned long *addr, int addrinarray)
+int set_memory_array_uc(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_UC_MINUS);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_UC_MINUS);
 }
 EXPORT_SYMBOL(set_memory_array_uc);
 
-int set_memory_array_wc(unsigned long *addr, int addrinarray)
+int set_memory_array_wc(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_WC);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WC);
 }
 EXPORT_SYMBOL(set_memory_array_wc);
 
-int set_memory_array_wt(unsigned long *addr, int addrinarray)
+int set_memory_array_wt(unsigned long *addr, int numpages)
 {
-	return _set_memory_array(addr, addrinarray, _PAGE_CACHE_MODE_WT);
+	return _set_memory_array(addr, numpages, _PAGE_CACHE_MODE_WT);
 }
 EXPORT_SYMBOL_GPL(set_memory_array_wt);
 
@@ -1941,18 +1941,18 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
-int set_memory_array_wb(unsigned long *addr, int addrinarray)
+int set_memory_array_wb(unsigned long *addr, int numpages)
 {
 	int i;
 	int ret;
 
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	ret = change_page_attr_clear(addr, addrinarray,
+	ret = change_page_attr_clear(addr, numpages,
 				      __pgprot(_PAGE_CACHE_MASK), 1);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < addrinarray; i++)
+	for (i = 0; i < numpages; i++)
 		free_memtype(__pa(addr[i]), __pa(addr[i]) + PAGE_SIZE);
 
 	return 0;
@@ -2082,7 +2082,7 @@ int set_pages_uc(struct page *page, int numpages)
 }
 EXPORT_SYMBOL(set_pages_uc);
 
-static int _set_pages_array(struct page **pages, int addrinarray,
+static int _set_pages_array(struct page **pages, int numpages,
 		enum page_cache_mode new_type)
 {
 	unsigned long start;
@@ -2092,7 +2092,7 @@ static int _set_pages_array(struct page **pages, int addrinarray,
 	int free_idx;
 	int ret;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		if (PageHighMem(pages[i]))
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
@@ -2105,10 +2105,10 @@ static int _set_pages_array(struct page **pages, int addrinarray,
 	set_type = (new_type == _PAGE_CACHE_MODE_WC) ?
 				_PAGE_CACHE_MODE_UC_MINUS : new_type;
 
-	ret = cpa_set_pages_array(pages, addrinarray,
+	ret = cpa_set_pages_array(pages, numpages,
 				  cachemode2pgprot(set_type));
 	if (!ret && new_type == _PAGE_CACHE_MODE_WC)
-		ret = change_page_attr_set_clr(NULL, addrinarray,
+		ret = change_page_attr_set_clr(NULL, numpages,
 					       cachemode2pgprot(
 						_PAGE_CACHE_MODE_WC),
 					       __pgprot(_PAGE_CACHE_MASK),
@@ -2128,21 +2128,21 @@ err_out:
 	return -EINVAL;
 }
 
-int set_pages_array_uc(struct page **pages, int addrinarray)
+int set_pages_array_uc(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_UC_MINUS);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_UC_MINUS);
 }
 EXPORT_SYMBOL(set_pages_array_uc);
 
-int set_pages_array_wc(struct page **pages, int addrinarray)
+int set_pages_array_wc(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_WC);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WC);
 }
 EXPORT_SYMBOL(set_pages_array_wc);
 
-int set_pages_array_wt(struct page **pages, int addrinarray)
+int set_pages_array_wt(struct page **pages, int numpages)
 {
-	return _set_pages_array(pages, addrinarray, _PAGE_CACHE_MODE_WT);
+	return _set_pages_array(pages, numpages, _PAGE_CACHE_MODE_WT);
 }
 EXPORT_SYMBOL_GPL(set_pages_array_wt);
 
@@ -2154,7 +2154,7 @@ int set_pages_wb(struct page *page, int numpages)
 }
 EXPORT_SYMBOL(set_pages_wb);
 
-int set_pages_array_wb(struct page **pages, int addrinarray)
+int set_pages_array_wb(struct page **pages, int numpages)
 {
 	int retval;
 	unsigned long start;
@@ -2162,12 +2162,12 @@ int set_pages_array_wb(struct page **pages, int addrinarray)
 	int i;
 
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-	retval = cpa_clear_pages_array(pages, addrinarray,
+	retval = cpa_clear_pages_array(pages, numpages,
 			__pgprot(_PAGE_CACHE_MASK));
 	if (retval)
 		return retval;
 
-	for (i = 0; i < addrinarray; i++) {
+	for (i = 0; i < numpages; i++) {
 		if (PageHighMem(pages[i]))
 			continue;
 		start = page_to_pfn(pages[i]) << PAGE_SHIFT;
