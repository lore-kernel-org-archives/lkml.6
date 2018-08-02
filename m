Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2BDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B058A20BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="eaY4rhkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaR/vsOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B058A20BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeHBISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:18:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42453 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbeHBISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:18:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A41621BBE;
        Thu,  2 Aug 2018 02:29:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Aug 2018 02:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9BqKIOkve5iUXxeZK
        dvGcxDgbv4jJE/PwFVdeHYS0PM=; b=eaY4rhkNxN8cUuWOb1eh0PmA5kc6Lu0Dl
        6uAp3sv3is4X0r0cViIOi0lVayNTx4twPdDeqhmbLMduPylrSt463pcvdL9v7ACS
        Ltpb93hata6PX+pwWSf9aC6GmpJZ8iOwfZK6EHFacvLYaL46EIHkuSCrhu/F6pm9
        4jnIjfr1ueNEE1dcDK9anfTlRWK2gHNQo5daLpaXe+IV2b0qQJPXLhXIMwFyvv0R
        jiArfOMOe67tExGauNwbhvJAfbiEkqQoZ780OWvnFCh+6sg5D9lAaECdVC1uBgfW
        qOu/WM907bUVE0UVH7oIZf3B5xge96oBGaO0PMYUDfNcUzu2ZCJbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9BqKIOkve5iUXxeZKdvGcxDgbv4jJE/PwFVdeHYS0PM=; b=TaR/vsOB
        wRPcdDY0/qzdYxxwl3G2N3ZrpeV1is/78juEBo9Yf10XiylvWHhTLT8XJYzewz3K
        2cuX99to02ut5VF176RJUtZtksz4wyGhrlyKUymq8x/Btld2z8gT4+c8fX6cF6uL
        7KvDRXi+3vWMFSNhyYljubbRs53Ix7xiWcBCDFoaqZ8S19oIztBmmv479jB3ogjW
        nYkEJOIac2BhX+V8/suctqgoMpGiv+m2fV8HHjvU6xxftOAgWgARY7r7/j2Zdrx1
        m6zFJICH+50gkoDy0aly8z5o6apgMYoCviwg4bTMXZAKLzLt2535v4o3BYoVUypD
        9vVyEYsnTiqGYA==
X-ME-Proxy: <xmx:saRiWyAUDxKWe_kYGiYyarmWwWOmnyQzbgGY3wF3wZCm0RMINtxowQ>
    <xmx:saRiW8riu8z8YRU6z9QtN4glblfcDLvIdUryZDAVRtxvsxuTpHV00g>
    <xmx:saRiW9AgLr8aV_bVGp3dMJv9rKKfy1udDfNhjzfS5EC0o9wihIeL-Q>
    <xmx:saRiW3V4pSR9xATv176Nd43XfgVJWb9D6YhFNatPSUMBAosOkfisug>
    <xmx:saRiW_CL8OG6IH8u4-R3DIIIZf96fZLqBKXBTIhgZiTcP4-8cysFkg>
    <xmx:saRiWzhEPEarVqgbEyy_g2oe_ZGkolrRdS8vlNUC_ACbWUZ4KgfKxg>
X-ME-Sender: <xms:saRiW3wJGqGl73bL7HwFSn6UPQzwkk7LXbx_IADF7EUeQd5RZxgpYg>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F571E4116;
        Thu,  2 Aug 2018 02:29:04 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jay Schulist <jschlst@samba.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 1/3] docs: net: Fix various minor typos
Date:   Thu,  2 Aug 2018 16:28:46 +1000
Message-Id: <20180802062848.14332-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802062848.14332-1-me@tobin.cc>
References: <20180802062848.14332-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document contains a few minor typos and grammatical issues.  We should
however try to keep the current flavour of the document.

Fix typos and grammar if fix is _really_ an improvement.

Cc: Jay Schulist <jschlst@samba.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc; Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.txt | 66 +++++++++++++++--------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index e6b4ebb2b243..1fe4adf9c4c6 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -29,8 +29,8 @@ removing the old one and placing your new one in its place, assuming your
 filter has passed the checks, otherwise if it fails the old filter will
 remain on that socket.
 
