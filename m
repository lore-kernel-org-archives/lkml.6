Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74C820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IWObyHm3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W03Zt8de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74C820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbeGYDjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:39:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34445 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388446AbeGYDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:39:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0967321CEC;
        Tue, 24 Jul 2018 22:30:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Pdqg+bsNhCBjTZG1X
        ZolszNuUd1LmLWnXJntJhJgE4U=; b=IWObyHm3nYf92kE/cmLCSpbRBHtTI0xfD
        ACB5RG97McuURnOvmX55WqafyE0f5vpa9WK/LShd7ekTr1tUCbz6z2dhtaKK8Q3y
        E8hXHoqAHg1hG6hb2bHyrARlv1IhB4e/+e5CyTWU8LHli8BzkdbFVnOoCun4F5o/
        f1K5GbGfvEMhEiTncvNSA7bZV1wfORZ+Wvmq/GXWphUXeIekpUMCQfnKMfL3mRyI
        711ZBHGP2zyfmXVFyHm27RZ2Va+tLVpQtQizgC8b+GF87b+O6zYy3po5aaq1bGeS
        jgM4IqaU9BD/M30EgrQvpq80nSOqVzXjmXMsGBBflkentbNarG0wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Pdqg+bsNhCBjTZG1XZolszNuUd1LmLWnXJntJhJgE4U=; b=W03Zt8de
        0wsbq3KZ0d1CbHrmw9hZpzyGmFFLpSzhdxImKXMWGc83q46yJyG7uVtsNS0ahVgy
        tHowlz2c5RUZiCjtjzQqvZ9pns53A4TrfLl41jWaYL4MKHy3jCK+N9d238rEuJGt
        5iAYztcPCHhGJBEOS131bxPS40gnHeWAb+y7EMvj3Ds3G7vtvrIvOXvOuNcZK7HT
        Y4553BrAvKFZYhma5v/GehZNLc070/qdJ8YQLufhtUrbY9ve4JN151zMBvhz5I2H
        pTrqKyvDGMmpKYLnOUpEL2fa63SbxP5Q76Ym3vtsxT2YDjhBjOiVv97TPAjzts9b
        ZqswpFmh3G5syA==
X-ME-Proxy: <xmx:reBXWzpO0tsL5mqD04Oc-iE-UQrmZLGJssjeKX_vEt0a_SxkcZvOTQ>
    <xmx:reBXW6ko2Id8bkbSnCD3uAA6AWc6GR84iuXrOn-_dmXwqu9ZfBGHwg>
    <xmx:reBXW71DRorlNXuwLJa2x14DVhvgloM0Sl_bTJEqGk_bhXERu7GbHw>
    <xmx:reBXW_QzQYEcG9_mHGaIo1dL0untwv09cZBhHk_VVA2non98iYlJ2g>
    <xmx:reBXW8xUGPuf9ub1fnzkK1E6K-hIi_QWru2kR9am9bOn_kePq5h_VA>
    <xmx:reBXW6U-sFsy-f-yzWh3nebtXq-bPX1T6IRuNLoq2UEiKfgWOW7xnw>
X-ME-Sender: <xms:reBXW31lBU96RC6xqEQABQ2bB3jtFAPjgl4wIBhu5GKs_suKoOYeLw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 952701026A;
        Tue, 24 Jul 2018 22:30:04 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] docs: bpf: Add toctree to index
Date:   Wed, 25 Jul 2018 12:29:24 +1000
Message-Id: <20180725022926.8993-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725022926.8993-1-me@tobin.cc>
References: <20180725022926.8993-1-me@tobin.cc>
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

