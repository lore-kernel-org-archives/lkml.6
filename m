Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224yiPGFBYpujof/gaRgxucLtr6B4zBZblmYtR5DylP6sPfLCNVoEtO2y/QvTS1zhbUaNh9k
ARC-Seal: i=1; a=rsa-sha256; t=1519217801; cv=none;
        d=google.com; s=arc-20160816;
        b=OYXkfYrbmoYOWJmdsZxr+QBSXVzYK38fsak6j8d9CeaMOj6+RuJmb/t4T17D6vJQLF
         vl7odDK2v/XXkSNmonYkITe+BflnoQGFfwI9xVzWPmhlv7w95M/Qq3hNtRATbYRBv3Um
         iGRi/8CwO0so2F/RM3fD/xi0j7Yu4mNHevnPWwC9+3FItE1wFC8rBRpnjs8AUwXlMmwV
         dfhm6Gh2VF2YEqiU+jmKzdVVdQ9nd+4gGCt2d/9YTDc+7n6CVr1XoMgcYL6CbS6uLah+
         iAUgJ4lpfCtt5KrSpyI5VATW6amoAF8nN2LMOuBpoSLU2/dQOmYsoxcKlpaVLp9HLzn0
         zESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xSGdFAOge+ggrr+Mr9cfaaoioIc4nsNctXl6vcvDWV8=;
        b=mDWSQX2T+wZrQKbfdd5EmX+3eeDvXatdkAxsdJ0iqmZfNWwjJYfKyOQXEzxqRQzRdZ
         TN3gk+D19Zjsord4u6KKei4+WhW2vbOm36TIxwLbajWVXgQH8UTgSk+WMjmwhELTqPPu
         NzTdoayaXvWeQaGd3w/g16NGHEY25TzC3eKMZcermslgW/oINalX5V7T0moSVmu36xBh
         dGv8m2zpNgLHvmSjMzKfxMK+HZNKsriDuRuVOwEiOH+ElsJ/ElAA4Oacamuk372lHgH7
         gjLrz63sU0DthPk7PCu7KIaUMKI3oOCq/if7DP5z08i0OGFprSUboeHut6dr5DC9L3MJ
         canA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 59/77] selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c
Date: Wed, 21 Feb 2018 13:49:08 +0100
Message-Id: <20180221124434.697287368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015325375300324?=
X-GMAIL-MSGID: =?utf-8?q?1593015325375300324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 4105c69703cdeba76f384b901712c9397b04e9c2 upstream.

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled). To keep the "Set TF and check int80"
test running on 64-bit installs with CONFIG_IA32_EMULATION=y enabled, build
this test only if we can also build 32-bit binaries (which should be a
good approximation for that).

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-5-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/Makefile              |    2 ++
 tools/testing/selftests/x86/single_step_syscall.c |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -26,11 +26,13 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.s
 ifeq ($(CAN_BUILD_I386),1)
 all: all_32
 TEST_PROGS += $(BINARIES_32)
+EXTRA_CFLAGS += -DCAN_BUILD_32
 endif
 
 ifeq ($(CAN_BUILD_X86_64),1)
 all: all_64
 TEST_PROGS += $(BINARIES_64)
+EXTRA_CFLAGS += -DCAN_BUILD_64
 endif
 
 all_32: $(BINARIES_32)
--- a/tools/testing/selftests/x86/single_step_syscall.c
+++ b/tools/testing/selftests/x86/single_step_syscall.c
@@ -119,7 +119,9 @@ static void check_result(void)
 
 int main()
 {
+#ifdef CAN_BUILD_32
 	int tmp;
+#endif
 
 	sethandler(SIGTRAP, sigtrap, 0);
 
@@ -139,12 +141,13 @@ int main()
 		      : : "c" (post_nop) : "r11");
 	check_result();
 #endif
-
+#ifdef CAN_BUILD_32
 	printf("[RUN]\tSet TF and check int80\n");
 	set_eflags(get_eflags() | X86_EFLAGS_TF);
 	asm volatile ("int $0x80" : "=a" (tmp) : "a" (SYS_getpid)
 			: INT80_CLOBBERS);
 	check_result();
+#endif
 
 	/*
 	 * This test is particularly interesting if fast syscalls use
