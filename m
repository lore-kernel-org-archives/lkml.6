Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9E20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="p6t3kZFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZbVNqFrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9E20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbeHAGxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:25 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44371 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbeHAGxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:24 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C0CE7574;
        Wed,  1 Aug 2018 01:09:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qrD9GhAtyQU1PiLoE
        wDAejckBknIIG7czvjwUJ1Ik14=; b=p6t3kZFNQ95s+kWhWjgkIV3slCrfTZzCA
        FXKlLZdCNtm01QgwqqnY7RhpiuQstBW5yzPotu3/0bOlKaNp/KEZLiy1BtyPVlVr
        ditzXiv36Tnd9aAoI3EJMxz2pSnBG3XgMY5WiRYnvuy+JWwVX+Xfht4XezroffZc
        HM35w9NL8xNC1blBLVvDR+sjBAQL/ke/CK/7eWKbEsCMUNONYmZ7wQJjJB86+71I
        9xv4watdIieDCAKgm93uArAapi/e9Q+XVS+/QogJf7vB2RwK9YbouG+/izysG3x1
        RLPC8c6kzxFmYKNNoWvxoVpjvWVZvzC9vcMSO/L6hmcBzU9s1N0lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=qrD9GhAtyQU1PiLoEwDAejckBknIIG7czvjwUJ1Ik14=; b=ZbVNqFrU
        tpKpE4WLTtfeEDgXTOL2z9g8Tb6Zr0QgTG7QbSAaDWCo7/HaB69jNC1cME2Qq0uU
        eSzZeiaFwN5fHtd5cZA0PAfPqLkHFIjqet2sqOJOO4j7VKkcKC9zB1T+00lsphJ4
        573wi7yzqzdzF2WDhYMJo/oqF0zpnMDBOvX7AYMCC07+DE8cQHsWZ1egQ1ikTW8v
        f27izTOLKSn3lkflbQXVAjNgPUR43oxO3FXJoAyNTxS5jElmtc9HYMRKEqkHi9eL
        nilK/YmU6SpYuMlPc7IsjY8zK5c1BlgLvTwzZZrbcHm0vn4Qm7zAeQzY466ngdkM
        fooJjf5Q609N3w==
X-ME-Proxy: <xmx:lEBhW4KAKvNnAXQxJhQT1l_Ml5LPrbrm6EO1OBiuJpv6fCy8TD-PbA>
    <xmx:lEBhW3mnzAeplzqrTt1JpzWUJqjywQFuAIDfIEyBCqvMQR3bmZ0BbA>
    <xmx:lEBhW5wJURZ7EqnNuQvHqt8X7jx24GBrlnMHuHWF0ESXy4pwnIieJw>
    <xmx:lEBhW5uynaYrUnA8Vv02sxzjh2Z3tPxXjIK03tOk1vUflNXAEXJvBg>
    <xmx:lEBhWzG-YxHJbwvv1FNOQHltre9dyHLcVQ-ipIxREnx6ZI50qISb1A>
    <xmx:lEBhW3sXKw67KESCMzthZ1FCullAsF4mGoSU5ilS79k_8bYb_9o-aw>
X-ME-Sender: <xms:lEBhW_d-BJNSGdjSiPlto1f-rGYor6SRZnN4XZKyp8gKZLfHs0Nn0w>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8882E10268;
        Wed,  1 Aug 2018 01:09:39 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 04/13] docs: net: Use correct heading adornments
Date:   Wed,  1 Aug 2018 15:08:59 +1000
Message-Id: <20180801050908.29970-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to RST format requires the use of correct RST heading
adornments.  While we are at it we can make sure spacing around headings
is uniform.  Choose to use one empty line after any heading.

Use correct levels of heading adornment.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 36 +++++++++++++++++------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 14ce8901c245..19325286780b 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1,10 +1,11 @@
+=======================================================
 Linux Socket Filtering aka Berkeley Packet Filter (BPF)
 =======================================================
 
 .. _bpf_filter:
 
 Introduction
-------------
+============
 
 Linux Socket Filtering (LSF) is derived from the Berkeley Packet Filter.
 Though there are some distinct differences between the BSD and Linux
