Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x225r9w9vNxdbUMFJ8yOGMU3bo9ECOQMIOQVQNOA1Is5J7+FktPUfc1abrzgn/Ud4aW1/wmFJ
ARC-Seal: i=1; a=rsa-sha256; t=1518424020; cv=none;
        d=google.com; s=arc-20160816;
        b=n/JIHGDzt/LSwL4giMsA6sTOJ/rrd1bvACVJ9ANpvcqhExqIWeuj9RX9b9+y21A519
         FSTSspSjLskR8rfaC28V04zpPRsHuUo7C6FUPmm9Ve3Y617hdbsVeSMTIQrAFPr205Cv
         AJW+jcl5Q7HfmeMofu7HDA23SW/ma1W9UgqFOLG9+qF7tLmHEqQzbmdvKzZtcQc9Ll8e
         jwofwGYXH1ptBWrsWS5sR26MNML6W6SFKArAN5A0nZyN0Rnb16xbovyMeDZDsshq/geD
         7Z7ySfj2A+E+PQmlKSzOfN1CgzUho1bLFVzFgy4rgrNvl8rOs2nNjxFGOgaW0Iej7tNQ
         PxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=m1U0ubIbidKuQwt3Fk+KSzcz5FjBC6KWmu5UmnfNVBs=;
        b=sVsOQhnI63uW+EFvDopJwxoR32f7jXDqFtRWM4xDSNFKPEXLb/EV95B8wTrBge7Dcb
         w4FsOXMG45r6S2UylRSnHayWjnB2ZNE+mum3O0F5C5F30GGPjUiruAnJjQc5Y9bBXWXJ
         MFlxpnVHr02HzFeydcmYU9FCJH0YaN6im+44mlYr5UNxGGAP4WVB0OhvEluPWn0oeJjb
         POplUSPciA7htNmxVkcYwL1uXFlPU/dBskjHasgHIx5M0JS+uz8y5gijq+gf0DFi6aCQ
         QMtSVXPcE+465gfZqlmYmkqJGVa3XVcs2/kiq+UQtwhcuzNlHYfiVVMdbyvtAQSeg2Vb
         +USA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=e8gh2NN2;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=e8gh2NN2;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 12 Feb 2018 09:26:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-s390 <linux-s390@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Message-ID: <20180212082635.GA25314@hirez.programming.kicks-ass.net>
References: <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator>
 <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592182986230060984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:

> That actually sounds like we could just
> 
>  (a) make gcc 4.5 be the minimum required version
> 
>  (b) actually error out if we find a bad compiler

So the unofficial plan was to enforce asm-goto and -fentry support by
hard failure to build, which would get us at gcc-4.6 and then remove all
the fallback cruft needed for those features -- for x86. If we want to
do this tree wide, that's obviously OK with me too ;-)

The below is the two force-asm-goto and force-fentry patches folded.

---
 Makefile          | 17 +++++++++++------
 arch/x86/Makefile | 25 +++++--------------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index d192dd826cce..1a46f23d0974 100644
--- a/Makefile
+++ b/Makefile
@@ -489,6 +489,17 @@ KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 endif
 
+# check for 'asm goto'
+ifeq ($(shell $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
+  CC_HAVE_ASM_GOTO := 1
+  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
+  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
+endif
+
+ifeq ($(call cc-option-yn, -mfentry), y)
+  CC_HAVE_FENTRY := 1
+endif
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
@@ -654,12 +665,6 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
 
-# check for 'asm goto'
-ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
-	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
-endif
-
 include scripts/Makefile.kcov
 include scripts/Makefile.gcc-plugins
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fad55160dcb9..35cea458a7be 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -158,27 +158,12 @@ ifdef CONFIG_X86_X32
 endif
 export CONFIG_X86_X32_ABI
 
-#
-# If the function graph tracer is used with mcount instead of fentry,
-# '-maccumulate-outgoing-args' is needed to prevent a GCC bug
-# (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=42109)
-#
-ifdef CONFIG_FUNCTION_GRAPH_TRACER
-  ifndef CONFIG_HAVE_FENTRY
-	ACCUMULATE_OUTGOING_ARGS := 1
-  else
-    ifeq ($(call cc-option-yn, -mfentry), n)
-	ACCUMULATE_OUTGOING_ARGS := 1
-
-	# GCC ignores '-maccumulate-outgoing-args' when used with '-Os'.
-	# If '-Os' is enabled, disable it and print a warning.
-        ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-          undefine CONFIG_CC_OPTIMIZE_FOR_SIZE
-          $(warning Disabling CONFIG_CC_OPTIMIZE_FOR_SIZE.  Your compiler does not have -mfentry so you cannot optimize for size with CONFIG_FUNCTION_GRAPH_TRACER.)
-        endif
+ifndef CC_HAVE_ASM_GOTO
+  $(error Compiler lacks asm-goto support.)
+endif
 
-    endif
-  endif
+ifndef CC_HAVE_FENTRY
+  $(error Compiler lacks -mfentry support.)
 endif
 
 #
