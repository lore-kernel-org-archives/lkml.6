Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520955826-2-12272736332002873514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955825; b=vgmghVXG2bGxWBXAkhlOe6TWhXYR3XHwnrjMQ9etryUN7OA
    cjl/FwQe20LwexeR3aLVcX9mCE0EQdXSOtPwODIqd8jtd5UBIUrDRv/ApHD1KoSg
    6ME7R9NdhVIQoF4W9oeFpbGknR1AM+ae+3+2Jm7JbGAnkhfLTcglhz2bygh07P+J
    aCv6Epvi6Cjhoxt5Zvhwwau3ipcWw6z3z7w5v9fjKQSzRDx3Us99HOHEo4DfsH+d
    A6xn2xeHUzLxaV5y5dJCqbtKm119NlKffbFX/Ezp/M8nmgfxGU4obzC5JHufZl5X
    7rhnGNhkdILGgtYuAACKXCqdpXinfskT+uwkokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955825; bh=sT2gVHnWloXdEBfg7LWu0DUXN2
    r3HfZOQbd3+ImbytQ=; b=v5ZJOibIi+jA5dBmfUG3juFVaAvsg2WTWqI21bBMQw
    ZcouGxBCXdpUdAathPO/pOetjnuYW2b4jnnXij6KqIkudMCUt5VYJh6ybIbY+W7i
    hnsb2fHGpxFM+pIfZOFz0odCl2sIbZ+gPLscKtvjXNvX87seqYOoO3mSUo6CWqEf
    eKRzTuTk7Iyb6gx12IlwItB4iWYMjo4dzka3CSX7IazYuK3u4kbwya6aOOvY1vMr
    H8WBIIcP2v+QnnJPgKjp+xtReEhW6hvBnFCiDxOSxDf6ODZseZC86y+OJa+pl/wm
    BO9UfGGmwDgWTWXWJ8Qiker27FsL11L/zqUJD+IFnI2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934281AbeCMPnX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:43:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964847AbeCMPll (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 137/140] objtool, retpolines: Integrate objtool with retpoline support more closely
Date: Tue, 13 Mar 2018 16:25:40 +0100
Message-Id: <20180313152507.382458750@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit d5028ba8ee5a18c9d0bb926d883c28b370f89009 upstream.

Disable retpoline validation in objtool if your compiler sucks, and otherwise
select the validation stuff for CONFIG_RETPOLINE=y (most builds would already
have it set due to ORC).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile               |    5 +++++
 arch/x86/Kconfig       |    1 +
 arch/x86/Makefile      |   10 +++-------
 scripts/Makefile.build |    2 ++
 4 files changed, 11 insertions(+), 7 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -431,6 +431,7 @@ config GOLDFISH
 config RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	default y
+	select STACK_VALIDATION if HAVE_STACK_VALIDATION
 	help
 	  Compile kernel with the retpoline compiler options to guard against
 	  kernel-to-user data leaks by avoiding speculative indirect
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,13 +232,9 @@ KBUILD_CFLAGS += -fno-asynchronous-unwin
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
-    RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
-
-    RETPOLINE_CFLAGS += $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
-    ifneq ($(RETPOLINE_CFLAGS),)
-        KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
-    endif
+ifneq ($(RETPOLINE_CFLAGS),)
+  KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
+endif
 endif
 
 archscripts: scripts_basic
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -272,8 +272,10 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
