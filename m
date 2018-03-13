Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvNppmUCsNdM1QOUR6tXOfagG4B1he2kpeop1D5tRiowcg5Q5l2Wpr27mXXUyJVvEh4l4c2
ARC-Seal: i=1; a=rsa-sha256; t=1520955120; cv=none;
        d=google.com; s=arc-20160816;
        b=wuFb6dh8v2ilgaF2euHiaFYMG4A+EWlf27hqOZZJ/ulUoW2JFsl3s5Jnr0CHuv4NZh
         bxXDzLFwFGYllzuJEjPyx/bLJzv2mOujvyZOD5xT3/oskIWXyCWhbyTKtYDMt1zIHRKZ
         G09ucspxkKJUQgdKtOSBxyy1DQAHWpug6w9nwCsS8BJ9S7mtqixlzP27maGmQAfktZVE
         8NGs6MDlyzyPyCW8ExmplBbpEXw5q55RDlIk+AX7SjWVIyaMlzTj4sMfvrc9OlIA+HtD
         IsszYyC/GdiD9LGkWWJ5Lt0e3n+rf2MBrdh6ODlmU0+MSgrmt4C/0/yEmAlH0h0YIAgE
         NICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZPRlVdaozkAwZ6C7GsGI01PU3apm9UtSuqYY2fA0A1w=;
        b=oolWq3tFHjPO/eqAC/1Udg8MYMsTCgUca13iuDiUZDTzC9egP+TkLZpkJhXxpReAZu
         uf17YZEovsg38RjxE4wr4mLobIEZZ5SzGC8BbMFxYmlXxAUhxpRvLzoWnx022UJvwnzz
         wW51xvGMFBgzbhzF7O5tBTlgVQn5WO1ajsedNL4FzjIoB2E5tRDdWkfRCVC8FEuP7Y0J
         vTuHFvxCmU+d0fMbCpHJD8EX56505/TM0Ub0g4amA4DecN/cAKBeSGAvmcEjTasB6jeX
         VhtDJ3wogTzdwZkXrVmaSrSubEmSYLrsT2SEoMDfFx1isvb+0zoFAN6VjmDI+H27gF5h
         6hrQ==
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
Subject: [PATCH 4.15 095/146] x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
Date: Tue, 13 Mar 2018 16:24:22 +0100
Message-Id: <20180313152327.961496713@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837036467128835?=
X-GMAIL-MSGID: =?utf-8?q?1594837036467128835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit bd89004f6305cbf7352238f61da093207ee518d6 upstream.

The objtool retpoline validation found this indirect jump. Seeing how
it's on CPU bringup before we run userspace it should be safe, annotate
it.

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
 arch/x86/kernel/head_64.S |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include <asm/nops.h>
 #include "../entry/calling.h"
 #include <asm/export.h>
+#include <asm/nospec-branch.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -134,6 +135,7 @@ ENTRY(secondary_startup_64)
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
 	UNWIND_HINT_EMPTY
