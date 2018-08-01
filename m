Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F7C208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="g6jcI+Pj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBcHNmWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F7C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbeHAGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:18 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36585 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731897AbeHAGxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B34457E;
        Wed,  1 Aug 2018 01:09:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2wmxxDv2UY+esS3EU
        JV2LGCmrVOUVjGbcEiL+i4pkDI=; b=g6jcI+Pj6sEBqBOS1Wzqy0oJi8V8g+w+l
        tl2cZWu0j3GBKYzFIpijM2ltLzrtrEu5vzyLHXGwGPAsDnJyBJF5J2VkfZywPbxV
        CGhw7AiwxprEDUjOxq5fFQ+Yi6Z7MsWCwW78OBqaQbhfa65/+/LiQlrau9pajhIL
        7iDVlIrODhjfJEZ8h7cudQKn55jyNNkgwqBBJUYaseE6vX3Ri4jPjI3k33OHgK9j
        QtuUCAnXEqRXIc3kD91JkvJQXts4dUJunx8N1CkjUt6oqnma0bT+PTpVFGuxZ5JU
        s0I9M3EGBjJfxbIwjETdqcc6HEvzpgF4M5IEvv/npYcc4fEeLorQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=2wmxxDv2UY+esS3EUJV2LGCmrVOUVjGbcEiL+i4pkDI=; b=PBcHNmWR
        SeIigchJhWMVn3Ma2RSaIaHMpxdd3tvIbnUYbGJuiD/8mm+cDHWD9dW3nKCLxn0f
        g2xBRYucOi57G25aGqkWL4LdrcGaBh2GhyXegLa8+gJdDhJeWWK2t1JWuuNAqYAS
        bWIXjQT50CE4Cf5DJqBTpXenIWGgvHP42DL0BgGYinimLWhi1H3znngSb4uSrqZv
        UiEWLaA+GgBFQgTGoKyzKuMKLygdlgtbslXi9aCzOXxE2Q4gnmowQjRE32s+s/DK
        oUfiF7GTmZ/kgJlLsThl/yV2kq2SSpgLwMp/V1tT/4X3To+e+D9ig5xrJSx7DhZN
        YjvMDIe49tDTBQ==
X-ME-Proxy: <xmx:jEBhW1hE925iHNK4S7LbaDnHzTA8Hv4B8wMJSbm-95l9gdFRM4lQaw>
    <xmx:jEBhW6bd3YE0yKaayQQqeUEtY9TEUksYjo3c8m9I7WZumYXS1OX-eg>
    <xmx:jEBhW2ORXGh0svpBa_YaYdFottqZzVjDGL2Fxb3dogj3l9EAf8KDzA>
    <xmx:jEBhW2SKHhk5WBiFdQByu4-7swDH5ZPesOcl6xj9Ky2rlNQfyrQ0IQ>
    <xmx:jEBhWx7JtQmazKdXhrfrHN-mQD3rHCK4Nuj0syWu_ZRRGc7WQEIv1g>
    <xmx:jUBhW_ofFa-X26BXKR9TrkJ8x3iMxr1GYTJ6LemEc2iI3y5f1FnP4A>
X-ME-Sender: <xms:jEBhW1MXYGTl479wSal7_EJnELLxE6nQhO3_REpFWaIMKS_RLE6pVQ>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A3141026B;
        Wed,  1 Aug 2018 01:09:31 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 02/13] docs: Update references to filter.rst
Date:   Wed,  1 Aug 2018 15:08:57 +1000
Message-Id: <20180801050908.29970-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/networking/filter.rst was just renamed.  In order to use RST
references we need to add a label to filter.rst

Add label and update references from filter.txt to filter.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/index.rst              | 9 ++++-----
 Documentation/networking/filter.rst      | 2 ++
 Documentation/networking/packet_mmap.txt | 2 +-
 tools/bpf/bpf_asm.c                      | 2 +-
 tools/bpf/bpf_dbg.c                      | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index 00a8450a602f..192393135c61 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -7,10 +7,10 @@ Filter) facility, with a focus on the extended BPF version (eBPF).
 
 This kernel side documentation is still work in progress.  The main
 textual documentation is (for historical reasons) described in
-`Documentation/networking/filter.txt`_, which describe both classical
-and extended BPF instruction-set.
-The Cilium project also maintains a `BPF and XDP Reference Guide`_
-that goes into great technical depth about the BPF Architecture.
+:ref:`Documentation/networking/filter.rst <bpf_filter>`, which describe
+both classical and extended BPF instruction-set.  The Cilium project also
+maintains a `BPF and XDP Reference Guide`_ that goes into great technical
+depth about the BPF Architecture.
 
 The primary info for the bpf syscall is available in the `man-pages`_
 for `bpf(2)`_.
@@ -30,7 +30,6 @@ Two sets of Questions and Answers (Q&A) are maintained.
 
 
 .. Links:
-.. _Documentation/networking/filter.txt: ../networking/filter.txt
 .. _man-pages: https://www.kernel.org/doc/man-pages/
 .. _bpf(2): http://man7.org/linux/man-pages/man2/bpf.2.html
 .. _BPF and XDP Reference Guide: http://cilium.readthedocs.io/en/latest/bpf/
diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index e6b4ebb2b243..14ce8901c245 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1,6 +1,8 @@
 Linux Socket Filtering aka Berkeley Packet Filter (BPF)
 =======================================================
 
+.. _bpf_filter:
+
 Introduction
 ------------
 
diff --git a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
index 999eb41da81d..494614573c67 100644
--- a/Documentation/networking/packet_mmap.txt
+++ b/Documentation/networking/packet_mmap.txt
@@ -1051,7 +1051,7 @@ for more information on hardware timestamps.
 -------------------------------------------------------------------------------
 
 - Packet sockets work well together with Linux socket filters, thus you also
-  might want to have a look at Documentation/networking/filter.txt
+  might want to have a look at Documentation/networking/filter.rst
 
 --------------------------------------------------------------------------------
 + THANKS
diff --git a/tools/bpf/bpf_asm.c b/tools/bpf/bpf_asm.c
index c15aef097b04..5040875735db 100644
--- a/tools/bpf/bpf_asm.c
+++ b/tools/bpf/bpf_asm.c
@@ -10,7 +10,7 @@
  *
  * How to get into it:
  *
- * 1) read Documentation/networking/filter.txt
+ * 1) read Documentation/networking/filter.rst
  * 2) Run `bpf_asm [-c] <filter-prog file>` to translate into binary
  *    blob that is loadable with xt_bpf, cls_bpf et al. Note: -c will
  *    pretty print a C-like construct.
diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
index 61b9aa5d6415..d05d8df0ce3b 100644
--- a/tools/bpf/bpf_dbg.c
+++ b/tools/bpf/bpf_dbg.c
@@ -12,7 +12,7 @@
  * for making a verdict when multiple simple BPF programs are combined
  * into one in order to prevent parsing same headers multiple times.
  *
- * More on how to debug BPF opcodes see Documentation/networking/filter.txt
+ * More on how to debug BPF opcodes see Documentation/networking/filter.rst
  * which is the main document on BPF. Mini howto for getting started:
  *
  *  1) `./bpf_dbg` to enter the shell (shell cmds denoted with '>'):
-- 
2.17.1

