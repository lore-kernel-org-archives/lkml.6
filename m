Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517855053-2-1886609919098542683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855052; b=jWc2EpJ4SBqdlS1XvuZSfDEKrGwnNJfeIzdi9lapGLfHCD/
    VrbHzZUTpNDlCcuk85m86QvK4nRr5ic/9mE5YFRLbGzxd14fbZgTrlzZvzjMpOgt
    /dh5HnQplwUwnUZQ360JhoMVimZQeB9Uw1ZUxiLrU3luuPMpBBgfweRUVIRPDXni
    jybMmUmrlhwJUZnAaGxXkodckw15OI+m25VyZJVYmE+Vm0IC/7DP0Xnls1cr4IvP
    5ucRK2n+dX5W0jcllYZfFGTzwfVkZJzU3Bg1KstNokCmzom6KAncmyeIax2ruGVc
    R5g60zCw0cljltSBOhaNZn95YpzWIxtq8hrkzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517855052; bh=2aCiLSw7QZSOOW5JT6FerXIX4H
    V6AAkpCORsZe5HwVI=; b=CTlMC10b9CzbYXjpMFW3QhVlxIm0of5vXz8McZ4NUk
    HFaezTOwGqOFbzpDBfcSpNNxgCeyzTr6l4TzIWzuaAQV0W6WF6zVBioY/D9knk4j
    QfrXciiyuglSXJp9lBS37LKeg/5Gi9yHhUP0CDjSWGF6+YLICt6d/3gmhhx2xLty
    fAQXvLeFbTMGqmkjOuB9CyquSqBuSUYk6gZwcqUrL3Xd6cpXKxHwmFKTwNcWCv0U
    OkI/ONNq0DYYLY/udVKfgRaBr5kGVBSOrHj3xb/kAouuQQyU1TcKO5g2CHMXgW+I
    FQ+kXoirFuHZVxRLigdKuPZ8K6VW6qxj4NMKCUmvF6Bg==
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
        id S1753503AbeBESYI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:24:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753489AbeBESYD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:24:03 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw2@infradead.org>,
        torvalds@linux-foundation.org, jeyu@kernel.org,
        arjan@linux.intel.com
Subject: [PATCH 4.14 07/64] module/retpoline: Warn about missing retpoline in module
Date: Mon,  5 Feb 2018 10:22:26 -0800
Message-Id: <20180205182138.873302302@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen ak@linux.intel.com

commit caf7501a1b4ec964190f31f9c3f163de252273b8

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |   17 ++++++++++++++++-
 include/linux/module.h     |    9 +++++++++
 kernel/module.c            |   11 +++++++++++
 scripts/mod/modpost.c      |    9 +++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/cpu.h>
+#include <linux/module.h>
 
 #include <asm/nospec-branch.h>
 #include <asm/cmdline.h>
@@ -93,6 +94,19 @@ static const char *spectre_v2_strings[]
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
@@ -278,6 +292,7 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s\n", spectre_v2_strings[spectre_v2_enabled]);
+	return sprintf(buf, "%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		       spectre_v2_bad_module ? " - vulnerable module loaded" : "");
 }
 #endif
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -794,6 +794,15 @@ static inline void module_bug_finalize(c
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
@@ -2855,6 +2855,15 @@ static int check_modinfo_livepatch(struc
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
@@ -3021,6 +3030,8 @@ static int check_modinfo(struct module *
 		add_taint_module(mod, TAINT_OOT_MODULE, LOCKDEP_STILL_OK);
 	}
 
+	check_modinfo_retpoline(mod, info);
+
 	if (get_modinfo(info, "staging")) {
 		add_taint_module(mod, TAINT_CRAP, LOCKDEP_STILL_OK);
 		pr_warn("%s: module is from the staging directory, the quality "
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2165,6 +2165,14 @@ static void add_intree_flag(struct buffe
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
@@ -2506,6 +2514,7 @@ int main(int argc, char **argv)
 		err |= check_modname_len(mod);
 		add_header(&buf, mod);
 		add_intree_flag(&buf, !external_module);
+		add_retpoline(&buf);
 		add_staging_flag(&buf, mod->name);
 		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
