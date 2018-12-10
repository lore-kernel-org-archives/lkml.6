Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450EEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FB52064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FB52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucloud.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeLJQqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:46:23 -0500
Received: from m97188.mail.qiye.163.com ([220.181.97.188]:38331 "EHLO
        m97188.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLJQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:46:22 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 11:46:20 EST
Received: from localhost (unknown [114.241.220.134])
        by m97188.mail.qiye.163.com (Hmail) with ESMTPA id 6BF619628EA;
        Tue, 11 Dec 2018 00:37:31 +0800 (CST)
From:   WANG Chao <chao.wang@ucloud.cn>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Borislav Petkov <bp@suse.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        srinivas.eeda@oracle.com
Subject: [PATCH] treewide: replace RETPOLINE with CONFIG_RETPOLINE
Date:   Tue, 11 Dec 2018 00:37:25 +0800
Message-Id: <20181210163725.95977-1-chao.wang@ucloud.cn>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1ktWUFJV1koWUFJQjdXWQgYFAkeWUFLVUtXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kSHx4VD1lBWUc6MFE6HRw*IjkBNE8sLVE9FCNOC0wwCS9VSlVKTk9P
        T05CQ05ITUtJVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZDB4ZWUEdGhcIHldZCAFZQUhC
        Tk83V1kSC1lBWUpKT1VJT0pVSUlLVUpIT1kG
X-HM-Tid: 0a6798fb16c120bckuqy6bf619628ea
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend
on compiler support"), RETPOLINE has been replaced by CONFIG_RETPOLINE.

Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
---
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 include/linux/compiler-gcc.h | 2 +-
 include/linux/module.h       | 2 +-
 scripts/mod/modpost.c        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 500278f5308e..e8abe3f6c10e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,7 +213,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2010493e1040..977ddf2774f9 100644
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
index fce6b4335e36..0c575f51fe57 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..5a5b3780456f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2157,7 +2157,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
 /* Cannot check for assembler */
 static void add_retpoline(struct buffer *b)
 {
-	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
 	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
 	buf_printf(b, "#endif\n");
 }
-- 
2.19.2

