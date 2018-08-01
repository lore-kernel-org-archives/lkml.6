Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F50C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9A320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="begUMZdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7ULQQA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9A320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387400AbeHAGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:58 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51577 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733055AbeHAGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EA2774F3;
        Wed,  1 Aug 2018 01:10:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xcMCFxk7rQWN7/37k
        kLloc4EGMhn50rgGvGYxC5rhBc=; b=begUMZdO0hFNeaghJzRdW05WrUsJ06wQY
        YMiPd8CDsT6ouWqgdRleNPT14flCVidSerQ4eleVhUWM0ePqJTiucYXjWbaxyQuV
        qMpfNeyEKDvTRuObbwDhVcpuUShT+zDtjL18cy8AUY+5LnrriTmoF7DyTjfcjFEi
        21n0ZbeTcgFNfutPMFMu4KstzUPWcrpx9F0ac7a+WGNOwbq9Okc353LtBirEwBOJ
        2AwTTNeWQlo78QltHaG8KuHKPXDMa62dd4Ieh68eyn5y3MFc1B+KYBKKyif2VRzP
        DCGZXZWKsGz5YdnQhIlEoZJcwyZ/bhY/mEAven8pGYJalKavgUodQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=xcMCFxk7rQWN7/37kkLloc4EGMhn50rgGvGYxC5rhBc=; b=c7ULQQA0
        6bVEQomtkeq3zueIb3VZaRSSlIlayF3genSADJ5LpJPdqJ/gDrXZT7anQVDltdE2
        uZPIrxV/RMM9h+WXUMaHqIioxGAGg/m9LwDU0QFDA/YzEmEr6fZTkR++7RKtyV9Q
        lIavuBPj2thJ7/V6xCJUDZw6zII8aOogM92KjFjy34xDRbPoYYkyQf8wN7PbfVeR
        /OWuu0961jYuVVQ8wnjaF8rhUK8YcnJe+ZAwG4vWsERLw/S6ItaSVZBZ7pF6cg6d
        +T+3LqPKJB+jc5vMHvku7KRv8ZwJBwwez2QhaMAK5sks4AuuHemTas9DRUP/w+zJ
        tLLvW/vh7Z9U9A==
X-ME-Proxy: <xmx:tEBhW1MN3rWZR7Z-vK3y1j1dbJU555-E1IOgGqkLMD7GjMiicu-Mmg>
    <xmx:tEBhW6BEuV7YCjb6ca2KCYGqKkXKjereJFuGICj9PEko-mcJUwvp6g>
    <xmx:tEBhW-U_dT_uCZ9Eci0V7seA9H33AM4itgl_pXhHtDm8etOYN5kG7Q>
    <xmx:tEBhW8bdGN98PLdleNoQyHyG-PcH5LkQpM_XcRsQVtfp-41bjGmcEA>
    <xmx:tEBhW0J7wxkZBCemPAbcSHMO7m2LD1hV1hK0dsaATHPErRihl6jqBg>
    <xmx:tEBhW2D-IsGqAx3R1maIUh55ddAdkhRusmqmAwT4ymlRV27Dj7Llqw>
X-ME-Sender: <xms:tEBhW00qwtgjb3rR9qEwzyTgO1kccLUBGKvGb7Ybx4KZES24mHoTIw>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id A044910255;
        Wed,  1 Aug 2018 01:10:11 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Date:   Wed,  1 Aug 2018 15:09:07 +1000
Message-Id: <20180801050908.29970-13-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few minor typos and grammatical issues.  We should however
try to keep the current flavour of the document.

Fix typos and grammar if glaringly required.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 65 +++++++++++++++--------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 99dfa74fc4f7..b989a6c882b8 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -32,10 +32,10 @@ removing the old one and placing your new one in its place, assuming your
 filter has passed the checks, otherwise if it fails the old filter will
 remain on that socket.
 
-SO_LOCK_FILTER option allows to lock the filter attached to a socket. Once
-set, a filter cannot be removed or changed. This allows one process to
+SO_LOCK_FILTER option allows locking of the filter attached to a socket.
+Once set, a filter cannot be removed or changed. This allows one process to
 setup a socket, attach a filter, lock it then drop privileges and be
-assured that the filter will be kept until the socket is closed.
+assured  that the filter will be kept until the socket is closed.
 
 The biggest user of this construct might be libpcap. Issuing a high-level
 filter command like ``tcpdump -i em1 port 22`` passes through the libpcap
@@ -470,7 +470,7 @@ JIT compiler
 ============
 
 The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC, PowerPC,
-ARM, ARM64, MIPS and s390 and can be enabled through CONFIG_BPF_JIT. The JIT
+ARM, ARM64, MIPS and s390 which can be enabled through CONFIG_BPF_JIT. The JIT
 compiler is transparently invoked for each attached filter from user space
 or for internal kernel users if it has been previously enabled by root::
 
