Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40488208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ZFA6kw09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="waQL91VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40488208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeGQFAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:00:07 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:55559 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeGQFAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:00:06 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 71F70207;
        Tue, 17 Jul 2018 00:29:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 00:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=llyu8kt/AANGU+ufu
        g73RrFNiQyLGZgShGQBqI7yYvw=; b=ZFA6kw09MtcN517GACo8n+KTzyZqIM7y8
        mQi13IfYXy0KRv60Ol991fgYQ7BzjZRTagOq2qXuiDmhOh5pn8t1fGeu0dD5XoC8
        3PODkvTDPaVrCjRaXzO6x4XSbovLAqTYRkfrL/vvmQXMHeGTKtv1dFzBOhQWmwzY
        o1MlPuzpM5+gqtEXjoFEuCtwip0VS/3aoDlp00w8YFDYhfxJMXAKWjiF/jy3pvHs
        Tys4ONdNYdo+gRPdMFzJB/Nx+vTY/vp1Zmt3bg814gJpcPEYRehPVI0dMu6V5SVU
        ekzN0mwpan5VPcIuD0ZRkA0cmAUzuiZaJRJHwvDW3coqmGCNhXZ3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=llyu8kt/AANGU+ufug73RrFNiQyLGZgShGQBqI7yYvw=; b=waQL91VW
        W+pgw0ZhqXgtvtEwHK0Bk/E0ZK+Qxv7CmcE1RarVk6NsBL4ZIfdZ8Sc/RI+nlZIk
        UzYr1AwSTQ7zEXsjhnSmg9nIR8y3acDBQukTcZwBx+QsBLW0AxymC2QgwzDwCRi/
        0rMrUyySF3N26qSPfeF7y7S4U9twnOgI1a+AcOiMsmSdbavCOqw4ckk8XgkXooxz
        6zPyXmMeBwgn1uR/B0MSWFecjYItLbfg/5yEuU052iV8qyr8cX6DcxLVvLIkA7+g
        WkxDn/TFi0KmoafLtiXrTQhm69LGIN+sAVPLiAqjmGVgTt65jCKEZgSEHWu7G8cv
        HHElYBBUVVJWsg==
X-ME-Proxy: <xmx:qXBNWzsRtiJnXY60GisqEm2A44YN4bRYN9pUaJFBsRjepXTzutN7BQ>
    <xmx:qXBNW0yGQaJ3i0PMcrNSm9gHUDZ5oqdnf10FhgRhjxb7H43HvA9BVA>
    <xmx:qXBNW-ZZKai1xAXb2KnVyfNl1VjRNBF7el8hCcumdFI6P-rghIVoJw>
    <xmx:qXBNW82cmd6Yc_DOzuYTigabEO-47E-onqSJlXUxFQxeWXtbpQblRQ>
    <xmx:qXBNW8iG3O1GTE0MDNnkPuBqh6siWpqmMy2FygotFgTVD0JBpYY4ng>
    <xmx:qXBNW7RyLp2xM9iep0XgKaQ3GtuQCKynEMZHG0HBfu0BOhbUT2hxdA>
X-ME-Sender: <xms:qXBNW3Bsb8LTNCWOW9LFTxGu6rdpvE-6QYF4Vu92K6nZFbCJwLfklg>
Received: from localhost (ppp121-44-239-37.bras2.syd2.internode.on.net [121.44.239.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E0B9E450F;
        Tue, 17 Jul 2018 00:29:28 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] docs: networking: Convert bridge.txt to rst
Date:   Tue, 17 Jul 2018 14:29:06 +1000
Message-Id: <20180717042906.17308-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717042906.17308-1-me@tobin.cc>
References: <20180717042906.17308-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel documentation is now restructured text. Convert the Ethernet
Bridge documentation and include it in the toplevel kernel
documentation.

 - Fix heading adornments.
 - Add license identifier.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/{bridge.txt => bridge.rst} | 6 ++++++
 Documentation/networking/index.rst                  | 1 +
 2 files changed, 7 insertions(+)
 rename Documentation/networking/{bridge.txt => bridge.rst} (85%)

diff --git a/Documentation/networking/bridge.txt b/Documentation/networking/bridge.rst
similarity index 85%
rename from Documentation/networking/bridge.txt
rename to Documentation/networking/bridge.rst
index a27cb6214ed7..4aef9cddde2f 100644
--- a/Documentation/networking/bridge.txt
+++ b/Documentation/networking/bridge.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Ethernet Bridging
+=================
+
 In order to use the Ethernet bridging functionality, you'll need the
 userspace tools.
 
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 65502f2031a8..d75da2ff25c7 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -18,6 +18,7 @@ Contents:
    failover
    net_failover
    alias
+   bridge
 
 .. only::  subproject
 
-- 
2.17.1

