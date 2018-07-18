Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F26ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0D820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WHAOTgzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOnvJTV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0D820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeGREDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:03:41 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37729 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725721AbeGREDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:03:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A726C324;
        Tue, 17 Jul 2018 23:27:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 23:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=llyu8kt/AANGU+ufu
        g73RrFNiQyLGZgShGQBqI7yYvw=; b=WHAOTgzBUEkZ5hi9JJYvrSe8N++VBWdLC
        qqQVaYzOZTCgqcaRygKunYXUnSuCohifl63i4CPnO9hNc0Z9I3Cmd40lHtkEvxzU
        /+/XUo8UFSiV4kU6VVharsxjNZots6Cp6oOFzb+rKqyoxD1UOjSFDUTRbRj7S5i5
        BA2aOYtCvIRy29Yz4S5xv3Bbxw8zRubtUwsm6u+9TR78HFzA6KSeOIyf2uS/YLNv
        n0TrLql8v3yflHaJGfu0NCRRu4TEzaSdDbTQ6/zto/KxDfokYRZG8oViQQOQ9RC6
        KfgoA853hgt4iSK8b+QPzIg2+4Fguay8fQ3ATcgDFqsGXauX+ONHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=llyu8kt/AANGU+ufug73RrFNiQyLGZgShGQBqI7yYvw=; b=dOnvJTV7
        t6oqIDnyLZQZ0/1ZPmsuk7gPPJfKa5inDCDhXshkSWa0y9i8I6SsI0lXS7Q4Lue3
        +St3rN+3N2dlc8NQXf2VmQ7PrDp0b2IKn+ZXUzHvdUYJWWx0etlGIf82E+6cFfxK
        PvWhaNEgRP7MDXMiassY9QpzPZHFj9GAnU0OsL2apGFSozhEHoHzdsh61h7pc7QV
        QgCAkEMKe4KWjrFyMwnx7AmQGutC+e6DQYCQ3bFEtWf/4pobkT22sj+JjsEHl60o
        L1S30l1nkhG9amQCIh22kzam3IYlkKA0J0EFsLzKgQLco4xGYISXPLZFr9gg2QoA
        MkXLiPZ/Sf1zvw==
X-ME-Proxy: <xmx:vLNOWyJoVChSy0M-KWDlzUzkyeFSE5udEAQ4ukCBZ6rpDLt_4gC64A>
    <xmx:vLNOW7zpn5KedBS5CVQ5B6Z5mw09K9OMNNPjj0CNGcHtNceBtKGTpQ>
    <xmx:vLNOW2xSJwKLv_zWmYdTZX5Hr3BEApnXHwBQr4URnLU1wnR2qmn84g>
    <xmx:vLNOW93GbKhbFaSZlMRy4aNPAaidm_lbTGm0eJnajrSaHbk130iaMQ>
    <xmx:vLNOW4XWsTia_XD3k9MD5r8X6HOFlm1g2Xua8EC6hg6uY4HsogjUWA>
    <xmx:vLNOWyoMDhf_i49PIHsammO38Tt11QHln-u0kYSCxx1QZwCAfpTgvA>
X-ME-Sender: <xms:vLNOW4EWk55BQGS6mA6Zg6-QH_DdqadpAClX5SYDC02HV8ZQ5t98-w>
Received: from localhost (124-169-0-210.dyn.iinet.net.au [124.169.0.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id 695C0E465F;
        Tue, 17 Jul 2018 23:27:55 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] docs: networking: Convert bridge.txt to rst
Date:   Wed, 18 Jul 2018 13:27:36 +1000
Message-Id: <20180718032736.8000-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718032736.8000-1-me@tobin.cc>
References: <20180718032736.8000-1-me@tobin.cc>
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

