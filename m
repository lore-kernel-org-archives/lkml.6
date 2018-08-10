Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A89C46471
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF872223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ROQ4GfxG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7uWaAsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF872223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeHJEw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:52:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41807 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeHJEwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:52:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8245321EE9;
        Thu,  9 Aug 2018 22:25:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 22:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nzTe4qeCgn8dnqo0v
        yd+mPIXtPIzBuO4PJuQFezREjI=; b=ROQ4GfxGrgnPO9ozGOKnhRjiligbaqJzJ
        KnRmAEVQtSN9+m4mv7+iqVyEzKadqACRJ4j47AQm62ag/xLaTwV7TJUg041etxz/
        BFaiOh0htIL/iLifSOOuDuNTIWXbqFXNBVptcCrcZ0TjpHGbYVGyvWr+GlH7kPgr
        ZoNC3+JXs2eIH5JV86wOqFA9dusk6sYXtNkvD0nukJfFjfmfxTz3ALdjP+EBkc8r
        EcD2bPOZhbiV0hvT4Y3frc+AGOUVd5THqiGeZbZElyJ0b0COOGvUtAEcrogP3IK2
        tCCpZ+K63yTbHNsy7sF44Nx5gTZpQA+yiVKv0TIRh7xETneSnKorg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=nzTe4qeCgn8dnqo0vyd+mPIXtPIzBuO4PJuQFezREjI=; b=R7uWaAsv
        2N6972VhR24c3bFWE+VtrIzhuRSFnWsiqtK2ykqjaEhTSkP+m5BR3FxuWSD7JBv4
        66W4wbzD46W3O3nAy5Opc3JN2U4qelek/Zf36BrdNsI1TCkw4W0at4CTx5jGGCBb
        /8HsSILRtew83i4LK45u7ryaiZ5dUPrcloFU2/6PglYQ16kjF//orCXL+Bxi+Quz
        nYMOVyy/Anp12cO12Sh7QVyyAdrpLZgo+Xe9rxFuGCxO7O9qtGYjGU9X6Ug/7jHf
        J14PPnNKsAm4piqIJfpTpgqPBAkGB31ZWTQS/oqKPNok3d8BJ5vnDq1WmV17DPv/
        gV95NPJE4MV8Hw==
X-ME-Proxy: <xmx:h_dsWzckibugV1sHGyaV_2HhAjrTepuscg9nKPlucvnNRw3ht1D4pQ>
    <xmx:h_dsWw0xfJiQ5sXRxDCtLnsbPOjo1EwwqjrhnI_O95ELPjCNC6HgNg>
    <xmx:h_dsW6KLV40IhsjDWfhAymRGMCr5jsTMDbYG6eR3wCYfUBYT4_RBtg>
    <xmx:h_dsW_G9np5J9RKyklaS1JDF1WER3OvSzmgGIs5oLCFvCt9go--J6g>
    <xmx:h_dsW2WDUrV13urjSEl6gKQmKxp5Tt0diLFXCZ_iHBRsOlnYYPhJLA>
    <xmx:h_dsW0dGpaz4RKKs3KUlOsusMkZsz7PpryLywSlA5_95t5F_wsFPGA>
X-ME-Sender: <xms:h_dsW_0C74cglZwXw6lTXQffk_RLIwPDOb9lMXxp1xvdSSfcvtwZEw>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id A812110288;
        Thu,  9 Aug 2018 22:25:10 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] docs: Judiciously use double ticks
Date:   Fri, 10 Aug 2018 12:24:49 +1000
Message-Id: <20180810022450.1237-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810022450.1237-1-me@tobin.cc>
References: <20180810022450.1237-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double ticks _can_ make the documentation easier to follow in HTML.
They can however make the documentation _harder_ to read in plain text.
We should use double ticks but judiciously.

Judiciously use double ticks to replace single ticks.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/userspace-api/eBPF.rst | 69 ++++++++++++++--------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/Documentation/userspace-api/eBPF.rst b/Documentation/userspace-api/eBPF.rst
index 6fe1d966aee9..e4764fbf5376 100644
--- a/Documentation/userspace-api/eBPF.rst
+++ b/Documentation/userspace-api/eBPF.rst
@@ -153,7 +153,7 @@ to in-kernel function.  If R1 - R5 registers are mapped to CPU registers
 that are used for argument passing on given architecture, the JIT
 compiler doesn't need to emit extra moves.  Function arguments will be
 in the correct registers and BPF_CALL instruction will be JITed as
