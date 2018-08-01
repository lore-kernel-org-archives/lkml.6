Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C798C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1590520841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IHkwkIfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGDctlFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1590520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbeHAGxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:14 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:37101 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733001AbeHAGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B3DA4441;
        Wed,  1 Aug 2018 01:09:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wwKYmbWul3LpjtYHq
        qe8vdzXC3qzlJeRL6ETnOpzEck=; b=IHkwkIfqCOHUQXKuRg3H+vTqWr2HT0Jrv
        t1Cro8uC3qJ767JIwX5gFQhCZIihqr9CuveEoA2aBZLvJL9REA2MxUs0OPQHKFl3
        VV4bzNOOsz15pxo8bQ+caRbQ6WLiWnkRz+VVxu2gMZ+Mb/iZqBnW+RaVHgsu1iD8
        8qxNNNlYJyUa6ot1d7CZ6W98NzfGa0L7ETMjzuvnyt3G2EWz75SuHO2KCnCTBC0e
        +4ZsgLnvOwoqjptMs1TTyuuCBH+zuIXH68YzB6JOLTrcg96WAf13OCWCYEAyPdxg
        myNcF0SewxQ+EhvBEx22wrj8Ufq3pjSFTh3S2ajXLtbCxJ08rdmgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wwKYmbWul3LpjtYHqqe8vdzXC3qzlJeRL6ETnOpzEck=; b=kGDctlFW
        CmnMNvEgZH1jIhx+V5/DdUh330OaiFb54VoU9RXmVHuphoL/9Q6RLzARp2wLNlg1
        ljQWa4lQXowrqXCq6s7Q+uOlzFIVcIVby8aMV/UUqfO9PQjrzxHYWsVNj3lKQADH
        6FmL/HEkV5ukFKryhxyC5Q8TnHMukhVkGPPxEHcsLVKPBIpP4Lxc082uklxTrpfy
        rvXtSvM4iARMZVh0xhoyRZ6WVAWWBDdzTNxq3gks3MLHjWRYibTQVwfEC7IDD9dx
        e5VKjM+rDayrVgu40N81D61ja9z6gR1H1t6iISv6TqeliaZ7buRyWIL7uxRoV8mC
        BVzN4czklDVhfQ==
X-ME-Proxy: <xmx:iUBhW7UQByS_kbk3eFUeHeYFIJbjUVjnW7iOgJ4NyGGNYCVlG0CjIg>
    <xmx:iUBhW4Sib3vca_ifhCF_bwIUh9rMmY7F5J_Ov41c5PfP_zBtm9fWxQ>
    <xmx:iUBhW_Ssq18B0EnneG6Bx6fLcGVAveaQCi5NWYuztG-iVxSUa_BOtg>
    <xmx:iUBhW6EIHzWxURk983KSSa4HA7eub8lriaXjMriz6mpp3O59Si76jQ>
    <xmx:iUBhWzmd4IAf00cePdg8QdaZdBCzAQJPW3PF0-uSy2ThFfSbvo7a2A>
    <xmx:iUBhWxxi8cFJsQmE-2k7qxDgLKbI1yPRZZAiuBorgZbwuMYtW2kFxw>
X-ME-Sender: <xms:iUBhWxuikohNFGZ9aHkkt0ykyb3pbe2_oEqioQshD63xGfStTG1Yuw>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6DBF010269;
        Wed,  1 Aug 2018 01:09:28 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 01/13] docs: net: Rename filter.txt to filter.rst
Date:   Wed,  1 Aug 2018 15:08:56 +1000
Message-Id: <20180801050908.29970-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801050908.29970-1-me@tobin.cc>
References: <20180801050908.29970-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for conversion to RST format.  Rename file in a single
commit to ease review.

Rename Documentation/networking/filter.txt to
Documentation/networking/filter.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/networking/00-INDEX                   | 2 --
 Documentation/networking/{filter.txt => filter.rst} | 0
 MAINTAINERS                                         | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)
 rename Documentation/networking/{filter.txt => filter.rst} (100%)

diff --git a/Documentation/networking/00-INDEX b/Documentation/networking/00-INDEX
index 1e5153ed8990..37c65b3a90be 100644
--- a/Documentation/networking/00-INDEX
+++ b/Documentation/networking/00-INDEX
@@ -78,8 +78,6 @@ eql.txt
 	- serial IP load balancing
 fib_trie.txt
 	- Level Compressed Trie (LC-trie) notes: a structure for routing.
-filter.txt
-	- Linux Socket Filtering
 fore200e.txt
 	- FORE Systems PCA-200E/SBA-200E ATM NIC driver info.
 framerelay.txt
diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.rst
similarity index 100%
rename from Documentation/networking/filter.txt
rename to Documentation/networking/filter.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index fce04d747a1a..a95431e90ab9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2746,7 +2746,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
 Q:	https://patchwork.ozlabs.org/project/netdev/list/?delegate=77147
 S:	Supported
 F:	arch/x86/net/bpf_jit*
-F:	Documentation/networking/filter.txt
+F:	Documentation/networking/filter.rst
 F:	Documentation/bpf/
 F:	include/linux/bpf*
 F:	include/linux/filter.h
-- 
2.17.1

