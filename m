Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A28ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9828820684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9828820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeGTAVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:21:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGTAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:21:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNYnJ82454219
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:34:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNYm9f2454216;
        Thu, 19 Jul 2018 16:34:48 -0700
Date:   Thu, 19 Jul 2018 16:34:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-4e8537e4a7a15402b87c424b22c25c9e59681d16@git.kernel.org>
Cc:     llong@redhat.com, jpoimboe@redhat.com, boris.ostrovsky@oracle.com,
        luto@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        jgross@suse.com, dhgutteridge@sympatico.ca, bp@alien8.de,
        dvlasenk@redhat.com, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, brgerst@gmail.com,
        jkosina@suse.cz, jroedel@suse.de, mingo@kernel.org,
        aarcange@redhat.com, linux-kernel@vger.kernel.org,
        eduval@amazon.com, dave.hansen@intel.com, pavel@ucw.cz,
        David.Laight@aculab.com, tglx@linutronix.de
Reply-To: David.Laight@aculab.com, pavel@ucw.cz, tglx@linutronix.de,
          eduval@amazon.com, linux-kernel@vger.kernel.org,
          aarcange@redhat.com, jroedel@suse.de, mingo@kernel.org,
          jkosina@suse.cz, dave.hansen@intel.com,
          gregkh@linuxfoundation.org, brgerst@gmail.com, hpa@zytor.com,
          peterz@infradead.org, luto@kernel.org, will.deacon@arm.com,
          llong@redhat.com, jpoimboe@redhat.com,
          boris.ostrovsky@oracle.com, bp@alien8.de, dvlasenk@redhat.com,
          torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
          jgross@suse.com
In-Reply-To: <1531906876-13451-32-git-send-email-joro@8bytes.org>
References: <1531906876-13451-32-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/dump_pagetables: Define INIT_PGD
Git-Commit-ID: 4e8537e4a7a15402b87c424b22c25c9e59681d16
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

Commit-ID:  4e8537e4a7a15402b87c424b22c25c9e59681d16
Gitweb:     https://git.kernel.org/tip/4e8537e4a7a15402b87c424b22c25c9e59681d16
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:08 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:46 +0200

x86/mm/dump_pagetables: Define INIT_PGD

Define INIT_PGD to point to the correct initial page-table for 32 and 64
bit and use it where needed. This fixes the build on 32 bit with
CONFIG_PAGE_TABLE_ISOLATION enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-32-git-send-email-joro@8bytes.org

---
 arch/x86/mm/dump_pagetables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2f3c9196b834..e6fd0cdef9ad 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -111,6 +111,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	((pgd_t *) &init_top_pgt)
+
 #else /* CONFIG_X86_64 */
 
 enum address_markers_idx {
@@ -139,6 +141,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	(swapper_pg_dir)
+
 #endif /* !CONFIG_X86_64 */
 
 /* Multipliers for offsets within the PTEs */
@@ -496,11 +500,7 @@ static inline bool is_hypervisor_range(int idx)
 static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 				       bool checkwx, bool dmesg)
 {
-#ifdef CONFIG_X86_64
-	pgd_t *start = (pgd_t *) &init_top_pgt;
-#else
-	pgd_t *start = swapper_pg_dir;
-#endif
+	pgd_t *start = INIT_PGD;
 	pgprotval_t prot, eff;
 	int i;
 	struct pg_state st = {};
@@ -566,7 +566,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 static void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pgd_t *pgd = (pgd_t *) &init_top_pgt;
+	pgd_t *pgd = INIT_PGD;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
