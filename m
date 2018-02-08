Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227tLajKNVhi2VYZRO/sBKxBYEkGJ6c8xy7ylrG2TQ0Ra2KIhz5/SWCEzXjTzmQC2vpXau60
ARC-Seal: i=1; a=rsa-sha256; t=1518106812; cv=none;
        d=google.com; s=arc-20160816;
        b=uxomVDpcVq35can7U4KWpxpTAyIUT0z5PtJ+IwBGojha7jPpN30lU85DvV6cP9Jncz
         PXlgOKy3FZReeHpCjYBdIXeDWEiM2i8/DK+NoAW9DqSM7U/WmDw81b1schEAZ4kU4Unv
         e3YjWjfZneEm4qqKFlXIkPc0ISp9wOHXfxmD0ScfphV1xQJoV676ibA4utLbn1tNqKoO
         JRtc6bRD8sCsw4gBkMKXSwJisoZJP0Cwjg7mQ1X+tGfj4rRBs21FkJ51ENXLdvS83uIw
         PHq0j5GRc2bGHFdCPXsmF0UH3tkqOgspSTyDxIn2HzGoUame9Fy8XmcfCiQOliwxTG0o
         h7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=dIcQHxJOo1WEOZ1InbfU14tiSNMjCN+ELjZYvOPLjWU=;
        b=W6vl1t7jjsiL1pz/QKeIYAZZsfZwXOlacNivKVlvGgDJXyGWIhhCE8uQ5l3YPKKSDq
         lzbLT4q2MLlBu7/fuD6ukmdCvpXr0dbMEfFPHGdjU7sSZIXaRLXo/JO55egrWLsa0EGu
         8956Cw5OXVGTJ9KMos6nfpMB//zml24C+REiS8Q2CSgwsTu3CejtwIgRbCBxxk1soT/D
         1AyiTWoGA8EIx1P8vcEzfJL3twE52p5i6FCBOOT8Nq8Z5h6BSMb+GcgLSkIRvqOu7KN2
         tmkeXGQF9tX2g0vG4pVFz25wW7umaT0Wl9JYFSOGWrnPkRguBYBLbX9bAYc+8H89LxGU
         qTEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=vku4TdNu;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=vku4TdNu;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w18GJP1J021191
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/7] Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO
Date: Fri,  9 Feb 2018 01:19:12 +0900
Message-Id: <1518106752-29228-8-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368439232985?=
X-GMAIL-MSGID: =?utf-8?q?1591850368439232985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add CC_HAS_STACKPROTECTOR(_STRONG) and proper dependency.

I re-arranged the choice values, _STRONG, _REGULAR, _NONE in this order
because the default of choice is the first visible symbol.

TODO:
Broken stackprotector is not tested.
scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh should be
evaluated in Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Test stackprotector options in Kconfig to kill CC_STACKPROTECTOR_AUTO

Add CC_HAS_STACKPROTECTOR(_STRONG) and proper dependency.

I re-arranged the choice values, _STRONG, _REGULAR, _NONE in this order
because the default of choice is the first visible symbol.

TODO:
Broken stackprotector is not tested.
scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh should be
evaluated in Kconfig.

---

 Makefile     | 58 +++++++++++-----------------------------------------------
 arch/Kconfig | 54 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/Makefile b/Makefile
index 9afd617..8123ccf 100644
--- a/Makefile
+++ b/Makefile
@@ -679,56 +679,20 @@ ifneq ($(CONFIG_FRAME_WARN),0)
 KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
 
-# This selects the stack protector compiler flag. Testing it is delayed
-# until after .config has been reprocessed, in the prepare-compiler-check
-# target.
-ifdef CONFIG_CC_STACKPROTECTOR_AUTO
-  stackp-flag := $(call cc-option,-fstack-protector-strong,$(call cc-option,-fstack-protector))
-  stackp-name := AUTO
-else
-ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
-  stackp-flag := -fstack-protector
-  stackp-name := REGULAR
-else
-ifdef CONFIG_CC_STACKPROTECTOR_STRONG
-  stackp-flag := -fstack-protector-strong
-  stackp-name := STRONG
-else
-  # If either there is no stack protector for this architecture or
-  # CONFIG_CC_STACKPROTECTOR_NONE is selected, we're done, and $(stackp-name)
-  # is empty, skipping all remaining stack protector tests.
-  #
-  # Force off for distro compilers that enable stack protector by default.
-  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
-endif
-endif
-endif
-# Find arch-specific stack protector compiler sanity-checking script.
-ifdef stackp-name
-ifneq ($(stackp-flag),)
-  stackp-path := $(srctree)/scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh
-  stackp-check := $(wildcard $(stackp-path))
-  # If the wildcard test matches a test script, run it to check functionality.
-  ifdef stackp-check
-    ifneq ($(shell $(CONFIG_SHELL) $(stackp-check) $(CC) $(KBUILD_CPPFLAGS) $(biarch)),y)
-      stackp-broken := y
-    endif
-  endif
-  ifndef stackp-broken
-    # If the stack protector is functional, enable code that depends on it.
-    KBUILD_CPPFLAGS += -DCONFIG_CC_STACKPROTECTOR
-    # Either we've already detected the flag (for AUTO) or we'll fail the
-    # build in the prepare-compiler-check rule (for specific flag).
-    KBUILD_CFLAGS += $(stackp-flag)
-  else
-    # We have to make sure stack protector is unconditionally disabled if
-    # the compiler is broken (in case we're going to continue the build in
-    # AUTO mode).
-    KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
-  endif
+ifeq ($(CONFIG_CC_STACKPROTECTOR_STRONG),y)
+KBUILD_CFLAGS += -fstack-protector-strong
 endif
