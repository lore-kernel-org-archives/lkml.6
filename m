Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XCt9uXLm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kks7xD3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbeHAGxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:40 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52085 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733057AbeHAGxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D7E2562F;
        Wed,  1 Aug 2018 01:09:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3uLJA6MooOOL7a/1v
        1Xk7G0pce3uXZf93kbLuAP1i2E=; b=XCt9uXLmQVhFe0VPsWGw2tyTepYG8ZbQ6
        O/jW+U5IG5XbIUHJONE+4STTKbGChq6i3h2697/7GhEyUHY8RL9vGcrwGvsGzM1f
        TLqFV3UkCPwvz2omy++ByUEXnxuYORBolRiOK68B2YxsRgicIaGQpq1eQOCvx3kP
        vM+zTfqOcP1W/F4w5feO4qUJAh87/DTEYAc8vIk752zga9JN86ZZJqts/19XuAei
        2kYVY2V9hpO4+XZ4iKEj0itDNpapwxiWAyLLbmE/owTvDvxdmzLINLsveiaBh1LG
        gMQcd28U+2lEdixdc/DAUtAAW0ivh7mr1FSYQ3tXdAN9lHgzNIF3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3uLJA6MooOOL7a/1v1Xk7G0pce3uXZf93kbLuAP1i2E=; b=kks7xD3D
        yioEpN1ylHbCDADIkmlA8Bkpezf0o2Y4/5ioK50pk1uAUAIaEoCvd+hRg6Xa3/JX
        5zBNATDTggTt4y0AUAFEiEDi6ANcZUgPa+xusStkGlpAl7C0p7/Rc0aqqoGK6hxV
        udgaMqkH42bM52t7lwwJpk/i0J+gvSf0aYJ+JBAfkBc2gvYSpYYF5bW4LHSb+W9R
        LMcUjPLJVWTU5SOpCoyEHXcbceuwoqp/a/zH8CQH4K5bb0upT81eRp1G+0iFYgga
        WBYbkmD7EtQsPjBJG0OmZFOPyU2/YSDAsYHvlObSzJ3QHYoug5WANiPL8zkgE6Ja
        Ld/0himhtvFqjQ==
X-ME-Proxy: <xmx:o0BhW2BsQzsweCQDs40uBaooPH_KgJk0Zt6h9wInwCo60XiE1L5Ocw>
    <xmx:o0BhW3vUTy4tPGEJFi5u40tX-6gSvr0wa-ynSISJsa_uGkv-VCg5dg>
    <xmx:o0BhW4xalN6H-NWjQEgjRzx6Wk5ej8PLsOZf7TxzZ4VwBvtVDiVPOQ>
    <xmx:o0BhW2N2YNmF5vhp-u3-vdSioFjSdgdaqkH2it1oKbrOIvV7P1DmwQ>
    <xmx:o0BhWwqE3hNKKSewm-Hm25djjTGjnEGaOedeHnAgoKwS64ayh0tJtg>
    <xmx:o0BhW1Rd0IwCk1fqKGM1Dtb4GwDX0Gdo1NEYL5mZe2tSjwDu1KWyzg>
X-ME-Sender: <xms:o0BhWyTo8oBo2mB5Zr41rRfk3zgyw2D7Bo8Wy3O_HLHszHOp8tA4hA>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97858E4621;
        Wed,  1 Aug 2018 01:09:54 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 08/13] docs: net: Use double ticks instead of single tick
Date:   Wed,  1 Aug 2018 15:09:03 +1000
Message-Id: <20180801050908.29970-9-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single tick around a command should  be converted to a double
tick for RST files (excluding ticks in a code snippet section).

Use double ticks instead of single tick.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index f9ec58144ed3..dda1afdb5f26 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -38,9 +38,9 @@ setup a socket, attach a filter, lock it then drop privileges and be
 assured that the filter will be kept until the socket is closed.
 
 The biggest user of this construct might be libpcap. Issuing a high-level
-filter command like `tcpdump -i em1 port 22` passes through the libpcap
+filter command like ``tcpdump -i em1 port 22`` passes through the libpcap
 internal compiler that generates a structure that can eventually be loaded
-via SO_ATTACH_FILTER to the kernel. `tcpdump -i em1 port 22 -ddd`
+via SO_ATTACH_FILTER to the kernel. ``tcpdump -i em1 port 22 -ddd``
 displays what is being placed into this structure.
 
 Although we were only speaking about sockets here, BPF in Linux is used
@@ -375,7 +375,7 @@ Starting bpf_dbg is trivial and just requires issuing::
 
 In case input and output do not equal stdin/stdout, bpf_dbg takes an
 alternative stdin source as a first argument, and an alternative stdout
-sink as a second one, e.g. `./bpf_dbg test_in.txt test_out.txt`.
+sink as a second one, e.g. ``./bpf_dbg test_in.txt test_out.txt``.
 
 Other than that, a particular libreadline configuration can be set via
 file "~/.bpf_dbg_init" and the command history is stored in the file
@@ -388,7 +388,7 @@ The usual workflow would be to ...
 
   > load bpf 6,40 0 0 12,21 0 3 2048,48 0 0 23,21 0 1 1,6 0 0 65535,6 0 0 0
     Loads a BPF filter from standard output of bpf_asm, or transformed via
-    e.g. `tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
+    e.g. tcpdump -iem1 -ddd port 22 | tr '\n' ','`. Note that for JIT
     debugging (next section), this command creates a temporary socket and
     loads the BPF code into the kernel. Thus, this will also be useful for
     JIT developers.
@@ -523,7 +523,7 @@ generating disassembly out of the kernel log's hexdump::
     44:	leaveq
     45:	retq
 
-Issuing option `-o` will "annotate" opcodes to resulting assembler
+Issuing option ``-o`` will "annotate" opcodes to resulting assembler
 instructions, which can be very useful for JIT developers::
 
   # ./bpf_jit_disasm -o
-- 
2.17.1

