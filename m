Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518040341; cv=none;
        d=google.com; s=arc-20160816;
        b=IUuXSsSu/VygnrJaLv4leeny/uqD6Hb5TGdFAlboiiwTdJZtMDH4u4tcOX7Nc6jRGr
         eXZj3Tay6dgfuESoGCes+UoeRS32hZWDRyMNOYoY4nEsmpfrCW82cZLx17cu/DhpTWYH
         2SghZGTd/IDDsQ4RYhkFACUc4EvzjOtaxoZudFS+BAbLk0V71vCzrhAfjlOJNtNT4sqS
         JwVnH1jijLqFgV4IhG+wICQftOKScdWaoTsxhrzBhCBqfr674JGMX6xbLPllyFsdxIy/
         6tZUQoMXj/exg3YayTRbN4V9cCQRatCzjgyGrr+J9gtCVT3pHQexMAG5tpyLFm0YKURv
         pEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=gTLyIX7hiYaFC4eFBhj3UPvMUjIPAs62Otll9jf9/tc=;
        b=MIryg5rBy+IooJZKoKCxqyeDfccnxCWFPiZ4bBfEEkg7QeQhUkVUSKpOCiO9VkTnp1
         3daOp7qwPLlc45nJvkctxpBI75Jsmu0EhaGUuQQs6Du5aI0vlL/TQksDDHF60sG4LJH0
         4X3sGbQR8ljGU7cfdmhmtRy6faQ3gx4isuDw9j7JG494W1CJbcY2hQ7aMqTKOhmEasOo
         N4GuNkSN25bGvbOmcuO61H98c8Fh3qSdCLBljktaPnCMrWOIumQPn+HgnxRVwXnut7u4
         SvCIaDj5jzfHrVx47TZIUYUe9/VPSLvyKYY03ZywpJNLQm83HbpqdohPlN3hGACp0GCH
         UAvg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QlmEBZUo;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QlmEBZUo;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x226T+LFyKhMmeXhUs+p4L3xkSffoK2HCcaWcdulZUK2WcfypNKQLreMxM9ThcOLNIMSEzwwUYQ==
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Ingo Molnar <mingo@kernel.org>,
	gnomes@lxorguk.ukuu.org.uk,
	Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	thomas.lendacky@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>
Subject: [PATCH v2] x86/retpoline: Add clang support
Date: Wed,  7 Feb 2018 13:52:18 -0800
Message-Id: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1591780669011927496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

clang has its own set of compiler options for retpoline support.

Link: https://github.com/llvm-mirror/clang/commit/0d816739a82da29748caf88570affb9715e18b69
Link: https://github.com/llvm-mirror/llvm/commit/fd5a8723ce9f2a6b250e85972ef859e4253ea95d
Link: https://github.com/llvm-mirror/llvm/commit/59b64490fda69d29bb42cfdf7eec37bcc31ff833
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: llvm has been updated to use the same thunk names as gcc.
    Tested with:
    clang version 7.0.0
	(https://git.llvm.org/git/clang.git/
		848874aed95a913fb45f363120500cebfe54e2ef)
	(https://git.llvm.org/git/llvm.git/
		3afd566557f3616881505db0d69f5d19bf55ae14)
    cross-checked with gcc 7.3.0 (x86_64-linux-gcc.br_real (Buildroot
    2018.02-rc1) 7.3.0).

Tested with 64-bit builds only; 32-bit images fail to build with clang
with various unrelated errors and are difficult to test.

I had to change '+=' to '=' below since make otherwise sets
RETPOLINE_CFLAGS to " ", and the subsequent ifneq would always match.
This is also the reason for the "ifeq ($(RETPOLINE_CFLAGS),)".
If there is another/different/better way to handle this, please let
me know.

There are curently lots of warnings when building an image with clang.

./include/linux/init.h:134:6: warning:
	unknown attribute 'indirect_branch' ignored

I was inclined to add "&& !defined(__clang__)" to the condition for the
__noretpoline define to fix the problem, but concluded that this should
be a separate patch unless it can be addressed in clang.

 arch/x86/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fad55160dcb9..c1a35cea88e1 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,7 +232,12 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-    RETPOLINE_CFLAGS += $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    # gcc
+    RETPOLINE_CFLAGS = $(call cc-option,-mindirect-branch=thunk-extern -mindirect-branch-register)
+    ifeq ($(RETPOLINE_CFLAGS),)
+	# clang
+	RETPOLINE_CFLAGS = $(call cc-option,-mretpoline-external-thunk)
+    endif
     ifneq ($(RETPOLINE_CFLAGS),)
         KBUILD_CFLAGS += $(RETPOLINE_CFLAGS) -DRETPOLINE
     endif
-- 
2.7.4
