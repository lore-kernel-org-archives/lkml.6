Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs3E8DLA6aP22/czBV6JyMcs+9OoOX7H1X4oow2sZ/hrqntZkhYi3h1noGcMTUZefOSitwd
ARC-Seal: i=1; a=rsa-sha256; t=1520955208; cv=none;
        d=google.com; s=arc-20160816;
        b=r/LyTk11yacLYhCuBrotEnpG/ro5ftpsYSOwAW77lquLscHyAVji72G+eZgAobG9F3
         pIh7Go4GhRmi+5PTZxrbCnN8xiDq9CaYzMDCqrsOJ/ZZ00Ocu3MTHn9TmAeK3785R558
         gg7OIJnaWaT7kwKPW2OfH4QzDcuQzW2PXQoWilx7w+9OJgEtYy2pngWHGrKQU/5oBX9L
         FzDEk23DWYsCLXVZUWQxtsDnEem/FT/ZXjoGfEEY2g1OWstXtyjdvkRjLH5/QU3xn7zP
         M2m+Hz7lsg5ZR4g2cq7DL9HraWbb8Q5DAXw76kJStrWwrYs3WmxLRsY0oKVsr7mTvcJr
         ZNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L5cNd4HnMxs/3gB0HGp63UITxWuj/A7bbhFQfsVxDxE=;
        b=EKPbhRudSVnfi/r0ngU7LN6vqChjm5aeeqrxTQ0cYMoQZGbv/RkFBYcVGv3BLhrQfn
         IMJVkPn9TqKm2IR8RZpGrvysziaWE2KSChWpB1awgsQ3bmBWgKK78ogIG9i+sonBiQIX
         ljLngAA5KL7XsPJV658IHMayPb/EpDkMtv1PrLxsSLMaCgs1ngV1W+TrBDFChQc0W79H
         e1TwlGE/elGhIb3Jpjtt7V03thUjBRJYOMmReNkwwLiePhVKK/0jZd/3pR3j0D39s0tl
         a4DLCLcGLyD3Vt5u8dJuYPRixza4Yo3t3kI0z1TCMaKeXNarr9kWxduOzVXa65XoNDlr
         04iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 100/146] objtool, retpolines: Integrate objtool with retpoline support more closely
Date: Tue, 13 Mar 2018 16:24:27 +0100
Message-Id: <20180313152328.262644942@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837128607912092?=
X-GMAIL-MSGID: =?utf-8?q?1594837128607912092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -487,6 +487,11 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG
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
@@ -432,6 +432,7 @@ config GOLDFISH
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
@@ -267,8 +267,10 @@ else
 objtool_args += $(call cc-ifversion, -lt, 0405, --no-unreachable)
 endif
 ifdef CONFIG_RETPOLINE
+ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args += --retpoline
 endif
+endif
 
 
 ifdef CONFIG_MODVERSIONS
