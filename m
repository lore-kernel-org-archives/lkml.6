Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B96D26212
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIqltt5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B96D26212
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934351AbeFYWmA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:42:00 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:45751 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934290AbeFYWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:55 -0400
Received: by mail-ua0-f202.google.com with SMTP id n7-v6so4559015uak.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=YZtwxOCWQG9zzuB4MmeU+g0a2U4PhBZltez3EVA7Gyc=;
        b=QIqltt5xU3+HE/Lad39owEuAytloXCAyGHidtz/LtDDTbLj5Th0zZTPNRDk1EO/QHA
         L4ZgyO1TQ64shXJIUaKiUWHv+fdNYjTaVY4TEzdSC7xjVLIj1ult50Rv2GRL3XGus0Wt
         hah8ii23JRpI5vp5SXpiaJ/xDEKiFMGOW+P1XAmCbfeGAhEzI60QCEYSNISRLzcgwlZg
         HIm5+59z98BzBevLB5VRaokhA3KsYciV0wvPH6m+RclmBRdbFWbWOY2LvFfDbBKF3l7Y
         HuOSD2ukWbm3rokqaVaDmoasHKeos0z9LRFEegIdWVDy02O+hEghCQr5FINIcKMUkV5l
         aaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=YZtwxOCWQG9zzuB4MmeU+g0a2U4PhBZltez3EVA7Gyc=;
        b=rYoxYnh2e3oEFuiZr9UJtMWlZkaKxo9VwX05uQhQDI11dlVL+ACwcCLWb96fU6MSLh
         U262ZBvfnF7kvTQvWX3vDtGmMCRgRmcgqyf2El0Au0ST2nDa2OLAOay8Bkqv/FyvAjH3
         ZgDjrPkslVkjt8p0NjYeijXOhyORYmUZ8NIikmuEblznnmtU4z4PLaKwWMCK3fc1Bel5
         KNtCQTgynoQSB3bpbmzVMl5MHFbkLrjaAaZMjsAi225vcWRSzFmEt+snlKQiI5Rd/J1r
         XDND/05+5pArk4mRTIrtbGO9+Fo361fIZA/OeXCPJjieO8uyLcBhKr+P3SHzhW3YThUk
         D+cQ==
X-Gm-Message-State: APt69E37Hc9gqz70/D5wyBuzkVPxLLLx6ryoIcyxqn8DMOd9WNpsjTqe
        Si7aVH/UVTzwnnPVP29EMowgjxtyUDaxhw==
X-Google-Smtp-Source: ADUXVKKArWleXolVizv3RP1IDn74c6KuG50B70SZ9jcW48mOsbqyKmkY/U1rmau7bq4bLirjGxlyVgXBv1MpXA==
MIME-Version: 1.0
X-Received: by 2002:a1f:cf41:: with SMTP id f62-v6mr6657092vkg.29.1529966514067;
 Mon, 25 Jun 2018 15:41:54 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:39:03 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-16-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 15/27] compiler: Option to default to hidden symbols
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Li <sparse@chrisli.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to default visibility to hidden except for key
symbols. This option is disabled by default and will be used by x86_64
PIE support to remove errors between compilation units.

The default visibility is also enabled for external symbols that are
compared as they maybe equals (start/end of sections). In this case,
older versions of GCC will remove the comparison if the symbols are
hidden. This issue exists at least on gcc 4.9 and before.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/boot/boot.h                 |  2 +-
 arch/x86/include/asm/setup.h         |  2 +-
 arch/x86/kernel/cpu/microcode/core.c |  4 ++--
 drivers/base/firmware_loader/main.c  |  4 ++--
 include/asm-generic/sections.h       |  6 ++++++
 include/linux/compiler.h             |  7 +++++++
 init/Kconfig                         |  7 +++++++
 kernel/kallsyms.c                    | 16 ++++++++--------
 kernel/trace/trace.h                 |  4 ++--
 lib/dynamic_debug.c                  |  4 ++--
 10 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ef5a9cc66fb8..d726c35bdd96 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -193,7 +193,7 @@ static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 }
 
 /* Heap -- available for dynamic lists. */
-extern char _end[];
+extern char _end[] __default_visibility;
 extern char *HEAP;
 extern char *heap_end;
 #define RESET_HEAP() ((void *)( HEAP = _end ))
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc974416..083a6e99b884 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -68,7 +68,7 @@ static inline void x86_ce4100_early_setup(void) { }
  * This is set up by the setup-routine at boot-time
  */
 extern struct boot_params boot_params;
