Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0B20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Zv4PU7CR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmnGbmJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbeHAGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:30 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42769 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbeHAGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0A0EF578;
        Wed,  1 Aug 2018 01:09:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=S2r2y5vqKZBG1sEh7
        JePq6jUNUINM0oRL3IJ1B1GzCg=; b=Zv4PU7CR8URtY93EPE64q5PItKWHXDIdb
        07Txhkj2XG0spLaGkLielMPuk9wtXSaClYr5LavF0YgXQanf5yH2tNeFqNYvmTt/
        h63xaqnFAK+Rx+eyl5VtglDKao5tXftc6knMNlBnTvKPoHL6e2Wr0iMCkrRf9tH7
        6a+HrGCx42Mf9AQaqMPFxrRYnLfdVadurMo2Ju2GmaasXUX59UsV8h6nqzu3YTzN
        7t4ytABSHP1sG/7wc4Yd0COZx1JI9PGP9uLHRUKOdj+YuPTLVpTypYTRWWEWcJUg
        yLZ6TK6wEOTGRAMI9dDP5IH1SnzUycyy3c89bAFa6noMO0y3S6Gyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=S2r2y5vqKZBG1sEh7JePq6jUNUINM0oRL3IJ1B1GzCg=; b=KmnGbmJv
        khkcBxH1OeMoxjgm2SRMGMetQXPJUaF1i2G41etH/tHFy8uLbBVpnkeePcSdrdnV
        qOZLkemjDAUWSebKBAcTlHy6di5vXz+QZJVe2oS5pY1daRRJHuB9uEr0tY14NUbO
        gF1PhKrsxN3bwJy9jGw0lSHo8eBmpi0Yo8Yv80KYZrSd8EFvPCL5oQOMt/eCq+lE
        J6/j8EYap5WSwGaFLfdyrJcL5x0N+dPIcButEWOrxLXfj0FXuwHbz7MpLgeLnkMr
        km7fVRq2wx5NCh5VlLuRwY18//G6+MbvHEVYHd/EOxuJpAxPAlBh5+mk5deiZ1tr
        otsxKlQu0IlL9Q==
X-ME-Proxy: <xmx:mEBhWzisgnpkWCfs3tRruBUYmK8zbUGfOQKV2IuC_A76LeRNqyGB7w>
    <xmx:mEBhW7jtzBidb-QcZQVH48juI5eFtI2057DyAXnAvvj-ONtyJJYlPw>
    <xmx:mEBhW6HKSLIu3B-V7OF070mA7hWqwiy7OdQviEOLXtmHehtqvf3Exg>
    <xmx:mEBhW5PySzJ8nEmyJzl8Lf_S1PkNFWCNYcQKNi20FSwoZC-Yzcdrag>
    <xmx:mEBhW9POn2ty_9Ozc_OnS7f3JOLdzDBizc5BjplMOJ7o7P4XcJwxRg>
    <xmx:mEBhW2fh8X86WzY9pCqlCsY4WOSVMAtOspmunakopj_ivq2QQaih6g>
X-ME-Sender: <xms:mEBhWweVRtv7TtJZH3hhdrHCopY0rVxMoRaJ7VzjuAPQyU8D9zJkEw>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 579D61027B;
        Wed,  1 Aug 2018 01:09:43 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 05/13] docs: net: Fix indentation issues for code snippets
Date:   Wed,  1 Aug 2018 15:09:00 +1000
Message-Id: <20180801050908.29970-6-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent conversion of filter.txt to RST format did not fix indentation.
Sphinx emits various warnings about indentation.  We should prefix all
code snippets with the RST identifier '::' and indent first column of
snippets 2 characters (inline with other docs in RST format).

Fix indentation issues for code snippets (including spaces to tabs when
appropriate).

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 746 +++++++++++++++-------------
 1 file changed, 398 insertions(+), 348 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 19325286780b..916e7ac01576 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -62,38 +62,40 @@ Structure
 =========
 
 User space applications include <linux/filter.h> which contains the
-following relevant structures:
+following relevant structures::
 
-struct sock_filter {	/* Filter block */
+  struct sock_filter {	/* Filter block */
 	__u16	code;   /* Actual filter code */
 	__u8	jt;	/* Jump true */
 	__u8	jf;	/* Jump false */
 	__u32	k;      /* Generic multiuse field */
-};
+  };
 
 Such a structure is assembled as an array of 4-tuples, that contains
 a code, jt, jf and k value. jt and jf are jump offsets and k a generic
 value to be used for a provided code.
+::
 
-struct sock_fprog {			/* Required for SO_ATTACH_FILTER. */
+  struct sock_fprog {			/* Required for SO_ATTACH_FILTER. */
 	unsigned short		   len;	/* Number of filter blocks */
 	struct sock_filter __user *filter;
-};
+  };
 
 For socket filtering, a pointer to this structure (as shown in
 follow-up example) is being passed to the kernel through setsockopt(2).
 
 Example
 -------
+::
 
-#include <sys/socket.h>
-#include <sys/types.h>
-#include <arpa/inet.h>
-#include <linux/if_ether.h>
-/* ... */
+  #include <sys/socket.h>
+  #include <sys/types.h>
+  #include <arpa/inet.h>
+  #include <linux/if_ether.h>
+  /* ... */
 