-single 'call' HW instruction.  This calling convention was picked to
+single ``call`` HW instruction.  This calling convention was picked to
 cover common call situations without performance penalty.
 
 After an in-kernel function call, R1 - R5 are reset to unreadable and R0
@@ -266,7 +266,7 @@ Which is in this example equivalent in C to::
 
 In-kernel functions foo() and bar() with prototype: u64 (*)(u64 arg1,
 u64 arg2, u64 arg3, u64 arg4, u64 arg5); will receive arguments in
-proper registers and place their return value into '%rax' which is R0 in
+proper registers and place their return value into ``%rax`` which is R0 in
 eBPF.  Prologue and epilogue are emitted by JIT and are implicit in the
 interpreter.  R0-R5 are scratch registers, so eBPF program needs to
 preserve them across the calls as defined by calling convention.
@@ -423,7 +423,7 @@ exactly the same operations as BPF_ALU, but with 64-bit wide operands
 instead.  So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition i.e.
 dst_reg = dst_reg + src_reg
 
-Classic BPF wastes the whole BPF_RET class to represent a single 'ret'
+Classic BPF wastes the whole BPF_RET class to represent a single ``ret``
 operation.  Classic BPF_RET | BPF_K means copy imm32 into return
 register and perform function exit.  eBPF is modeled to match CPU, so
 BPF_JMP | BPF_EXIT in eBPF means function exit only.  The eBPF program
@@ -467,7 +467,7 @@ eBPF has two non-generic instructions: (BPF_ABS | <size> | BPF_LD) and
 
 They had to be carried over from classic to have strong performance of
 socket filters running in eBPF interpreter.  These instructions can only
-be used when interpreter context is a pointer to 'struct sk_buff' and
+be used when interpreter context is a pointer to ``struct sk_buff`` and
 have seven implicit operands.  Register R6 is an implicit input that
 must contain pointer to sk_buff.  Register R0 is an implicit output
 which contains the data fetched from the packet.  Registers R1-R5 are
@@ -500,7 +500,7 @@ Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.  Note that 1
 and 2 byte atomic increments are not supported.
 
 eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which
-consists of two consecutive 'struct bpf_insn' 8-byte blocks and is
+consists of two consecutive ``struct bpf_insn`` 8-byte blocks and is
 interpreted as single instruction that loads 64-bit immediate value into
 a dst_reg.
 
@@ -563,8 +563,8 @@ alignment checked.  For example::
 will be rejected, since R1 doesn't have a valid pointer type at the time
 of execution of instruction bpf_xadd.
 
