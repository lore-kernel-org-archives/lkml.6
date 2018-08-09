Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE953C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2227221BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="YCw0+PTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sglX4deS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2227221BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeHIHqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:46:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44543 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728056AbeHIHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:46:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6AFD21E32;
        Thu,  9 Aug 2018 01:23:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 01:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/hO7wxwKn9MrWKzb6
        UHW9/uuooECcGQYdkOqXomXeTk=; b=YCw0+PTsbLSN1/cPD2/RyZUXPGJuh/uFx
        PHZ/0tt59Bmr5oeu1zmuL+fvR9y2PQHM7bmW6CGG1sVgJ+Wew58kI9KgqemesTDk
        LfD9XqdE/adcfRQ7jLw+gxlY0i+zcGaQmj4HH0tgxfj5rkn1Hbwxa6n/A94Z2uoF
        PCdYI9jd3sv4Rku0m3lnLSHa1O6Md8dJu+B3wfi+qTwxPSgncGvqhPkcLvfImxUL
        6rwlDo80ppaRyQSa6TIXIeLNHAyoT4Q6AVfBRl1Gjg14vkWHt+ptlEKuSMStdHfe
        Yo+VNBiBlBJK0cJnr0dUzcFA9FMYOsuezZ/uLGa+f46hKSVknXDHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/hO7wxwKn9MrWKzb6UHW9/uuooECcGQYdkOqXomXeTk=; b=sglX4deS
        mbkQlt/GhalbXn76nZhIXFdJWi9LOgdK4Q8tV7x7tHj4pKEeJhtbC3ch0eSFIlRx
        42cxhVq69M84jNp+aMm6v3G29qqGTytYTRz6UjqSSKmPFaMV4nI5rc2zSlFl2oeg
        x+ziEBB7xBKohEGO2eoOabkoGjqRmr9Zi1LvooUch+L3SspgbQIPTfleOH6fyq7g
        R04DdjNtTPzS8kSs6i1SEua/OIYehNbw0vwaUWEfceSSB8JeXGt9KPvDYmw0uTo8
        VtY8P0CaNdx4GwvOlgHqI8N6mjjFL5SfNxV8iNIourR4+7LvUIMNRQl5wj4wOxbi
        zEjD7D2WoKlwGA==
X-ME-Proxy: <xmx:5M9rW3aH_hLfvnCu_KJhJ5h6CCS72hpupLwJoesKZUzdjpVlD-niSw>
    <xmx:5M9rWyLnafUQWLyCPijodEMshcwiTAk3kPhfHFs0hbGUIw2byiXfow>
    <xmx:5M9rW8vGhdLJqj9YZ3qUqky-WM5jjQ7pHo4HszfxacpUIA1PYs9ZMg>
    <xmx:5M9rWzoFmhCxvKwmOAymPkPRuKfHWM7P-Zl9eIKbR3jsSTRDnMYU-Q>
    <xmx:5M9rW8ZzoBixykHvb5zrlQruybZKdx_84e6bwDm7k6M79rLkqzIgig>
    <xmx:5M9rWwCUqFKnD2YkXOrrkzxEShU3WNRq0DK98MgcWGhBOfzgmbOJ_w>
X-ME-Sender: <xms:5M9rW808ITAHinmhPKyBivYoc91W-XYyO78IX3v6bW5-t0suFKcPbg>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C34410268;
        Thu,  9 Aug 2018 01:23:46 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/4] docs: Separate and convert filter.txt to RST
Date:   Thu,  9 Aug 2018 15:23:26 +1000
Message-Id: <20180809052328.27942-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809052328.27942-1-me@tobin.cc>
References: <20180809052328.27942-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RST is the preferred format for kernel documentation now.  Convert
networking/filter.txt to RST format.  Currently filer.txt contains
documentation on various things related to BPF.  To improve the quality
of the kernel documentation we can split this file up.  Also, BPF is
useful to userspace for applications outside of just networking.

Split filter.txt up into three RST files, all now located under
Documentation/userspace-api/.  After the split there should be no Sphinx
warnings.

Create three new files from the content of filter.txt

 - socket-filter.rst on how to write socket filters
 - cBPF.rst describing classic BPF and its tools
 - eBPF.rst describing extended BPF

Add files to MAINTAINERS.

Do conversion

 - Fix line length (72 character maximum).
 - Use double spaces after a period (full stop).
 - Use RST format directives for code snippets (::).
 - Fix indentation of code snippets.
 - Use correct heading adornments.
 - Add SPDX license comment

Because these three files are related (also seccomp_filter.rst) there
are a number of references to each.  Add an RST reference label to the
top of each file and use it with the relative path (starting at
Documentation) as is typical in kernel docs.  Use a list so as to make
the text file readable as well as the rendered HTML.

Add RST label and SPDX licence comment to seccomp_filter.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
---
 Documentation/userspace-api/cBPF.rst          |  432 +++++++
 Documentation/userspace-api/eBPF.rst          | 1007 +++++++++++++++++
 Documentation/userspace-api/index.rst         |    3 +
 .../userspace-api/seccomp_filter.rst          |   11 +
 Documentation/userspace-api/socket_filter.rst |  183 +++
 MAINTAINERS                                   |    4 +-
 6 files changed, 1639 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/cBPF.rst
 create mode 100644 Documentation/userspace-api/eBPF.rst
 create mode 100644 Documentation/userspace-api/socket_filter.rst

