Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2DEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA122088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="k8tTj3yI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7iYWclM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA122088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeGZGRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:17:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53691 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeGZGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:17:45 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5000A21F60;
        Thu, 26 Jul 2018 01:02:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XYF3hyB3qg7ns/YbF
        2XAvKIewuB3V4bMseLCeu/HSyc=; b=k8tTj3yIKPJGiv3kmv93p/9Xf7gr2qTHi
        oZKES+PY/2mKusHKfBWsjXKsg7GPWtRXL9Ok4HLDcX5Bf9LXCshDDnfIE8VpqCY6
        +Tl+TtRiB4FP9k48+TCgRxume4QJ6WcQZZ9EkLufCqZFuW8jkJGf7uzpi0zQNOSS
        jjASRcQau2/KUIWTbs5KgWaNeUv+djQyAK+4JXcYU2T8DE+Ka4VZRNjHs97XVUwi
        WC6W6ejghBh93foDaI1v59eVXt8qhwhGj+/rkME300PUsk/sm5PPPQ2zUB1ZqUqH
        4LXEnS34lKv5yCsf6z8v31dK5pZYG5BHAW0dCaCxynk3c4U8Hau6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=XYF3hyB3qg7ns/YbF2XAvKIewuB3V4bMseLCeu/HSyc=; b=a7iYWclM
        +lciv1Pk6azPma+EVhfkt/sKrqo5w5/uT9AwIDYZJ94uCfNvouKzBKUT5rfJ++N3
        FuTDd/MyYdhWxt1LR+/ADaWI8ECdCu9mTbQd+oWrsaogzwSYDyBMSZlAG8Zug25H
        e+a381+rTKf1S+lHDuDQJyWva2Xi+u/023m6824Z526a9o1gficQ7cNJEhnxZF5a
        TngT0Wfe5v7tSkYiLlX5UqN91FYQkwzWj8qYJq19IFN9qkD/k3NbxIEYyxTnLQl7
        lSadOd260knQ144gOjXwze9NeUP8GbO7bQtm2d575rYkkcLMrKfr4dvy0QsW3wF4
        0NQdiiClGmqqJw==
X-ME-Proxy: <xmx:9FVZW2hl7HaixTlhtjJHK2SOrdgz4Z2eMjlBU2a_-yaw5vsi8kaFjw>
    <xmx:9FVZWydP1HsrOFwNlL2fLpeX5m0Fd-kpSgynH0e5w41zf0_lpbOq3w>
    <xmx:9FVZWxpTDxOtQzHmlIMmuYgoCGLD8zeNWyZn2utyHmjo_SrwT8kdbw>
    <xmx:9FVZW4TdLt3i7I33nho7FZYmtda4z4oDWa4pMcrDotRnsrgu659QkA>
    <xmx:9FVZWw5SHDoElXmrY4TtWQlEp-DogHXONyW2fVEMK4QpZ-S40AOvyA>
    <xmx:9FVZWwJKA9Uz_RafckaYHlXauY8yLghlZjHmhLmb8CfAorCmAQXa2A>
X-ME-Sender: <xms:9FVZW1IWx5f5sKXs_nPYoobvLWfuG1vPTJijS1xMV3NGCJGy375Saw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C8561026B;
        Thu, 26 Jul 2018 01:02:43 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/3] docs: Update references to netdev-FAQ
Date:   Thu, 26 Jul 2018 15:02:26 +1000
Message-Id: <20180726050226.1980-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050226.1980-1-me@tobin.cc>
References: <20180726050226.1980-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File 'Documentation/networking/netdev-FAQ.txt' has been converted to RST
format.  We should update all links/references to point to the new file.

Update references to netdev-FAQ

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/bpf_devel_QA.rst            | 21 ++++++++-----------
 Documentation/process/stable-kernel-rules.rst |  2 +-
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 0e7c1d946e83..c9856b927055 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -106,9 +106,9 @@ into the bpf-next tree will make their way into net-next tree. net and
 net-next are both run by David S. Miller. From there, they will go
 into the kernel mainline tree run by Linus Torvalds. To read up on the
 process of net and net-next being merged into the mainline tree, see
