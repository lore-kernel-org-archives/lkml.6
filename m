Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F79C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="T/1NkHaV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Io0tdNOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733220AbeHAGxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:37 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38253 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733201AbeHAGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:36 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 14C82690;
        Wed,  1 Aug 2018 01:09:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pGznYWx2BfXKBRCC2
        WGyCsSAlL6XIJll52rwqvBceLY=; b=T/1NkHaVukDojjX2tdANwSRB7KWQjT4uH
        Gz+w0m40lavVblcbHSiBOp3g0WTjI6jm/Es83rOceO/Dmr2iPoV2gAA2UeHoDi+u
        fU61IYSPa9YnKC1BO4L+mP0WytV/tJqwGf+4SLK9eD74U2Mere5hOHvx2jhBPrlB
        lbk6FSbsGUmOFZESKMOR+/PxoSyFbJ03ZmyV+yGPyj+bHtppabdjuGZ9Ks7dZ3wz
        zO1wlz6vENwaRf1hU8yNnN87GmFYWTqdaYaYowl5zfi6VBwCbHFddzsbgZhBufmz
        uyzE5SPwnn90dD8ebTRTHsqF5mLw0whxKeKFkpAodT8M13R/iUsLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pGznYWx2BfXKBRCC2WGyCsSAlL6XIJll52rwqvBceLY=; b=Io0tdNOb
        DAHr31uyNzTH5bkYQcR8n5gUVXsIZc+8ygWOmrw26v4Uz6+yPPFXK7yOlzNHFrVD
        Myfw7TIAgV7p5Pa6QXgmfmwM3xpSGxlAMOHcC3bLnRvfeS5HjBFkF0ktHG+vbeVZ
        bYW+H1yOmmbyx+rbJaYXR6Pes+4rOJKvA7/rz5IpSXIJ1BvkPbNu59Zu2/0NOs2W
        vtjcR/nwKuw1Ep9M/4DYsgaFvyyFe7qxHm0/X9m+Mqs4a9eehmg8W8HD/Fjd8MdR
        Gs+t0xuu5OSWoXXwxf7pKZcinzdxwXv7vAhQUQSw2GtDgyJoBRQqUMEzmj9Wnmpy
        PqMJv19AW3d+/A==
X-ME-Proxy: <xmx:n0BhW1NUdtAkleDaMdl0ykpDZLq2xdqpqzaahB61zDaarpQTxwBA0A>
    <xmx:n0BhW4Jv8fwcNcsgKUmDIXM_stju3LPvA1EgBpJI0TaD1h796bMvTA>
    <xmx:n0BhW2GPrUyhc9u3UnPNpNoYn52ViXMEpDxaFhjuucAIO9BzByvJAA>
    <xmx:n0BhWwSw6cnr6DrCaf_Gfj69Uy8Zo-Kq8DVL1VNTxyvJTS1AJ_uYkA>
    <xmx:n0BhWyF160Ujdkk1wXxSg8INMiugxJLZAJITGBSCJyWLBu1rJCl_Wg>
    <xmx:n0BhW4K8hGj-pbcFMErW0p6X0tfgxXRMzbrbOxHxP-b61EK7id5aIg>
X-ME-Sender: <xms:n0BhW46zpB5oMS9p5ZwtOObg73Vu3ZCtIruPEybaEvqFoYI3ZTMkww>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id C97DF10269;
        Wed,  1 Aug 2018 01:09:50 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 07/13] docs: net: Use double ticks instead of single quote
Date:   Wed,  1 Aug 2018 15:09:02 +1000
Message-Id: <20180801050908.29970-8-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are many places that use single quote to guard text.
RST has the double tick for code.  Also the document is full of
identifiers.  Using too many double ticks hinders reading the file in
text format.  For this reason we only change a few select cases to use
the double tick.

Sphinx also emits a bunch of cryptic warnings due to not correctly
wrapping lines.

These two fixes touch the same lines so its all in one patch.

Use double ticks instead of single quote to guard inline code.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 100 ++++++++++++++--------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 62630e8f023a..f9ec58144ed3 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -289,7 +289,7 @@ Possible BPF extensions are shown in the following table::
   vlan_tpid                             skb->vlan_proto
   rand                                  prandom_u32()
 
-These extensions can also be prefixed with '#'.
+These extensions can also be prefixed with ``#``.
 Examples for low-level BPF:
 
 ARP packets::
@@ -382,7 +382,7 @@ file "~/.bpf_dbg_init" and the command history is stored in the file
 "~/.bpf_dbg_history".
 
 Interaction in bpf_dbg happens through a shell that also has auto-completion
-support (follow-up example commands starting with '>' denote bpf_dbg shell).
+support (follow-up example commands starting with ``>`` denote bpf_dbg shell).
 The usual workflow would be to ...
 ::
 
@@ -689,7 +689,7 @@ Some core changes of the new internal format:
   to in-kernel function. If R1 - R5 registers are mapped to CPU registers
   that are used for argument passing on given architecture, the JIT compiler
   doesn't need to emit extra moves. Function arguments will be in the correct