+ifeq ($(CONFIG_CC_STACKPROTECTOR_REGULAR),y)
+KBUILD_CFLAGS += -fstack-protector
 endif
 
+# is this necessary?
+#ifeq ($(CONFIG_CC_STACKPROTECTOR_NONE),y)
+#KBUILD_CFLAGS += -fno-stack-protector
+#endif
+
+# TODO: run scripts/gcc-$(SRCARCH)_$(BITS)-has-stack-protector.sh from Kconfig
+
 ifeq ($(cc-name),clang)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
diff --git a/arch/Kconfig b/arch/Kconfig
index 76c0b54..50723d8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -538,10 +538,20 @@ config HAVE_CC_STACKPROTECTOR
 	  - its compiler supports the -fstack-protector option
 	  - it has implemented a stack canary (e.g. __stack_chk_guard)
 
+config CC_HAS_STACKPROTECTOR
+	bool
+	option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
+
+config CC_HAS_STACKPROTECTOR_STRONG
+	bool
+	option shell="$CC -Werror -fstack-protector-strong -c -x c /dev/null"
+
+config CC_STACKPROTECTOR
+	bool
+
 choice
 	prompt "Stack Protector buffer overflow detection"
 	depends on HAVE_CC_STACKPROTECTOR
-	default CC_STACKPROTECTOR_AUTO
 	help
 	  This option turns on the "stack-protector" GCC feature. This
 	  feature puts, at the beginning of functions, a canary value on
@@ -551,26 +561,10 @@ choice
 	  overwrite the canary, which gets detected and the attack is then
 	  neutralized via a kernel panic.
 
-config CC_STACKPROTECTOR_NONE
-	bool "None"
-	help
-	  Disable "stack-protector" GCC feature.
-
-config CC_STACKPROTECTOR_REGULAR
-	bool "Regular"
-	help
-	  Functions will have the stack-protector canary logic added if they
-	  have an 8-byte or larger character array on the stack.
-
-	  This feature requires gcc version 4.2 or above, or a distribution
-	  gcc with the feature backported ("-fstack-protector").
-
-	  On an x86 "defconfig" build, this feature adds canary checks to
-	  about 3% of all kernel functions, which increases kernel code size
-	  by about 0.3%.
-
 config CC_STACKPROTECTOR_STRONG
 	bool "Strong"
+	depends on CC_HAS_STACKPROTECTOR_STRONG
+	select CC_STACKPROTECTOR
 	help
 	  Functions will have the stack-protector canary logic added in any
 	  of the following conditions:
@@ -588,11 +582,25 @@ config CC_STACKPROTECTOR_STRONG
 	  about 20% of all kernel functions, which increases the kernel code
 	  size by about 2%.
 
-config CC_STACKPROTECTOR_AUTO
-	bool "Automatic"
+config CC_STACKPROTECTOR_REGULAR
+	bool "Regular"
+	depends on CC_HAS_STACKPROTECTOR
+	select CC_STACKPROTECTOR
+	help
+	  Functions will have the stack-protector canary logic added if they
+	  have an 8-byte or larger character array on the stack.
+
+	  This feature requires gcc version 4.2 or above, or a distribution
+	  gcc with the feature backported ("-fstack-protector").
+
+	  On an x86 "defconfig" build, this feature adds canary checks to
+	  about 3% of all kernel functions, which increases kernel code size
+	  by about 0.3%.
+
+config CC_STACKPROTECTOR_NONE
+	bool "None"
 	help
-	  If the compiler supports it, the best available stack-protector
-	  option will be chosen.
+	  Disable "stack-protector" GCC feature.
 
 endchoice
 
-- 
2.7.4