-the `netdev FAQ`_ under:
+the :ref:`netdev-FAQ`
+
 
- `Documentation/networking/netdev-FAQ.txt`_
 
 Occasionally, to prevent merge conflicts, we might send pull requests
 to other trees (e.g. tracing) with a small subset of the patches, but
@@ -125,8 +125,8 @@ request)::
 Q: How do I indicate which tree (bpf vs. bpf-next) my patch should be applied to?
 ---------------------------------------------------------------------------------
 
-A: The process is the very same as described in the `netdev FAQ`_, so
-please read up on it. The subject line must indicate whether the
+A: The process is the very same as described in the :ref:`netdev-FAQ`,
+so please read up on it. The subject line must indicate whether the
 patch is a fix or rather "next-like" content in order to let the
 maintainers know whether it is targeted at bpf or bpf-next.
 
@@ -184,7 +184,7 @@ ii) run extensive BPF test suite and
 Once the BPF pull request was accepted by David S. Miller, then
 the patches end up in net or net-next tree, respectively, and
 make their way from there further into mainline. Again, see the
-`netdev FAQ`_ for additional information e.g. on how often they are
+:ref:`netdev-FAQ` for additional information e.g. on how often they are
 merged to mainline.
 
 Q: How long do I need to wait for feedback on my BPF patches?
@@ -208,7 +208,7 @@ Q: Are patches applied to bpf-next when the merge window is open?
 -----------------------------------------------------------------
 A: For the time when the merge window is open, bpf-next will not be
 processed. This is roughly analogous to net-next patch processing,
-so feel free to read up on the `netdev FAQ`_ about further details.
+so feel free to read up on the :ref:`netdev-FAQ` about further details.
 
 During those two weeks of merge window, we might ask you to resend
 your patch series once bpf-next is open again. Once Linus released
@@ -372,7 +372,7 @@ netdev kernel mailing list in Cc and ask for the fix to be queued up:
   netdev@vger.kernel.org
 
 The process in general is the same as on netdev itself, see also the
-`netdev FAQ`_ document.
+:ref:`netdev-FAQ`.
 
 Q: Do you also backport to kernels not currently maintained as stable?
 ----------------------------------------------------------------------
@@ -388,9 +388,7 @@ Q: The BPF patch I am about to submit needs to go to stable as well
 What should I do?
 
 A: The same rules apply as with netdev patch submissions in general, see
-`netdev FAQ`_ under:
-
-  `Documentation/networking/netdev-FAQ.txt`_
+the :ref:`netdev-FAQ`.
 
 Never add "``Cc: stable@vger.kernel.org``" to the patch description, but
 ask the BPF maintainers to queue the patches instead. This can be done
@@ -630,8 +628,7 @@ when:
 .. Links
 .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
 .. _MAINTAINERS: ../../MAINTAINERS
-.. _Documentation/networking/netdev-FAQ.txt: ../networking/netdev-FAQ.txt
-.. _netdev FAQ: ../networking/netdev-FAQ.txt
+.. _netdev-FAQ: ../networking/netdev-FAQ.rst
 .. _samples/bpf/: ../../samples/bpf/
 .. _selftests: ../../tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 36a2dded525b..0de6f6145cc6 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -37,7 +37,7 @@ Procedure for submitting patches to the -stable tree
 
  - If the patch covers files in net/ or drivers/net please follow netdev stable
    submission guidelines as described in
-   Documentation/networking/netdev-FAQ.txt
+   :ref:`Documentation/networking/netdev-FAQ.rst <netdev-FAQ>`
  - Security patches should not be handled (solely) by the -stable review
    process but should follow the procedures in
    :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`.
-- 
2.17.1

