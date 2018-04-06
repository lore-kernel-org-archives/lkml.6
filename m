Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx498P/gUGv0xPMGxl/rHx2Ep47M4/jaS8/2hSoMeW0LLf/PHtR3QcltigCDQVuv0ZaPKFjH5
ARC-Seal: i=1; a=rsa-sha256; t=1523021693; cv=none;
        d=google.com; s=arc-20160816;
        b=JBdBGizd6b3npAHl/o3UP7amXtBN5mO0XHYNwWiLTofSvt/gKtOfsLuhaziSBlW0RL
         pDgEdG2U+inFDIZQoudTrBf8PvcC1FXui/TlCGUQJhRY0E1fWoyDeSKZXmwTmmECiFQb
         jJdt6EBrM8H1PQDKfDbDa9uGmV0/Ty/m0rZ264YUQOjXgi2YSk/3olIa2Eb9ewh7ZgvT
         zt7QTyXT/z6GXedctMj0zI9WymmS8bgLyFQ7Wuh3DLno2VMGskPve6OEgFNo0xaaP9bl
         eMXSdW59MKEPV8sxJuTI/Gydh8VHYaPH3Et0Kdi0aOkP0HA9PJ0kWxpwLWqICb5ngjOA
         YoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VOTBAD94XvamumPSPxiRicatM2xNDlaZjtR0lhWIgi8=;
        b=RR5qRh1IOURTFStz8EN7BDh0e148ecDbWQwPRQZdjfQ2mcwhDv31FL/6dYuuMX5r42
         mBHREYj7PYBxaXoGkfWSvt+zFhsqfbFrnnvOIZ8mUInkWVgMgQCH7yFaPqEKAtoAOuBf
         6XUzexKoSzikBCwVrjHoPs1ZNOucwc3+6UtOaNkjlgYsxaziPEKsuG/drxZ9wYE3C6Pf
         g8IwXG3z9Xrsmc/B0O1AfeamfoPjYvpOXKjSA5wYaW0aQ6P5QN4CJ6X32niGW6rrqefD
         +nAxzb0CGz+K8TFtrLFOu+hNOwEPhuh5QE65TzC8gizgr4rPei4YE6HFVjx1JnoJG1WN
         4ISw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"and Acked-by: Mark Rutland" <mark.rutland@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jessica Yu <jeyu@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 4.9 056/102] module: extend rodata=off boot cmdline parameter to module mappings
Date: Fri,  6 Apr 2018 15:23:37 +0200
Message-Id: <20180406084339.504156219@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003994999812012?=
X-GMAIL-MSGID: =?utf-8?q?1597003994999812012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/init.h |    3 +++
 init/main.c          |    7 +++++--
 kernel/module.c      |   20 +++++++++++++++++---
 3 files changed, 25 insertions(+), 5 deletions(-)

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
--- a/init/main.c
+++ b/init/main.c
@@ -81,6 +81,7 @@
 #include <linux/proc_ns.h>
 #include <linux/io.h>
 #include <linux/kaiser.h>
+#include <linux/cache.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -914,14 +915,16 @@ static int try_to_run_init_process(const
 
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
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1911,6 +1911,9 @@ static void frob_writable_data(const str
 /* livepatching wants to disable read-only so it can frob module. */
 void module_disable_ro(const struct module *mod)
 {
+	if (!rodata_enabled)
+		return;
+
 	frob_text(&mod->core_layout, set_memory_rw);
 	frob_rodata(&mod->core_layout, set_memory_rw);
 	frob_ro_after_init(&mod->core_layout, set_memory_rw);
@@ -1920,6 +1923,9 @@ void module_disable_ro(const struct modu
 
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
