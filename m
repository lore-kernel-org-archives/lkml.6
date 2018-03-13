Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMxQ6z7cLTZwipyvrRooGHMWZReMMVTrZkaJDa/9XDHC1Y0OX2kHnuPwtwXPfzDqiLkGGh
ARC-Seal: i=1; a=rsa-sha256; t=1520955684; cv=none;
        d=google.com; s=arc-20160816;
        b=HFmuQqgITjcFmBGrjsRLZE44uKihxoSPAvwdoC735J3pvQe1bYSMuBXX05tU6JQ0mo
         +trpiD8hG6o6Sz16W89p6Iso3zuYMH547ujpGuF5JeQ4Iw9VgOO2SDXF4YKVSJ7XWU98
         lzMWPIPaDGj1SJweqCRrnDk6SYrRxPfweERsMxAzOISIcOQxpD4O4IFp+sHfYc3vv32O
         cPIkSSxMUTl565nea52S8Hbq8W0tYl205seUcKJh8x+/lRdu9uYcK76FaXu56bAXIJUN
         XwRv+uiEXh2f9DhTn9B6rellV07Apvm7R3SXKYkR2DC8bUVANP6coIRgvOvJKDscpdu7
         Au9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qKn6B6Ew6dS5kkktH7zd+bC2xNctr9ryBJn4Etw5UEY=;
        b=K1sAK96JBpHHKJJOiXqW0oELUm6pXlSjPxHdLGJHKgsAZtoCjZyKqjLpUDWcLdwyfH
         KZghWJSLQJx8JYIrmOJtdkfKlgAz8NQPC0vBm+JUF0zKGN+YspImUe0BqTO4H9ch6ZUq
         nRlETU54ayJd/eAwkxzFXFvNUb2i7y6vZ2YwtKQshioXZAFdgoIlG3xtgOkcRB+Odc6J
         pDqCoWVrcSM6Pqs6kapgOnonz5rhbaWfdk3BUHEy25k52lRS5Dyq1FM3LO8orH5s8QO+
         s7AK0ecxCcrxW4DsaFucel1GYeaTFH/mMSH+Icjem+X5dV79oGwyu0oFEAOkSo+jxAHC
         vOeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 126/140] x86/speculation, objtool: Annotate indirect calls/jumps for objtool
Date: Tue, 13 Mar 2018 16:25:29 +0100
Message-Id: <20180313152506.646423522@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837026936112982?=
X-GMAIL-MSGID: =?utf-8?q?1594837627406975660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 9e0e3c5130e949c389caabc8033e9799b129e429 upstream.

Annotate the indirect calls/jumps in the CALL_NOSPEC/JUMP_NOSPEC
alternatives.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/nospec-branch.h |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -68,6 +68,18 @@
 .endm
 
 /*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+.macro ANNOTATE_RETPOLINE_SAFE
+	.Lannotate_\@:
+	.pushsection .discard.retpoline_safe
+	_ASM_PTR .Lannotate_\@
+	.popsection
+.endm
+
+/*
  * These are the bare retpoline primitives for indirect jmp and call.
  * Do not use these directly; they only exist to make the ALTERNATIVE
  * invocation below less ugly.
@@ -103,9 +115,9 @@
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(jmp *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *\reg),	\
 		__stringify(RETPOLINE_JMP \reg), X86_FEATURE_RETPOLINE,	\
-		__stringify(lfence; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	jmp	*\reg
 #endif
@@ -114,9 +126,9 @@
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
 	ANNOTATE_NOSPEC_ALTERNATIVE
-	ALTERNATIVE_2 __stringify(call *\reg),				\
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *\reg),	\
 		__stringify(RETPOLINE_CALL \reg), X86_FEATURE_RETPOLINE,\
-		__stringify(lfence; call *\reg), X86_FEATURE_RETPOLINE_AMD
+		__stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *\reg), X86_FEATURE_RETPOLINE_AMD
 #else
 	call	*\reg
 #endif
@@ -144,6 +156,12 @@
 	".long 999b - .\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_RETPOLINE_SAFE					\
+	"999:\n\t"						\
+	".pushsection .discard.retpoline_safe\n\t"		\
+	_ASM_PTR " 999b\n\t"					\
+	".popsection\n\t"
+
 #if defined(CONFIG_X86_64) && defined(RETPOLINE)
 
 /*
@@ -153,6 +171,7 @@
 # define CALL_NOSPEC						\
 	ANNOTATE_NOSPEC_ALTERNATIVE				\
 	ALTERNATIVE(						\
+	ANNOTATE_RETPOLINE_SAFE					\
 	"call *%[thunk_target]\n",				\
 	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
 	X86_FEATURE_RETPOLINE)
