Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvv4+i+F/yjZ6rrazlIuKIa9+Ky5056HNZyt4ikaT2rNMAK3Ua9aEC5MYFf1BsKvjBkkvPc
ARC-Seal: i=1; a=rsa-sha256; t=1520966032; cv=none;
        d=google.com; s=arc-20160816;
        b=peld2Pw+9rsXszXP2g529kEguAwxHFRzTSEU37Rj7t/RHSWNn/Q/iHIycfy56tRTx3
         FVLbaHzKLkBFArDQIJnYz0TZKBtQuGRzzX7+yRLvjpmbpJYBcxnGyGkZMzERT7VVxLuf
         zObkI/UCu1en4omlMBq2pAxtTaPHoVeLCBY1pCCBsF3mklLKCygtxel5LYiJAKqHhitH
         1mkW1nWpqbMhwwG8+C7Ro9VPeP1EJPVbZwLMSM1pIpre2FY3fT1FwLlkxUm2fXpJYMhM
         Wl+rCygS5bhrgq0Z5ytLl8ugnyqg+6FYiR7nqBoTVbT1AFoDXc/wFgj5r9lyVfpgOfze
         ewOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=28jtqkuI/3INGkGjZKgFJyOIS31V8rzqeF41hUcJBb8=;
        b=Q9+szmZTZVphYfuCyMJ51xgV7Mmj601TBUOEfB92qAiF/mmFYZdgV7h410JzsrdJ3v
         I8TSMUUuAqSiaMoVX2V4N6MaDxjBqT/XTDxw/HQg2BLmy+UJUt2bt8b/axoOy/ROVnbV
         iezGs7OfAVoKz5sNW4zdCdnSGr5IhemJo3SYQ5Wp2jfhw/Ehh4phz/s0MFfY5fV1Plup
         nn7TibLT1ZEP9l6Xsl6iCJI6S9Qa7FCBLITINSI8UnwjaB9dIDBAHPe40/r0gm0qbf3k
         iFMB6kxFlLTZrLkI5Wv134GjpZuSHrP+K68P7N79iatrlM+EO0WK4iLWoJh3CUorlmuY
         3Siw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/8] powerpc/64: Use barrier_nospec in syscall entry
Date: Tue, 13 Mar 2018 19:33:01 +0100
Message-Id: <7121fe11b8ecbc0dd041819d8d331324df58c0e0.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
In-Reply-To: <cover.1520965380.git.msuchanek@suse.de>
References: <cover.1520965380.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848478381218409?=
X-GMAIL-MSGID: =?utf-8?q?1594848478381218409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..7bfc4cf48af2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -159,6 +160,7 @@ system_call:			/* label this so stack traces look sane */
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
 	cmpldi	0,r0,NR_syscalls
+	barrier_nospec
 	bge-	.Lsyscall_enosys
 
 .Lsyscall:
@@ -319,6 +321,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
+	barrier_nospec
 	blt+	.Lsyscall
 
 	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
-- 
2.13.6
