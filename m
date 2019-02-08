Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FF820844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfBHNjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:39:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:39:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x18DcbpP2188805
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 05:38:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x18Dca762188801;
        Fri, 8 Feb 2019 05:38:36 -0800
Date:   Fri, 8 Feb 2019 05:38:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sergey Senozhatsky <tipbot@zytor.com>
Message-ID: <tip-ba2ba356b2c849ec62d5fefa9cd4168163b13211@git.kernel.org>
Cc:     sergey.senozhatsky.work@gmail.com, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, peterz@infradead.org,
        sergey.senozhatsky@gmail.com, luto@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, luto@kernel.org,
          sergey.senozhatsky@gmail.com, hpa@zytor.com,
          peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
          sergey.senozhatsky.work@gmail.com
In-Reply-To: <20190108130225.5066-1-sergey.senozhatsky@gmail.com>
References: <20190108130225.5066-1-sergey.senozhatsky@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/cpu_entry_area: Move
 percpu_setup_debug_store() to __init section
Git-Commit-ID: ba2ba356b2c849ec62d5fefa9cd4168163b13211
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

Commit-ID:  ba2ba356b2c849ec62d5fefa9cd4168163b13211
Gitweb:     https://git.kernel.org/tip/ba2ba356b2c849ec62d5fefa9cd4168163b13211
Author:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
AuthorDate: Tue, 8 Jan 2019 22:02:24 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 8 Feb 2019 14:32:33 +0100

x86/cpu_entry_area: Move percpu_setup_debug_store() to __init section

WARNING: vmlinux.o(.text.unlikely+0x498d): Section mismatch in reference
         from the function percpu_setup_debug_store() to the function
         .init.text:cea_map_percpu_pages()

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Link: https://lkml.kernel.org/r/20190108130225.5066-1-sergey.senozhatsky@gmail.com

---
 arch/x86/mm/cpu_entry_area.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 12d7e7fb4efd..19c6abf9ea31 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -52,7 +52,7 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
-static void percpu_setup_debug_store(int cpu)
+static void __init percpu_setup_debug_store(int cpu)
 {
 #ifdef CONFIG_CPU_SUP_INTEL
 	int npages;
