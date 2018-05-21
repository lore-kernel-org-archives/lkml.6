Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526938025-2-16325950061671574293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938024; b=axafcsRZSN0+UNjwgqNf099F/VLFH7lQsvvnVDUKhoQEGw9Elg
    bgQgyJSFEXqXEfMtXUL+fknwjZ21X35Hw7mXjrYhfgORWIeO3rPFtOibCZShNQ39
    ioIYfGBDNEdJH+DktuOXx67OyDR8ZWShT+y3K7iLrfs8brhM/pK/rKXHWHsvXw5K
    4fNE8UbRUPFoJtV1gtHFSyutSbtpy37P65klQZiGWYWx+tMaEpqS3Xsx+JH1auP4
    KS6YVtjhfTI/pJ00MhoX9TdzjCghMbOPbS153R2NiJEjI/9oVWTlBX91/7DBy+Tm
    QOzokBUBG/uvVNB/UzfAnot7MaMYDzpkh/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938024; bh=1oZ0t6gpftp9iJm02ejBBZoTWFPvfY
    8LoDmYv3SaunE=; b=kPe4E6gCSJbot90X6RG5XsDOfyVHLP43bAhX8ky2mwwIkS
    LTiijynUhQxlDk2A/pOuvyFTWuBDM9/5mEKWNXUHHdcD2U4IZ6Lv6oXM+t44onbR
    yl76D5Jw75J3CrxgAyDEthwfrSTqejTkt0LvreKQReUpgq/nN3LfJzWnK1rPQxUG
    I8Lic63BV6H92rNKcmUjBhQ1fpEPpKFtcvB8HcarbXqANAdqXwEPGoDV5YqpN1Jm
    xpJgCNJqTZR0Wn6RpaXTygtegJf0PjV9qXGenmvsPieTrY9u7VSUk4kj3eyzL+X7
    5Du6Q2F5/yXqOH8HltCvSnbgtX44OhC39jvI/0qQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=yn0r8fzb x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=yn0r8fzb x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcROfoayUTlRa6h9xv3zADT+kFuGBwg+A8thwBmpsljGd6JYhfoYQSnzNDIuKvYKHx6nJcFhGru4D89E5Ie6GyD1tB6nmQY8K8ykoua0zUeeAFz5BX8
    qn21ktJxHDLVNKdStoiXM/Z/K0/nmecatBRnK/PATIY4V0Bobo7e4OiRs4eKDQylJRDceWf4TSGer0d16H1xAvbdsZ9FAv5/Thk1e7gt30yY6aaXMey69Ce0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=0KWrXloaP-1o7eCutvEA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeEUV06 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932660AbeEUV04 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 110/110] bpf: Prevent memory disambiguation attack
Date: Mon, 21 May 2018 23:12:47 +0200
Message-Id: <20180521210515.145840770@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

commit af86ca4e3088fe5eacf2f7e58c01fa68ca067672 upstream

Detect code patterns where malicious 'speculative store bypass' can be used
and sanitize such patterns.

 39: (bf) r3 = r10
 40: (07) r3 += -216
 41: (79) r8 = *(u64 *)(r7 +0)   // slow read
 42: (7a) *(u64 *)(r10 -72) = 0  // verifier inserts this instruction
 43: (7b) *(u64 *)(r8 +0) = r3   // this store becomes slow due to r8
 44: (79) r1 = *(u64 *)(r6 +0)   // cpu speculatively executes this load
 45: (71) r2 = *(u8 *)(r1 +0)    // speculatively arbitrary 'load byte'
                                 // is now sanitized

Above code after x86 JIT becomes:
 e5: mov    %rbp,%rdx
 e8: add    $0xffffffffffffff28,%rdx
 ef: mov    0x0(%r13),%r14
 f3: movq   $0x0,-0x48(%rbp)
 fb: mov    %rdx,0x0(%r14)
 ff: mov    0x0(%rbx),%rdi
103: movzbq 0x0(%rdi),%rsi

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/bpf_verifier.h |    1 
 kernel/bpf/verifier.c        |   59 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 57 insertions(+), 3 deletions(-)

--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -146,6 +146,7 @@ struct bpf_insn_aux_data {
 		s32 call_imm;			/* saved imm field of call insn */
 	};
 	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
+	int sanitize_stack_off; /* stack slot to be cleared */
 	bool seen; /* this insn was processed by the verifier */
 };
 
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -970,7 +970,7 @@ static bool register_is_null(struct bpf_
  */
 static int check_stack_write(struct bpf_verifier_env *env,
 			     struct bpf_func_state *state, /* func where register points to */
-			     int off, int size, int value_regno)
+			     int off, int size, int value_regno, int insn_idx)
 {
 	struct bpf_func_state *cur; /* state of the current function */
 	int i, slot = -off - 1, spi = slot / BPF_REG_SIZE, err;
@@ -1009,8 +1009,33 @@ static int check_stack_write(struct bpf_
 		state->stack[spi].spilled_ptr = cur->regs[value_regno];
 		state->stack[spi].spilled_ptr.live |= REG_LIVE_WRITTEN;
 
-		for (i = 0; i < BPF_REG_SIZE; i++)
+		for (i = 0; i < BPF_REG_SIZE; i++) {
+			if (state->stack[spi].slot_type[i] == STACK_MISC &&
+			    !env->allow_ptr_leaks) {
+				int *poff = &env->insn_aux_data[insn_idx].sanitize_stack_off;
+				int soff = (-spi - 1) * BPF_REG_SIZE;
+
+				/* detected reuse of integer stack slot with a pointer
+				 * which means either llvm is reusing stack slot or
+				 * an attacker is trying to exploit CVE-2018-3639
+				 * (speculative store bypass)
+				 * Have to sanitize that slot with preemptive
+				 * store of zero.
+				 */
+				if (*poff && *poff != soff) {
+					/* disallow programs where single insn stores
+					 * into two different stack slots, since verifier
+					 * cannot sanitize them
+					 */
+					verbose(env,
+						"insn %d cannot access two stack slots fp%d and fp%d",
+						insn_idx, *poff, soff);
+					return -EINVAL;
+				}
+				*poff = soff;
+			}
 			state->stack[spi].slot_type[i] = STACK_SPILL;
+		}
 	} else {
 		u8 type = STACK_MISC;
 
@@ -1685,7 +1710,7 @@ static int check_mem_access(struct bpf_v
 
 		if (t == BPF_WRITE)
 			err = check_stack_write(env, state, off, size,
-						value_regno);
+						value_regno, insn_idx);
 		else
 			err = check_stack_read(env, state, off, size,
 					       value_regno);
@@ -5156,6 +5181,34 @@ static int convert_ctx_accesses(struct b
 		else
 			continue;
 
+		if (type == BPF_WRITE &&
+		    env->insn_aux_data[i + delta].sanitize_stack_off) {
+			struct bpf_insn patch[] = {
+				/* Sanitize suspicious stack slot with zero.
+				 * There are no memory dependencies for this store,
+				 * since it's only using frame pointer and immediate
+				 * constant of zero
+				 */
+				BPF_ST_MEM(BPF_DW, BPF_REG_FP,
+					   env->insn_aux_data[i + delta].sanitize_stack_off,
+					   0),
+				/* the original STX instruction will immediately
+				 * overwrite the same stack slot with appropriate value
+				 */
+				*insn,
+			};
+
+			cnt = ARRAY_SIZE(patch);
+			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			continue;
+		}
+
 		if (env->insn_aux_data[i + delta].ptr_type != PTR_TO_CTX)
 			continue;
 