-  registers and BPF_CALL instruction will be JITed as single 'call' HW
+  registers and BPF_CALL instruction will be JITed as single ``call`` HW
   instruction. This calling convention was picked to cover common call
   situations without performance penalty.
 
@@ -803,7 +803,7 @@ Some core changes of the new internal format:
 
   In-kernel functions foo() and bar() with prototype: u64 (*)(u64 arg1, u64
   arg2, u64 arg3, u64 arg4, u64 arg5); will receive arguments in proper
-  registers and place their return value into '%rax' which is R0 in eBPF.
+  registers and place their return value into ``%rax`` which is R0 in eBPF.
   Prologue and epilogue are emitted by JIT and are implicit in the
   interpreter. R0-R5 are scratch registers, so eBPF program needs to preserve
   them across the calls as defined by calling convention.
@@ -831,7 +831,7 @@ A program, that is translated internally consists of the following elements::
 
   op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
 
-So far 87 internal BPF instructions were implemented. 8-bit 'op' opcode field
+So far 87 internal BPF instructions were implemented. 8-bit ``op`` opcode field
 has room for new instructions. Some of them may use 16/24/32 byte encoding. New
 instructions must be multiple of 8 bytes to preserve backward compatibility.
 
@@ -992,7 +992,7 @@ eBPF has two non-generic instructions: (BPF_ABS | <size> | BPF_LD) and
 
 They had to be carried over from classic to have strong performance of
 socket filters running in eBPF interpreter. These instructions can only
-be used when interpreter context is a pointer to 'struct sk_buff' and
+be used when interpreter context is a pointer to ``struct sk_buff`` and
 have seven implicit operands. Register R6 is an implicit input that must
 contain pointer to sk_buff. Register R0 is an implicit output which contains
 the data fetched from the packet. Registers R1-R5 are scratch registers
@@ -1024,7 +1024,7 @@ Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
 2 byte atomic increments are not supported.
 
 eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which consists
-of two consecutive 'struct bpf_insn' 8-byte blocks and interpreted as single
+of two consecutive ``struct bpf_insn`` 8-byte blocks and interpreted as single
 instruction that loads 64-bit immediate value into a dst_reg.
 Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
 32-bit immediate value into a register.
@@ -1083,7 +1083,7 @@ For example::
 will be rejected, since R1 doesn't have a valid pointer type at the time of
 execution of instruction bpf_xadd.
 
-At the start R1 type is PTR_TO_CTX (a pointer to generic 'struct bpf_context')
+At the start R1 type is PTR_TO_CTX (a pointer to generic ``struct bpf_context``)
 A callback is used to customize verifier to restrict eBPF program access to only
 certain fields within ctx structure with specified size and alignment.
 
@@ -1138,7 +1138,7 @@ Register value tracking
 
 In order to determine the safety of an eBPF program, the verifier must track
 the range of possible values in each register and also in each stack slot.
-This is done with 'struct bpf_reg_state', defined in include/linux/
+This is done with ``struct bpf_reg_state``, defined in include/linux/
 bpf_verifier.h, which unifies tracking of scalar and pointer values.  Each
 register state has a type, which is either NOT_INIT (the register has not been
 written to), SCALAR_VALUE (some value which is not usable as a pointer), or a
@@ -1219,7 +1219,7 @@ Ex::
   6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
 
 this 2byte load from the packet is safe to do, since the program author
-did check 'if (skb->data + 14 > skb->data_end) goto err' at insn #5 which
+did check ``if (skb->data + 14 > skb->data_end) goto err`` at insn #5 which
 means that in the fall-through case the register R3 (which points to skb->data)
 has at least 14 directly accessible bytes. The verifier marks it
 as R3=pkt(id=0,off=0,r=14).
@@ -1228,7 +1228,7 @@ off=0 means that no additional constants were added.
 r=14 is the range of safe access which means that bytes [R3, R3 + 14) are ok.
 Note that R5 is marked as R5=pkt(id=0,off=14,r=14). It also points
 to the packet data, but constant 14 was added to the register, so
-it now points to 'skb->data + 14' and accessible range is [R5, R5 + 14 - 14)
+it now points to ``skb->data + 14`` and accessible range is [R5, R5 + 14 - 14)
 which is zero bytes.
 
 More complex packet access may look like::
@@ -1250,29 +1250,30 @@ More complex packet access may look like::
    R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
   19:  r1 = *(u8 *)(r3 +4)
 
