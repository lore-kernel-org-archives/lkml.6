Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790660-2-16301553014690283605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790660; b=SumM/CIkDXQE2PCHGK9XWM9yiZrlCLNx2M7DX+05rO+zJEy
    psEbVb2Sh/TeQ1UMlcXtY5B9IKivWaNnSXMVKzmNk2DBihH/l3UDInyjXbZ5gsEZ
    nWYn0hdkCb+yEiLn1a+OWuGLcpnOVC3YC6zWxebDOI8pp5slfkCqYg8sRSwx1KGU
    xLBKUnHQo5JZAEPgHtboN39MDg6h1mXS6WqEMP3clBepMBv3MMG9neuC8caOvDDU
    /T83OBQcBotxsj8tt6EtjbNkhWusV/x9PEMPTHraDMFCjv+U295E+RGgVNaT/tOp
    QjVdWHrXt/w0dStuMxOwtNXUQtPpvdUMaTcAOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790660;
    bh=9AGPVua7FerW9MHbnW3GGajj8cb4hN8hkiOyT6YzHrQ=; b=Lfz8k7f2GOCb
    88q2D840jasSYhF8JyB+Mm4UV5aa/xMUxIKlwihtfhPrP0bvdne62W6IBolzMLen
    Wb96dERlYHgftoefgAW748/zqQ5LUi9C8xl0X2uHOWZJrF6Cem/WJFesL+LiGcLx
    Ppcml0H85tkUcrT9iVDSkoaFxaKEvx3DZmKznPKkW0WqZ4trNjIy9cRTGNoA/qk1
    bJtvqgrLHD38o7oAkueMS6ecAMcRf5wlCUx/Wxs431IEzSxB+b0cZ0nLWbJBQ6Gb
    VKEVFsglUX45LMb/uCpNto1erja/vFAdVWVK2hW/KmTx+q+sF2xJJf4NXJRH8SED
    44cYsMDOIg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DgNjoIR8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GJ05QnnV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DgNjoIR8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GJ05QnnV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeB1D6f (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:35 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43072 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbeB1D6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:32 -0500
X-Google-Smtp-Source: AH8x224QwyjU2+Hp9QVT8vm8vMuWqKIhQOJJDw2FO6iottKghpCQpD2EKoSGdMNf9sP9zlpiTLyarQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jessica Yu <jeyu@redhat.com>, Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 08/29] module: extend 'rodata=off' boot cmdline parameter to module mappings
Date: Wed, 28 Feb 2018 11:56:30 +0800
Message-Id: <1519790211-16582-9-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

commit 39290b389ea upstream.

The current "rodata=off" parameter disables read-only kernel mappings
under CONFIG_DEBUG_RODATA:
    commit d2aa1acad22f ("mm/init: Add 'rodata=off' boot cmdline parameter
    to disable read-only kernel mappings")

This patch is a logical extension to module mappings ie. read-only mappings
at module loading can be disabled even if CONFIG_DEBUG_SET_MODULE_RONX
(mainly for debug use). Please note, however, that it only affects RO/RW
permissions, keeping NX set.

This is the first step to make CONFIG_DEBUG_SET_MODULE_RONX mandatory
(always-on) in the future as CONFIG_DEBUG_RODATA on x86 and arm64.

Suggested-by: and Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Link: http://lkml.kernel.org/r/20161114061505.15238-1-takahiro.akashi@linaro.org
Signed-off-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	keeping kaiser.h in init/main.c
---
 include/linux/init.h |  3 +++
 init/main.c          |  7 +++++--
 kernel/module.c      | 20 +++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 8e346d1..4dfe300 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -133,6 +133,9 @@ void prepare_namespace(void);
 void __init load_default_modules(void);
 int __init init_rootfs(void);
 
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_DEBUG_SET_MODULE_RONX)
+extern bool rodata_enabled;
+#endif
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void);
 #endif
diff --git a/init/main.c b/init/main.c
index 99f0265..f22957a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -81,6 +81,7 @@
 #include <linux/proc_ns.h>
 #include <linux/io.h>
 #include <linux/kaiser.h>
+#include <linux/cache.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -914,14 +915,16 @@ static int try_to_run_init_process(const char *init_filename)
 
 static noinline void __init kernel_init_freeable(void);
 
-#ifdef CONFIG_DEBUG_RODATA
-static bool rodata_enabled = true;
+#if defined(CONFIG_DEBUG_RODATA) || defined(CONFIG_SET_MODULE_RONX)
+bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
 {
 	return strtobool(str, &rodata_enabled);
 }
 __setup("rodata=", set_debug_rodata);
+#endif
 
+#ifdef CONFIG_DEBUG_RODATA
 static void mark_readonly(void)
 {
 	if (rodata_enabled)
diff --git a/kernel/module.c b/kernel/module.c
index 07bfb99..0651f2d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1911,6 +1911,9 @@ static void frob_writable_data(const struct module_layout *layout,
 /* livepatching wants to disable read-only so it can frob module. */
 void module_disable_ro(const struct module *mod)
 {
+	if (!rodata_enabled)
+		return;
+
 	frob_text(&mod->core_layout, set_memory_rw);
 	frob_rodata(&mod->core_layout, set_memory_rw);
 	frob_ro_after_init(&mod->core_layout, set_memory_rw);
@@ -1920,6 +1923,9 @@ void module_disable_ro(const struct module *mod)
 
 void module_enable_ro(const struct module *mod, bool after_init)
 {
+	if (!rodata_enabled)
+		return;
+
 	frob_text(&mod->core_layout, set_memory_ro);
 	frob_rodata(&mod->core_layout, set_memory_ro);
 	frob_text(&mod->init_layout, set_memory_ro);
@@ -1952,6 +1958,9 @@ void set_all_modules_text_rw(void)
 {
 	struct module *mod;
 
+	if (!rodata_enabled)
+		return;
+
 	mutex_lock(&module_mutex);
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
@@ -1968,6 +1977,9 @@ void set_all_modules_text_ro(void)
 {
 	struct module *mod;
 
+	if (!rodata_enabled)
+		return;
+
 	mutex_lock(&module_mutex);
 	list_for_each_entry_rcu(mod, &modules, list) {
 		if (mod->state == MODULE_STATE_UNFORMED)
@@ -1981,10 +1993,12 @@ void set_all_modules_text_ro(void)
 
 static void disable_ro_nx(const struct module_layout *layout)
 {
-	frob_text(layout, set_memory_rw);
-	frob_rodata(layout, set_memory_rw);
+	if (rodata_enabled) {
+		frob_text(layout, set_memory_rw);
+		frob_rodata(layout, set_memory_rw);
+		frob_ro_after_init(layout, set_memory_rw);
+	}
 	frob_rodata(layout, set_memory_x);
-	frob_ro_after_init(layout, set_memory_rw);
 	frob_ro_after_init(layout, set_memory_x);
 	frob_writable_data(layout, set_memory_x);
 }
-- 
2.7.4
