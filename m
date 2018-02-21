Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227BR0UT4OcEd8jtMVcrgxT9i0UzRf+O6EQazyepOo2TOnZ2H5KgommUItrbXKn17nYhSsJU
ARC-Seal: i=1; a=rsa-sha256; t=1519218064; cv=none;
        d=google.com; s=arc-20160816;
        b=W3QdJ9KLK5xrj91i5KDO2yHyl88Qna0AK/woZqGLR3L7yywqCZ2W/bqoYAAPk9k2OU
         /Cvr30rvhXzW+hqUVKDnRrWviMmhpXegsWhiu6PtiQFUFZYZK+1pikendXBf1Xi/WlYR
         SOrtmsTwmxT812JfCijaQ7Ifc7fsSnuL5av7KbBiF4jSbNg/CMlIPiHtazdKhMyVONJk
         +Ijxs+wCuyZcmOiiK1R27RVaydkrQ6sdVbbRbfSk++/RlLpV94Mw91cuAU81Sjb6amUB
         aNPxvTLkLQrJLsUNoETQ0esx0XCprpwmbnpRgmrgdSbjsJkDsbyDgetYhsvvCksH2dmu
         BWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WFCHFjOknZah9neORYO0CmXzXulKu9/91Gax8LuGc3A=;
        b=i2eM7qgdAzFW16nogqNiVl1lNVFU7+AFoYYKcDluvRTMUQPBFkUCVTkJM2IH1Um9oy
         D9v1JkLlDUrbO1peJm5b+Es9/EHsn0T5zrLwIS6RZoSMMqJdsaaRauJFg9zua76r1jKi
         EsWxtRLETKtHOxyxW5MZWL+DbW03R5c3KucN/JTcG6r6A55V2LZ3yay26MOgt7Akqy3c
         qOmkPcFM90t3gAOkMLQnMnz9asM1aIoQPA4Hrb8rVbBkcIo/R0n12vQr6+OxVRWE6+jU
         D7p0qrBpL70TH5muDp7HTiWVwhZiDRFMlxZCdLBAQw0X44lH0E5GezlfVsR0hZrZKjMT
         /40A==
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
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	dan.j.williams@intel.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 064/167] x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
Date: Wed, 21 Feb 2018 13:47:55 +0100
Message-Id: <20180221124528.011979151@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015601288879092?=
X-GMAIL-MSGID: =?utf-8?q?1593015601288879092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 92816f571af81e9a71cc6f3dc8ce1e2fcdf7b6b8 upstream.

... same as the other macros in arch/x86/entry/calling.h

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Link: http://lkml.kernel.org/r/20180211104949.12992-8-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -97,7 +97,7 @@ For 32-bit we have the following convent
 
 #define SIZEOF_PTREGS	21*8
 
-	.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
 	/*
 	 * Push registers and sanitize registers of values that a
 	 * speculation attack might otherwise want to exploit. The
@@ -131,9 +131,9 @@ For 32-bit we have the following convent
 	pushq	%r15		/* pt_regs->r15 */
 	xorq    %r15, %r15	/* nospec   r15*/
 	UNWIND_HINT_REGS
-	.endm
+.endm
 
-	.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1 skip_r11rcx=0
 	popq %r15
 	popq %r14
 	popq %r13
@@ -163,7 +163,7 @@ For 32-bit we have the following convent
 
 	.macro icebp
 	.byte 0xf1
-	.endm
+.endm
 
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
