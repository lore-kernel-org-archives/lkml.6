Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC0C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B6C20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="OAzA9wNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r6OdxCvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B6C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeGYDjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:39:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43133 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727504AbeGYDjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:39:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BEEE21C93;
        Tue, 24 Jul 2018 22:30:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9ULxI065wxuHuMhA2
        pwxMp4SwzNC7ScI7xbDvmLP2E4=; b=OAzA9wNFFNYJlMX9X2n5unmu/+FGDF4u1
        zO0/Fnp6Df5kJHkfEGNZ6J/oQIy80Ap0OfPkpA/L3oS4W/MbUtOHdOumLOYxT2Ga
        Mbl+DLn/BlnILjSN5ptgufQE61HnsyoD2c/+znFZ66KRrf6ttPlFam5XoX8tayeV
        Z8n0SX19TtVP9+irDFIPQLWjOJWX2iGx/+dYf0GKzyIkswVgczwLTmYk9/BDo0V+
        YjvPHHYPyg1ovu5/wa3s2eG0xXR2C1nbL3uFlFjtN8obwXHdFM7gHZ+HVzX0xYL6
        AGGzopcrIwQkM2UygjzJ6C/uuijMe2KSx9xiRkRvwvY1z21wdxOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=9ULxI065wxuHuMhA2pwxMp4SwzNC7ScI7xbDvmLP2E4=; b=r6OdxCvY
        5NAS1Uk1pVb57k/n/x3QSd/tXifBK1DVIga/+CkDY2a1/erRI7W8AiTDL6lmQIs+
        +fF3uzoQHcQFCAnfy0GBvobLHeZPWPTQJNTGFkiTXgkT0wzPjTTwolWcvovMUSF2
        CrjsEXQpOE3665TQsLFM7WKpwRVCgL0900NtjBarOL/1ud7xFb9KjtETdFsUUmtO
        nyC+LGStO8SSfY5iuOLQBuSn1ZqnqeCzCA8jQVMhs7/3H6RjHljfVJ1e3n4I3s3Z
        uZZJUS5TdEyyAmbZ2PFo212yjZD0kwMwhGk/sVMXasuVtpbojI2Fc8DSKneBKbKn
        3d1dlk3ZytMCPQ==
X-ME-Proxy: <xmx:qOBXWzjcn4dxqOPTnzjA4Vuef8-7cyfbB_29rG5Gc5xSB8C8JzGKVg>
    <xmx:qOBXWzvOKYm83dIjwWSz7ZBgcFFvw6oXMzGPBrhK4vLWZH6ECjimXA>
    <xmx:qOBXW-LeyzQKkgP1heP-vi7MpGpcOC1OT737K9NXqQOYjrp9TlHRnQ>
    <xmx:qOBXW9vR3dQBGOz0h-UtZiYtz0MyyUggX9KiupDn6FE6eRqiLdaHsA>
    <xmx:qOBXW2Q5GfH5FY_aLKlLR3e3JjWvxxyknknqt0mbFsYTWJtGshtVtg>
    <xmx:qOBXW96GIpY0eKHgTJeClrdrQYAYaE0hLyuB07hWu6MpMd3lAg6CiA>
X-ME-Sender: <xms:qOBXW2wCMTYY4zDqPnRQUG9Gq8c94nzsvINEadX6R1KCgWzP-60P2g>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6423A1026E;
        Tue, 24 Jul 2018 22:29:59 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] docs: bpf: Rename README.rst to index.rst
Date:   Wed, 25 Jul 2018 12:29:23 +1000
Message-Id: <20180725022926.8993-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725022926.8993-1-me@tobin.cc>
References: <20180725022926.8993-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bpf/ docs were converted to us RST format.  'README.rst' was
created but in order to fit in with the Sphinx build system this file
should be named 'index.rst'.  Rename file, fixes to integrate into Sphinx
build system in following patches.

docs: Rename Documentation/bpf/README.rst to Documentation/bpf/index.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/{README.rst => index.rst} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/bpf/{README.rst => index.rst} (100%)

diff --git a/Documentation/bpf/README.rst b/Documentation/bpf/index.rst
similarity index 100%
rename from Documentation/bpf/README.rst
rename to Documentation/bpf/index.rst
-- 
2.17.1