-The state of the register R3 is R3=pkt(id=2,off=0,r=8)
-id=2 means that two 'r3 += rX' instructions were seen, so r3 points to some
-offset within a packet and since the program author did
-'if (r3 + 8 > r1) goto err' at insn #18, the safe range is [R3, R3 + 8).
-The verifier only allows 'add'/'sub' operations on packet registers. Any other
-operation will set the register state to 'SCALAR_VALUE' and it won't be
-available for direct packet access.
-Operation 'r3 += rX' may overflow and become less than original skb->data,
-therefore the verifier has to prevent that.  So when it sees 'r3 += rX'
-instruction and rX is more than 16-bit value, any subsequent bounds-check of r3
-against skb->data_end will not give us 'range' information, so attempts to read
-through the pointer will give "invalid access to packet" error.
-Ex. after insn 'r4 = *(u8 *)(r3 +12)' (insn #7 above) the state of r4 is
-R4=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) which means that upper 56 bits
-of the register are guaranteed to be zero, and nothing is known about the lower
-8 bits. After insn 'r4 *= 14' the state becomes
-R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since multiplying an 8-bit
-value by constant 14 will keep upper 52 bits as zero, also the least significant
-bit will be zero as 14 is even.  Similarly 'r2 >>= 48' will make
-R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)), since the shift is not sign
-extending.  This logic is implemented in adjust_reg_min_max_vals() function,
-which calls adjust_ptr_min_max_vals() for adding pointer to scalar (or vice
-versa) and adjust_scalar_min_max_vals() for operations on two scalars.
+The state of the register R3 is R3=pkt(id=2,off=0,r=8) id=2 means that
+two ``r3 += rX`` instructions were seen, so r3 points to some offset within
+a packet and since the program author did ``if (r3 + 8 > r1) goto err`` at
+insn #18, the safe range is [R3, R3 + 8).  The verifier only allows
+'add'/'sub' operations on packet registers. Any other operation will set
+the register state to 'SCALAR_VALUE' and it won't be available for direct
+packet access.  Operation ``r3 += rX`` may overflow and become less than
+original skb->data, therefore the verifier has to prevent that.  So when it
+sees ``r3 += rX`` instruction and rX is more than 16-bit value, any
+subsequent bounds-check of r3 against skb->data_end will not give us
+'range' information, so attempts to read through the pointer will give
+"invalid access to packet" error.  Ex. after insn ``r4 = *(u8 *)(r3 +12)``
+(insn #7 above) the state of r4 is
+R4=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) which means that upper
+56 bits of the register are guaranteed to be zero, and nothing is known
+about the lower 8 bits. After insn ``r4 *= 14`` the state becomes
+R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since multiplying
+an 8-bit value by constant 14 will keep upper 52 bits as zero, also the
+least significant bit will be zero as 14 is even.  Similarly ``r2 >>= 48``
+will make R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)), since
+the shift is not sign extending.  This logic is implemented in
+adjust_reg_min_max_vals() function, which calls adjust_ptr_min_max_vals()
+for adding pointer to scalar (or vice versa) and
+adjust_scalar_min_max_vals() for operations on two scalars.
 
 The end result is that bpf program author can access packet directly
 using normal C code as::
@@ -1303,27 +1304,24 @@ and userspace.
 
 The maps are accessed from user space via BPF syscall, which has commands:
 
-- create a map with given type and attributes
-  map_fd = bpf(BPF_MAP_CREATE, union bpf_attr *attr, u32 size)
-  using attr->map_type, attr->key_size, attr->value_size, attr->max_entries
-  returns process-local file descriptor or negative error
+- create a map with given type and attributes ``map_fd =
+  bpf(BPF_MAP_CREATE, union bpf_attr *attr, u32 size)`` using
+  attr->map_type, attr->key_size, attr->value_size, attr->max_entries
+  returns process-local file descriptor or negative error.
 
-- lookup key in a given map
-  err = bpf(BPF_MAP_LOOKUP_ELEM, union bpf_attr *attr, u32 size)
-  using attr->map_fd, attr->key, attr->value
-  returns zero and stores found elem into value or negative error
+- lookup key in a given map ``err = bpf(BPF_MAP_LOOKUP_ELEM, union bpf_attr
+  *attr, u32 size)`` using attr->map_fd, attr->key, attr->value returns
+  zero and stores found elem into value or negative error.
 
-- create or update key/value pair in a given map
-  err = bpf(BPF_MAP_UPDATE_ELEM, union bpf_attr *attr, u32 size)
-  using attr->map_fd, attr->key, attr->value
-  returns zero or negative error
+- create or update key/value pair in a given map ``err =
+  bpf(BPF_MAP_UPDATE_ELEM, union bpf_attr *attr, u32 size)`` using
+  attr->map_fd, attr->key, attr->value returns zero or negative error.
 
-- find and delete element by key in a given map
-  err = bpf(BPF_MAP_DELETE_ELEM, union bpf_attr *attr, u32 size)
-  using attr->map_fd, attr->key
+- find and delete element by key in a given map ``err =
+  bpf(BPF_MAP_DELETE_ELEM, union bpf_attr *attr, u32 size)`` using
+  attr->map_fd, attr->key.
 
-- to delete map: close(fd)
-  Exiting process will delete maps automatically
+- to delete map: close(fd) Exiting process will delete maps automatically.
 
 userspace programs use this syscall to create/access maps that eBPF programs
 are concurrently updating.
-- 
2.17.1