@@ -58,7 +59,7 @@ Conference Proceedings (USENIX'93). USENIX Association, Berkeley,
 CA, USA, 2-2. [http://www.tcpdump.org/papers/bpf-usenix93.pdf]
 
 Structure
----------
+=========
 
 User space applications include <linux/filter.h> which contains the
 following relevant structures:
@@ -169,7 +170,7 @@ implementors may wish to manually write test cases and thus need low-level
 access to BPF code as well.
 
 BPF engine and instruction set
-------------------------------
+==============================
 
 Under tools/bpf/ there's a small helper tool called bpf_asm which can
 be used to write low-level filters for example scenarios mentioned in the
@@ -462,7 +463,7 @@ breakpoints: 0 1
   Exits bpf_dbg.
 
 JIT compiler
-------------
+============
 
 The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC, PowerPC,
 ARM, ARM64, MIPS and s390 and can be enabled through CONFIG_BPF_JIT. The JIT
@@ -569,7 +570,8 @@ For BPF JIT developers, bpf_jit_disasm, bpf_asm and bpf_dbg provides a useful
 toolchain for developing and testing the kernel's JIT compiler.
 
 BPF kernel internals
---------------------
+====================
+
 Internally, for the kernel interpreter, a different instruction set
 format with similar underlying principles from BPF described in previous
 paragraphs is being used. However, the instruction set format is modelled
@@ -843,7 +845,7 @@ descends all possible paths. It simulates execution of every insn and observes
 the state change of registers and stack.
 
 eBPF opcode encoding
---------------------
+====================
 
 eBPF is reusing most of the opcode encoding from classic to simplify conversion
 of classic BPF to eBPF. For arithmetic and jump instructions the 8-bit 'code'
@@ -1014,7 +1016,8 @@ Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which loads
 32-bit immediate value into a register.
 
 eBPF verifier
--------------
+=============
+
 The safety of the eBPF program is determined in two steps.
 
 First step does DAG check to disallow loops and other CFG validation.
@@ -1107,7 +1110,8 @@ all use cases.
 See details of eBPF verifier in kernel/bpf/verifier.c
 
 Register value tracking
------------------------
+=======================
+
 In order to determine the safety of an eBPF program, the verifier must track
 the range of possible values in each register and also in each stack slot.
 This is done with 'struct bpf_reg_state', defined in include/linux/
@@ -1175,7 +1179,7 @@ bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses through
 that pointer are safe.
 
 Direct packet access
---------------------
+====================
 In cls_bpf and act_bpf programs the verifier allows direct access to the packet
 data via skb->data and skb->data_end pointers.
 Ex:
@@ -1261,7 +1265,8 @@ which makes such programs easier to write comparing to LD_ABS insn
 and significantly faster.
 
 eBPF maps
----------
+=========
+
 'maps' is a generic storage of different types for sharing data between kernel
 and userspace.
 
@@ -1300,7 +1305,8 @@ The map is defined by:
   . value size in bytes
 
 Pruning
--------
+=======
+
 The verifier does not actually walk all possible paths through the program.  For
 each new branch to analyse, the verifier looks at all the states it's previously
 been in when at this instruction.  If any of them contain the current state as a
@@ -1316,7 +1322,7 @@ registers it may hold).  They must all be safe for the branch to be pruned.
 This is implemented in states_equal().
 
 Understanding eBPF verifier messages
-------------------------------------
+====================================
 
 The following are few examples of invalid eBPF programs and verifier error
 messages as seen in the log:
@@ -1447,7 +1453,7 @@ Error:
   R0 invalid mem access 'imm'
 
 Testing
--------
+=======
 
 Next to the BPF toolchain, the kernel also ships a test module that contains
 various test cases for classic and internal BPF that can be executed against
@@ -1461,13 +1467,13 @@ via insmod or modprobe against 'test_bpf' module. Results of the test cases
 including timings in nsec can be found in the kernel log (dmesg).
 
 Misc
-----
+====
 
 Also trinity, the Linux syscall fuzzer, has built-in support for BPF and
 SECCOMP-BPF kernel fuzzing.
 
 Written by
-----------
+==========
 
 The document was written in the hope that it is found useful and in order
 to give potential BPF hackers or security auditors a better overview of
-- 
2.17.1

