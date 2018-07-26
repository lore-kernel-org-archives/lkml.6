Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835C120673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="glYFEIli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4OgzJg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835C120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeGZGSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:18:23 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32989 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbeGZGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:18:22 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6650821FEC;
        Thu, 26 Jul 2018 01:03:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Pdqg+bsNhCBjTZG1X
        ZolszNuUd1LmLWnXJntJhJgE4U=; b=glYFEIliQ/Vau/6i2lvQEOmH1dbNoJwYi
        TrAyKIbiJg7gG1po4VI2FE+H3vp2X0wXznirOURz0Qjl4yqoCUEhEfdexelbKODC
        Xsq6grBtnps1FDpl4Q4KsZZMKhMGBHQHqGjQJyKitZJvFdOTIF6CHbWerxgIlsOk
        1eqrm+DAQQIa0axUVOlloLMOP2jAKS7TZnShlYqTw497O7hzPYFlQX3BdgGqjrSh
        F6KQYNquf086BnArFzYdiSyrd/2RbBXLFDNuxzJFXGiFf4tQoM3zaVZJbFKIkkw5
        3vIAWt6nEiusBB9UWWEL74hIcPvlonACqMmes+xz202P57Apajjww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Pdqg+bsNhCBjTZG1XZolszNuUd1LmLWnXJntJhJgE4U=; b=c4OgzJg0
        W11uoKSKbvEdOCVEKM01TCOXoXoU/YfnsKO5LhbaWBAsQEtd1XouKhXknG4Vn+I/
        qbgejOOMXiziaofR/ZCt6lfQQ2Tg72UHehKLVVodXdBhw8o0bDpfo37IMvVsO1wM
        TXYJEn71vuBVYIyli5VM+HZdVHmAf6FT4DDtXI+t5/RwG2+APBBLdf7rtb3BqEZR
        0Gpawh7ep1OSsbNDp0SurgfLqSoyCk8cKb7LpS7WpKTjm8Whngznmr+3r6iOFEzu
        gp+lBnOhchoqjFk1Nt1p9wyzq6WN7m7jdnA7+bMcSC+GGpZncRo1v5h5H3PhsmVc
        TG5LbsgBEtQ7tA==
X-ME-Proxy: <xmx:GVZZW178ov5Ar3YnxzZ7hBZYEiZN39mS_po_e4kcIA5VFAkFaF4aSQ>
    <xmx:GVZZWxUEutBzrgGPbZMKNOhgA1ID1h6w-PmRet23rOz2yGrRhQZ9Dg>
    <xmx:GVZZW50OtTU05_cGD9vIWtiuz6btdeHSkjIK0eNWdU7eu4RCcCe9Bw>
    <xmx:GVZZWxXMlN03RsN9YEqHncQ4dj9w1TRQO57JX4Ze7gvzYyP7apRIig>
    <xmx:GVZZW7pn2wfutvTEA6-IbqdFu9FcF_drjF7e11sD-vwHrGywnMv7pQ>
    <xmx:GVZZW0pK1tmcmt1kQRDQuIu4SGopUXkl6gq1O4-ciPehjl4cZ0VPew>
X-ME-Sender: <xms:GVZZW2bm0jp6CrHgdOBv6JG0dGKVsmcv4XvcNcDYOKGqw-Lu1xM8kg>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 808101026B;
        Thu, 26 Jul 2018 01:03:20 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] docs: bpf: Add toctree to index
Date:   Thu, 26 Jul 2018 15:03:03 +1000
Message-Id: <20180726050305.2147-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050305.2147-1-me@tobin.cc>
References: <20180726050305.2147-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bpf/ docs were converted to us RST format.  bp/index.rst was
created out of README but toctree was not added to include files within
Documentation/bpf/

Add toctree to Documentation/bpf/index.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/bpf/index.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
index b9a80c9e9392..ab2ff13a809b 100644
--- a/Documentation/bpf/index.rst
+++ b/Documentation/bpf/index.rst
@@ -22,14 +22,14 @@ Frequently asked questions (FAQ)
 
 Two sets of Questions and Answers (Q&A) are maintained.
 
-* QA for common questions about BPF see: bpf_design_QA_
+.. toctree::
+   :maxdepth: 1
 
-* QA for developers interacting with BPF subsystem: bpf_devel_QA_
+   bpf_design_QA
+   bpf_devel_QA
 
 
 .. Links:
-.. _bpf_design_QA: bpf_design_QA.rst
-.. _bpf_devel_QA:  bpf_devel_QA.rst
 .. _Documentation/networking/filter.txt: ../networking/filter.txt
 .. _man-pages: https://www.kernel.org/doc/man-pages/
 .. _bpf(2): http://man7.org/linux/man-pages/man2/bpf.2.html
-- 
2.17.1

