Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58249ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1395B21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFRvCw1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1395B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbeJSA2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:28:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40798 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:28:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so8119348pfi.7;
        Thu, 18 Oct 2018 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9eCcFwClc/5D+HmPAfHoHvl09JbyYIVvefaSqD/YOyI=;
        b=fFRvCw1hiJEZweCIp0gv9a3Zk4dga6dxB4jIE6EV2Brch+GvTEs3vxnMCI41hbRRGB
         wp9yzOF+mIzPvC9EEeG/PjEsqGv8hpIeXljLcfq5zCpOZKUk/DSA7g7EFoNxXwe1K7jy
         NLljTQoATWRyjHLdK6K+vy7qklRbSBX77I+0rZlEKUKs7SOT8sQeZhNSpLLolP1JC+6g
         BG7EHQSUU1nMv9tRLm8tczRHP1dnA1gm5azOlvXie4FuJKcyr2VR8nS8Nvo79JWjzqik
         MEiBhhiqsiFI0E4Ew9YnAsZTXr0nSM0XtkDMyEXVzHaQ6CukQoRB4VsSITeovEHGfaPy
         oR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9eCcFwClc/5D+HmPAfHoHvl09JbyYIVvefaSqD/YOyI=;
        b=rG+gva3xXruxKXZjWnIrA/XkaKkTw65fR9WlUJWUAcuVAxWa+iT1am1XHEuW0382Gx
         ImnOc1an0dpuRKe4otwqS98FqfqGKLYjm7P4o7TmlC9/TGJx85zyttxTBZQM+FqAMMhW
         mW8klUbGTgAG0qNw4coJ5KMKhT+WgHTRY44UDwBSet3zkaX9ICGl1ntRZXx1j3lEABAq
         OZUc22XjfdAZEFLhb5bTkzAfZRO/i6bW5/ir4Di3UKvPZ4TviU1D6kdLVSxWco4VPejc
         gh/iWLML0JtLaHZN95HUwCn6Yv3NW1zc24UhNlg0lHUb6IfEns6dnCr+YZ5tn+BIdLfP
         CApQ==
X-Gm-Message-State: ABuFfogKMNE555sh7y/XER5PgPn828dhBs00K4W2Jba/xu/0fDvwP1OM
        3otg1tqINDDFnDcbwbjELDU=
X-Google-Smtp-Source: ACcGV62iJNPxQPazmNAibcbEa9bGAYUqtlH3ywUPDs9QfLOd4ZQ7dvKyzknAFCLw4rGYzHvSISD07g==
X-Received: by 2002:a63:f448:: with SMTP id p8-v6mr28973391pgk.124.1539879981819;
        Thu, 18 Oct 2018 09:26:21 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27813420pgt.83.2018.10.18.09.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:26:21 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 4/4] kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Date:   Thu, 18 Oct 2018 16:25:48 +0000
Message-Id: <20181018162548.6399-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018162548.6399-1-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 Makefile                     |  5 +++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 init/Kconfig                 | 19 +++++++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 757d6507cb5c..0e747fafb53b 100644
--- a/Makefile
+++ b/Makefile
@@ -657,6 +657,10 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
+KBUILD_CFLAGS	+= $(call cc-option, -Og)
+KBUILD_CFLAGS   += $(call cc-disable-warning,maybe-uninitialized,)
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
index 4d36b27214fd..2a76f7c64b54 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -85,7 +85,7 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..9385c62e9f00 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -320,7 +320,7 @@ static inline void *offset_to_ptr(const int *off)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/init/Kconfig b/init/Kconfig
index 1e234e2f1cba..b01c7c654570 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1081,6 +1081,25 @@ config CC_OPTIMIZE_FOR_SIZE
 
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
 
 config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-- 
2.17.1

