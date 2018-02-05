Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227LdTN6xb3cwZkim+livharCqWk+75DmBrm2WHBfxvvYb4cx8d6Jb34yZDnBy9zXGsWNCao
ARC-Seal: i=1; a=rsa-sha256; t=1517855092; cv=none;
        d=google.com; s=arc-20160816;
        b=Flvkn3m5vRDSsoTqRQhYsB5Wq1s2xxgmOZc7ewSAT/42cWmmh15ZNeuFuSYfE0IbHH
         Edks2Zs1/uZA5vaLKC4KqfFgjNoC2nqePVZsa30IoVZi608LVGDKHSBDRQaAbIBczuV4
         GHZvj+zV96ECzF5jWSBbtyyr7XyDafbPdMmnYiybPfwUvxpRhwK8kRmR5SzW5GXVYCBC
         XUaHCXbrxpzGariFYIPuiXjq0eczidk8VYg8PPG+hiuuVK32B1c/UpxI14il9FpPNeZ8
         tqXXpeFq9bQm/zYJIsDBsua+ML7padOYsiL4fmJ6sqvaBFV0L/GKvDHqQMZZgZrCCrsa
         78UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YoXPp7RhRi70Bz1EZwfmF9kShonOvlCtwQnvzfJCH10=;
        b=J+kCf/7h13rWFX0s5yN6RE8vO+nZcvNgBNoB+ddPYjxejU5OjvgTtqRz8suJhoIAUt
         EJLtQudCUryQNdS4tY361vp5iRhZWaQPR3D+uTxNaeKBfiBA1Z5VfoM50IMqmU7yOYwK
         Y1DTIjXdcFneFV9fFaagT6f/dajhqEVv5p0GISNbRnXhR0K4Z+gs9a3hd7hhCBZPe16k
         cZtuchs6e7WkmpzxoiYLjr5Y6yuQ23zJPtMDWWXRBuC58mGEPvJMaWJOpqbxSXGIKumq
         hqZzLzPhXlaFYvMkOhj4gd4RlBTcWVFIR7iKJZGAds2/1BCfeU9Rs0eHCNoU+5KDcYNo
         ohiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	riel@redhat.com,
	ak@linux.intel.com,
	peterz@infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	jikos@kernel.org,
	luto@amacapital.net,
	dave.hansen@intel.com,
	torvalds@linux-foundation.org,
	keescook@google.com,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	tim.c.chen@linux.intel.com,
	pjt@google.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 11/60] x86/alternative: Print unadorned pointers
Date: Mon,  5 Feb 2018 10:22:44 -0800
Message-Id: <20180205182214.391249322@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586338745413455?=
X-GMAIL-MSGID: =?utf-8?q?1591586420763949642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov bp@suse.de

commit 0e6c16c652cadaffd25a6bb326ec10da5bcec6b4

After commit ad67b74d2469 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. However, this makes the alternative
debug output completely useless. Switch to %px in order to see the
unadorned kernel pointers.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: riel@redhat.com
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: jikos@kernel.org
Cc: luto@amacapital.net
Cc: dave.hansen@intel.com
Cc: torvalds@linux-foundation.org
Cc: keescook@google.com
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Cc: pjt@google.com
Link: https://lkml.kernel.org/r/20180126121139.31959-2-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/alternative.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -298,7 +298,7 @@ recompute_jump(struct alt_instr *a, u8 *
 	tgt_rip  = next_rip + o_dspl;
 	n_dspl = tgt_rip - orig_insn;
 
-	DPRINTK("target RIP: %p, new_displ: 0x%x", tgt_rip, n_dspl);
+	DPRINTK("target RIP: %px, new_displ: 0x%x", tgt_rip, n_dspl);
 
 	if (tgt_rip - orig_insn >= 0) {
 		if (n_dspl - 2 <= 127)
@@ -355,7 +355,7 @@ static void __init_or_module noinline op
 	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
 	local_irq_restore(flags);
 
-	DUMP_BYTES(instr, a->instrlen, "%p: [%d:%d) optimized NOPs: ",
+	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
 		   instr, a->instrlen - a->padlen, a->padlen);
 }
 
@@ -376,7 +376,7 @@ void __init_or_module noinline apply_alt
 	u8 *instr, *replacement;
 	u8 insnbuf[MAX_PATCH_LEN];
 
-	DPRINTK("alt table %p -> %p", start, end);
+	DPRINTK("alt table %px, -> %px", start, end);
 	/*
 	 * The scan order should be from start to end. A later scanned
 	 * alternative code can overwrite previously scanned alternative code.
@@ -400,14 +400,14 @@ void __init_or_module noinline apply_alt
 			continue;
 		}
 
-		DPRINTK("feat: %d*32+%d, old: (%p, len: %d), repl: (%p, len: %d), pad: %d",
+		DPRINTK("feat: %d*32+%d, old: (%px len: %d), repl: (%px, len: %d), pad: %d",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, a->instrlen,
 			replacement, a->replacementlen, a->padlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%p: old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%p: rpl_insn: ", replacement);
+		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
+		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
 
 		memcpy(insnbuf, replacement, a->replacementlen);
 		insnbuf_sz = a->replacementlen;
@@ -433,7 +433,7 @@ void __init_or_module noinline apply_alt
 				 a->instrlen - a->replacementlen);
 			insnbuf_sz += a->instrlen - a->replacementlen;
 		}
-		DUMP_BYTES(insnbuf, insnbuf_sz, "%p: final_insn: ", instr);
+		DUMP_BYTES(insnbuf, insnbuf_sz, "%px: final_insn: ", instr);
 
 		text_poke_early(instr, insnbuf, insnbuf_sz);
 	}
