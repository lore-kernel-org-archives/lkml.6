Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162658-2-3960585057492125217
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162658; b=F4G872B0gZ57ZRL6sVhmJdcwkrCqqbmvxvX1HxsP6LkyI9GH47
    deN3SiGsYWtM2dlRzoQ6oSheNjDGoxdEfIciJZ7mMbgFIliJXyEzBDoUz3ghQcgx
    hMpRmmcpNie5pLNXw5Gpr9Xv19Yy6xOXTEVpYJL+oz40+5Q+ciLxReYoaCzO7P/O
    r7tkjVi8yzqkH5g4CoLjAXMq3f6Rs7XUAsPJfV5QyAUBHwjHCS2bFOHQOa51Y/gj
    1xSnhjhc7Q2HeB4ig7guG1blo3dDnH/Rm4r9ehwojCEgUKoOh8X/TC35H6n+pUAd
    IT0wdn9eQclHA1vbm/ivnmorrGDkAvwlIzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162658; bh=TBfFPo/m+lijF0+0GqEMNKKQEMKB1g
    rWDGPxUcacoTk=; b=lsbeByb0oVRT1VVm1AL6FvPfuLmi5Zrp810J2vhVGA9q8A
    AKjEDWDxr2nlgkjPChyMOjR/mp2CuG9CIeEQRR/mqqKmUWt4sm8ynT092PmqVnaG
    JZxMknphSYO7iiezSdEtTds0GJ85UxYomvfqXXVrwZ6Qc+yOxLPExX4KWN7eCrDw
    c9OQ5XPqRS/xPO90UBe/uJJJ41VNYgqNHgiFDDdKooF7V+Vtm2DmIu24MJbdrrfj
    iwnt3CxXwNZ4l4AEVn9uYQORprh1N2qbqVLgvqyyb8482vSIo8QgLSqxxITVNJ82
    t79fijR3w1L1LoGnQ4NyOh9CcLdfvYcRAZRgXnMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MtW9IV7n x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=MtW9IV7n x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPQ1cjJ6pfKesQUFJ1sCiFVWIIRDf8Ob9gMLqiekNkTFJSzzrBhAl5fK/oYtVlFg3pHgoSvO22DbimVCGWmY78qCZW9HO28vbMYp0Q0qcni6x0pyFXko
    iCygDQtNcnQXCAu8OSB4/AJmErg973+gAFwvFHTkhC0V9lGHkt2ENkREn/OU0U0uwIUyF+5Lz1akRh7MCdeZ6jRQtXOEaR+cNf8CKN2FeaokTbK0K49Pb9zl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=ri-GQuXACv77juQeL10A:9
    a=Jut7cI41H8T5KsYh:21 a=9yjvXDHs8Mt41E2s:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969340AbeEXLux (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966941AbeEXJqu (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 83/92] s390: use expoline thunks in the BPF JIT
Date: Thu, 24 May 2018 11:39:00 +0200
Message-Id: <20180524093207.228733985@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[ Upstream commit de5cb6eb514ebe241e3edeb290cb41deb380b81d ]

The BPF JIT need safe guarding against spectre v2 in the sk_load_xxx
assembler stubs and the indirect branches generated by the JIT itself
need to be converted to expolines.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/net/bpf_jit.S      |   16 ++++++----
 arch/s390/net/bpf_jit_comp.c |   63 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 8 deletions(-)

--- a/arch/s390/net/bpf_jit.S
+++ b/arch/s390/net/bpf_jit.S
@@ -8,6 +8,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include "bpf_jit.h"
 
 /*
@@ -53,7 +54,7 @@ ENTRY(sk_load_##NAME##_pos);						\
 	clg	%r3,STK_OFF_HLEN(%r15);	/* Offset + SIZE > hlen? */	\
 	jh	sk_load_##NAME##_slow;					\
 	LOAD	%r14,-SIZE(%r3,%r12);	/* Get data from skb */		\
-	b	OFF_OK(%r6);		/* Return */			\
+	B_EX	OFF_OK,%r6;		/* Return */			\
 									\
 sk_load_##NAME##_slow:;							\
 	lgr	%r2,%r7;		/* Arg1 = skb pointer */	\
@@ -63,11 +64,14 @@ sk_load_##NAME##_slow:;							\
 	brasl	%r14,skb_copy_bits;	/* Get data from skb */		\
 	LOAD	%r14,STK_OFF_TMP(%r15);	/* Load from temp bufffer */	\
 	ltgr	%r2,%r2;		/* Set cc to (%r2 != 0) */	\
-	br	%r6;			/* Return */
+	BR_EX	%r6;			/* Return */
 
 sk_load_common(word, 4, llgf)	/* r14 = *(u32 *) (skb->data+offset) */
 sk_load_common(half, 2, llgh)	/* r14 = *(u16 *) (skb->data+offset) */
 
+	GEN_BR_THUNK %r6
+	GEN_B_THUNK OFF_OK,%r6
+
 /*
  * Load 1 byte from SKB (optimized version)
  */
@@ -79,7 +83,7 @@ ENTRY(sk_load_byte_pos)
 	clg	%r3,STK_OFF_HLEN(%r15)	# Offset >= hlen?
 	jnl	sk_load_byte_slow
 	llgc	%r14,0(%r3,%r12)	# Get byte from skb
-	b	OFF_OK(%r6)		# Return OK
+	B_EX	OFF_OK,%r6		# Return OK
 
 sk_load_byte_slow:
 	lgr	%r2,%r7			# Arg1 = skb pointer
@@ -89,7 +93,7 @@ sk_load_byte_slow:
 	brasl	%r14,skb_copy_bits	# Get data from skb
 	llgc	%r14,STK_OFF_TMP(%r15)	# Load result from temp buffer
 	ltgr	%r2,%r2			# Set cc to (%r2 != 0)
-	br	%r6			# Return cc
+	BR_EX	%r6			# Return cc
 
 #define sk_negative_common(NAME, SIZE, LOAD)				\
 sk_load_##NAME##_slow_neg:;						\
@@ -103,7 +107,7 @@ sk_load_##NAME##_slow_neg:;						\
 	jz	bpf_error;						\
 	LOAD	%r14,0(%r2);		/* Get data from pointer */	\
 	xr	%r3,%r3;		/* Set cc to zero */		\
-	br	%r6;			/* Return cc */
+	BR_EX	%r6;			/* Return cc */
 
 sk_negative_common(word, 4, llgf)
 sk_negative_common(half, 2, llgh)
@@ -112,4 +116,4 @@ sk_negative_common(byte, 1, llgc)
 bpf_error:
 # force a return 0 from jit handler
 	ltgr	%r15,%r15	# Set condition code
-	br	%r6
+	BR_EX	%r6
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -24,6 +24,8 @@
 #include <linux/bpf.h>
 #include <asm/cacheflush.h>
 #include <asm/dis.h>
+#include <asm/facility.h>
+#include <asm/nospec-branch.h>
 #include "bpf_jit.h"
 
 int bpf_jit_enable __read_mostly;
@@ -41,6 +43,8 @@ struct bpf_jit {
 	int base_ip;		/* Base address for literal pool */
 	int ret0_ip;		/* Address of return 0 */
 	int exit_ip;		/* Address of exit */
+	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
+	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
 	int labels[1];		/* Labels for local jumps */
 };
@@ -248,6 +252,19 @@ static inline void reg_set_seen(struct b
 	REG_SET_SEEN(b2);					\
 })
 