-At the start R1 type is PTR_TO_CTX (a pointer to generic 'struct
-bpf_context').  A callback is used to customize verifier to restrict
+At the start R1 type is PTR_TO_CTX (a pointer to generic ``struct
+bpf_context``).  A callback is used to customize verifier to restrict
 eBPF program access to only certain fields within ctx structure with
 specified size and alignment.
 
@@ -626,7 +626,7 @@ Register value tracking
 
 In order to determine the safety of an eBPF program, the verifier must
 track the range of possible values in each register and also in each
-stack slot.  This is done with 'struct bpf_reg_state', defined in
+stack slot.  This is done with ``struct bpf_reg_state``, defined in
 include/linux/bpf_verifier.h, which unifies tracking of scalar and
 pointer values.  Each register state has a type, which is either
 NOT_INIT (the register has not been written to), SCALAR_VALUE (some
@@ -713,7 +713,7 @@ data via skb->data and skb->data_end pointers, e.g.::
   6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
 
 this 2byte load from the packet is safe to do, since the program author
-did check 'if (skb->data + 14 > skb->data_end) goto err' at insn #5
+did check ``if (skb->data + 14 > skb->data_end) goto err`` at insn #5
 which means that in the fall-through case the register R3 (which points
 to skb->data) has at least 14 directly accessible bytes.  The verifier
 marks it as R3=pkt(id=0,off=0,r=14).  id=0 means that no additional
@@ -721,8 +721,8 @@ variables were added to the register.  off=0 means that no additional
 constants were added.  r=14 is the range of safe access which means that
 bytes [R3, R3 + 14) are ok.  Note that R5 is marked as
 R5=pkt(id=0,off=14,r=14).  It also points to the packet data, but
-constant 14 was added to the register, so it now points to 'skb->data +
-14' and accessible range is [R5, R5 + 14 - 14) which is zero bytes.
+constant 14 was added to the register, so it now points to ``skb->data +
+14`` and accessible range is [R5, R5 + 14 - 14) which is zero bytes.
 
 More complex packet access may look like::
 
@@ -743,30 +743,29 @@ More complex packet access may look like::
   R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
   19:  r1 = *(u8 *)(r3 +4)
 
-The state of the register R3 is R3=pkt(id=2,off=0,r=8) id=2 means that
-two 'r3 += rX' instructions were seen, so r3 points to some offset
-within a packet and since the program author did 'if (r3 + 8 > r1) goto
-err' at insn #18, the safe range is [R3, R3 + 8).  The verifier only
-allows 'add'/'sub' operations on packet registers.  Any other operation
-will set the register state to 'SCALAR_VALUE' and it won't be available
-for direct packet access.  Operation 'r3 += rX' may overflow and become
-less than original skb->data, therefore the verifier has to prevent
-that.  So when it sees 'r3 += rX' instruction and rX is more than 16-bit
-value, any subsequent bounds-check of r3 against skb->data_end will not
-give us 'range' information, so attempts to read through the pointer
-will give "invalid access to packet" error.  Ex. after insn 'r4 = *(u8
-*)(r3 +12)' (insn #7 above) the state of r4 is
-R4=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) which means that upper
-56 bits of the register are guaranteed to be zero, and nothing is known
-about the lower 8 bits.  After insn 'r4 *= 14' the state becomes
-R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since multiplying an
-8-bit value by constant 14 will keep upper 52 bits as zero, also the
-least significant bit will be zero as 14 is even.  Similarly 'r2 >>= 48'
-will make R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)), since the
-shift is not sign extending.  This logic is implemented in
-adjust_reg_min_max_vals() function, which calls
-adjust_ptr_min_max_vals() for adding pointer to scalar (or vice versa)
-and adjust_scalar_min_max_vals() for operations on two scalars.
+The state of the register R3 is ``R3=pkt(id=2,off=0,r=8)`` id=2 means that
+two ``r3 += rX`` instructions were seen, so r3 points to some offset within
+a packet and since the program author did ``if (r3 + 8 > r1) goto err`` at
+insn #18, the safe range is [R3, R3 + 8).  The verifier only allows
+'add'/'sub' operations on packet registers.  Any other operation will set
+the register state to 'SCALAR_VALUE' and it won't be available for direct
+packet access.  Operation ``r3 += rX`` may overflow and become less than
+original skb->data, therefore the verifier has to prevent that.  So when it
+sees ``r3 += rX`` instruction and rX is more than 16-bit value, any
+subsequent bounds-check of r3 against skb->data_end will not give us
+'range' information, so attempts to read through the pointer will give
+"invalid access to packet" error.  Ex. after insn ``r4 = *(u8 *)(r3 +12)``
+(insn #7 above) the state of r4 is R4=inv(id=0,umax_value=255,var_off=(0x0;
+0xff)) which means that upper 56 bits of the register are guaranteed to be
+zero, and nothing is known about the lower 8 bits.  After insn ``r4 *= 14``
+the state becomes R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since
+multiplying an 8-bit value by constant 14 will keep upper 52 bits as zero,
+also the least significant bit will be zero as 14 is even.  Similarly ``r2
+>>= 48`` will make R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)),
+since the shift is not sign extending.  This logic is implemented in
+adjust_reg_min_max_vals() function, which calls adjust_ptr_min_max_vals()
+for adding pointer to scalar (or vice versa) and
+adjust_scalar_min_max_vals() for operations on two scalars.
 
 The end result is that bpf program author can access packet directly
 using normal C code as::
-- 
2.17.1