@@ -580,7 +580,7 @@ Internally, for the kernel interpreter, a different instruction set
 format with similar underlying principles from BPF described in previous
 paragraphs is being used. However, the instruction set format is modelled
 closer to the underlying architecture to mimic native instruction sets, so
-that a better performance can be achieved (more details later). This new
+that better performance can be achieved (more details later). This new
 ISA is called 'eBPF' or 'internal BPF' interchangeably. (Note: eBPF which
 originates from [e]xtended BPF is not the same as BPF extensions! While
 eBPF is an ISA, BPF extensions date back to classic BPF's 'overloading'
@@ -655,12 +655,12 @@ Some core changes of the new internal format:
 
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
@@ -694,7 +694,7 @@ Some core changes of the new internal format:
   situations without performance penalty.
 
   After an in-kernel function call, R1 - R5 are reset to unreadable and R0 has
-  a return value of the function. Since R6 - R9 are callee saved, their state
+  the return value of the function. Since R6 - R9 are callee saved, their state
   is preserved across the call.
 
   For example, consider three C functions::
@@ -732,7 +732,7 @@ Some core changes of the new internal format:
   are currently not supported, but these restrictions can be lifted if necessary
   in the future.
 
-  On 64-bit architectures all register map to HW registers one to one. For
+  On 64-bit architectures all registers map to HW registers one to one. For
   example, x86_64 JIT compiler can map them as ... ::
 
     R0 - rax
@@ -831,9 +831,10 @@ A program, that is translated internally consists of the following elements::
 
   op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
 
-So far 87 internal BPF instructions were implemented. 8-bit ``op`` opcode field
-has room for new instructions. Some of them may use 16/24/32 byte encoding. New
-instructions must be multiple of 8 bytes to preserve backward compatibility.
+So far 87 internal BPF instructions have been implemented. 8-bit ``op``
+opcode field has room for new instructions. Some of them may use 16/24/32
+byte encoding. New instructions must be a multiple of 8 bytes to preserve
+backward compatibility.
 
 Internal BPF is a general purpose RISC instruction set. Not every register and
 every instruction are used during translation from original BPF to new format.
@@ -844,11 +845,11 @@ out of registers and would have to resort to spill/fill to stack.
 
 Internal BPF can used as generic assembler for last step performance
 optimizations, socket filters and seccomp are using it as assembler. Tracing
-filters may use it as assembler to generate code from kernel. In kernel usage
+filters may use it as assembler to generate code from kernel.  In-kernel usage
 may not be bounded by security considerations, since generated internal BPF code
-may be optimizing internal code path and not being exposed to the user space.
-Safety of internal BPF can come from a verifier (TBD). In such use cases as
-described, it may be used as safe instruction set.
+may use an optimised internal code path and may not be being exposed to user
+space. Safety of internal BPF can come from a verifier (TBD). In such use cases
+as described, it may be used as safe as the instruction set.
 
 Just like the original BPF, the new format runs within a controlled environment,
 is deterministic and the kernel can easily prove that. The safety of the program
@@ -945,7 +946,7 @@ Classic BPF is using BPF_MISC class to represent A = X and X = A moves.
 eBPF is using BPF_MOV | BPF_X | BPF_ALU code instead. Since there are no
 BPF_MISC operations in eBPF, the class 7 is used as BPF_ALU64 to mean
 exactly the same operations as BPF_ALU, but with 64-bit wide operands
-instead. So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition, i.e.:
+instead. So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition i.e.
 dst_reg = dst_reg + src_reg
 
 Classic BPF wastes the whole BPF_RET class to represent a single 'ret'
@@ -1024,8 +1025,8 @@ Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
 2 byte atomic increments are not supported.
 
 eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
-of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
-instruction that loads 64-bit immediate value into a dst_reg.
+of two consecutive ``struct bpf_insn`` 8-byte blocks and is interpreted as
+a single instruction that loads 64-bit immediate value into a dst_reg.
 Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
 32-bit immediate value into a register.
 
@@ -1035,8 +1036,8 @@ eBPF verifier
 The safety of the eBPF program is determined in two steps.
 
 First step does DAG check to disallow loops and other CFG validation.
-In particular it will detect programs that have unreachable instructions.
-(though classic BPF checker allows them)
+In particular it will detect programs that have unreachable instructions
+(though classic BPF checker allows them).
 
 Second step starts from the first insn and descends all possible paths.
 It simulates execution of every insn and observes the state change of
@@ -1107,7 +1108,7 @@ For example::
   bpf_ld R0 = *(u32 *)(R10 - 4)
   bpf_exit
 
-is invalid program.
+is an invalid program.
 Though R10 is correct read-only register and has type PTR_TO_STACK
 and R10 - 4 is within stack bounds, there were no stores into that location.
 
@@ -1118,13 +1119,13 @@ Allowed function calls are customized with bpf_verifier_ops->get_func_proto()
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
@@ -1202,7 +1203,7 @@ checked and found to be non-NULL, all copies can become PTR_TO_MAP_VALUEs.
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

