Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2343747-1528187094-2-4204008303111815803
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528187094; b=MEqfX554EQh7+jcBKM0xjdEL7q26HM4PxQ4/aoOoy+27a2lV/u
    8olUcFFifTwE5FhUL6a1oNl8fM+TeoUERU/TmsKdFqx5AuuM0zr+rgjbO13BNmub
    SLjn7wsqyWkPzOEYr4glEBwsoGvQ2+NNlarUeUQUBEk/wwxw0SvXNxgUXu29tn4h
    T9EMjfF+T/sDyUsWAes59EWUTMeAIVBz6Dd7NU1ilnI3apihlk/qUtIHUQqKE/aY
    XKVPQxWh31R0SDt3W3nm4F1TOH0wV89RMOnEqwbR4e/OtnKrm91LL5lLO4fllsfN
    572WbEXx7hN49DCxN21lUwMDVO57gLHxmEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1528187094; bh=
    eh8EXKz1TN0BuzzM3a1sbENx2muGW9am5X3RT6n8tIw=; b=dL57bo3qmhqSy8Gi
    2nfobndpQj1ndlOKPgoa7X1wB40WOoqSC312DcBrdAvJFqpGeWAsQDbromctXKQo
    r4pBfSiMuU6AQGEwNEEa78UaRvB75MlB6cb4EDdUH7p+x2KGdSMTFYqVBQP2vrPp
    pnsuDSGryU6//i6Yi3L7ulVZqwFiKukRbgV/Iil2EEgmyKRzKZtpTCKaNXCcaWhz
    hQirmyCM/AR6vJgzHXd0Eu63kiY2XF1pzeyZz5BPglCKdSGiMewiYvU8Av0QHFwj
    bsfqcwAZGM3n4g/tYQyZtgYm89Ko+t2c+EQF7d+Mngovx/r52k8YdfmvXy9sganA
    tYhNSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAN23gPgLQbt1vtTQ1QkbPl89PhYhcvzSLnUGJ38vS3K2Wx+CZ2lsGBMxphN0XLkW/Of+qAkr+pNFEXfG2ylGD3LWJyk2/u9VFopJMdr0XQTtcZWYKpG
    yDYrf+VzSKFcxltecbcXOBFiPMurXujKXqmSkVBRHA/uhKCCds6x/XK5iEOz6bIZzinJJ1FPtpITE0KWThVGj2BE4Bcw5qU2o1ylCFIHAIXXc8TfXrUiSjsZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=QyXUC8HyAAAA:8
    a=D19gQVrFAAAA:8 a=meVymXHHAAAA:8 a=5NYyq80fgkvXH1-8aWYA:9
    a=MKjBOvsjgiNZNP_j:21 a=e4QWLhH9G8etyXrT:21 a=W4TVW4IDbPiebHqcZpNg:22
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeFEIYw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 04:24:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:33944 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeFEIYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Jun 2018 04:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,478,1520924400";
   d="scan'208";a="45352183"
From: changbin.du@intel.com
To: mingo@redhat.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc: rostedt@goodmis.org, tglx@linutronix.de, rdunlap@infradead.org,
        x86@kernel.org, linux@armlinux.org.uk, lgirdwood@gmail.com,
        broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sparse@vger.kernel.org,
        changbin.du@gmail.com, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v5 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date: Tue,  5 Jun 2018 16:13:40 +0800
Message-Id: <1528186420-6615-5-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
References: <1528186420-6615-1-git-send-email-changbin.du@intel.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

This will apply GCC '-Og' optimization level which is supported
since GCC 4.8. This optimization level offers a reasonable level
of optimization while maintaining fast compilation and a good
debugging experience. It is similar to '-O1' while perferring
to keep debug ability over runtime speed.

If enabling this option breaks your kernel, you should either
disable this or find a fix (mostly in the arch code). Currently
this option has only been tested on x86_64 and arm platform.

This option can satisfy people who was searching for a method
to disable compiler optimizations so to achieve better kernel
debugging experience with kgdb or qemu.

The main problem of '-Og' is we must not use __attribute__((error(msg))).
The compiler will report error though the call to error function
still can be optimize out. So we must fallback to array tricky.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux

Comparison of system performance: a bit drop (~6%).
    This benchmark of kernel compilation is suggested by Ingo Molnar.
    https://lkml.org/lkml/2018/5/2/74

    Preparation: Set cpufreq to 'performance'.
    for ((cpu=0; cpu<120; cpu++)); do
      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
      [ -f $G ] && echo performance > $G
    done

    w/o CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

        219.764246652 seconds time elapsed                   ( +-  0.78% )

    w/ CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

         233.574187771 seconds time elapsed                  ( +-  0.19% )

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
v3:
  o Rename DEBUG_EXPERIENCE to CC_OPTIMIZE_FOR_DEBUGGING
  o Move new configuration item to "General setup->Compiler optimization level"
v2:
  o Improve performance benchmark as suggested by Ingo.
  o Grammar updates in description. (Randy Dunlap)
---
 Makefile                     |  4 ++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6720c40..977418a 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,9 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
+KBUILD_CFLAGS	+= $(call cc-option, -Og)
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
@@ -649,6 +652,7 @@ else
 KBUILD_CFLAGS   += -O2
 endif
 endif
+endif
 
 KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 			$(call cc-disable-warning,maybe-uninitialized,))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b4bf73f..586ed11 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -192,7 +192,7 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 # define __compiletime_warning(message) __attribute__((warning(message)))
 # define __compiletime_error(message) __attribute__((error(message)))
 #endif /* __CHECKER__ */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c..e97caf4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,7 +301,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/init/Kconfig b/init/Kconfig
index f013afc..aa52535 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1036,6 +1036,25 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config CC_OPTIMIZE_FOR_DEBUGGING
+	bool "Optimize for better debugging experience (-Og)"
+	select NO_AUTO_INLINE
+	help
+	  This will apply GCC '-Og' optimization level which is supported
+	  since GCC 4.8. This optimization level offers a reasonable level
+	  of optimization while maintaining fast compilation and a good
+	  debugging experience. It is similar to '-O1' while preferring to
+	  keep debug ability over runtime speed. The overall performance
+	  will drop a bit (~6%).
+
+	  Use only if you want to debug the kernel, especially if you want
+	  to have better kernel debugging experience with gdb facilities
+	  like kgdb or qemu. If enabling this option breaks your kernel,
+	  you should either disable this or find a fix (mostly in the arch
+	  code).
+
+	  If unsure, select N.
+
 endchoice
 
 config SYSCTL
-- 
2.7.4
