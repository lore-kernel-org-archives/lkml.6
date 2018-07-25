Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB854C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600EF20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="HL6Y3JTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXVEcKxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600EF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeGYDji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:39:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53285 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388446AbeGYDjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:39:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D540421BF4;
        Tue, 24 Jul 2018 22:30:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r5bh0PHJe3rhT0Dlp
        GtTL2v0AdRo0Kq4/FgSdnx8QsQ=; b=HL6Y3JTETvH+hnho3U2VLDYbq57lGvOqs
        Ar/TNNMv4RAhwAUXKshproF8LKx7jA3gk0RUJOH4LtxDB7jcskPgB4Xz4wAaz9dI
        0kQN87Zi7kzuDn/PX+ZUtIMD1tqgEFjAUG1j3ibpQM0e29S4i4ADkD6FMhLiXKq2
        IvJbRpXy0egU6jdmgeWadSwyVYywmKWJN6Md8qfa2XpM6OVusUjH6toE9O5hlQQh
        pOEHOLb1fHBc8QlKGjon9Ws5q060vJOMODubIeqjkpOy24yMlIS2JvGpzivQAUtZ
        cT7DlYSVifWgIvKPct7N65DLJ7cmdTtJkw2VvktRneu7lBCPh9FQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=r5bh0PHJe3rhT0DlpGtTL2v0AdRo0Kq4/FgSdnx8QsQ=; b=OXVEcKxL
        87qAZQ8WuijRUAmV+zDM5LjS4tLa3+xRTGRq6/vX8I+/ji//t0Q0Cxt+NAeJs5+B
        c1KmN6YDnh1LvNI9UvIaX+6ebXDVz3Ys7pELYm6fcHTACIOC6ijPnPOIJqaXFQNs
        E3Uhwf06sE0PtODDnl6ExNta2mioJNIgK3AaTH1K03Gsj10HtAUGKyR28bs0TKbJ
        sjBONUHrhUq9sQbaq0LmO33Wvi15tESXlBZBghYLNjTRzkYOM0SD8Vs0YezjCT3s
        +qBoavyRWxo9I3fZZae6EtBAgzpkjVM5cX3+BXMriy31ex0Axnb+bbOnuTNJL84G
        joZXlXC40cqxOg==
X-ME-Proxy: <xmx:tOBXW3gb6NnCBQtpuyGQn72z8IUYfjD_HO1jzNQc0pTMEGqlz-aMcQ>
    <xmx:tOBXW6KGUE4U-SkfQwzeowYQ2hETkrxHdZQgpkBHBc_DWpHzTkD1-A>
    <xmx:tOBXW8qGUvWnyhVe7rSqQdUR2EKM-NqQgh4jGEDweqJcMBAn5AmZHA>
    <xmx:tOBXW3p9mk3VesYURDGWzHigOlGaG7bssqPqNElzmfjlRuEEc7LFdQ>
    <xmx:tOBXWyHQZ2tWJkNHSd4De2_kL91Iw74sFOJdV9NKCvE2i7ddCJZHOg>
    <xmx:tOBXW0MwKUQCSa2Mcx9vSLIiq4i1j1-SEnMwE5MIV-L5VVrYV8O6IA>
X-ME-Sender: <xms:tOBXWyEM4osijjnJBXl5J8qiTzbWz68sk5yQJsr6oQSWS1F-YvzzAw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C48AE454E;
        Tue, 24 Jul 2018 22:30:11 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: bpf: Capitalise document heading
Date:   Wed, 25 Jul 2018 12:29:26 +1000
Message-Id: <20180725022926.8993-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725022926.8993-1-me@tobin.cc>
References: <20180725022926.8993-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of files in the kernel documentation index use
capitalisation for all words, especially the shorter ones.  BPF docs
better fit in with the rest of the documentation if the heading is all
capitalised.

Capitalise document heading.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index ab2ff13a809b..00a8450a602f 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -1,5 +1,5 @@
 =================
-BPF documentation
+BPF Documentation
 =================
 
 This directory contains documentation for the BPF (Berkeley Packet
-- 
2.17.1

