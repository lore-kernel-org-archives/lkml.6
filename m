Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF77C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F52208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hOM1vLZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aV0217+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F52208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbeHAGxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:49 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48259 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733055AbeHAGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9FB653D4;
        Wed,  1 Aug 2018 01:10:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=BLhz9q5Br0APWXDfc
        9o6H1xQibD1cp8+XYJD9ekkLUw=; b=hOM1vLZmuXVbfAgPVvdokhy1tHTPvovSn
        cliTooTSK8TKKKQFEAYZ03UH9+a88egTTC0WuZ0RnAFxvLqY+nAltpQAN84KHdUX
        E1793IcsmvDVgPcHCVvcRUW+fsnNfwGAStrVAXnH0olmMqFu5092iLGrIF00vhaZ
        +W3jiTEX37MPbOogD156720KCWc3gJTL0DfkkhGeld+RMbIN26lWkjWcG7BQZeGX
        gte1dbhwyJ3cQaWdqdpKAo5F5J7MyDW0tS6G5TWflvnf4qLzF8HWkvtvR/bMDXeX
        H98NmK+OvJxo4zOgxrkoBna/6EtiniXb+zxbWOFf4ov8vgO2AEERQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=BLhz9q5Br0APWXDfc9o6H1xQibD1cp8+XYJD9ekkLUw=; b=aV0217+C
        28tSLZ9TJq/UduOnnEma5kYLq2SDxrx1IewHDV5ZqzTVyxySf059eOz1XtlQGvH2
        mfZw3ZFMcpm8uUJmCgqPfV1EHMay7PwhDm17kBbGE5ppCbCHvXBFiqo0Gwta+9Ad
        uDCuZly6psiN3bdZ2/voCXun9evxi7vUQwyrMW/EedtoAzI1ynojeVnAcy88YVBT
        xdt2usxqpbBUtRDonVBoVvRBjrpw0B6GYh6oQ51NSoPD9SbW69wV0a3VIzTPxP2x
        I+RoczXFPXkQnfQw6g/C0Hl5sKCgyDBnwnMEsHjCiho2p4cC1fweWTS/9Fn78yJQ
        hzqAamV0KSNDrw==
X-ME-Proxy: <xmx:rEBhW_SSU5xAyXIOlRxT3WtP35S-3qKrQpmZCwugLxVxSPlnYZu5zQ>
    <xmx:rEBhW4rkYQnME9MY8K5YgDswdVMO0AvYLn35nTBBGhzt8-5IAoJNXQ>
    <xmx:rEBhWzq1TxookS4gfOfLVaqmWkRdGrCLgvQ_NSuIdq_UHhNA4Vp49A>
    <xmx:rEBhW1GTEGvsyNEa0WpCvyMiwecbwJPnyf1f64KCgijbVDNyoKToCQ>
    <xmx:rEBhW9vTGBS-vIlRevmYpYAmQVcu_iRKWGuTxO3eHYECGcrxdqkMKw>
    <xmx:rEBhWztUEVqLBiGemnsgwqQIEo5LTjBMQy1lG9qS4YQOLNM5rl19oQ>
X-ME-Sender: <xms:rEBhW2y0vZImkMJ9mpL49fspcmi2glSH90knqe_bIMrQNCzkjOtvcg>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 161B7E405A;
        Wed,  1 Aug 2018 01:10:01 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 10/13] docs: net: Embed reference to seccomp_filter
Date:   Wed,  1 Aug 2018 15:09:05 +1000
Message-Id: <20180801050908.29970-11-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typical RST documents embed the reference link straight in the text.
Currently document uses a '[1]' with the reference below that
paragraph.

Use RST :ref:`path/to/file` <label>` format and embed the reference to
seccomp_filter directly in the text.  Add a label to seccomp_filter.rst
to enable the reference to function correctly.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/filter.rst            | 12 ++++++------
 Documentation/userspace-api/seccomp_filter.rst |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 10c4eab042df..1ed6972c3544 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -43,12 +43,12 @@ internal compiler that generates a structure that can eventually be loaded
 via SO_ATTACH_FILTER to the kernel. ``tcpdump -i em1 port 22 -ddd``
 displays what is being placed into this structure.
 
-Although we were only speaking about sockets here, BPF in Linux is used
-in many more places. There's xt_bpf for netfilter, cls_bpf in the kernel
-qdisc layer, SECCOMP-BPF (SECure COMPuting [1]), and lots of other places
-such as team driver, PTP code, etc where BPF is being used.
-
- [1] Documentation/userspace-api/seccomp_filter.rst
+Although we were only speaking about sockets here, BPF in Linux is used in
+many more places. There's xt_bpf for netfilter, cls_bpf in the kernel qdisc
+layer, SECCOMP-BPF (SECure COMPuting
+:ref:`Documentation/userspace-api/seccomp_filter.rst <seccomp_filter>`),
+and lots of other places such as team driver, PTP code, etc where BPF is
+being used.
 
 Original BPF paper:
 
diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index 82a468bc7560..6c3eb4908818 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -2,6 +2,8 @@
 Seccomp BPF (SECure COMPuting with filters)
 ===========================================
 
+.. _seccomp_filter:
+
 Introduction
 ============
 
-- 
2.17.1

