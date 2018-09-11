Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B0DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD97D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD97D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeIKLS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:18:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeIKLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:18:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8B6Kcfj2135623
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 23:20:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8B6KcJu2135620;
        Mon, 10 Sep 2018 23:20:38 -0700
Date:   Mon, 10 Sep 2018 23:20:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chao Fan <tipbot@zytor.com>
Message-ID: <tip-44060e8a5189fd79220a94422b82cccc49a85e91@git.kernel.org>
Cc:     douly.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de, bhe@redhat.com
Reply-To: torvalds@linux-foundation.org, bhe@redhat.com,
          peterz@infradead.org, tglx@linutronix.de,
          fanc.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180807015705.21697-1-fanc.fnst@cn.fujitsu.com>
References: <20180807015705.21697-1-fanc.fnst@cn.fujitsu.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Remove return value from
 handle_mem_options()
Git-Commit-ID: 44060e8a5189fd79220a94422b82cccc49a85e91
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

Commit-ID:  44060e8a5189fd79220a94422b82cccc49a85e91
Gitweb:     https://git.kernel.org/tip/44060e8a5189fd79220a94422b82cccc49a85e91
Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
AuthorDate: Tue, 7 Aug 2018 09:57:05 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 15:07:11 +0200

x86/boot/KASLR: Remove return value from handle_mem_options()

It's not used by its sole user, so remove this unused functionality.

Also remove a stray unused variable that GCC didn't warn about for some reason.

Suggested-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kirill.shutemov@linux.intel.com
Link: http://lkml.kernel.org/r/20180807015705.21697-1-fanc.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d1e19f358b6e..9ed9709d9947 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -241,7 +241,7 @@ static void parse_gb_huge_pages(char *param, char *val)
 }
 
 
-static int handle_mem_options(void)
+static void handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -251,7 +251,7 @@ static int handle_mem_options(void)
 
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
 		!strstr(args, "hugepages"))
-		return 0;
+		return;
 
 	tmp_cmdline = malloc(len + 1);
 	if (!tmp_cmdline)
@@ -269,8 +269,7 @@ static int handle_mem_options(void)
 		/* Stop at -- */
 		if (!val && strcmp(param, "--") == 0) {
 			warn("Only '--' specified in cmdline");
-			free(tmp_cmdline);
-			return -1;
+			goto out;
 		}
 
 		if (!strcmp(param, "memmap")) {
@@ -283,16 +282,16 @@ static int handle_mem_options(void)
 			if (!strcmp(p, "nopentium"))
 				continue;
 			mem_size = memparse(p, &p);
-			if (mem_size == 0) {
-				free(tmp_cmdline);
-				return -EINVAL;
-			}
+			if (mem_size == 0)
+				goto out;
+
 			mem_limit = mem_size;
 		}
 	}
 
+out:
 	free(tmp_cmdline);
-	return 0;
+	return;
 }
 
 /*
@@ -578,7 +577,6 @@ static void process_mem_region(struct mem_vector *entry,
 			       unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	struct slot_area slot_area;
 	unsigned long start_orig, end;
 	struct mem_vector cur_entry;
 