-extern char _text[];
+extern char _text[] __default_visibility;
 
 static inline bool kaslr_enabled(void)
 {
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 08286269fd24..3ed2f9d54abb 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -149,8 +149,8 @@ static bool __init check_loader_disabled_bsp(void)
 	return *res;
 }
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+extern struct builtin_fw __start_builtin_fw[] __default_visibility;
+extern struct builtin_fw __end_builtin_fw[] __default_visibility;
 
 bool get_builtin_firmware(struct cpio_data *cd, const char *name)
 {
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 0943e7065e0e..2ffd019af2d4 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -94,8 +94,8 @@ static struct firmware_cache fw_cache;
 
 #ifdef CONFIG_FW_LOADER
 
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
+extern struct builtin_fw __start_builtin_fw[] __default_visibility;
+extern struct builtin_fw __end_builtin_fw[] __default_visibility;
 
 static void fw_copy_to_prealloc_buf(struct firmware *fw,
 				    void *buf, size_t size)
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 849cd8eb5ca0..0a0e23405ddd 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -32,6 +32,9 @@
  *	__softirqentry_text_start, __softirqentry_text_end
  *	__start_opd, __end_opd
  */
+#ifdef CONFIG_DEFAULT_HIDDEN
+#pragma GCC visibility push(default)
+#endif
 extern char _text[], _stext[], _etext[];
 extern char _data[], _sdata[], _edata[];
 extern char __bss_start[], __bss_stop[];
@@ -49,6 +52,9 @@ extern char __start_once[], __end_once[];
 
 /* Start and end of .ctors section - used for constructor calls. */
 extern char __ctors_start[], __ctors_end[];
+#ifdef CONFIG_DEFAULT_HIDDEN
+#pragma GCC visibility pop
+#endif
 
 /* Start and end of .opd section - used for function descriptors. */
 extern char __start_opd[], __end_opd[];
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 42506e4d1f53..d9837a58906e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -278,6 +278,13 @@ unsigned long read_word_at_a_time(const void *addr)
 	__u.__val;					\
 })
 
+#ifdef CONFIG_DEFAULT_HIDDEN
+#pragma GCC visibility push(hidden)
+#define __default_visibility  __attribute__((visibility ("default")))
+#else
+#define __default_visibility
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/init/Kconfig b/init/Kconfig
index 24b60536e26b..d4f90cc38ede 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1718,6 +1718,13 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+#
+# Default to hidden visibility for all symbols.
+# Useful for Position Independent Code to reduce global references.
+#
+config DEFAULT_HIDDEN
+	bool
+
 source "arch/Kconfig"
 
 endmenu		# General setup
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a23e21ada81b..f4e58b7a6daf 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -29,24 +29,24 @@
  * These will be re-linked against their real values
  * during the second link stage.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[] __weak __default_visibility;
+extern const int kallsyms_offsets[] __weak __default_visibility;
+extern const u8 kallsyms_names[] __weak __default_visibility;
 
 /*
  * Tell the compiler that the count isn't in the small data section if the arch
  * has one (eg: FRV).
  */
 extern const unsigned long kallsyms_num_syms
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".rodata"))) __default_visibility;
 
 extern const unsigned long kallsyms_relative_base
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".rodata"))) __default_visibility;
 
-extern const u8 kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const u8 kallsyms_token_table[] __weak __default_visibility;
+extern const u16 kallsyms_token_index[] __weak __default_visibility;
 
-extern const unsigned long kallsyms_markers[] __weak;
+extern const unsigned long kallsyms_markers[] __weak __default_visibility;
 
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 630c5a24b2b2..8dcfcf6961bc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1751,8 +1751,8 @@ extern int trace_event_enable_disable(struct trace_event_file *file,
 				      int enable, int soft_disable);
 extern int tracing_alloc_snapshot(void);
 
-extern const char *__start___trace_bprintk_fmt[];
-extern const char *__stop___trace_bprintk_fmt[];
+extern const char *__start___trace_bprintk_fmt[] __default_visibility;
+extern const char *__stop___trace_bprintk_fmt[] __default_visibility;
 
 extern const char *__start___tracepoint_str[];
 extern const char *__stop___tracepoint_str[];
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c7c96bc7654a..40b752b53627 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -37,8 +37,8 @@
 #include <linux/device.h>
 #include <linux/netdevice.h>
 
-extern struct _ddebug __start___verbose[];
-extern struct _ddebug __stop___verbose[];
+extern struct _ddebug __start___verbose[] __default_visibility;
+extern struct _ddebug __stop___verbose[] __default_visibility;
 
 struct ddebug_table {
 	struct list_head link;
-- 
2.18.0.rc2.346.g013aa6912e-goog

