Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339720841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Sy1gryTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3WUWVnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9339720841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbeHAGxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:53 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35797 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733055AbeHAGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:53 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 31905578;
        Wed,  1 Aug 2018 01:10:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k0TJi9DTpxYrr37Cz
        vISLnppjSJNXrwK4zV65YKVAnk=; b=Sy1gryTfBoKDLPED3uqTI+LNj5ZBwWyXL
        /bTLay1nTFYjOEHx2ywlvN2a8qSQu29+lm690wB9sjglxp2gFpOEs7sC8WcR53lU
        OOv+DOzbn37HrytD0mjwDko7sGwNsw+ul+hA6WRCbiIgfiZ5vMFXbYTKLiwOvIug
        c+JLeMccDYVIvQWpHY6JHQKdkOqODjLE79Jd1rCMb2wgjGSpV/StI+lAkCsBPRto
        2c2yrexaxd1l2XVLAOylnTwkwM0itxLouaUyrc/+rQYXEvDoMbL5bIIiblzKTzBh
        qiojL99fH5X3Bzw27pF32pyzimwYQTxexyAfUvNTCg+2iWogOoSbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=k0TJi9DTpxYrr37CzvISLnppjSJNXrwK4zV65YKVAnk=; b=n3WUWVnx
        sYn1tTLXQlqcm4Ne00e22KIEwMgNDpXoKXC1C2PCSIfry+HiJO41TMQKIRtavVO6
        2+6sYPKYzTxETtvrfYHm56oORF1x1zFXiEDPKnwp8U1n23yuPlKXVqKcZznfXpoO
        SxuXDPZ7h7697EhAGs14RA/zygYbBCrwLyd5QhajYTRSNSR+xW9w0/xrVp1LxSp8
        XBXwnHUZHYKF57jpYF1fon2tenqyhYV3/c26UVOWL5c3wxQ+yOCE7+uaXwAumVve
        tDC76D934qR2wEZEDRJcyOqo2+xOE783/5wunyFFrqXolVJU52EDC3urETFy34tE
        +o+yLx10TKzEVA==
X-ME-Proxy: <xmx:sEBhWzU47u1n6cLQcp5oYjhZLa3lcs6o-Se47XdY2vqKmwee11DlHg>
    <xmx:sEBhW18RQBDpEx3DfYwBCCDRaIEp0YxNsCyPVflAnGpqWtoJ4rBWLg>
    <xmx:sEBhWwL79yUt3OIXwvUvQ8CFGOqtyrJdyBKq-NUf06n55uFYhTOCrw>
    <xmx:sEBhW72-iwIt3Lb1cmF3dEoTotPwpYxXwUUuPUJwksG9ukWh4OEaFw>
    <xmx:sEBhW8XphWOiGxISH5KVeuMJ8ODHNjEHfjfRz9apjNJPBHMk2hea8A>
    <xmx:sEBhW_J4XhVjaq6u5TsgEbB0gaJ7qOClWkn6zF9TvMtBPcQwsT39hQ>
X-ME-Sender: <xms:sEBhW_5Z9rWCQpjCgdIn1lNlqm98bmslgoEc0sD3cZN5Yek3DjG8GA>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E72410255;
        Wed,  1 Aug 2018 01:10:06 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 11/13] docs: net: Use correct RST list construct
Date:   Wed,  1 Aug 2018 15:09:06 +1000
Message-Id: <20180801050908.29970-12-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are using a custom list format.  We should use the correct
standard list construct.  Also lists require a newline before and after
the list items.

Use correct RST list construct.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst | 30 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 1ed6972c3544..99dfa74fc4f7 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1162,18 +1162,21 @@ arithmetic), and this is tracked in two parts: the 'fixed offset' and 'variable
 offset'.  The former is used when an exactly-known value (e.g. an immediate
 operand) is added to a pointer, while the latter is used for values which are
 not exactly known.  The variable offset is also used in SCALAR_VALUEs, to track
-the range of possible values in the register.
-The verifier's knowledge about the variable offset consists of:
+the range of possible values in the register.  The verifier's knowledge
+about the variable offset consists of:
+
 * minimum and maximum values as unsigned
 * minimum and maximum values as signed
 * knowledge of the values of individual bits, in the form of a 'tnum': a u64
-'mask' and a u64 'value'.  1s in the mask represent bits whose value is unknown;
-1s in the value represent bits known to be 1.  Bits known to be 0 have 0 in both
-mask and value; no bit should ever be 1 in both.  For example, if a byte is read
-into a register from memory, the register's top 56 bits are known zero, while
-the low 8 are unknown - which is represented as the tnum (0x0; 0xff).  If we
-then OR this with 0x40, we get (0x40; 0xbf), then if we add 1 we get (0x0;
-0x1ff), because of potential carries.
+  'mask' and a u64 'value'
+
+1s in the mask represent bits whose value is unknown; 1s in the value
+represent bits known to be 1.  Bits known to be 0 have 0 in both mask and
+value; no bit should ever be 1 in both.  For example, if a byte is read
+into a register from memory, the register's top 56 bits are known zero,
+while the low 8 are unknown - which is represented as the tnum (0x0; 0xff).
+If we then OR this with 0x40, we get (0x40; 0xbf), then if we add 1 we get
+(0x0; 0x1ff), because of potential carries.
 
 Besides arithmetic, the register state can also be updated by conditional
 branches.  For instance, if a SCALAR_VALUE is compared > 8, in the 'true' branch
@@ -1329,10 +1332,11 @@ are concurrently updating.
 maps can have different types: hash, array, bloom filter, radix-tree, etc.
 
 The map is defined by:
-  . type
-  . max number of elements
-  . key size in bytes
-  . value size in bytes
+
+- type
+- max number of elements
+- key size in bytes
+- value size in bytes
 
 Pruning
 =======
-- 
2.17.1