diff --git a/Documentation/userspace-api/cBPF.rst b/Documentation/userspace-api/cBPF.rst
new file mode 100644
index 000000000000..9d50c202bb60
--- /dev/null
+++ b/Documentation/userspace-api/cBPF.rst
@@ -0,0 +1,432 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. _cbpf:
+
+====================================
+Classic Berkley Packet Filter (cBPF)
+====================================
+
+For an introduction to BPF and Linux Socket Filtering please see
+:ref:`Documentation/userspace-api/socket-filter.rst <socket-filter>`
+
+Under tools/bpf/ there's a small helper tool called bpf_asm which can be
+used to write low-level filters for example scenarios mentioned in the
+above linked document.  Asm-like syntax mentioned here has been
+implemented in bpf_asm and will be used for further explanations
+(instead of dealing with less readable opcodes directly, principles are
+the same).  The syntax is closely modelled after Steven McCanne's and
+Van Jacobson's BPF paper [1].
+
+The BPF architecture consists of the following basic elements:
+
+.. flat-table:: BPF Elements
+
+   * - Element
+     - Description
+
+   * - A
+     - 32 bit wide accumulator
+
+   * - X
+     - 32 bit wide X register
+
+   * - M[]
+     - 16 x 32 bit wide misc registers aka "scratch memory store",
+       addressable from 0 to 15
+
+A program, that is translated by bpf_asm into "opcodes" is an array that
+consists of the following elements (as already mentioned)::
+
+  op:16, jt:8, jf:8, k:32
+
+The element op is a 16 bit wide opcode that has a particular instruction
+encoded.  jt and jf are two 8 bit wide jump targets, one for condition
+"jump if true", the other one "jump if false".  Eventually, element k
+contains a miscellaneous argument that can be interpreted in different
+ways depending on the given instruction in op.
+
+The instruction set consists of load, store, branch, alu, miscellaneous
+and return instructions that are also represented in bpf_asm syntax.
+This table lists all bpf_asm instructions available resp.  what their
+underlying opcodes as defined in linux/filter.h stand for:
+::
+
+  Instruction      Addressing mode      Description
+
+  ld               1, 2, 3, 4, 10       Load word into A
+  ldi              4                    Load word into A
+  ldh              1, 2                 Load half-word into A
+  ldb              1, 2                 Load byte into A
+  ldx              3, 4, 5, 10          Load word into X
+  ldxi             4                    Load word into X
+  ldxb             5                    Load byte into X
+
+  st               3                    Store A into M[]
+  stx              3                    Store X into M[]
+
+  jmp              6                    Jump to label
+  ja               6                    Jump to label
+  jeq              7, 8                 Jump on A == k
+  jneq             8                    Jump on A != k
+  jne              8                    Jump on A != k
+  jlt              8                    Jump on A <  k
+  jle              8                    Jump on A <= k
+  jgt              7, 8                 Jump on A >  k
+  jge              7, 8                 Jump on A >= k
+  jset             7, 8                 Jump on A &  k
+
+  add              0, 4                 A + <x>
+  sub              0, 4                 A - <x>
+  mul              0, 4                 A * <x>
+  div              0, 4                 A / <x>
+  mod              0, 4                 A % <x>
+  neg                                   !A
+  and              0, 4                 A & <x>
+  or               0, 4                 A | <x>
+  xor              0, 4                 A ^ <x>
+  lsh              0, 4                 A << <x>
+  rsh              0, 4                 A >> <x>
+
+  tax                                   Copy A into X
+  txa                                   Copy X into A
+
+  ret              4, 9                 Return
+
+The next table shows addressing formats from the 2nd column::
+
+  Addressing mode  Syntax               Description
+
+   0               x/%x                 Register X
+   1               [k]                  BHW at byte offset k in the packet
+   2               [x + k]              BHW at the offset X + k in the packet
+   3               M[k]                 Word at offset k in M[]
+   4               #k                   Literal value stored in k
+   5               4*([k]&0xf)          Lower nibble * 4 at byte offset k in the packet
+   6               L                    Jump label L
+   7               #k,Lt,Lf             Jump to Lt if true, otherwise jump to Lf
+   8               #k,Lt                Jump to Lt if predicate is true
+   9               a/%a                 Accumulator A
+  10               extension            BPF extension
+
+The Linux kernel also has a couple of BPF extensions that are used along
+with the class of load instructions by "overloading" the k argument with
+a negative offset + a particular extension offset.  The result of such
+BPF extensions are loaded into A.
+
+Possible BPF extensions are shown in the following table::
+
+  Extension                             Description
+
+  len                                   skb->len
+  proto                                 skb->protocol
+  type                                  skb->pkt_type
+  poff                                  Payload start offset
+  ifidx                                 skb->dev->ifindex
+  nla                                   Netlink attribute of type X with offset A
+  nlan                                  Nested Netlink attribute of type X with offset A
+  mark                                  skb->mark
+  queue                                 skb->queue_mapping
+  hatype                                skb->dev->type
+  rxhash                                skb->hash
+  cpu                                   raw_smp_processor_id()
+  vlan_tci                              skb_vlan_tag_get(skb)
+  vlan_avail                            skb_vlan_tag_present(skb)
+  vlan_tpid                             skb->vlan_proto
+  rand                                  prandom_u32()
+
+These extensions can also be prefixed with '#'.
+Examples for low-level BPF:
+
+ARP packets::
+
+  ldh [12]
+  jne #0x806, drop
+  ret #-1
+  drop: ret #0
+
+IPv4 TCP packets::
+
+  ldh [12]
+  jne #0x800, drop
+  ldb [23]
+  jneq #6, drop
+  ret #-1
+  drop: ret #0
+
+(Accelerated) VLAN w/ id 10::
+
+  ld vlan_tci
+  jneq #10, drop
+  ret #-1
+  drop: ret #0
+
+icmp random packet sampling, 1 in 4::
+
+  ldh [12]
+  jne #0x800, drop
+  ldb [23]
+  jneq #1, drop
+  # get a random uint32 number
+  ld rand
+  mod #4
+  jneq #1, drop
+  ret #-1
+  drop: ret #0
+
+SECCOMP filter example::
+
+  ld [4]                  /* offsetof(struct seccomp_data, arch) */
+  jne #0xc000003e, bad    /* AUDIT_ARCH_X86_64 */
+  ld [0]                  /* offsetof(struct seccomp_data, nr) */
+  jeq #15, good           /* __NR_rt_sigreturn */
+  jeq #231, good          /* __NR_exit_group */
+  jeq #60, good           /* __NR_exit */
+  jeq #0, good            /* __NR_read */
+  jeq #1, good            /* __NR_write */
+  jeq #5, good            /* __NR_fstat */
+  jeq #9, good            /* __NR_mmap */
+  jeq #14, good           /* __NR_rt_sigprocmask */
+  jeq #13, good           /* __NR_rt_sigaction */
+  jeq #35, good           /* __NR_nanosleep */
+  bad: ret #0             /* SECCOMP_RET_KILL_THREAD */
+  good: ret #0x7fff0000   /* SECCOMP_RET_ALLOW */
+
+The above example code can be placed into a file (here called "foo"),
+and then be passed to the bpf_asm tool for generating opcodes, output
+that xt_bpf and cls_bpf understands and can directly be loaded with.
+Example with above ARP code::
+
+  $ ./bpf_asm foo
+  4,40 0 0 12,21 0 1 2054,6 0 0 4294967295,6 0 0 0,
+
+In copy and paste C-like output::
+
+  $ ./bpf_asm -c foo
+  { 0x28,  0,  0, 0x0000000c },
+  { 0x15,  0,  1, 0x00000806 },
+  { 0x06,  0,  0, 0xffffffff },
+  { 0x06,  0,  0, 0000000000 },
+
+In particular, as usage with xt_bpf or cls_bpf can result in more
+complex BPF filters that might not be obvious at first, it's good to
+test filters before attaching to a live system.  For that purpose,
+there's a small tool called bpf_dbg under tools/bpf/ in the kernel
+source directory.  This debugger allows for testing BPF filters against
+given pcap files, single stepping through the BPF code on the pcap's
+packets and to do BPF machine register dumps.
+
+Starting bpf_dbg is trivial and just requires issuing::
+
+  # ./bpf_dbg
+
+In case input and output do not equal stdin/stdout, bpf_dbg takes an
+alternative stdin source as a first argument, and an alternative stdout
+sink as a second one, e.g. `./bpf_dbg test_in.txt test_out.txt`.
+
+Other than that, a particular libreadline configuration can be set via
+file "~/.bpf_dbg_init" and the command history is stored in the file
+"~/.bpf_dbg_history".
+
+Interaction in bpf_dbg happens through a shell that also has
+auto-completion support (follow-up example commands starting with '>'
+denote bpf_dbg shell).  The usual workflow would be to ... ::
+
+  > load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
+    Loads a BPF filter from standard output of bpf_asm, or transformed via
+    e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`.  Note that for JIT
+    debugging (next section), this command creates a temporary socket and
+    loads the BPF code into the kernel.  Thus, this will also be useful for
+    JIT developers.
+
+  > load pcap foo.pcap
+    Loads standard tcpdump pcap file.
+
+  > run [<n>]
+  bpf passes:1 fails:9
+    Runs through all packets from a pcap to account how many passes and fails
+    the filter will generate.  A limit of packets to traverse can be given.
+
+  > disassemble
+  l0:	  ldh [12]
+  l1:	  jeq #0x800, l2, l5
+  l2:	  ldb [23]
+  l3:	  jeq #0x1, l4, l5
+  l4:	  ret #0xffff
+  l5:	  ret #0
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
+  breakpoint at: l0:  	  ldh [12]
+  > breakpoint 1
+  breakpoint at: l1:	  jeq #0x800, l2, l5
+    ...
+    Sets breakpoints at particular BPF instructions.  Issuing a `run` command
+    will walk through the pcap file continuing from the current packet and
+    break when a breakpoint is being hit (another `run` will continue from
+    the currently active breakpoint executing next instructions):
+
+  > run
+  -- register dump --
+  pc:       [0]                       <-- program counter
+  code:     [40] jt[0] jf[0] k[12]    <-- plain BPF code of current instruction
+  curr:     l0:	ldh [12]              <-- disassembly of current instruction
+  A:        [00000000][0]             <-- content of A (hex, decimal)
+  X:        [00000000][0]             <-- content of X (hex, decimal)
+  M[0,15]:  [00000000][0]             <-- folded content of M (hex, decimal)
+  -- packet dump --                   <-- Current packet from pcap (hex)
+  len: 42
+    0: 00 19 cb 55 55 a4 00 14 a4 43 78 69 08 06 00 01
+   16: 08 00 06 04 00 01 00 14 a4 43 78 69 0a 3b 01 26
+   32: 00 00 00 00 00 00 0a 3b 01 01
+  (breakpoint)
+  >
+
+  > breakpoint
+  breakpoints: 0 1
+    Prints currently set breakpoints.
+
+  > step [-<n>, +<n>]
+    Performs single stepping through the BPF program from the current pc
+    offset.  Thus, on each step invocation, above register dump is issued.
+    This can go forwards and backwards in time, a plain `step` will break
+    on the next BPF instruction, thus +1.  (No `run` needs to be issued here.)
+
+  > select <n>
+    Selects a given packet from the pcap file to continue from.  Thus, on
+    the next `run` or `step`, the BPF program is being evaluated against
+    the user pre-selected packet.  Numbering starts just as in Wireshark
+    with index 1.
+
+  > quit
+  #
+    Exits bpf_dbg.
+
+JIT compiler
+============
+
+The Linux kernel has a built-in BPF JIT compiler for x86_64, SPARC,
+PowerPC, ARM, ARM64, MIPS and s390 which can be enabled through
+CONFIG_BPF_JIT.  The JIT compiler is transparently invoked for each
+attached filter from user space or for internal kernel users if it has
+been previously enabled by root::
+
+  echo 1 > /proc/sys/net/core/bpf_jit_enable
+
+For JIT developers, doing audits etc, each compile run can output the
+generated opcode image into the kernel log via::
+
+  echo 2 > /proc/sys/net/core/bpf_jit_enable
+
+Example output from dmesg::
+
+  [ 3389.935842] flen=6 proglen=70 pass=3 image=ffffffffa0069c8f
+  [ 3389.935847] JIT code: 00000000: 55 48 89 e5 48 83 ec 60 48 89 5d f8 44 8b 4f 68
+  [ 3389.935849] JIT code: 00000010: 44 2b 4f 6c 4c 8b 87 d8 00 00 00 be 0c 00 00 00
+  [ 3389.935850] JIT code: 00000020: e8 1d 94 ff e0 3d 00 08 00 00 75 16 be 17 00 00
+  [ 3389.935851] JIT code: 00000030: 00 e8 28 94 ff e0 83 f8 01 75 07 b8 ff ff 00 00
+  [ 3389.935852] JIT code: 00000040: eb 02 31 c0 c9 c3
+
+When CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently
+set to 1 and setting any other value than that will return in failure.
+This is even the case for setting bpf_jit_enable to 2, since dumping the
+final JIT image into the kernel log is discouraged and introspection
+through bpftool (under tools/bpf/bpftool/) is the generally recommended
+approach instead.
+
+In the kernel source tree under tools/bpf/, there's bpf_jit_disasm for
+generating disassembly out of the kernel log's hexdump::
+
+  # ./bpf_jit_disasm
+  70 bytes emitted from JIT compiler (pass:3, flen:6)
+  ffffffffa0069c8f + <x>:
+     0:	  push   %rbp
+     1:	  mov    %rsp,%rbp
+     4:	  sub    $0x60,%rsp
+     8:	  mov    %rbx,-0x8(%rbp)
+     c:	  mov    0x68(%rdi),%r9d
+    10:	  sub    0x6c(%rdi),%r9d
+    14:	  mov    0xd8(%rdi),%r8
+    1b:	  mov    $0xc,%esi
+    20:	  callq  0xffffffffe0ff9442
+    25:	  cmp    $0x800,%eax
+    2a:	  jne    0x0000000000000042
+    2c:	  mov    $0x17,%esi
+    31:	  callq  0xffffffffe0ff945e
+    36:	  cmp    $0x1,%eax
+    39:	  jne    0x0000000000000042
+    3b:	  mov    $0xffff,%eax
+    40:	  jmp    0x0000000000000044
+    42:	  xor    %eax,%eax
+    44:	  leaveq
+    45:	  retq
+
+Issuing option `-o` will "annotate" opcodes to resulting assembler
+instructions, which can be very useful for JIT developers::
+
+  # ./bpf_jit_disasm -o
+  70 bytes emitted from JIT compiler (pass:3, flen:6)
+  ffffffffa0069c8f + <x>:
+     0:	  push   %rbp
+	  55
+     1:	  mov    %rsp,%rbp
+	  48 89 e5
+     4:	  sub    $0x60,%rsp
+	  48 83 ec 60
+     8:	  mov    %rbx,-0x8(%rbp)
+	  48 89 5d f8
+     c:	  mov    0x68(%rdi),%r9d
+	  44 8b 4f 68
+    10:	  sub    0x6c(%rdi),%r9d
+	  44 2b 4f 6c
+    14:	  mov    0xd8(%rdi),%r8
+	  4c 8b 87 d8 00 00 00
+    1b:	  mov    $0xc,%esi
+	  be 0c 00 00 00
+    20:	  callq  0xffffffffe0ff9442
+	  e8 1d 94 ff e0
+    25:	  cmp    $0x800,%eax
+	  3d 00 08 00 00
+    2a:	  jne    0x0000000000000042
+	  75 16
+    2c:	  mov    $0x17,%esi
+	  be 17 00 00 00
+    31:	  callq  0xffffffffe0ff945e
+	  e8 28 94 ff e0
+    36:	  cmp    $0x1,%eax
+	  83 f8 01
+    39:	  jne    0x0000000000000042
+	  75 07
+    3b:	  mov    $0xffff,%eax
+	  b8 ff ff 00 00
+    40:	  jmp    0x0000000000000044
+	  eb 02
+    42:	  xor    %eax,%eax
+	  31 c0
+    44:	  leaveq
+	  c9
+    45:	  retq
+	  c3
+
+For BPF JIT developers, bpf_jit_disasm, bpf_asm and bpf_dbg provides a
+useful toolchain for developing and testing the kernel's JIT compiler.
+
+Reference
+=========
+
+The original BPF paper:
+
+[1] Steven McCanne and Van Jacobson. 1993.  The BSD packet filter: a new
+architecture for user-level packet capture.  In Proceedings of the
+USENIX Winter 1993 Conference Proceedings on USENIX Winter 1993
+Conference Proceedings (USENIX'93).  USENIX Association, Berkeley, CA,
+USA, 2-2. [http://www.tcpdump.org/papers/bpf-usenix93.pdf]
diff --git a/Documentation/userspace-api/eBPF.rst b/Documentation/userspace-api/eBPF.rst
new file mode 100644
index 000000000000..39fbe18a38fa
--- /dev/null
+++ b/Documentation/userspace-api/eBPF.rst
@@ -0,0 +1,1007 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. _ebpf:
+
+=====================================
+Internal Berkley Packet Filter (eBPF)
+=====================================
+
+For an introduction to BPF and Linux Socket Filtering please see
+:ref:`Documentation/userspace-api/socket-filter.rst <socket-filter>`
+
+Internally, for the kernel interpreter, a different instruction set format
+with similar underlying principles from BPF described in the document
+linked to above is being used.  However, the instruction set format is
+modelled closer to the underlying architecture to mimic native instruction
+sets, so that better performance can be achieved (more details later).
+This new ISA is called 'eBPF' or 'internal BPF' interchangeably.  (Note:
+eBPF which originates from [e]xtended BPF is not the same as BPF
+extensions! While eBPF is an ISA, BPF extensions date back to classic BPF's
+'overloading' of BPF_LD | BPF_{B,H,W} | BPF_ABS instruction.)
+
+It is designed to be JITed with one to one mapping, which can also open up
+the possibility for GCC/LLVM compilers to generate optimized eBPF code
+through an eBPF backend that performs almost as fast as natively compiled
+code.
+
+The new instruction set was originally designed with the possible goal in
+mind to write programs in "restricted C" and compile into eBPF with a
+optional GCC/LLVM backend, so that it can just-in-time map to modern 64-bit
+CPUs with minimal performance overhead over two steps, that is, C -> eBPF
+-> native code.
+
+Currently, the new format is being used for running user BPF programs,
+which includes seccomp BPF, classic socket filters, cls_bpf traffic
+classifier, team driver's classifier for its load-balancing mode,
+netfilter's xt_bpf extension, PTP dissector/classifier, and much more.
+
+For more information please see:
+
+- :ref:`Documentation/userspace-api/seccomp_filter.rst <seccomp-filter>`
+- :ref:`Documentation/userspace-api/socket_filter.rst <socket-filter>`
+- :ref:`Documentation/userspace-api/cBPF.rst <ebpf>`
+
+They are all internally converted by the kernel into the new instruction
+set representation and run in the eBPF interpreter.  For in-kernel
+handlers, this all works transparently by using bpf_prog_create() for
+setting up the filter, resp.  bpf_prog_destroy() for destroying it.  The
+macro BPF_PROG_RUN(filter, ctx) transparently invokes eBPF interpreter or
+JITed code to run the filter.  'filter' is a pointer to struct bpf_prog
+that we got from bpf_prog_create(), and 'ctx' the given context (e.g.  skb
+pointer).  All constraints and restrictions from bpf_check_classic() apply
+before a conversion to the new layout is being done behind the scenes!
+
+Currently, the classic BPF format is being used for JITing on most 32-bit
+architectures, whereas x86-64, aarch64, s390x, powerpc64, sparc64, arm32
+perform JIT compilation from eBPF instruction set. (see cBPF document
+linked above.)
+
+Some core changes of the new internal format
+--------------------------------------------
+
+Number of registers increase from 2 to 10
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The old format had two registers A and X, and a hidden frame pointer.
+The new layout extends this to be 10 internal registers and a read-only
+frame pointer.  Since 64-bit CPUs are passing arguments to functions via
+registers the number of args from eBPF program to in-kernel function is
+restricted to 5 and one register is used to accept return value from an
+in-kernel function.  Natively, x86_64 passes first 6 arguments in
+registers, aarch64/ sparcv9/mips64 have 7 - 8 registers for arguments;
+x86_64 has 6 callee saved registers, and aarch64/sparcv9/mips64 have 11
+or more callee saved registers.
+
+.. flat-table:: eBPF Calling Convention
+   :widths: 1 2
+
+   * - Register
+     - Convention
+
+   * - R0
+     - return value from in-kernel function, and exit value for eBPF
+       program
+
+   * - R1 - R5
+     - arguments from eBPF program to in-kernel function
+
+   * - R6 - R9
+     - callee saved registers that in-kernel function will preserve
+
+   * - R10
+     - read-only frame pointer to access stack
+
+Thus, all eBPF registers map one to one to HW registers on x86_64,
+aarch64, etc, and eBPF calling convention maps directly to ABIs used by
+the kernel on 64-bit architectures.
+
+On 32-bit architectures JIT may map programs that use only 32-bit
+arithmetic and may let more complex programs to be interpreted.
+
+R0 - R5 are scratch registers and eBPF program needs spill/fill them if
+necessary across calls.  Note that there is only one eBPF program (==
+one eBPF main routine) and it cannot call other eBPF functions, it can
+only call predefined in-kernel functions, though.
+
+Register width increases from 32-bit to 64-bit
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Still, the semantics of the original 32-bit ALU operations are preserved
+via 32-bit subregisters.  All eBPF registers are 64-bit with 32-bit
+lower subregisters that zero-extend into 64-bit if they are being
+written to.  That behavior maps directly to x86_64 and arm64 subregister
+definition, but makes other JITs more difficult.
+
+32-bit architectures run 64-bit internal BPF programs via interpreter.
+Their JITs may convert BPF programs that only use 32-bit subregisters
+into native instruction set and let the rest be interpreted.
+
+Operation is 64-bit since on 64-bit architectures pointers are also
+64-bit wide and we want to pass 64-bit values in/out of kernel
+functions.  32-bit eBPF registers would otherwise require us to define a
+register-pair ABI, thus we would not be able to use a direct eBPF
+register to HW register mapping and JIT would need to do
+combine/split/move operations for every register in and out of the
+function, which is complex, bug prone and slow.  Another reason is the
+use of atomic 64-bit counters.
+
+Conditional jt/jf targets replaced with jt/fall-through
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+While the original design has constructs such as::
+
+  if (cond)
+      jump_true;
+  else
+      jump_false;
+
+they are being replaced into alternative constructs like::
+
+  if (cond)
+      jump_true;
+
+  /* else fall-through */".
+
+Zero overhead calls from/to other kernel functions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Introduces bpf_call insn and register passing convention for zero
+overhead calls from/to other kernel functions.
+
+Before an in-kernel function call, the internal BPF program needs to
+place function arguments into R1 to R5 registers to satisfy calling
+convention, then the interpreter will take them from registers and pass
+to in-kernel function.  If R1 - R5 registers are mapped to CPU registers
+that are used for argument passing on given architecture, the JIT
+compiler doesn't need to emit extra moves.  Function arguments will be
+in the correct registers and BPF_CALL instruction will be JITed as
+single 'call' HW instruction.  This calling convention was picked to
+cover common call situations without performance penalty.
+
+After an in-kernel function call, R1 - R5 are reset to unreadable and R0
+has the return value of the function.  Since R6 - R9 are callee saved,
+their state is preserved across the call.
+
+For example, consider three C functions::
+
+  u64 f1() { return (*_f2)(1); }
+  u64 f2(u64 a) { return f3(a + 1, a); }
+  u64 f3(u64 a, u64 b) { return a - b; }
+
+GCC can compile f1, f3 into x86_64::
+
+  f1:
+    movl $1, %edi
+    movq _f2(%rip), %rax
+    jmp  *%rax
+  f3:
+    movq %rdi, %rax
+    subq %rsi, %rax
+    ret
+
+Function f2 in eBPF may look like::
+
+  f2:
+    bpf_mov R2, R1
+    bpf_add R1, 1
+    bpf_call f3
+    bpf_exit
+
+If f2 is JITed and the pointer stored to '_f2'.  The calls f1 -> f2 ->
+f3 and returns will be seamless.  Without JIT, __bpf_prog_run()
+interpreter needs to be used to call into f2.
+
+For practical reasons all eBPF programs have only one argument 'ctx'
+which is already placed into R1 (e.g. on __bpf_prog_run() startup) and
+the programs can call kernel functions with up to 5 arguments.  Calls
+with 6 or more arguments are currently not supported, but these
+restrictions can be lifted if necessary in the future.
+
+On 64-bit architectures all registers map to HW registers one to one.
+For example, x86_64 JIT compiler can map them as ::
+
+  R0 - rax
+  R1 - rdi
+  R2 - rsi
+  R3 - rdx
+  R4 - rcx
+  R5 - r8
+  R6 - rbx
+  R7 - r13
+  R8 - r14
+  R9 - r15
+  R10 - rbp
+
+since x86_64 ABI mandates rdi, rsi, rdx, rcx, r8, r9 for argument
+passing and rbx, r12 - r15 are callee saved.
+
+Then the following internal BPF pseudo-program::
+
+  bpf_mov R6, R1 /* save ctx */
+  bpf_mov R2, 2
+  bpf_mov R3, 3
+  bpf_mov R4, 4
+  bpf_mov R5, 5
+  bpf_call foo
+  bpf_mov R7, R0 /* save foo() return value */
+  bpf_mov R1, R6 /* restore ctx for next call */
+  bpf_mov R2, 6
+  bpf_mov R3, 7
+  bpf_mov R4, 8
+  bpf_mov R5, 9
+  bpf_call bar
+  bpf_add R0, R7
+  bpf_exit
+
+After JIT to x86_64 may look like::
+
+  push %rbp
+  mov %rsp,%rbp
+  sub $0x228,%rsp
+  mov %rbx,-0x228(%rbp)
+  mov %r13,-0x220(%rbp)
+  mov %rdi,%rbx
+  mov $0x2,%esi
+  mov $0x3,%edx
+  mov $0x4,%ecx
+  mov $0x5,%r8d
+  callq foo
+  mov %rax,%r13
+  mov %rbx,%rdi
+  mov $0x2,%esi
+  mov $0x3,%edx
+  mov $0x4,%ecx
+  mov $0x5,%r8d
+  callq bar
+  add %r13,%rax
+  mov -0x228(%rbp),%rbx
+  mov -0x220(%rbp),%r13
+  leaveq
+  retq
+
+Which is in this example equivalent in C to::
+
+  u64 bpf_filter(u64 ctx)
+  {
+          return foo(ctx, 2, 3, 4, 5) + bar(ctx, 6, 7, 8, 9);
+  }
+
+In-kernel functions foo() and bar() with prototype: u64 (*)(u64 arg1,
+u64 arg2, u64 arg3, u64 arg4, u64 arg5); will receive arguments in
+proper registers and place their return value into '%rax' which is R0 in
+eBPF.  Prologue and epilogue are emitted by JIT and are implicit in the
+interpreter.  R0-R5 are scratch registers, so eBPF program needs to
+preserve them across the calls as defined by calling convention.
+
+For example the following program is invalid::
+
+  bpf_mov R1, 1
+  bpf_call foo
+  bpf_mov R0, R1
+  bpf_exit
+
+After the call the registers R1-R5 contain junk values and cannot be
+read.  An in-kernel eBPF verifier is used to validate internal BPF
+programs.
+
+Additional miscellaneous changes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Also in the new design, eBPF is limited to 4096 insns, which means that
+any program will terminate quickly and will only call a fixed number of
+kernel functions.  Original BPF and the new format are two operand
+instructions, which helps to do one-to-one mapping between eBPF insn and
+x86 insn during JIT.
+
+The input context pointer for invoking the interpreter function is
+generic, its content is defined by a specific use case.  For seccomp
+register R1 points to seccomp_data, for converted BPF filters R1 points
+to a skb.
+
+A program, that is translated internally consists of the following
+elements::
+
+  op:16, jt:8, jf:8, k:32    ==>    op:8, dst_reg:4, src_reg:4, off:16, imm:32
+
+So far 87 internal BPF instructions have been implemented.  8-bit 'op'
+opcode field has room for new instructions.  Some of them may use
+16/24/32 byte encoding.  New instructions must be a multiple of 8 bytes
+to preserve backward compatibility.
+
+Internal BPF is a general purpose RISC instruction set.  Not every
+register and every instruction are used during translation from original
+BPF to new format.  For example, socket filters are not using 'exclusive
+add' instruction, but tracing filters may do to maintain counters of
+events, for example.  Register R9 is not used by socket filters either,
+but more complex filters may be running out of registers and would have
+to resort to spill/fill to stack.
+
+Internal BPF can used as generic assembler for last step performance
+optimizations, socket filters and seccomp are using it as assembler.
+Tracing filters may use it as assembler to generate code from kernel.
+In-kernel usage may not be bounded by security considerations, since
+generated internal BPF code may use an optimised internal code path and
+may not be being exposed to user space.  Safety of internal BPF can come
+from a verifier (TBD).  In such use cases as described, it may be used
+as safe as the instruction set.
+
+Just like the original BPF, the new format runs within a controlled
+environment, is deterministic and the kernel can easily prove that.  The
+safety of the program can be determined in two steps: first step does
+depth-first-search to disallow loops and other CFG validation; second
+step starts from the first insn and descends all possible paths.  It
+simulates execution of every insn and observes the state change of
+registers and stack.
+
+eBPF opcode encoding
+====================
+
+eBPF is reusing most of the opcode encoding from classic to simplify
+conversion of classic BPF to eBPF.  For arithmetic and jump instructions
+the 8-bit 'code' field is divided into three parts::
+
+  +----------------+--------+--------------------+
+  |   4 bits       |  1 bit |   3 bits           |
+  | operation code | source | instruction class  |
+  +----------------+--------+--------------------+
+  (MSB)                                      (LSB)
+
+Three LSB bits store instruction class which is one of::
+
+  Classic BPF classes:    eBPF classes:
+
+  BPF_LD    0x00          BPF_LD    0x00
+  BPF_LDX   0x01          BPF_LDX   0x01
+  BPF_ST    0x02          BPF_ST    0x02
+  BPF_STX   0x03          BPF_STX   0x03
+  BPF_ALU   0x04          BPF_ALU   0x04
+  BPF_JMP   0x05          BPF_JMP   0x05
+  BPF_RET   0x06          [ class 6 unused, for future if needed ]
+  BPF_MISC  0x07          BPF_ALU64 0x07
+
+When BPF_CLASS(code) == BPF_ALU or BPF_JMP, 4th bit encodes source
+operand ... ::
+
+  BPF_K     0x00
+  BPF_X     0x08
+
+in classic BPF, this means::
+
+  BPF_SRC(code) == BPF_X - use register X as source operand
+  BPF_SRC(code) == BPF_K - use 32-bit immediate as source operand
+
+in eBPF, this means::
+
+  BPF_SRC(code) == BPF_X - use 'src_reg' register as source operand
+  BPF_SRC(code) == BPF_K - use 32-bit immediate as source operand
+
+... and four MSB bits store operation code.
+
+If BPF_CLASS(code) == BPF_ALU or BPF_ALU64 [ in eBPF ], BPF_OP(code) is
+one of::
+
+  BPF_ADD   0x00
+  BPF_SUB   0x10
+  BPF_MUL   0x20
+  BPF_DIV   0x30
+  BPF_OR    0x40
+  BPF_AND   0x50
+  BPF_LSH   0x60
+  BPF_RSH   0x70
+  BPF_NEG   0x80
+  BPF_MOD   0x90
+  BPF_XOR   0xa0
+  BPF_MOV   0xb0  /* eBPF only: mov reg to reg */
+  BPF_ARSH  0xc0  /* eBPF only: sign extending shift right */
+  BPF_END   0xd0  /* eBPF only: endianness conversion */
+
+If BPF_CLASS(code) == BPF_JMP, BPF_OP(code) is one of::
+
+  BPF_JA    0x00
+  BPF_JEQ   0x10
+  BPF_JGT   0x20
+  BPF_JGE   0x30
+  BPF_JSET  0x40
+  BPF_JNE   0x50  /* eBPF only: jump != */
+  BPF_JSGT  0x60  /* eBPF only: signed '>' */
+  BPF_JSGE  0x70  /* eBPF only: signed '>=' */
+  BPF_CALL  0x80  /* eBPF only: function call */
+  BPF_EXIT  0x90  /* eBPF only: function return */
+  BPF_JLT   0xa0  /* eBPF only: unsigned '<' */
+  BPF_JLE   0xb0  /* eBPF only: unsigned '<=' */
+  BPF_JSLT  0xc0  /* eBPF only: signed '<' */
+  BPF_JSLE  0xd0  /* eBPF only: signed '<=' */
+
+So BPF_ADD | BPF_X | BPF_ALU means 32-bit addition in both classic BPF
+and eBPF.  There are only two registers in classic BPF, so it means A
++= X.  In eBPF it means dst_reg = (u32) dst_reg + (u32) src_reg;
+similarly, BPF_XOR | BPF_K | BPF_ALU means A ^= imm32 in classic BPF and
+analogous src_reg = (u32) src_reg ^ (u32) imm32 in eBPF.
+
+Classic BPF is using BPF_MISC class to represent A = X and X = A moves.
+eBPF is using BPF_MOV | BPF_X | BPF_ALU code instead.  Since there are
+no BPF_MISC operations in eBPF, the class 7 is used as BPF_ALU64 to mean
+exactly the same operations as BPF_ALU, but with 64-bit wide operands
+instead.  So BPF_ADD | BPF_X | BPF_ALU64 means 64-bit addition i.e.
+dst_reg = dst_reg + src_reg
+
+Classic BPF wastes the whole BPF_RET class to represent a single 'ret'
+operation.  Classic BPF_RET | BPF_K means copy imm32 into return
+register and perform function exit.  eBPF is modeled to match CPU, so
+BPF_JMP | BPF_EXIT in eBPF means function exit only.  The eBPF program
+needs to store return value into register R0 before doing a BPF_EXIT.
+Class 6 in eBPF is currently unused and reserved for future use.
+
+For load and store instructions the 8-bit 'code' field is divided as::
+
+  +--------+--------+-------------------+
+  | 3 bits | 2 bits |   3 bits          |
+  |  mode  |  size  | instruction class |
+  +--------+--------+-------------------+
+  (MSB)                             (LSB)
+
+Size modifier is one of ... ::
+
+  BPF_W   0x00    /* word */
+  BPF_H   0x08    /* half word */
+  BPF_B   0x10    /* byte */
+  BPF_DW  0x18    /* eBPF only, double word */
+
+... which encodes size of load/store operation::
+
+  B  - 1 byte
+  H  - 2 byte
+  W  - 4 byte
+  DW - 8 byte (eBPF only)
+
+Mode modifier is one of::
+
+  BPF_IMM  0x00  /* used for 32-bit mov in classic BPF and 64-bit in eBPF */
+  BPF_ABS  0x20
+  BPF_IND  0x40
+  BPF_MEM  0x60
+  BPF_LEN  0x80  /* classic BPF only, reserved in eBPF */
+  BPF_MSH  0xa0  /* classic BPF only, reserved in eBPF */
+  BPF_XADD 0xc0  /* eBPF only, exclusive add */
+
+eBPF has two non-generic instructions: (BPF_ABS | <size> | BPF_LD) and
+(BPF_IND | <size> | BPF_LD) which are used to access packet data.
+
+They had to be carried over from classic to have strong performance of
+socket filters running in eBPF interpreter.  These instructions can only
+be used when interpreter context is a pointer to 'struct sk_buff' and
+have seven implicit operands.  Register R6 is an implicit input that
+must contain pointer to sk_buff.  Register R0 is an implicit output
+which contains the data fetched from the packet.  Registers R1-R5 are
+scratch registers and must not be used to store the data across BPF_ABS
+| BPF_LD or BPF_IND | BPF_LD instructions.
+
+These instructions have implicit program exit condition as well.  When
+eBPF program is trying to access the data beyond the packet boundary,
+the interpreter will abort the execution of the program.  JIT compilers
+therefore must preserve this property.  src_reg and imm32 fields are
+explicit inputs to these instructions.
+
+For example::
+
+  BPF_IND | BPF_W | BPF_LD means:
+
+    R0 = ntohl(*(u32 *) (((struct sk_buff *) R6)->data + src_reg + imm32))
+    and R1 - R5 were scratched.
+
+Unlike classic BPF instruction set, eBPF has generic load/store
+operations::
+
+  BPF_MEM | <size> | BPF_STX:  *(size *) (dst_reg + off) = src_reg
+  BPF_MEM | <size> | BPF_ST:   *(size *) (dst_reg + off) = imm32
+  BPF_MEM | <size> | BPF_LDX:  dst_reg = *(size *) (src_reg + off)
+  BPF_XADD | BPF_W  | BPF_STX: lock xadd *(u32 *)(dst_reg + off16) += src_reg
+  BPF_XADD | BPF_DW | BPF_STX: lock xadd *(u64 *)(dst_reg + off16) += src_reg
+
+Where size is one of: BPF_B or BPF_H or BPF_W or BPF_DW.  Note that 1
+and 2 byte atomic increments are not supported.
+
+eBPF has one 16-byte instruction: BPF_LD | BPF_DW | BPF_IMM which
+consists of two consecutive 'struct bpf_insn' 8-byte blocks and is
+interpreted as single instruction that loads 64-bit immediate value into
+a dst_reg.
+
+Classic BPF has similar instruction: BPF_LD | BPF_W | BPF_IMM which
+loads 32-bit immediate value into a register.
+
+eBPF verifier
+=============
+
+The safety of the eBPF program is determined in two steps.
+
+First step does DAG check to disallow loops and other CFG validation.
+In particular it will detect programs that have unreachable instructions
+(though classic BPF checker allows them).
+
+Second step starts from the first insn and descends all possible paths.
+It simulates execution of every insn and observes the state change of
+registers and stack.
+
+At the start of the program the register R1 contains a pointer to context
+and has type PTR_TO_CTX.
+
+If verifier sees an insn that does R2=R1, then R2 has now type
+PTR_TO_CTX as well and can be used on the right hand side of expression.
+
+If R1=PTR_TO_CTX and insn is R2=R1+R1, then R2=SCALAR_VALUE, since
+addition of two valid pointers makes invalid pointer.  (In 'secure' mode
+verifier will reject any type of pointer arithmetic to make sure that
+kernel addresses don't leak to unprivileged users)
+
+If register was never written to, it's not readable::
+
+  bpf_mov R0 = R2
+  bpf_exit
+
+will be rejected, since R2 is unreadable at the start of the program.
+
+After kernel function call, R1-R5 are reset to unreadable and R0 has a
+return type of the function.
+
+Since R6-R9 are callee saved, their state is preserved across the call.::
+
+  bpf_mov R6 = 1
+  bpf_call foo
+  bpf_mov R0 = R6
+  bpf_exit
+
+is a correct program.  If there was R1 instead of R6, it would have been
+rejected.
+
+load/store instructions are allowed only with registers of valid types,
+which are PTR_TO_CTX, PTR_TO_MAP, PTR_TO_STACK.  They are bounds and
+alignment checked.  For example::
+
+ bpf_mov R1 = 1
+ bpf_mov R2 = 2
+ bpf_xadd *(u32 *)(R1 + 3) += R2
+ bpf_exit
+
+will be rejected, since R1 doesn't have a valid pointer type at the time
+of execution of instruction bpf_xadd.
+
+At the start R1 type is PTR_TO_CTX (a pointer to generic 'struct
+bpf_context').  A callback is used to customize verifier to restrict
+eBPF program access to only certain fields within ctx structure with
+specified size and alignment.
+
+For example, the following insn::
+
+  bpf_ld R0 = *(u32 *)(R6 + 8)
+
+intends to load a word from address R6 + 8 and store it into R0
+
+If R6=PTR_TO_CTX, via is_valid_access() callback the verifier will know
+that offset 8 of size 4 bytes can be accessed for reading, otherwise the
+verifier will reject the program.
+
+If R6=PTR_TO_STACK, then access should be aligned and be within stack
+bounds, which are [-MAX_BPF_STACK, 0).  In this example offset is 8, so
+it will fail verification, since it's out of bounds.
+
+The verifier will allow eBPF program to read data from stack only after
+it wrote into it.
+
+Classic BPF verifier does similar check with M[0-15] memory slots, for
+example::
+
+  bpf_ld R0 = *(u32 *)(R10 - 4)
+  bpf_exit
+
+is an invalid program.
+
+Though R10 is correct read-only register and has type PTR_TO_STACK and
+R10 - 4 is within stack bounds, there were no stores into that location.
+
+Pointer register spill/fill is tracked as well, since four (R6-R9)
+callee saved registers may not be enough for some programs.
+
+Allowed function calls are customized with::
+
+  bpf_verifier_ops->get_func_proto()
+
+The eBPF verifier will check that registers match argument constraints.
+After the call register R0 will be set to return type of the function.
+
+Function calls is an important mechanism to extend functionality of eBPF
+programs.  Socket filters may let programs call one set of functions,
+whereas tracing filters may allow a completely different set.
+
+If a function is made accessible to eBPF program, it needs to be thought
+through from a safety point of view.  The verifier will guarantee that
+the function is called with valid arguments.
+
+seccomp vs socket filters have different security restrictions for
+classic BPF.  Seccomp solves this by two stage verifier: classic BPF
+verifier is followed by seccomp verifier.  In case of eBPF one
+configurable verifier is shared for all use cases.
+
+See details of eBPF verifier in kernel/bpf/verifier.c
+
+Register value tracking
+=======================
+
+In order to determine the safety of an eBPF program, the verifier must
+track the range of possible values in each register and also in each
+stack slot.  This is done with 'struct bpf_reg_state', defined in
+include/linux/bpf_verifier.h, which unifies tracking of scalar and
+pointer values.  Each register state has a type, which is either
+NOT_INIT (the register has not been written to), SCALAR_VALUE (some
+value which is not usable as a pointer), or a pointer type.  The types
+of pointers describe their base, as follows::
+
+    PTR_TO_CTX          Pointer to bpf_context.
+    CONST_PTR_TO_MAP    Pointer to struct bpf_map.  "Const" because arithmetic
+                        on these pointers is forbidden.
+    PTR_TO_MAP_VALUE    Pointer to the value stored in a map element.
+    PTR_TO_MAP_VALUE_OR_NULL
+                        Either a pointer to a map value, or NULL; map accesses
+                        (see section 'eBPF maps', below) return this type,
+                        which becomes a PTR_TO_MAP_VALUE when checked != NULL.
+                        Arithmetic on these pointers is forbidden.
+    PTR_TO_STACK        Frame pointer.
+    PTR_TO_PACKET       skb->data.
+    PTR_TO_PACKET_END   skb->data + headlen; arithmetic forbidden.
+
+However, a pointer may be offset from this base (as a result of pointer
+arithmetic), and this is tracked in two parts: the 'fixed offset' and
+'variable offset'.  The former is used when an exactly-known value
+(e.g. an immediate operand) is added to a pointer, while the latter is
+used for values which are not exactly known.  The variable offset is
+also used in SCALAR_VALUEs, to track the range of possible values in the
+register.
+
+The verifier's knowledge about the variable offset consists of three
+things 1) minimum and maximum values as unsigned. 2) minimum and maximum
+values as signed. 3) knowledge of the values of individual bits, in the
+form of a 'tnum': a u64 'mask' and a u64 'value'.  1s in the mask
+represent bits whose value is unknown; 1s in the value represent bits
+known to be 1.  Bits known to be 0 have 0 in both mask and value; no bit
+should ever be 1 in both.  For example, if a byte is read into a
+register from memory, the register's top 56 bits are known zero, while
+the low 8 are unknown - which is represented as the tnum (0x0; 0xff).
+If we then OR this with 0x40, we get (0x40; 0xbf), then if we add 1 we
+get (0x0; 0x1ff), because of potential carries.
+
+Besides arithmetic, the register state can also be updated by
+conditional branches.  For instance, if a SCALAR_VALUE is compared > 8,
+in the 'true' branch it will have a umin_value (unsigned minimum value)
+of 9, whereas in the 'false' branch it will have a umax_value of 8.  A
+signed compare (with BPF_JSGT or BPF_JSGE) would instead update the
+signed minimum/maximum values.  Information from the signed and unsigned
+bounds can be combined; for instance if a value is first tested < 8 and
+then tested s> 4, the verifier will conclude that the value is also > 4
+and s< 8, since the bounds prevent crossing the sign boundary.
+
+PTR_TO_PACKETs with a variable offset part have an 'id', which is common
+to all pointers sharing that same variable offset.  This is important
+for packet range checks: after adding a variable to a packet pointer
+register A, if you then copy it to another register B and then add a
+constant 4 to A, both registers will share the same 'id' but the A will
+have a fixed offset of +4.  Then if A is bounds-checked and found to be
+less than a PTR_TO_PACKET_END, the register B is now known to have a
+safe range of at least 4 bytes.  See 'Direct packet access', below, for
+more on PTR_TO_PACKET ranges.
+
+The 'id' field is also used on PTR_TO_MAP_VALUE_OR_NULL, common to all
+copies of the pointer returned from a map lookup.  This means that when
+one copy is checked and found to be non-NULL, all copies can become
+PTR_TO_MAP_VALUEs.  As well as range-checking, the tracked information
+is also used for enforcing alignment of pointer accesses.  For instance,
+on most systems the packet pointer is 2 bytes after a 4-byte alignment.
+If a program adds 14 bytes to that to jump over the Ethernet header,
+then reads IHL and adds (IHL * 4), the resulting pointer will have a
+variable offset known to be 4n+2 for some n, so adding the 2 bytes
+(NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses
+through that pointer are safe.
+
+Direct packet access
+====================
+
+In cls_bpf and act_bpf programs the verifier allows direct access to the packet
+data via skb->data and skb->data_end pointers, e.g.::
+
+  1:  r4 = *(u32 *)(r1 +80)  /* load skb->data_end */
+  2:  r3 = *(u32 *)(r1 +76)  /* load skb->data */
+  3:  r5 = r3
+  4:  r5 += 14
+  5:  if r5 > r4 goto pc+16
+  R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
+  6:  r0 = *(u16 *)(r3 +12) /* access 12 and 13 bytes of the packet */
+
+this 2byte load from the packet is safe to do, since the program author
+did check 'if (skb->data + 14 > skb->data_end) goto err' at insn #5
+which means that in the fall-through case the register R3 (which points
+to skb->data) has at least 14 directly accessible bytes.  The verifier
+marks it as R3=pkt(id=0,off=0,r=14).  id=0 means that no additional
+variables were added to the register.  off=0 means that no additional
+constants were added.  r=14 is the range of safe access which means that
+bytes [R3, R3 + 14) are ok.  Note that R5 is marked as
+R5=pkt(id=0,off=14,r=14).  It also points to the packet data, but
+constant 14 was added to the register, so it now points to 'skb->data +
+14' and accessible range is [R5, R5 + 14 - 14) which is zero bytes.
+
+More complex packet access may look like::
+
+  R0=inv1 R1=ctx R3=pkt(id=0,off=0,r=14) R4=pkt_end R5=pkt(id=0,off=14,r=14) R10=fp
+  6:  r0 = *(u8 *)(r3 +7) /* load 7th byte from the packet */
+  7:  r4 = *(u8 *)(r3 +12)
+  8:  r4 *= 14
+  9:  r3 = *(u32 *)(r1 +76) /* load skb->data */
+  10:  r3 += r4
+  11:  r2 = r1
+  12:  r2 <<= 48
+  13:  r2 >>= 48
+  14:  r3 += r2
+  15:  r2 = r3
+  16:  r2 += 8
+  17:  r1 = *(u32 *)(r1 +80) /* load skb->data_end */
+  18:  if r2 > r1 goto pc+2
+  R0=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R1=pkt_end R2=pkt(id=2,off=8,r=8) R3=pkt(id=2,off=0,r=8) R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)) R5=pkt(id=0,off=14,r=14) R10=fp
+  19:  r1 = *(u8 *)(r3 +4)
+
+The state of the register R3 is R3=pkt(id=2,off=0,r=8) id=2 means that
+two 'r3 += rX' instructions were seen, so r3 points to some offset
+within a packet and since the program author did 'if (r3 + 8 > r1) goto
+err' at insn #18, the safe range is [R3, R3 + 8).  The verifier only
+allows 'add'/'sub' operations on packet registers.  Any other operation
+will set the register state to 'SCALAR_VALUE' and it won't be available
+for direct packet access.  Operation 'r3 += rX' may overflow and become
+less than original skb->data, therefore the verifier has to prevent
+that.  So when it sees 'r3 += rX' instruction and rX is more than 16-bit
+value, any subsequent bounds-check of r3 against skb->data_end will not
+give us 'range' information, so attempts to read through the pointer
+will give "invalid access to packet" error.  Ex. after insn 'r4 = *(u8
+*)(r3 +12)' (insn #7 above) the state of r4 is
+R4=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) which means that upper
+56 bits of the register are guaranteed to be zero, and nothing is known
+about the lower 8 bits.  After insn 'r4 *= 14' the state becomes
+R4=inv(id=0,umax_value=3570,var_off=(0x0; 0xfffe)), since multiplying an
+8-bit value by constant 14 will keep upper 52 bits as zero, also the
+least significant bit will be zero as 14 is even.  Similarly 'r2 >>= 48'
+will make R2=inv(id=0,umax_value=65535,var_off=(0x0; 0xffff)), since the
+shift is not sign extending.  This logic is implemented in
+adjust_reg_min_max_vals() function, which calls
+adjust_ptr_min_max_vals() for adding pointer to scalar (or vice versa)
+and adjust_scalar_min_max_vals() for operations on two scalars.
+
+The end result is that bpf program author can access packet directly
+using normal C code as::
+
+  void *data = (void *)(long)skb->data;
+  void *data_end = (void *)(long)skb->data_end;
+  struct eth_hdr *eth = data;
+  struct iphdr *iph = data + sizeof(*eth);
+  struct udphdr *udp = data + sizeof(*eth) + sizeof(*iph);
+
+  if (data + sizeof(*eth) + sizeof(*iph) + sizeof(*udp) > data_end)
+          return 0;
+  if (eth->h_proto != htons(ETH_P_IP))
+          return 0;
+  if (iph->protocol != IPPROTO_UDP || iph->ihl != 5)
+          return 0;
+  if (udp->dest == 53 || udp->source == 9)
+          ...;
+
+which makes such programs easier to write comparing to LD_ABS insn
+and significantly faster.
+
+eBPF maps
+=========
+
+'maps' is a generic storage of different types for sharing data between
+kernel and userspace.
+
+The maps are accessed from user space via BPF syscall, which has commands:
+
+- create a map with given type and attributes::
+
+    map_fd = bpf(BPF_MAP_CREATE, union bpf_attr *attr, u32 size)
+    using attr->map_type, attr->key_size, attr->value_size, attr->max_entries
+    returns process-local file descriptor or negative error
+
+- lookup key in a given map::
+
+    err = bpf(BPF_MAP_LOOKUP_ELEM, union bpf_attr *attr, u32 size)
+    using attr->map_fd, attr->key, attr->value
+    returns zero and stores found elem into value or negative error
+
+- create or update key/value pair in a given map::
+
+    err = bpf(BPF_MAP_UPDATE_ELEM, union bpf_attr *attr, u32 size)
+    using attr->map_fd, attr->key, attr->value
+    returns zero or negative error
+
+- find and delete element by key in a given map::
+
+    err = bpf(BPF_MAP_DELETE_ELEM, union bpf_attr *attr, u32 size)
+    using attr->map_fd, attr->key
+
+- to delete map::
+
+    close(fd)
+    Exiting process will delete maps automatically
+
+userspace programs use this syscall to create/access maps that eBPF
+programs are concurrently updating.
+
+maps can have different types: hash, array, bloom filter, radix-tree,
+etc.
+
+The map is defined by:
+
+- type
+- max number of elements
+- key size in bytes
+- value size in bytes
+
+Pruning
+=======
+
+The verifier does not actually walk all possible paths through the
+program.  For each new branch to analyse, the verifier looks at all the
+states it's previously been in when at this instruction.  If any of them
+contain the current state as a subset, the branch is 'pruned' - that is,
+the fact that the previous state was accepted implies the current state
+would be as well.  For instance, if in the previous state, r1 held a
+packet-pointer, and in the current state, r1 holds a packet-pointer with
+a range as long or longer and at least as strict an alignment, then r1
+is safe.  Similarly, if r2 was NOT_INIT before then it can't have been
+used by any path from that point, so any value in r2 (including another
+NOT_INIT) is safe.  The implementation is in the function regsafe().
+Pruning considers not only the registers but also the stack (and any
+spilled registers it may hold).  They must all be safe for the branch to
+be pruned.  This is implemented in states_equal().
+
+Understanding eBPF verifier messages
+====================================
+
+The following are few examples of invalid eBPF programs and verifier error
+messages as seen in the log:
+
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
+
+  BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+  BPF_EXIT_INSN(),
+
+  Error:
+    0: (bf) r0 = r2
+    R2 !read_ok
+
+Program that doesn't initialize R0 before exiting::
+
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_1),
+  BPF_EXIT_INSN(),
+
+  Error:
+    0: (bf) r2 = r1
+    1: (95) exit
+    R0 !read_ok
+
+Program that accesses stack out of bounds::
+
+  BPF_ST_MEM(BPF_DW, BPF_REG_10, 8, 0),
+  BPF_EXIT_INSN(),
+
+  Error:
+    0: (7a) *(u64 *)(r10 +8) = 0
+    invalid stack off=8 size=8
+
+Program that doesn't initialize stack before passing its address into function::
+
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+  BPF_LD_MAP_FD(BPF_REG_1, 0),
+  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_EXIT_INSN(),
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
+  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+  BPF_LD_MAP_FD(BPF_REG_1, 0),
+  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_EXIT_INSN(),
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 0x0
+    4: (85) call 1
+    fd 0 is not pointing to valid bpf_map
+
+Program that doesn't check return value of map_lookup_elem() before
+accessing map element::
+
+  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+  BPF_LD_MAP_FD(BPF_REG_1, 0),
+  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
+  BPF_EXIT_INSN(),
+
+  Error:
+    0: (7a) *(u64 *)(r10 -8) = 0
+    1: (bf) r2 = r10
+    2: (07) r2 += -8
+    3: (b7) r1 = 0x0
+    4: (85) call 1
+    5: (7a) *(u64 *)(r0 +0) = 0
+    R0 invalid mem access 'map_value_or_null'
+
+Program that correctly checks map_lookup_elem() returned value for NULL,
+but accesses the memory with incorrect alignment::
+
+  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+  BPF_LD_MAP_FD(BPF_REG_1, 0),
+  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+  BPF_ST_MEM(BPF_DW, BPF_REG_0, 4, 0),
+  BPF_EXIT_INSN(),
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
+
+Program that correctly checks map_lookup_elem() returned value for NULL
+and accesses memory with correct alignment in one side of 'if' branch,
+but fails to do so in the other side of 'if' branch::
+
+  BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
+  BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+  BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+  BPF_LD_MAP_FD(BPF_REG_1, 0),
+  BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+  BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0),
+  BPF_EXIT_INSN(),
+  BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 1),
+  BPF_EXIT_INSN(),
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
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index a3233da7fa88..5e389aaf177c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -18,8 +18,11 @@ place where this information is gathered.
 
    no_new_privs
    seccomp_filter
+   socket_filter
    unshare
    spec_ctrl
+   cBPF
+   eBPF
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index 82a468bc7560..7c057115299b 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. _seccomp-filter:
+
 ===========================================
 Seccomp BPF (SECure COMPuting with filters)
 ===========================================
@@ -40,6 +44,13 @@ path (avoiding pathological sizes or selecting which of the multiplexed
 system calls in socketcall() is allowed, for instance) which could be
 construed, incorrectly, as a more complete sandboxing solution.
 
+For more information on BPF please see:
+
+- Linux Socket Filters -
+  :ref:`Documentation/userspace-api/socket_filter.rst <socket-filter>`
+- Classic BPF (cBPF) - :ref:`Documentation/userspace-api/cBPF.rst <cbpf>`
+- Internal BPF (eBPF) - :ref:`Documentation/userspace-api/eBPF.rst <ebpf>`
+
 Usage
 =====
 
diff --git a/Documentation/userspace-api/socket_filter.rst b/Documentation/userspace-api/socket_filter.rst
new file mode 100644
index 000000000000..3f20eb5809c6
--- /dev/null
+++ b/Documentation/userspace-api/socket_filter.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. _socket-filter:
+
+======================
+Linux Socket Filtering
+======================
+
+Linux Socket Filtering (LSF) is derived from the Berkeley Packet
+Filter.
+
+Introduction
+============
+
+Though there are some distinct differences between the BSD and Linux
+kernel socket filtering, but when we speak of BPF or LSF in Linux
+context, we mean the very same mechanism of filtering in the Linux
+kernel.
+
+BPF allows a user-space program to attach a filter onto any socket and
+allow or disallow certain types of data to come through the socket.  LSF
+follows exactly the same filter code structure as BSD's BPF, so
+referring to the BSD bpf.4 manpage is very helpful in creating filters.
+
+On Linux, BPF is much simpler than on BSD.  One does not have to worry
+about devices or anything like that.  You simply create your filter
+code, send it to the kernel via the SO_ATTACH_FILTER option and if your
+filter code passes the kernel check on it, you then immediately begin
+filtering data on that socket.
+
+You can also detach filters from your socket via the SO_DETACH_FILTER
+option.  This will probably not be used much since when you close a
+socket that has a filter on it the filter is automagically removed.  The
+other less common case may be adding a different filter on the same
+socket where you had another filter that is still running: the kernel
+takes care of removing the old one and placing your new one in its
+place, assuming your filter has passed the checks, otherwise if it fails
+the old filter will remain on that socket.
+
+SO_LOCK_FILTER option allows locking of the filter attached to a socket.
+Once set, a filter cannot be removed or changed.  This allows one
+process to setup a socket, attach a filter, lock it then drop privileges
+and be assured that the filter will be kept until the socket is closed.
+
+The biggest user of this construct might be libpcap.  Issuing a
+high-level filter command like `tcpdump -i em1 port 22` passes through
+the libpcap internal compiler that generates a structure that can
+eventually be loaded via SO_ATTACH_FILTER to the kernel.  `tcpdump -i
+em1 port 22 -ddd` displays what is being placed into this structure.
+
+Although we were only speaking about sockets here, BPF in Linux is used
+in many more places.  There's xt_bpf for netfilter, cls_bpf in the
+kernel qdisc layer, SECCOMP-BPF (SECure COMPuting), and lots of
+other places such as team driver, PTP code, etc. where BPF is being used.
+
+For more information please see the following documents:
+
+- Classic BPF (cBPF) - :ref:`Documentation/userspace-api/cBPF.rst <cbpf>`
+- Internal BPF (eBPF) - :ref:`Documentation/userspace-api/eBPF.rst <ebpf>`
+- SECCOMP BPF -
+  :ref:`Documentation/userspace-api/seccomp_filter.rst <seccomp-filter>`
+
+And the original BPF paper:
+
+Steven McCanne and Van Jacobson. 1993.  The BSD packet filter: a new
+architecture for user-level packet capture.  In Proceedings of the
+USENIX Winter 1993 Conference Proceedings on USENIX Winter 1993
+Conference Proceedings (USENIX'93).  USENIX Association, Berkeley,
+CA, USA, 2-2. [http://www.tcpdump.org/papers/bpf-usenix93.pdf]
+
+Structure
+=========
+
+User space applications include <linux/filter.h> which contains the
+following relevant structures::
+
+  struct sock_filter {	/* Filter block */
+	  __u16	code;   /* Actual filter code */
+	  __u8	jt;	/* Jump true */
+	  __u8	jf;	/* Jump false */
+	  __u32	k;      /* Generic multiuse field */
+  };
+
+Such a structure is assembled as an array of 4-tuples, that contains
+a code, jt, jf and k value.  jt and jf are jump offsets and k a generic
+value to be used for a provided code. ::
+
+  struct sock_fprog {		/* Required for SO_ATTACH_FILTER. */
+	  unsigned short len;   /* Number of filter blocks. */
+	  struct sock_filter __user *filter;
+  };
+
+For socket filtering, a pointer to this structure (as shown in the
+follow-up example) is being passed to the kernel through setsockopt(2).
+
+Example
+=======
+::
+
+  #include <sys/socket.h>
+  #include <sys/types.h>
+  #include <arpa/inet.h>
+  #include <linux/if_ether.h>
+  /* ... */
+
+  /* From the example above: tcpdump -i em1 port 22 -dd */
+  struct sock_filter code[] = {
+	  { 0x28,  0,  0, 0x0000000c },
+	  { 0x15,  0,  8, 0x000086dd },
+	  { 0x30,  0,  0, 0x00000014 },
+	  { 0x15,  2,  0, 0x00000084 },
+	  { 0x15,  1,  0, 0x00000006 },
+	  { 0x15,  0, 17, 0x00000011 },
+	  { 0x28,  0,  0, 0x00000036 },
+	  { 0x15, 14,  0, 0x00000016 },
+	  { 0x28,  0,  0, 0x00000038 },
+	  { 0x15, 12, 13, 0x00000016 },
+	  { 0x15,  0, 12, 0x00000800 },
+	  { 0x30,  0,  0, 0x00000017 },
+	  { 0x15,  2,  0, 0x00000084 },
+	  { 0x15,  1,  0, 0x00000006 },
+	  { 0x15,  0,  8, 0x00000011 },
+	  { 0x28,  0,  0, 0x00000014 },
+	  { 0x45,  6,  0, 0x00001fff },
+	  { 0xb1,  0,  0, 0x0000000e },
+	  { 0x48,  0,  0, 0x0000000e },
+	  { 0x15,  2,  0, 0x00000016 },
+	  { 0x48,  0,  0, 0x00000010 },
+	  { 0x15,  0,  1, 0x00000016 },
+	  { 0x06,  0,  0, 0x0000ffff },
+	  { 0x06,  0,  0, 0x00000000 },
+  };
+
+  struct sock_fprog bpf = {
+	  .len = ARRAY_SIZE(code),
+	  .filter = code,
+  };
+
+  sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+  if (sock < 0)
+	  /* ... bail out ... */
+
+  ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
+  if (ret < 0)
+	  /* ... bail out ... */
+
+  /* ... */
+  close(sock);
+
+The above example code attaches a socket filter for a PF_PACKET socket
+in order to let all IPv4/IPv6 packets with port 22 pass.  The rest will
+be dropped for this socket.
+
+The setsockopt(2) call to SO_DETACH_FILTER doesn't need any arguments
+and SO_LOCK_FILTER for preventing the filter to be detached, takes an
+integer value with 0 or 1.
+
+Note that socket filters are not restricted to PF_PACKET sockets only,
+but can also be used on other socket families.
+
+Summary of system calls::
+
+  setsockopt(sockfd, SOL_SOCKET, SO_ATTACH_FILTER, &val, sizeof(val));
+  setsockopt(sockfd, SOL_SOCKET, SO_DETACH_FILTER, &val, sizeof(val));
+  setsockopt(sockfd, SOL_SOCKET, SO_LOCK_FILTER,   &val, sizeof(val));
+
+Normally, most use cases for socket filtering on packet sockets will be
+covered by libpcap in high-level syntax, so as an application developer
+you should stick to that.  libpcap wraps its own layer around all that.
+
+Unless i) using/linking to libpcap is not an option, ii) the required
+BPF filters use Linux extensions that are not supported by libpcap's
+compiler, iii) a filter might be more complex and not cleanly
+implementable with libpcap's compiler, or iv) particular filter codes
+should be optimized differently than libpcap's internal compiler does;
+then in such cases writing such a filter "by hand" can be of an
+alternative.  For example, xt_bpf and cls_bpf users might have
+requirements that could result in more complex filter code, or one that
+cannot be expressed with libpcap (e.g. different return codes for
+various code paths).  Moreover, BPF JIT implementors may wish to
+manually write test cases and thus need low-level access to BPF code as
+well.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 82f277462349..1611f9f6607f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2746,8 +2746,10 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
 Q:	https://patchwork.ozlabs.org/project/netdev/list/?delegate=77147
 S:	Supported
 F:	arch/x86/net/bpf_jit*
-F:	Documentation/networking/filter.txt
 F:	Documentation/bpf/
+F:	Documentation/userspace-api/socket_filter.rst
+F:	Documentation/userspace-api/eBPF.rst
+F:	Documentation/userspace-api/cBPF.rst
 F:	include/linux/bpf*
 F:	include/linux/filter.h
 F:	include/trace/events/xdp.h
-- 
2.17.1

