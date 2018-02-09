Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1472218-1518185523-2-9945757670835932076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185522; b=oHL6zySKOZcl5sYeNBvU5iKVkooJ9f8LNYvDtNFzofn9WxY
    3DLSeG5Qie5yP8FUxue7UPA2Xl0zTYUznKZr5cKq0t2noxIjOSrolZ1OrnXgexCk
    0eUQGt+ZUWu++pm3dYKLipbcmWj1SbSNxMXwpZ4d+Q7qBFeqMMDoSv90dNbbWI2v
    p38D7oEdCL9F/LrvN2RWuxdC3vT15ROyseFW50H7yj0feMEXW5NJJg5knrZ85WZU
    fyUuzNKguMUcV/JaHKp5LiIg0d67NKY4ctXf5yYKAwX+mHmrUi5+vzMPiZWwjVyi
    l3d7wqj1D5DlItcM0N04An4pPrMIensIbItrW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185522; bh=xfSejDediiu2WEb4W5TXzhIQ/3
    43HPUxBDvvG+4SSg0=; b=lyuhQEK8ZN+MQIwH7dCPwSllX0VJGQJNUxhbmflYEs
    IkHp24l7HkaMlvhfy/4LRhl/60AeGwA8OwTyA6ksFsVxZRKSNFMU7GH63eYxHbRn
    AQqZRfJ0nveAOplxdNDsOUKFLO4jXt+Di5e/G+j+J/ZXJdGk+3o5TkMd88xiMTje
    cCcxwUDwbyr+LgF1P/ndiP5P+AYWz7b9BvHeWkcnHm7zkNNXTAJN6Wpa8q/SQ42U
    /fhYzKXPkXaZyIHIhvor4+OdNuJBjt9QpNNqpyhAXWKaO3VQtEUMg1i5hTfveD49
    vfz94Yp/jSlBaOrV0LRszLf0wIvjZCPY47YbcSDD3rYQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeBINmB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeBINl7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        torvalds@linux-foundation.org, jeyu@kernel.org,
        arjan@linux.intel.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 38/92] module/retpoline: Warn about missing retpoline in module
Date: Fri,  9 Feb 2018 14:39:07 +0100
Message-Id: <20180209133933.910708237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

(cherry picked from commit caf7501a1b4ec964190f31f9c3f163de252273b8)

There's a risk that a kernel which has full retpoline mitigations becomes
vulnerable when a module gets loaded that hasn't been compiled with the
right compiler or the right option.

To enable detection of that mismatch at module load time, add a module info
string "retpoline" at build time when the module was compiled with
retpoline support. This only covers compiled C source, but assembler source
or prebuilt object files are not checked.

If a retpoline enabled kernel detects a non retpoline protected module at
load time, print a warning and report it in the sysfs vulnerability file.

[ tglx: Massaged changelog ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org
Cc: jeyu@kernel.org
Cc: arjan@linux.intel.com
Link: https://lkml.kernel.org/r/20180125235028.31211-1-andi@firstfloor.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   17 ++++++++++++++++-
 include/linux/module.h     |    9 +++++++++
 kernel/module.c            |   11 +++++++++++
 scripts/mod/modpost.c      |    9 +++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/module.h>
 
 #include <asm/nospec-branch.h>
 #include <asm/cmdline.h>
@@ -92,6 +93,19 @@ static const char *spectre_v2_strings[]
 #define pr_fmt(fmt)     "Spectre V2 mitigation: " fmt
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+static bool spectre_v2_bad_module;
+
+#ifdef RETPOLINE
+bool retpoline_module_ok(bool has_retpoline)
+{
+	if (spectre_v2_enabled == SPECTRE_V2_NONE || has_retpoline)
+		return true;
+
+	pr_err("System may be vunerable to spectre v2\n");
+	spectre_v2_bad_module = true;
+	return false;
+}
+#endif
 
 static void __init spec2_print_if_insecure(const char *reason)
 {
@@ -277,6 +291,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s\n", spectre_v2_strings[spectre_v2_enabled]);
+	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -791,6 +791,15 @@ static inline void module_bug_finalize(c
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
+#ifdef RETPOLINE
+extern bool retpoline_module_ok(bool has_retpoline);
+#else
+static inline bool retpoline_module_ok(bool has_retpoline)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_MODULE_SIG
 static inline bool module_sig_ok(struct module *module)
 {
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2817,6 +2817,15 @@ static int check_modinfo_livepatch(struc
 }
 #endif /* CONFIG_LIVEPATCH */
 
+static void check_modinfo_retpoline(struct module *mod, struct load_info *info)
+{
+	if (retpoline_module_ok(get_modinfo(info, "retpoline")))
+		return;
+
+	pr_warn("%s: loading module not compiled with retpoline compiler.\n",
+		mod->name);
+}
+
 /* Sets info->hdr and info->len. */
 static int copy_module_from_user(const void __user *umod, unsigned long len,
 				  struct load_info *info)
@@ -2969,6 +2978,8 @@ static int check_modinfo(struct module *
 		add_taint_module(mod, TAINT_OOT_MODULE, LOCKDEP_STILL_OK);
 	}
 
+	check_modinfo_retpoline(mod, info);
+
 	if (get_modinfo(info, "staging")) {
 		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
 		pr_warn("%s: module is from the staging directory, the quality "
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2130,6 +2130,14 @@ static void add_intree_flag(struct buffe
 		buf_printf(b, "\nMODULE_INFO(intree, \"Y\");\n");
 }
 
+/* Cannot check for assembler */
+static void add_retpoline(struct buffer *b)
+{
+	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
+	buf_printf(b, "#endif\n");
+}
+
 static void add_staging_flag(struct buffer *b, const char *name)
 {
 	static const char *staging_dir = "drivers/staging";
@@ -2474,6 +2482,7 @@ int main(int argc, char **argv)
 
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
+		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
