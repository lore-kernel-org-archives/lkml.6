Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yoe0cTXWMY0pu33+gR8WOekuDi/XBa10jNRLg6BA06V6GTULrMS9v769uVEUjrqmkbnZA
ARC-Seal: i=1; a=rsa-sha256; t=1517855013; cv=none;
        d=google.com; s=arc-20160816;
        b=Lu+2ZKvON3FvTolaE+4ys4laaux4w1R5rESLpXKxM9Xbzg9mM+Q7ubqO71GHFPYL7C
         ZyPiF2s4U13P8VB2hHaN7HQpCImZXS9Fv4S6iw49Q77BIHFQuMRI1lrP+U1PWh5+Zkb3
         xwnolYzAYqU8IMDR7LZJDKCstm/WXSf5gQDhbXUuZmQqGi1zHTgRQOf0jCx63Prn7Zbn
         3Hln4kWjGc6hscBJmyRhoK43VhlGB52YlWYMFXUCoYeekCcglR/D5Pz6hDIDllHzRb6U
         N8YJ84FAnxs388VxZHHp34Yta0R5V8ugp4k6EmwuuEbr1K8nrA/znmanITQB8xE8fhb4
         MfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hKl0e2+z2L3QrWJiKqqlqWvlcIx5hbke4DJqoL/Va9w=;
        b=l4sBYxD45fMXjS6P8EIOei4fGg6zKT90v4pq5i0kbMnd2I7M0fDjoSMVYsSbd/jzAE
         wcJnrA7fdQvnp7vcgf2N3aXuba4c5V6pMYWStzZQ3Wq08G3HRQPMlC+rI8oUG8rmIfVb
         mBmXs0N7hwvna2hRC9ydz9jikb43VMJu5RmTn3UqnzY/d7cE/gQlwgqMkzMYBpOycDE2
         UvKuK8xOALEe0HPeLWlMFw7IJxKbfOr1dur55BUd5PxMfFZdoIHd/QaevsAcpbydA2Ov
         L2e63be/s/VrqxNmpleOu+ixdeT9zt+J3PS2iosA2QrTK4fN0VVE5vvReNcCcM+3U2tY
         e18A==
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
Subject: [PATCH 4.14 15/64] x86/alternative: Print unadorned pointers
Date: Mon,  5 Feb 2018 10:22:34 -0800
Message-Id: <20180205182139.192877610@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586338745413455?=
X-GMAIL-MSGID: =?utf-8?q?1591586338745413455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