-/* From the example above: tcpdump -i em1 port 22 -dd */
-struct sock_filter code[] = {
+  /* From the example above: tcpdump -i em1 port 22 -dd */
+  struct sock_filter code[] = {
 	{ 0x28,  0,  0, 0x0000000c },
 	{ 0x15,  0,  8, 0x000086dd },
 	{ 0x30,  0,  0, 0x00000014 },
@@ -118,23 +120,23 @@ struct sock_filter code[] = {
 	{ 0x15,  0,  1, 0x00000016 },
 	{ 0x06,  0,  0, 0x0000ffff },
 	{ 0x06,  0,  0, 0x00000000 },
-};
+  };
 
-struct sock_fprog bpf = {
+  struct sock_fprog bpf = {
 	.len = ARRAY_SIZE(code),
 	.filter = code,
-};
+  };
 
-sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
-if (sock < 0)
+  sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+  if (sock < 0)
 	/* ... bail out ... */
 
-ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
-if (ret < 0)
+  ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
+  if (ret < 0)
 	/* ... bail out ... */
 
-/* ... */
-close(sock);
+  /* ... */
+  close(sock);
 
 The above example code attaches a socket filter for a PF_PACKET socket
 in order to let all IPv4/IPv6 packets with port 22 pass. The rest will
@@ -179,17 +181,17 @@ bpf_asm and will be used for further explanations (instead of dealing with
 less readable opcodes directly, principles are the same). The syntax is
 closely modelled after Steven McCanne's and Van Jacobson's BPF paper.
 
-The BPF architecture consists of the following basic elements:
+The BPF architecture consists of the following basic elements::
 
-  Element          Description
+  Element	Description
 
-  A                32 bit wide accumulator
-  X                32 bit wide X register
-  M[]              16 x 32 bit wide misc registers aka "scratch memory
-                   store", addressable from 0 to 15
+  A		32 bit wide accumulator
+  X		32 bit wide X register
+  M[]		16 x 32 bit wide misc registers aka "scratch memory
+		store", addressable from 0 to 15
 
 A program, that is translated by bpf_asm into "opcodes" is an array that
-consists of the following elements (as already mentioned):
+consists of the following elements (as already mentioned)::
 
   op:16, jt:8, jf:8, k:32
 
@@ -202,7 +204,7 @@ ways depending on the given instruction in op.
 The instruction set consists of load, store, branch, alu, miscellaneous
 and return instructions that are also represented in bpf_asm syntax. This
 table lists all bpf_asm instructions available resp. what their underlying
-opcodes as defined in linux/filter.h stand for:
+opcodes as defined in linux/filter.h stand for::
 
   Instruction      Addressing mode      Description
 
@@ -245,7 +247,7 @@ opcodes as defined in linux/filter.h stand for:
 
   ret              4, 9                 Return
 
-The next table shows addressing formats from the 2nd column:
+The next table shows addressing formats from the 2nd column::
 
   Addressing mode  Syntax               Description
 
@@ -266,7 +268,7 @@ with the class of load instructions by "overloading" the k argument with
 a negative offset + a particular extension offset. The result of such BPF
 extensions are loaded into A.
 
-Possible BPF extensions are shown in the following table:
+Possible BPF extensions are shown in the following table::
 
   Extension                             Description
 
@@ -290,14 +292,14 @@ Possible BPF extensions are shown in the following table:
 These extensions can also be prefixed with '#'.
 Examples for low-level BPF:
 
-** ARP packets:
+** ARP packets::
 
   ldh [12]
   jne #0x806, drop
   ret #-1
   drop: ret #0
 
-** IPv4 TCP packets:
+** IPv4 TCP packets::
 
   ldh [12]
   jne #0x800, drop
@@ -306,14 +308,15 @@ Examples for low-level BPF:
   ret #-1
   drop: ret #0
 
-** (Accelerated) VLAN w/ id 10:
+** (Accelerated) VLAN w/ id 10::
 
   ld vlan_tci
   jneq #10, drop
   ret #-1
   drop: ret #0
 
-** icmp random packet sampling, 1 in 4
+** icmp random packet sampling, 1 in 4::
+
   ldh [12]
   jne #0x800, drop
   ldb [23]
@@ -325,7 +328,7 @@ Examples for low-level BPF:
   ret #-1
   drop: ret #0
 
-** SECCOMP filter example:
+** SECCOMP filter example::
 
   ld [4]                  /* offsetof(struct seccomp_data, arch) */
   jne #0xc000003e, bad    /* AUDIT_ARCH_X86_64 */
@@ -346,18 +349,18 @@ Examples for low-level BPF:
 The above example code can be placed into a file (here called "foo"), and
 then be passed to the bpf_asm tool for generating opcodes, output that xt_bpf
 and cls_bpf understands and can directly be loaded with. Example with above
-ARP code:
+ARP code::
 
-$ ./bpf_asm foo
-4,40 0 0 12,21 0 1 2054,6 0 0 4294967295,6 0 0 0,
+  $ ./bpf_asm foo
+  4,40 0 0 12,21 0 1 2054,6 0 0 4294967295,6 0 0 0,
 
-In copy and paste C-like output:
+In copy and paste C-like output::
 
-$ ./bpf_asm -c foo
-{ 0x28,  0,  0, 0x0000000c },
-{ 0x15,  0,  1, 0x00000806 },
-{ 0x06,  0,  0, 0xffffffff },
-{ 0x06,  0,  0, 0000000000 },
+  $ ./bpf_asm -c foo
+  { 0x28,  0,  0, 0x0000000c },
+  { 0x15,  0,  1, 0x00000806 },
+  { 0x06,  0,  0, 0xffffffff },
+  { 0x06,  0,  0, 0000000000 },
 
 In particular, as usage with xt_bpf or cls_bpf can result in more complex BPF
 filters that might not be obvious at first, it's good to test filters before
@@ -366,9 +369,9 @@ bpf_dbg under tools/bpf/ in the kernel source directory. This debugger allows
 for testing BPF filters against given pcap files, single stepping through the
 BPF code on the pcap's packets and to do BPF machine register dumps.
 
-Starting bpf_dbg is trivial and just requires issuing:
+Starting bpf_dbg is trivial and just requires issuing::
 
-# ./bpf_dbg
+  # ./bpf_dbg
 
 In case input and output do not equal stdin/stdout, bpf_dbg takes an
 alternative stdin source as a first argument, and an alternative stdout
@@ -381,86 +384,87 @@ file "~/.bpf_dbg_init" and the command history is stored in the file
 Interaction in bpf_dbg happens through a shell that also has auto-completion
 support (follow-up example commands starting with '>' denote bpf_dbg shell).
 The usual workflow would be to ...
-
-> load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
-  Loads a BPF filter from standard output of bpf_asm, or transformed via
-  e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
-  debugging (next section), this command creates a temporary socket and
-  loads the BPF code into the kernel. Thus, this will also be useful for
-  JIT developers.
-
-> load pcap foo.pcap
-  Loads standard tcpdump pcap file.
-
-> run [<n>]
-bpf passes:1 fails:9
-  Runs through all packets from a pcap to account how many passes and fails
-  the filter will generate. A limit of packets to traverse can be given.
-
-> disassemble
-l0:	ldh [12]
-l1:	jeq #0x800, l2, l5
-l2:	ldb [23]
-l3:	jeq #0x1, l4, l5
-l4:	ret #0xffff
-l5:	ret #0
-  Prints out BPF code disassembly.
-
-> dump
-/* { op, jt, jf, k }, */
-{ 0x28,  0,  0, 0x0000000c },
-{ 0x15,  0,  3, 0x00000800 },
-{ 0x30,  0,  0, 0x00000017 },
-{ 0x15,  0,  1, 0x00000001 },
-{ 0x06,  0,  0, 0x0000ffff },
-{ 0x06,  0,  0, 0000000000 },
-  Prints out C-style BPF code dump.
-
-> breakpoint 0
-breakpoint at: l0:	ldh [12]
-> breakpoint 1
-breakpoint at: l1:	jeq #0x800, l2, l5
-  ...
-  Sets breakpoints at particular BPF instructions. Issuing a `run` command
-  will walk through the pcap file continuing from the current packet and
-  break when a breakpoint is being hit (another `run` will continue from
-  the currently active breakpoint executing next instructions):
-
-  > run
-  -- register dump --
-  pc:       [0]                       <-- program counter
-  code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
-  curr:     l0:	ldh [12]              <-- disassembly of current instruction
-  A:        [00000000][0]             <-- content of A (hex, decimal)
-  X:        [00000000][0]             <-- content of X (hex, decimal)
-  M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
-  -- packet dump --                   <-- Current packet from pcap (hex)
-  len: 42
-    0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
-   16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
-   32: 00 00 00 00 00 00 0a 3b 01 01
-  (breakpoint)
-  >
-
-> breakpoint
-breakpoints: 0 1
-  Prints currently set breakpoints.
-
-> step [-<n>, +<n>]
-  Performs single stepping through the BPF program from the current pc
-  offset. Thus, on each step invocation, above register dump is issued.
-  This can go forwards and backwards in time, a plain `step` will break
-  on the next BPF instruction, thus +1. (No `run` needs to be issued here.)
-
-> select <n>
-  Selects a given packet from the pcap file to continue from. Thus, on
-  the next `run` or `step`, the BPF program is being evaluated against
-  the user pre-selected packet. Numbering starts just as in Wireshark
-  with index 1.
-
-> quit
-#
-  Exits bpf_dbg.
+::
+
+  > load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
+    Loads a BPF filter from standard output of bpf_asm, or transformed via
+    e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
+    debugging (next section), this command creates a temporary socket and
+    loads the BPF code into the kernel. Thus, this will also be useful for
+    JIT developers.
+
+  > load pcap foo.pcap
+    Loads standard tcpdump pcap file.
+
+  > run [<n>]
+  bpf passes:1 fails:9
+    Runs through all packets from a pcap to account how many passes and fails
+    the filter will generate. A limit of packets to traverse can be given.
+
+  > disassemble
+  l0:	ldh [12]
+  l1:	jeq #0x800, l2, l5
+  l2:	ldb [23]
+  l3:	jeq #0x1, l4, l5
+  l4:	ret #0xffff
+  l5:	ret #0
+    Prints out BPF code disassembly.
+
+  > dump
+  /* { op, jt, jf, k }, */
+  { 0x28,  0,  0, 0x0000000c },
+  { 0x15,  0,  3, 0x00000800 },
+  { 0x30,  0,  0, 0x00000017 },
+  { 0x15,  0,  1, 0x00000001 },
+  { 0x06,  0,  0, 0x0000ffff },
+  { 0x06,  0,  0, 0000000000 },
+    Prints out C-style BPF code dump.
+
+  > breakpoint 0
+  breakpoint at: l0:	ldh [12]
+  > breakpoint 1
+  breakpoint at: l1:	jeq #0x800, l2, l5
+    ...
+    Sets breakpoints at particular BPF instructions. Issuing a `run` command
+    will walk through the pcap file continuing from the current packet and
+    break when a breakpoint is being hit (another `run` will continue from
+    the currently active breakpoint executing next instructions):
+
+    > run
+    -- register dump --
+    pc:       [0]                       <-- program counter
+    code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
+    curr:     l0:ldh [12]               <-- disassembly of current instruction
+    A:        [00000000][0]             <-- content of A (hex, decimal)
+    X:        [00000000][0]             <-- content of X (hex, decimal)
+    M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
+    -- packet dump --                   <-- Current packet from pcap (hex)
+    len: 42
+      0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
+     16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
+     32: 00 00 00 00 00 00 0a 3b 01 01
+    (breakpoint)
+    >
+
+  > breakpoint
+  breakpoints: 0 1
+    Prints currently set breakpoints.
+
+  > step [-<n>, +<n>]
+    Performs single stepping through the BPF program from the current pc
+    offset. Thus, on each step invocation, above register dump is issued.
+    This can go forwards and backwards in time, a plain `step` will break
+    on the next BPF instruction, thus +1. (No `run` needs to be issued here.)
+
+  > select <n>
+    Selects a given packet from the pcap file to continue from. Thus, on
+    the next `run` or `step`, the BPF program is being evaluated against
+    the user pre-selected packet. Numbering starts just as in Wireshark
+    with index 1.
+
+  > quit
+  #
+    Exits bpf_dbg.
 
 JIT compiler
 ============
@@ -468,23 +472,23 @@ JIT compiler
 The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC, PowerPC,
 ARM, ARM64, MIPS and s390 and can be enabled through CONFIG_BPF_JIT. The JIT
 compiler is transparently invoked for each attached filter from user space
-or for internal kernel users if it has been previously enabled by root:
+or for internal kernel users if it has been previously enabled by root::
 
   echo 1 > /proc/sys/net/core/bpf_jit_enable
 
 For JIT developers, doing audits etc, each compile run can output the generated
-opcode image into the kernel log via:
+opcode image into the kernel log via::
 
   echo 2 > /proc/sys/net/core/bpf_jit_enable
 
-Example output from dmesg:
+Example output from dmesg::
 
-[ 3389.935842] flen=6 proglen=70 pass=3 image=ffffffffa0069c8f
-[ 3389.935847] JIT code: 00000000: 55 48 89 e5 48 83 ec 60 48 89 5d f8 44 8b 4f 68
-[ 3389.935849] JIT code: 00000010: 44 2b 4f 6c 4c 8b 87 d8 00 00 00 be 0c 00 00 00
-[ 3389.935850] JIT code: 00000020: e8 1d 94 ff e0 3d 00 08 00 00 75 16 be 17 00 00
-[ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
-[ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
+  [ 3389.935842] flen=6 proglen=70 pass=3 image=ffffffffa0069c8f
+  [ 3389.935847] JIT code: 00000000: 55 48 89 e5 48 83 ec 60 48 89 5d f8 44 8b 4f 68
+  [ 3389.935849] JIT code: 00000010: 44 2b 4f 6c 4c 8b 87 d8 00 00 00 be 0c 00 00 00
+  [ 3389.935850] JIT code: 00000020: e8 1d 94 ff e0 3d 00 08 00 00 75 16 be 17 00 00
+  [ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
+  [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
 
 When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set to 1 and
 setting any other value than that will return in failure. This is even the case for
@@ -493,77 +497,77 @@ is discouraged and introspection through bpftool (under tools/bpf/bpftool/) is t
 generally recommended approach instead.
 
 In the kernel source tree under tools/bpf/, there's bpf_jit_disasm for
-generating disassembly out of the kernel log's hexdump:
-
-# ./bpf_jit_disasm
-70 bytes emitted from JIT compiler (pass:3, flen:6)
-ffffffffa0069c8f + <x>:
-   0:	push   %rbp
-   1:	mov    %rsp,%rbp
-   4:	sub    $0x60,%rsp
-   8:	mov    %rbx,-0x8(%rbp)
-   c:	mov    0x68(%rdi),%r9d
-  10:	sub    0x6c(%rdi),%r9d
-  14:	mov    0xd8(%rdi),%r8
-  1b:	mov    $0xc,%esi
-  20:	callq  0xffffffffe0ff9442
-  25:	cmp    $0x800,%eax
-  2a:	jne    0x0000000000000042
-  2c:	mov    $0x17,%esi
-  31:	callq  0xffffffffe0ff945e
-  36:	cmp    $0x1,%eax
-  39:	jne    0x0000000000000042
-  3b:	mov    $0xffff,%eax
-  40:	jmp    0x0000000000000044
-  42:	xor    %eax,%eax
-  44:	leaveq
-  45:	retq
+generating disassembly out of the kernel log's hexdump::
+
+  # ./bpf_jit_disasm
+  70 bytes emitted from JIT compiler (pass:3, flen:6)
+  ffffffffa0069c8f + <x>:
+     0:	push   %rbp
+     1:	mov    %rsp,%rbp
+     4:	sub    $0x60,%rsp
+     8:	mov    %rbx,-0x8(%rbp)
+     c:	mov    0x68(%rdi),%r9d
+    10:	sub    0x6c(%rdi),%r9d
+    14:	mov    0xd8(%rdi),%r8
+    1b:	mov    $0xc,%esi
+    20:	callq  0xffffffffe0ff9442
+    25:	cmp    $0x800,%eax
+    2a:	jne    0x0000000000000042
+    2c:	mov    $0x17,%esi
+    31:	callq  0xffffffffe0ff945e
+    36:	cmp    $0x1,%eax
+    39:	jne    0x0000000000000042
+    3b:	mov    $0xffff,%eax
+    40:	jmp    0x0000000000000044
+    42:	xor    %eax,%eax
+    44:	leaveq
+    45:	retq
 
 Issuing option `-o` will "annotate" opcodes to resulting assembler
-instructions, which can be very useful for JIT developers:
+instructions, which can be very useful for JIT developers::
 
-# ./bpf_jit_disasm -o
-70 bytes emitted from JIT compiler (pass:3, flen:6)
-ffffffffa0069c8f + <x>:
-   0:	push   %rbp
+  # ./bpf_jit_disasm -o
+  70 bytes emitted from JIT compiler (pass:3, flen:6)
+  ffffffffa0069c8f + <x>:
+     0:	push   %rbp
 	55
-   1:	mov    %rsp,%rbp
+     1:	mov    %rsp,%rbp
 	48 89 e5
-   4:	sub    $0x60,%rsp
+     4:	sub    $0x60,%rsp
 	48 83 ec 60
-   8:	mov    %rbx,-0x8(%rbp)
+     8:	mov    %rbx,-0x8(%rbp)
 	48 89 5d f8
-   c:	mov    0x68(%rdi),%r9d
+     c:	mov    0x68(%rdi),%r9d
 	44 8b 4f 68
-  10:	sub    0x6c(%rdi),%r9d
+    10:	sub    0x6c(%rdi),%r9d
 	44 2b 4f 6c
-  14:	mov    0xd8(%rdi),%r8
+    14:	mov    0xd8(%rdi),%r8
 	4c 8b 87 d8 00 00 00
-  1b:	mov    $0xc,%esi
+    1b:	mov    $0xc,%esi
 	be 0c 00 00 00
-  20:	callq  0xffffffffe0ff9442
+    20:	callq  0xffffffffe0ff9442
 	e8 1d 94 ff e0
-  25:	cmp    $0x800,%eax
+    25:	cmp    $0x800,%eax
 	3d 00 08 00 00
-  2a:	jne    0x0000000000000042
+    2a:	jne    0x0000000000000042
 	75 16
-  2c:	mov    $0x17,%esi
+    2c:	mov    $0x17,%esi
 	be 17 00 00 00
-  31:	callq  0xffffffffe0ff945e
+    31:	callq  0xffffffffe0ff945e
 	e8 28 94 ff e0
-  36:	cmp    $0x1,%eax
+    36:	cmp    $0x1,%eax
 	83 f8 01
-  39:	jne    0x0000000000000042
+    39:	jne    0x0000000000000042
 	75 07
-  3b:	mov    $0xffff,%eax
+    3b:	mov    $0xffff,%eax
 	b8 ff ff 00 00
-  40:	jmp    0x0000000000000044
+    40:	jmp    0x0000000000000044
 	eb 02
-  42:	xor    %eax,%eax
+    42:	xor    %eax,%eax
 	31 c0
-  44:	leaveq
+    44:	leaveq
 	c9
-  45:	retq
+    45:	retq
 	c3
 
 For BPF JIT developers, bpf_jit_disasm, bpf_asm and bpf_dbg provides a useful
@@ -663,9 +667,18 @@ Some core changes of the new internal format:
 
 - Conditional jt/jf targets replaced with jt/fall-through:
 
-  While the original design has constructs such as "if (cond) jump_true;
-  else jump_false;", they are being replaced into alternative constructs like
-  "if (cond) jump_true; /* else fall-through */".
+  While the original design has constructs such as::
+
+    if (cond)
+      jump_true;
+    else
+      jump_false;
+
+  they are being replaced into alternative constructs like::
+
+    if (cond)
+      jump_true;
+    /* else fall-through */
 
 - Introduces bpf_call insn and register passing convention for zero overhead
   calls from/to other kernel functions:
@@ -684,30 +697,30 @@ Some core changes of the new internal format:
   a return value of the function. Since R6 - R9 are callee saved, their state
   is preserved across the call.
 
-  For example, consider three C functions:
+  For example, consider three C functions::
 
-  u64 f1() { return (*_f2)(1); }
-  u64 f2(u64 a) { return f3(a + 1, a); }
-  u64 f3(u64 a, u64 b) { return a - b; }
+    u64 f1() { return (*_f2)(1); }
+    u64 f2(u64 a) { return f3(a + 1, a); }
+    u64 f3(u64 a, u64 b) { return a - b; }
 
-  GCC can compile f1, f3 into x86_64:
+  GCC can compile f1, f3 into x86_64::
 
-  f1:
-    movl $1, %edi
-    movq _f2(%rip), %rax
-    jmp  *%rax
-  f3:
-    movq %rdi, %rax
-    subq %rsi, %rax
-    ret
+    f1:
+      movl $1, %edi
+      movq _f2(%rip), %rax
+      jmp  *%rax
+    f3:
+      movq %rdi, %rax
+      subq %rsi, %rax
+      ret
 
-  Function f2 in eBPF may look like:
+  Function f2 in eBPF may look like::
 
-  f2:
-    bpf_mov R2, R1
-    bpf_add R1, 1
-    bpf_call f3
-    bpf_exit
+    f2:
+      bpf_mov R2, R1
+      bpf_add R1, 1
+      bpf_call f3
+      bpf_exit
 
   If f2 is JITed and the pointer stored to '_f2'. The calls f1 -> f2 -> f3 and
   returns will be seamless. Without JIT, __bpf_prog_run() interpreter needs to
@@ -720,7 +733,7 @@ Some core changes of the new internal format:
   in the future.
 
   On 64-bit architectures all register map to HW registers one to one. For
-  example, x86_64 JIT compiler can map them as ...
+  example, x86_64 JIT compiler can map them as ... ::
 
     R0 - rax
     R1 - rdi
@@ -737,7 +750,7 @@ Some core changes of the new internal format:
   ... since x86_64 ABI mandates rdi, rsi, rdx, rcx, r8, r9 for argument passing
   and rbx, r12 - r15 are callee saved.
 
-  Then the following internal BPF pseudo-program:
+  Then the following internal BPF pseudo-program::
 
     bpf_mov R6, R1 /* save ctx */
     bpf_mov R2, 2
@@ -755,7 +768,7 @@ Some core changes of the new internal format:
     bpf_add R0, R7
     bpf_exit
 
-  After JIT to x86_64 may look like:
+  After JIT to x86_64 may look like::
 
     push %rbp
     mov %rsp,%rbp
@@ -781,11 +794,11 @@ Some core changes of the new internal format:
     leaveq
     retq
 
-  Which is in this example equivalent in C to:
+  Which is in this example equivalent in C to::
 
     u64 bpf_filter(u64 ctx)
     {
-        return foo(ctx, 2, 3, 4, 5) + bar(ctx, 6, 7, 8, 9);
+	return foo(ctx, 2, 3, 4, 5) + bar(ctx, 6, 7, 8, 9);
     }
 
   In-kernel functions foo() and bar() with prototype: u64 (*)(u64 arg1, u64
@@ -795,7 +808,7 @@ Some core changes of the new internal format:
   interpreter. R0-R5 are scratch registers, so eBPF program needs to preserve
   them across the calls as defined by calling convention.
 
-  For example the following program is invalid:
+  For example the following program is invalid::
 
     bpf_mov R1, 1
     bpf_call foo
@@ -814,7 +827,7 @@ The input context pointer for invoking the interpreter function is generic,
 its content is defined by a specific use case. For seccomp register R1 points
 to seccomp_data, for converted BPF filters R1 points to a skb.
 
-A program, that is translated internally consists of the following elements:
+A program, that is translated internally consists of the following elements::
 
   op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
 
@@ -849,7 +862,7 @@ eBPF opcode encoding
 
 eBPF is reusing most of the opcode encoding from classic to simplify conversion
 of classic BPF to eBPF. For arithmetic and jump instructions the 8-bit 'code'
-field is divided into three parts:
+field is divided into three parts::
 
   +----------------+--------+--------------------+
   |   4 bits       |  1 bit |   3 bits           |
@@ -857,7 +870,7 @@ field is divided into three parts:
   +----------------+--------+--------------------+
   (MSB)                                      (LSB)
 
-Three LSB bits store instruction class which is one of:
+Three LSB bits store instruction class which is one of::
 
   Classic BPF classes:    eBPF classes:
 
@@ -871,23 +884,24 @@ Three LSB bits store instruction class which is one of:
   BPF_MISC  0x07          BPF_ALU64 0x07
 
 When BPF_CLASS(code) == BPF_ALU or BPF_JMP, 4th bit encodes source operand ...
+::
 
   BPF_K     0x00
   BPF_X     0x08
 
- * in classic BPF, this means:
+in classic BPF, this means::
 
   BPF_SRC(code) == BPF_X - use register X as source operand
   BPF_SRC(code) == BPF_K - use 32-bit immediate as source operand
 
- * in eBPF, this means:
+in eBPF, this means::
 
   BPF_SRC(code) == BPF_X - use 'src_reg' register as source operand
   BPF_SRC(code) == BPF_K - use 32-bit immediate as source operand
 
 ... and four MSB bits store operation code.
 
-If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of:
+If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of::
 
   BPF_ADD   0x00
   BPF_SUB   0x10
@@ -904,7 +918,7 @@ If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is one of:
   BPF_ARSH  0xc0  /* eBPF only: sign extending shift right */
   BPF_END   0xd0  /* eBPF only: endianness conversion */
 
-If BPF_CLASS(code) == BPF_JMP, BPF_OP(code) is one of:
+If BPF_CLASS(code) == BPF_JMP, BPF_OP(code) is one of::
 
   BPF_JA    0x00
   BPF_JEQ   0x10
@@ -941,7 +955,7 @@ in eBPF means function exit only. The eBPF program needs to store return
 value into register R0 before doing a BPF_EXIT. Class 6 in eBPF is currently
 unused and reserved for future use.
 
-For load and store instructions the 8-bit 'code' field is divided as:
+For load and store instructions the 8-bit 'code' field is divided as::
 
   +--------+--------+-------------------+
   | 3 bits | 2 bits |   3 bits          |
@@ -949,21 +963,21 @@ For load and store instructions the 8-bit 'code' field is divided as:
   +--------+--------+-------------------+
   (MSB)                             (LSB)
 
-Size modifier is one of ...
+Size modifier is one of ... ::
 
   BPF_W   0x00    /* word */
   BPF_H   0x08    /* half word */
   BPF_B   0x10    /* byte */
   BPF_DW  0x18    /* eBPF only, double word */
 
-... which encodes size of load/store operation:
+... which encodes size of load/store operation::
 
- B  - 1 byte
- H  - 2 byte
- W  - 4 byte
- DW - 8 byte (eBPF only)
+  B  - 1 byte
+  H  - 2 byte
+  W  - 4 byte
+  DW - 8 byte (eBPF only)
 
-Mode modifier is one of:
+Mode modifier is one of::
 
   BPF_IMM  0x00  /* used for 32-bit mov in classic BPF and 64-bit in eBPF */
   BPF_ABS  0x20
@@ -991,20 +1005,20 @@ the interpreter will abort the execution of the program. JIT compilers
 therefore must preserve this property. src_reg and imm32 fields are
 explicit inputs to these instructions.
 
-For example:
+For example::
 
   BPF_IND | BPF_W | BPF_LD means:
 
     R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + src_reg + imm32))
     and R1 - R5 were scratched.
 
-Unlike classic BPF instruction set, eBPF has generic load/store operations:
+Unlike classic BPF instruction set, eBPF has generic load/store operations::
 
-BPF_MEM | <size> | BPF_STX:  *(size *) (dst_reg + off) = src_reg
-BPF_MEM | <size> | BPF_ST:   *(size *) (dst_reg + off) = imm32
-BPF_MEM | <size> | BPF_LDX:  dst_reg = *(size *) (src_reg + off)
-BPF_XADD | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
-BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
+  BPF_MEM | <size> | BPF_STX:  *(size *) (dst_reg + off) = src_reg
+  BPF_MEM | <size> | BPF_ST:   *(size *) (dst_reg + off) = imm32
+  BPF_MEM | <size> | BPF_LDX:  dst_reg = *(size *) (src_reg + off)
+  BPF_XADD | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
+  BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
 
 Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW. Note that 1 and
 2 byte atomic increments are not supported.
@@ -1037,29 +1051,35 @@ since addition of two valid pointers makes invalid pointer.
 (In 'secure' mode verifier will reject any type of pointer arithmetic to make
 sure that kernel addresses don't leak to unprivileged users)
 
-If register was never written to, it's not readable:
+If register was never written to, it's not readable::
+
   bpf_mov R0 = R2
   bpf_exit
+
 will be rejected, since R2 is unreadable at the start of the program.
 
 After kernel function call, R1-R5 are reset to unreadable and
 R0 has a return type of the function.
 
-Since R6-R9 are callee saved, their state is preserved across the call.
+Since R6-R9 are callee saved, their state is preserved across the call. ::
+
   bpf_mov R6 = 1
   bpf_call foo
   bpf_mov R0 = R6
   bpf_exit
+
 is a correct program. If there was R1 instead of R6, it would have
 been rejected.
 
 load/store instructions are allowed only with registers of valid types, which
 are PTR_TO_CTX, PTR_TO_MAP, PTR_TO_STACK. They are bounds and alignment checked.
-For example:
+For example::
+
  bpf_mov R1 = 1
  bpf_mov R2 = 2
  bpf_xadd *(u32 *)(R1 + 3) += R2
  bpf_exit
+
 will be rejected, since R1 doesn't have a valid pointer type at the time of
 execution of instruction bpf_xadd.
 
@@ -1067,8 +1087,10 @@ At the start R1 type is PTR_TO_CTX (a pointer to generic 'struct bpf_context')
 A callback is used to customize verifier to restrict eBPF program access to only
 certain fields within ctx structure with specified size and alignment.
 
-For example, the following insn:
+For example, the following insn::
+
   bpf_ld R0 = *(u32 *)(R6 + 8)
+
 intends to load a word from address R6 + 8 and store it into R0
 If R6=PTR_TO_CTX, via is_valid_access() callback the verifier will know
 that offset 8 of size 4 bytes can be accessed for reading, otherwise
@@ -1080,9 +1102,11 @@ so it will fail verification, since it's out of bounds.
 The verifier will allow eBPF program to read data from stack only after
 it wrote into it.
 Classic BPF verifier does similar check with M[0-15] memory slots.
-For example:
+For example::
+
   bpf_ld R0 = *(u32 *)(R10 - 4)
   bpf_exit
+
 is invalid program.
 Though R10 is correct read-only register and has type PTR_TO_STACK
 and R10 - 4 is within stack bounds, there were no stores into that location.
@@ -1118,19 +1142,21 @@ This is done with 'struct bpf_reg_state', defined in include/linux/
 bpf_verifier.h, which unifies tracking of scalar and pointer values.  Each
 register state has a type, which is either NOT_INIT (the register has not been
 written to), SCALAR_VALUE (some value which is not usable as a pointer), or a
-pointer type.  The types of pointers describe their base, as follows:
+pointer type.  The types of pointers describe their base, as follows::
+
     PTR_TO_CTX          Pointer to bpf_context.
     CONST_PTR_TO_MAP    Pointer to struct bpf_map.  "Const" because arithmetic
-                        on these pointers is forbidden.
+			on these pointers is forbidden.
     PTR_TO_MAP_VALUE    Pointer to the value stored in a map element.
     PTR_TO_MAP_VALUE_OR_NULL
-                        Either a pointer to a map value, or NULL; map accesses
-                        (see section 'eBPF maps', below) return this type,
-                        which becomes a PTR_TO_MAP_VALUE when checked != NULL.
-                        Arithmetic on these pointers is forbidden.
+			Either a pointer to a map value, or NULL; map accesses
+			(see section 'eBPF maps', below) return this type,
+			which becomes a PTR_TO_MAP_VALUE when checked != NULL.
+			Arithmetic on these pointers is forbidden.
     PTR_TO_STACK        Frame pointer.
     PTR_TO_PACKET       skb->data.
     PTR_TO_PACKET_END   skb->data + headlen; arithmetic forbidden.
+
 However, a pointer may be offset from this base (as a result of pointer
 arithmetic), and this is tracked in two parts: the 'fixed offset' and 'variable
 offset'.  The former is used when an exactly-known value (e.g. an immediate
@@ -1182,14 +1208,15 @@ Direct packet access
 ====================
 In cls_bpf and act_bpf programs the verifier allows direct access to the packet
 data via skb->data and skb->data_end pointers.
-Ex:
-1:  r4 = *(u32 *)(r1 +80)  /* load skb->data_end */
-2:  r3 = *(u32 *)(r1 +76)  /* load skb->data */
-3:  r5 = r3
-4:  r5 += 14
-5:  if r5 > r4 goto pc+16
-R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
-6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
+Ex::
+
+  1:  r4 = *(u32 *)(r1 +80)  /* load skb->data_end */
+  2:  r3 = *(u32 *)(r1 +76)  /* load skb->data */
+  3:  r5 = r3
+  4:  r5 += 14
+  5:  if r5 > r4 goto pc+16
+   R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
+  6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
 
 this 2byte load from the packet is safe to do, since the program author
 did check 'if (skb->data + 14 > skb->data_end) goto err' at insn #5 which
@@ -1204,23 +1231,25 @@ to the packet data, but constant 14 was added to the register, so
 it now points to 'skb->data + 14' and accessible range is [R5, R5 + 14 - 14)
 which is zero bytes.
 
-More complex packet access may look like:
- R0=inv1 R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
- 6:  r0 = *(u8 *)(r3 +7) /* load 7th byte from the packet */
- 7:  r4 = *(u8 *)(r3 +12)
- 8:  r4 *= 14
- 9:  r3 = *(u32 *)(r1 +76) /* load skb->data */
-10:  r3 += r4
-11:  r2 = r1
-12:  r2 <<= 48
-13:  r2 >>= 48
-14:  r3 += r2
-15:  r2 = r3
-16:  r2 += 8
-17:  r1 = *(u32 *)(r1 +80) /* load skb->data_end */
-18:  if r2 > r1 goto pc+2
- R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
-19:  r1 = *(u8 *)(r3 +4)
+More complex packet access may look like::
+
+  R0=inv1 R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
+   6:  r0 = *(u8 *)(r3 +7) /* load 7th byte from the packet */
+   7:  r4 = *(u8 *)(r3 +12)
+   8:  r4 *= 14
+   9:  r3 = *(u32 *)(r1 +76) /* load skb->data */
+  10:  r3 += r4
+  11:  r2 = r1
+  12:  r2 <<= 48
+  13:  r2 >>= 48
+  14:  r3 += r2
+  15:  r2 = r3
+  16:  r2 += 8
+  17:  r1 = *(u32 *)(r1 +80) /* load skb->data_end */
+  18:  if r2 > r1 goto pc+2
+   R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
+  19:  r1 = *(u8 *)(r3 +4)
+
 The state of the register R3 is R3=pkt(id=2,off=0,r=8)
 id=2 means that two 'r3 += rX' instructions were seen, so r3 points to some
 offset within a packet and since the program author did
@@ -1246,7 +1275,8 @@ which calls adjust_ptr_min_max_vals() for adding pointer to scalar (or vice
 versa) and adjust_scalar_min_max_vals() for operations on two scalars.
 
 The end result is that bpf program author can access packet directly
-using normal C code as:
+using normal C code as::
+
   void *data = (void *)(long)skb->data;
   void *data_end = (void *)(long)skb->data_end;
   struct eth_hdr *eth = data;
@@ -1254,13 +1284,14 @@ using normal C code as:
   struct udphdr *udp = data + sizeof(*eth) + sizeof(*iph);
 
   if (data + sizeof(*eth) + sizeof(*iph) + sizeof(*udp) > data_end)
-          return 0;
+	return 0;
   if (eth->h_proto != htons(ETH_P_IP))
-          return 0;
+	return 0;
   if (iph->protocol != IPPROTO_UDP || iph->ihl != 5)
-          return 0;
+	return 0;
   if (udp->dest == 53 || udp->source == 9)
-          ...;
+	...;
+
 which makes such programs easier to write comparing to LD_ABS insn
 and significantly faster.
 
@@ -1271,6 +1302,7 @@ eBPF maps
 and userspace.
 
 The maps are accessed from user space via BPF syscall, which has commands:
+
 - create a map with given type and attributes
   map_fd = bpf(BPF_MAP_CREATE, union bpf_attr *attr, u32 size)
   using attr->map_type, attr->key_size, attr->value_size, attr->max_entries
@@ -1327,66 +1359,79 @@ Understanding eBPF verifier messages
 The following are few examples of invalid eBPF programs and verifier error
 messages as seen in the log:
 
-Program with unreachable instructions:
-static struct bpf_insn prog[] = {
-  BPF_EXIT_INSN(),
-  BPF_EXIT_INSN(),
-};
-Error:
-  unreachable insn 1
+Program with unreachable instructions::
+
+  static struct bpf_insn prog[] = {
+    BPF_EXIT_INSN(),
+    BPF_EXIT_INSN(),
+  };
+
+  Error:
+    unreachable insn 1
+
+Program that reads uninitialized register::
 
-Program that reads uninitialized register:
   BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
   BPF_EXIT_INSN(),
-Error:
-  0: (bf) r0 = r2
-  R2 !read_ok
 
-Program that doesn't initialize R0 before exiting:
+  Error:
+    0: (bf) r0 = r2
+    R2 !read_ok
+
+Program that doesn't initialize R0 before exiting::
+
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
   BPF_EXIT_INSN(),
-Error:
-  0: (bf) r2 = r1
-  1: (95) exit
-  R0 !read_ok
 
-Program that accesses stack out of bounds:
+  Error:
+    0: (bf) r2 = r1
+    1: (95) exit
+    R0 !read_ok
+
+Program that accesses stack out of bounds::
+
   BPF_ST_MEM(BPF_DW, BPF_REG_10, 8, 0),
   BPF_EXIT_INSN(),
-Error:
-  0: (7a) *(u64 *)(r10 +8) = 0
-  invalid stack off=8 size=8
 
-Program that doesn't initialize stack before passing its address into function:
+  Error:
+    0: (7a) *(u64 *)(r10 +8) = 0
+    invalid stack off=8 size=8
+
+Program that doesn't initialize stack before passing its address into function::
+
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
   BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_EXIT_INSN(),
-Error:
-  0: (bf) r2 = r10
-  1: (07) r2 += -8
-  2: (b7) r1 = 0x0
-  3: (85) call 1
-  invalid indirect read from stack off -8+0 size 8
-
-Program that uses invalid map_fd=0 while calling to map_lookup_elem() function:
+
+  Error:
+    0: (bf) r2 = r10
+    1: (07) r2 += -8
+    2: (b7) r1 = 0x0
+    3: (85) call 1
+    invalid indirect read from stack off -8+0 size 8
+
+Program that uses invalid map_fd=0 while calling to map_lookup_elem() function::
+
   BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
   BPF_LD_MAP_FD(BPF_REG_1, 0),
   BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_EXIT_INSN(),
-Error:
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 0x0
-  4: (85) call 1
-  fd 0 is not pointing to valid bpf_map
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 0x0
+    4: (85) call 1
+    fd 0 is not pointing to valid bpf_map
 
 Program that doesn't check return value of map_lookup_elem() before accessing
-map element:
+map element::
+
   BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
@@ -1394,17 +1439,19 @@ map element:
   BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
   BPF_EXIT_INSN(),
-Error:
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 0x0
-  4: (85) call 1
-  5: (7a) *(u64 *)(r0 +0) = 0
-  R0 invalid mem access 'map_value_or_null'
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 0x0
+    4: (85) call 1
+    5: (7a) *(u64 *)(r0 +0) = 0
+    R0 invalid mem access 'map_value_or_null'
 
 Program that correctly checks map_lookup_elem() returned value for NULL, but
-accesses the memory with incorrect alignment:
+accesses the memory with incorrect alignment::
+
   BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
@@ -1413,20 +1460,22 @@ accesses the memory with incorrect alignment:
   BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
   BPF_EXIT_INSN(),
-Error:
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 1
-  4: (85) call 1
-  5: (15) if r0 == 0x0 goto pc+1
-   R0=map_ptr R10=fp
-  6: (7a) *(u64 *)(r0 +4) = 0
-  misaligned access off 4 size 8
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 1
+    4: (85) call 1
+    5: (15) if r0 == 0x0 goto pc+1
+     R0=map_ptr R10=fp
+    6: (7a) *(u64 *)(r0 +4) = 0
+    misaligned access off 4 size 8
 
 Program that correctly checks map_lookup_elem() returned value for NULL and
 accesses memory with correct alignment in one side of 'if' branch, but fails
-to do so in the other side of 'if' branch:
+to do so in the other side of 'if' branch::
+
   BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
   BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
   BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
@@ -1437,20 +1486,21 @@ to do so in the other side of 'if' branch:
   BPF_EXIT_INSN(),
   BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
   BPF_EXIT_INSN(),
-Error:
-  0: (7a) *(u64 *)(r10 -8) = 0
-  1: (bf) r2 = r10
-  2: (07) r2 += -8
-  3: (b7) r1 = 1
-  4: (85) call 1
-  5: (15) if r0 == 0x0 goto pc+2
-   R0=map_ptr R10=fp
-  6: (7a) *(u64 *)(r0 +0) = 0
-  7: (95) exit
-
-  from 5 to 8: R0=imm0 R10=fp
-  8: (7a) *(u64 *)(r0 +0) = 1
-  R0 invalid mem access 'imm'
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 1
+    4: (85) call 1
+    5: (15) if r0 == 0x0 goto pc+2
+     R0=map_ptr R10=fp
+    6: (7a) *(u64 *)(r0 +0) = 0
+    7: (95) exit
+
+    from 5 to 8: R0=imm0 R10=fp
+    8: (7a) *(u64 *)(r0 +0) = 1
+    R0 invalid mem access 'imm'
 
 Testing
 =======
@@ -1458,7 +1508,7 @@ Testing
 Next to the BPF toolchain, the kernel also ships a test module that contains
 various test cases for classic and internal BPF that can be executed against
 the BPF interpreter and JIT compiler. It can be found in lib/test_bpf.c and
-enabled via Kconfig:
+enabled via Kconfig::
 
   CONFIG_TEST_BPF=m
 
-- 
2.17.1