+#define EMIT6_PCREL_RILB(op, b, target)				\
+({								\
+	int rel = (target - jit->prg) / 2;			\
+	_EMIT6(op | reg_high(b) << 16 | rel >> 16, rel & 0xffff);	\
+	REG_SET_SEEN(b);					\
+})
+
+#define EMIT6_PCREL_RIL(op, target)				\
+({								\
+	int rel = (target - jit->prg) / 2;			\
+	_EMIT6(op | rel >> 16, rel & 0xffff);			\
+})
+
 #define _EMIT6_IMM(op, imm)					\
 ({								\
 	unsigned int __imm = (imm);				\
@@ -475,8 +492,45 @@ static void bpf_jit_epilogue(struct bpf_
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
 	save_restore_regs(jit, REGS_RESTORE);
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+		jit->r14_thunk_ip = jit->prg;
+		/* Generate __s390_indirect_jump_r14 thunk */
+		if (test_facility(35)) {
+			/* exrl %r0,.+10 */
+			EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
+		} else {
+			/* larl %r1,.+14 */
+			EMIT6_PCREL_RILB(0xc0000000, REG_1, jit->prg + 14);
+			/* ex 0,0(%r1) */
+			EMIT4_DISP(0x44000000, REG_0, REG_1, 0);
+		}
+		/* j . */
+		EMIT4_PCREL(0xa7f40000, 0);
+	}
 	/* br %r14 */
 	_EMIT2(0x07fe);
+
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable &&
+	    (jit->seen & SEEN_FUNC)) {
+		jit->r1_thunk_ip = jit->prg;
+		/* Generate __s390_indirect_jump_r1 thunk */
+		if (test_facility(35)) {
+			/* exrl %r0,.+10 */
+			EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
+			/* j . */
+			EMIT4_PCREL(0xa7f40000, 0);
+			/* br %r1 */
+			_EMIT2(0x07f1);
+		} else {
+			/* larl %r1,.+14 */
+			EMIT6_PCREL_RILB(0xc0000000, REG_1, jit->prg + 14);
+			/* ex 0,S390_lowcore.br_r1_tampoline */
+			EMIT4_DISP(0x44000000, REG_0, REG_0,
+				   offsetof(struct _lowcore, br_r1_trampoline));
+			/* j . */
+			EMIT4_PCREL(0xa7f40000, 0);
+		}
+	}
 }
 
 /*
@@ -980,8 +1034,13 @@ static noinline int bpf_jit_insn(struct
 		/* lg %w1,<d(imm)>(%l) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W1, REG_0, REG_L,
 			      EMIT_CONST_U64(func));
-		/* basr %r14,%w1 */
-		EMIT2(0x0d00, REG_14, REG_W1);
+		if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+			/* brasl %r14,__s390_indirect_jump_r1 */
+			EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
+		} else {
+			/* basr %r14,%w1 */
+			EMIT2(0x0d00, REG_14, REG_W1);
+		}
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 		if (bpf_helper_changes_skb_data((void *)func)) {