-SO_LOCK_FILTER option allows to lock the filter attached to a socket. Once
-set, a filter cannot be removed or changed. This allows one process to
+SO_LOCK_FILTER option allows locking of the filter attached to a socket.
+Once set, a filter cannot be removed or changed. This allows one process to
 setup a socket, attach a filter, lock it then drop privileges and be
 assured that the filter will be kept until the socket is closed.
 
@@ -463,7 +463,7 @@ JIT compiler
 ------------
 
 The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC, PowerPC,
-ARM, ARM64, MIPS and s390 and can be enabled through CONFIG_BPF_JIT. The JIT
+ARM, ARM64, MIPS and s390 which can be enabled through CONFIG_BPF_JIT. The JIT
 compiler is transparently invoked for each attached filter from user space
 or for internal kernel users if it has been previously enabled by root:
 
@@ -572,7 +572,7 @@ Internally, for the kernel interpreter, a different instruction set
 format with similar underlying principles from BPF described in previous
 paragraphs is being used. However, the instruction set format is modelled
 closer to the underlying architecture to mimic native instruction sets, so
-that a better performance can be achieved (more details later). This new
+that better performance can be achieved (more details later). This new
 ISA is called 'eBPF' or 'internal BPF' interchangeably. (Note: eBPF which
 originates from [e]xtended BPF is not the same as BPF extensions! While
 eBPF is an ISA, BPF extensions date back to classic BPF's 'overloading'
@@ -647,12 +647,12 @@ Some core changes of the new internal format:
 
   32-bit architectures run 64-bit internal BPF programs via interpreter.
   Their JITs may convert BPF programs that only use 32-bit subregisters into
-  native instruction set and let the rest being interpreted.
+  native instruction set and let the rest be interpreted.
 
-  Operation is 64-bit, because on 64-bit architectures, pointers are also
-  64-bit wide, and we want to pass 64-bit values in/out of kernel functions,
-  so 32-bit eBPF registers would otherwise require to define register-pair
-  ABI, thus, there won't be able to use a direct eBPF register to HW register
+  Operation is 64-bit since on 64-bit architectures pointers are also
+  64-bit wide and we want to pass 64-bit values in/out of kernel functions.
+  32-bit eBPF registers would otherwise require us to define a register-pair
+  ABI, thus we would not be able to use a direct eBPF register to HW register
   mapping and JIT would need to do combine/split/move operations for every
   register in and out of the function, which is complex, bug prone and slow.
   Another reason is the use of atomic 64-bit counters.
@@ -677,7 +677,7 @@ Some core changes of the new internal format:
   situations without performance penalty.
 
   After an in-kernel function call, R1 - R5 are reset to unreadable and R0 has
-  a return value of the function. Since R6 - R9 are callee saved, their state
+  the return value of the function. Since R6 - R9 are callee saved, their state
   is preserved across the call.
 
   For example, consider three C functions:
@@ -715,7 +715,7 @@ Some core changes of the new internal format:
   are currently not supported, but these restrictions can be lifted if necessary
   in the future.
 
-  On 64-bit architectures all register map to HW registers one to one. For
+  On 64-bit architectures all registers map to HW registers one to one. For
   example, x86_64 JIT compiler can map them as ...
 
     R0 - rax
@@ -814,9 +814,10 @@ A program, that is translated internally consists of the following elements:
 
   op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
 
-So far 87 internal BPF instructions were implemented. 8-bit 'op' opcode field
-has room for new instructions. Some of them may use 16/24/32 byte encoding. New
-instructions must be multiple of 8 bytes to preserve backward compatibility.
+So far 87 internal BPF instructions have been implemented. 8-bit 'op' opcode
+field has room for new instructions. Some of them may use 16/24/32 byte
+encoding. New instructions must be a multiple of 8 bytes to preserve backward
+compatibility.
 
 Internal BPF is a general purpose RISC instruction set. Not every register and
 every instruction are used during translation from original BPF to new format.
@@ -827,11 +828,11 @@ out of registers and would have to resort to spill/fill to stack.
 
 Internal BPF can used as generic assembler for last step performance
 optimizations, socket filters and seccomp are using it as assembler. Tracing
-filters may use it as assembler to generate code from kernel. In kernel usage
+filters may use it as assembler to generate code from kernel. In-kernel usage
 may not be bounded by security considerations, since generated internal BPF code
-may be optimizing internal code path and not being exposed to the user space.
-Safety of internal BPF can come from a verifier (TBD). In such use cases as
-described, it may be used as safe instruction set.
+may use an optimised internal code path and may not be being exposed to user
+space. Safety of internal BPF can come from a verifier (TBD). In such use cases
+as described, it may be used as safe as the instruction set.
 
 Just like the original BPF, the new format runs within a controlled environment,
 is deterministic and the kernel can easily prove that. The safety of the program
@@ -927,7 +928,7 @@ Classic BPF is using BPF_MISC class to represent A = X and X = A moves.
 eBPF is using BPF_MOV | BPF_X | BPF_ALU code instead. Since there are no
 BPF_MISC operations in eBPF, the class 7 is used as BPF_ALU64 to mean
 exactly the same operations as BPF_ALU, but with 64-bit wide operands
-instead. So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition, i.e.:
+instead. So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition i.e.
 dst_reg = dst_reg + src_reg
 
 Classic BPF wastes the whole BPF_RET class to represent a single 'ret'
@@ -1005,9 +1006,10 @@ BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
 2 byte atomic increments are not supported.
 
-eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
-of two consecutive 'struct bpf_insn' 8-byte blocks and interpreted as single
+eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists of
+two consecutive 'struct bpf_insn' 8-byte blocks and is interpreted as single
 instruction that loads 64-bit immediate value into a dst_reg.
+
 Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
 32-bit immediate value into a register.
 
@@ -1016,8 +1018,8 @@ eBPF verifier
 The safety of the eBPF program is determined in two steps.
 
 First step does DAG check to disallow loops and other CFG validation.
-In particular it will detect programs that have unreachable instructions.
-(though classic BPF checker allows them)
+In particular it will detect programs that have unreachable instructions
+(though classic BPF checker allows them).
 
 Second step starts from the first insn and descends all possible paths.
 It simulates execution of every insn and observes the state change of
@@ -1078,7 +1080,9 @@ Classic BPF verifier does similar check with M[0-15] memory slots.
 For example:
   bpf_ld R0 = *(u32 *)(R10 - 4)
   bpf_exit
-is invalid program.
+
+is an invalid program.
+
 Though R10 is correct read-only register and has type PTR_TO_STACK
 and R10 - 4 is within stack bounds, there were no stores into that location.
 
@@ -1089,13 +1093,13 @@ Allowed function calls are customized with bpf_verifier_ops->get_func_proto()
 The eBPF verifier will check that registers match argument constraints.
 After the call register R0 will be set to return type of the function.
 
-Function calls is a main mechanism to extend functionality of eBPF programs.
-Socket filters may let programs to call one set of functions, whereas tracing
-filters may allow completely different set.
+Function calls is an important mechanism to extend functionality of eBPF
+programs.  Socket filters may let programs call one set of functions,
+whereas tracing filters may allow a completely different set.
 
-If a function made accessible to eBPF program, it needs to be thought through
-from safety point of view. The verifier will guarantee that the function is
-called with valid arguments.
+If a function is made accessible to eBPF program, it needs to be thought
+through from a safety point of view. The verifier will guarantee that the
+function is called with valid arguments.
 
 seccomp vs socket filters have different security restrictions for classic BPF.
 Seccomp solves this by two stage verifier: classic BPF verifier is followed
@@ -1167,7 +1171,7 @@ checked and found to be non-NULL, all copies can become PTR_TO_MAP_VALUEs.
 As well as range-checking, the tracked information is also used for enforcing
 alignment of pointer accesses.  For instance, on most systems the packet pointer
 is 2 bytes after a 4-byte alignment.  If a program adds 14 bytes to that to jump
-over the Ethernet header, then reads IHL and addes (IHL * 4), the resulting
+over the Ethernet header, then reads IHL and adds (IHL * 4), the resulting
 pointer will have a variable offset known to be 4n+2 for some n, so adding the 2
 bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses through
 that pointer are safe.
-- 
2.17.1

