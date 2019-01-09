Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67878C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E1121738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfAIKF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:05:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56239 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbfAIKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:05:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x09A4Xqi3907465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Jan 2019 02:04:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x09A4Tav3907460;
        Wed, 9 Jan 2019 02:04:29 -0800
Date:   Wed, 9 Jan 2019 02:04:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for WANG Chao <tipbot@zytor.com>
Message-ID: <tip-e4f358916d528d479c3c12bd2fd03f2d5a576380@git.kernel.org>
Cc:     keescook@chromium.org, chao.wang@ucloud.cn, jeyu@kernel.org,
        jkosina@suse.cz, hpa@zytor.com, luc.vanoostenryck@gmail.com,
        zhenzhong.duan@oracle.com, akpm@linux-foundation.org,
        michal.lkml@markovi.net, arnd@arndb.de, mingo@kernel.org,
        miguel.ojeda.sandonis@gmail.com, dwmw@amazon.co.uk, x86@kernel.org,
        luto@kernel.org, ak@linux.intel.com, yamada.masahiro@socionext.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        gor@linux.ibm.com, bp@suse.de, daniel@iogearbox.net,
        tim.c.chen@linux.intel.com, stable@vger.kernel.org,
        peterz@infradead.org, geert@linux-m68k.org, konrad.wilk@oracle.com
Reply-To: konrad.wilk@oracle.com, geert@linux-m68k.org,
          peterz@infradead.org, stable@vger.kernel.org,
          tim.c.chen@linux.intel.com, daniel@iogearbox.net, bp@suse.de,
          gor@linux.ibm.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
          luto@kernel.org, ak@linux.intel.com, dwmw@amazon.co.uk,
          x86@kernel.org, miguel.ojeda.sandonis@gmail.com,
          mingo@kernel.org, arnd@arndb.de, michal.lkml@markovi.net,
          akpm@linux-foundation.org, zhenzhong.duan@oracle.com,
          luc.vanoostenryck@gmail.com, hpa@zytor.com, jeyu@kernel.org,
          jkosina@suse.cz, chao.wang@ucloud.cn, keescook@chromium.org
In-Reply-To: <20181210163725.95977-1-chao.wang@ucloud.cn>
References: <20181210163725.95977-1-chao.wang@ucloud.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86, modpost: Replace last remnants of RETPOLINE
 with CONFIG_RETPOLINE
Git-Commit-ID: e4f358916d528d479c3c12bd2fd03f2d5a576380
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

Commit-ID:  e4f358916d528d479c3c12bd2fd03f2d5a576380
Gitweb:     https://git.kernel.org/tip/e4f358916d528d479c3c12bd2fd03f2d5a576380
Author:     WANG Chao <chao.wang@ucloud.cn>
AuthorDate: Tue, 11 Dec 2018 00:37:25 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 9 Jan 2019 10:35:56 +0100

x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

Commit

  4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")

replaced the RETPOLINE define with CONFIG_RETPOLINE checks. Remove the
remaining pieces.

 [ bp: Massage commit message. ]

Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org
Cc: srinivas.eeda@oracle.com
Cc: stable <stable@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181210163725.95977-1-chao.wang@ucloud.cn
---
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 include/linux/compiler-gcc.h | 2 +-
 include/linux/module.h       | 2 +-
 scripts/mod/modpost.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8654b8b0c848..1de0f4170178 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -215,7 +215,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5776da43da97..dd8268f5f5f0 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,7 +68,7 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 9a21fe3509af..8fa38d3e7538 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -828,7 +828,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0de2fb236640..26bf886bd168 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2185,7 +2185,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
 /* Cannot check for assembler */
 static void add_retpoline(struct buffer *b)
 {
-	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
 	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
 	buf_printf(b, "#endif\n");
 }
