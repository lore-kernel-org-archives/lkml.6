Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0CC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E429320665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcZBVTU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E429320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJ1VzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:55:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40387 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1VzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:55:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so2681460pfi.7;
        Sun, 28 Oct 2018 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+j4XlDFq4raU553LDUaUCt5+jy/FBKWbgmTWsZs9/w4=;
        b=ZcZBVTU89pzNt3vBNg6lVDMrt64t8JhHC/0QMzrER553066hxt39E1B+2UPNQ1CWhP
         8v2Srqy/Yq86tkFT0eLx4mC/cdct4Rnrr7omJ/gsVPv8WxtIjs9QCE7NbNWLzElqVLzV
         Jweu+ZO6fkhSsXFPGne13D87/uAow5Sndz8G5BTRLmso+V9aUlySPUt4/YGPhS/6qZ9h
         U095NfJJa34DSdKEjJZy3VsaGm6860estcI6578dO9vw7pPuYG5AttvngxaYbyHfUeJv
         7+lb5IBXlUrdp6aoq1UOGGiTY45kTlxBk1mkyemOkyJqD8eLC0Yu8/sCeZH3rf3EtU7+
         omvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+j4XlDFq4raU553LDUaUCt5+jy/FBKWbgmTWsZs9/w4=;
        b=chdgAukOJVKuvWYWkJoCF+J1Yfg3e3DWoh3uSSh64Vuyr4Q0NSUn/YNqpaE7zQz4oT
         ESkip4ys26X644QM+8a12Vb5Df25ZDyiLRuzMbTpr4l9YLufquW2fTRn9+S52pyVCz/J
         JjVwqy1dGSePXczh86mvvWX9RLELL0b8+/J040hYE/h23KXHUMA0Zdsu1kKMPan60Gz+
         4j6hZweOJqri059fVqPSAc6LJHKbwE2nKtLGUATGg83bYsX8eR8hPwEbkC4BWNAiImtY
         1ID3G10uOBI7jJKhCEnTF+mZmRz9ZjNxmlHZ+kXyAk2CGvAY1WNTdsrWEjnefi0uINa4
         ElNA==
X-Gm-Message-State: AGRZ1gIfshElXjDEJ5pts9H3bjPl3Ct/hSfnQ8TjsxcEVHVovC+XKJof
        5DBF4DWkgUx/rV5YZaD09zU=
X-Google-Smtp-Source: AJdET5fvHJQDAmPn9R6YowSIM8HbjBhm2D9STevLO7cEgHL7LQu7zx+lqCgO6PEB40iV3xLLy4Kjsw==
X-Received: by 2002:a62:b24e:: with SMTP id x75-v6mr6183101pfe.148.1540732235340;
        Sun, 28 Oct 2018 06:10:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id e3-v6sm24520585pgc.71.2018.10.28.06.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 06:10:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date:   Sun, 28 Oct 2018 13:09:45 +0000
Message-Id: <20181028130945.23581-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181028130945.23581-1-changbin.du@gmail.com>
References: <20181028130945.23581-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

---
v3:
  o make CC_OPTIMIZE_FOR_DEBUGGING depends on $(cc-option,-Og)
  o reflect CONFIG_CC_OPTIMIZE_FOR_DEBUGGING in tiny.config
---
 Makefile                     |  5 +++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 20 ++++++++++++++++++++
 kernel/configs/tiny.config   |  1 +
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 04beb822ddfc..10de245a3325 100644
--- a/Makefile
+++ b/Makefile
@@ -657,6 +657,10 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
+KBUILD_CFLAGS	+= -Og
+KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
@@ -667,6 +671,7 @@ else
 KBUILD_CFLAGS   += -O2
 endif
 endif
+endif
 
 KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 			$(call cc-disable-warning,maybe-uninitialized,))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 90ddfefb6c2b..4832c98c7885 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -85,7 +85,7 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1921545c6351..3836397bf477 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -350,7 +350,7 @@ static inline void *offset_to_ptr(const int *off)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/init/Kconfig b/init/Kconfig
index a4112e95724a..0fb9c0b5f1a1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1105,6 +1105,26 @@ config CC_OPTIMIZE_FOR_SIZE
 
 	  If unsure, say N.
 
+config CC_OPTIMIZE_FOR_DEBUGGING
+	bool "Optimize for better debugging experience (-Og)"
+	depends on $(cc-option,-Og)
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
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
diff --git a/kernel/configs/tiny.config b/kernel/configs/tiny.config
index 7fa0c4ae6394..599ea86b0800 100644
--- a/kernel/configs/tiny.config
+++ b/kernel/configs/tiny.config
@@ -1,5 +1,6 @@
 # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is not set
 # CONFIG_KERNEL_GZIP is not set
 # CONFIG_KERNEL_BZIP2 is not set
 # CONFIG_KERNEL_LZMA is not set
-- 
2.17.1

