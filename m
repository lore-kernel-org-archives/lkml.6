Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76695C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326D320852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Y5+srSPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rt2Xx56Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326D320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbeGYDjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:39:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49549 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388446AbeGYDje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:39:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4DA7021AE8;
        Tue, 24 Jul 2018 22:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 24 Jul 2018 22:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8CcVBe7nFKx9jFKrb
        3lbH2vnLoc9LpA98dmP29qOWeA=; b=Y5+srSPKJtIwPARv4KdA01VtQThK4OioH
        18AcQ9KI8G07TwayVsx4uJN29hbiEB7cFLh187rNb7HLQ/nzJmNWNL8FkYxSGLf7
        rYGmO+dTncbs6XHju6LFOZYMB+QEeM9JEtvzvEzoDbgFEgZgKuIY3JDgSpBMHr/x
        aPCBmdG74aJ5T0+aNROYj9A8LLp2pLCEPe1hPtQF36ezkNp8L0DLDAjbq6gEkV0X
        Z7lqi2IBDt2goiXAxhIc02qxF2dzQ5sGJvrPv+A7D21d2jdItbbMwXhxgJ0YMtmu
        J3DJ2cS1mvj4wIsx1TVUqaqjOfVtUZGLaWA9SUL+G8k66dVD27tig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8CcVBe7nFKx9jFKrb3lbH2vnLoc9LpA98dmP29qOWeA=; b=Rt2Xx56Y
        mD3cZLpZoMPOhzde7edPPLgdOpHTqqFmLj9c+sGkYoWObHFdSa6cE4hmusHzAPG+
        kvZ5rkyoxfhrtvrcQsgpGxdmSUgokByEyWplxyukqyBybIUoqApv0afuW9/I/Ou4
        tHiP9tUTVPl/bv51Qz/1lS5YUZOKVSq2QHdrfNfUPU1ZB0tcIMv/GVnEubVpONsA
        GazhSMc3UOzmqJoTH5pqRkGvDYrxcYa1uyqkfH76EUVx+HTzfqatB/5yzccnQirL
        Mtw8Vfi3nMGM5YcrvkeribFvXkHLlv+xXF6q+9zbaOW+Nite4hVwEiXkklM6dY/w
        x6SvJukuU3WhRQ==
X-ME-Proxy: <xmx:seBXWzim1XOdnGl-BEqi2jfenD83lfX5qZuysjIfhXuexDX_FHTTLQ>
    <xmx:seBXW7m8_9ZUyRzrs_sriyygm0GivlnZ44399haBIdi4CNTnRr8Y8Q>
    <xmx:seBXWzEt-ITFFn2c830GPkGZ_hwmItJgsvPbOQpFpYFSmV0s_hW6vw>
    <xmx:seBXW1M3wr9tyZlFs8WN5Or5WA6pRBEkqyCLyKIzvXxZ1KL1BVP-PA>
    <xmx:seBXWysxFnb7zyJXWM0jKdUMvFVzkLgt2gy7P_DEWZ0hI2oHMMS3BA>
    <xmx:seBXW60uYqIBne6Vsj0z8R17x17zNgsDjavZHX836lKOjglqdC9zXg>
X-ME-Sender: <xms:seBXW4WANq-Af1k9PCo9d0KMhxTl53EVd0uTTm0gGAwN8LYD5T1RsA>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68253E450E;
        Tue, 24 Jul 2018 22:30:08 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] docs: Add bpf/index to top level index
Date:   Wed, 25 Jul 2018 12:29:25 +1000
Message-Id: <20180725022926.8993-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725022926.8993-1-me@tobin.cc>
References: <20180725022926.8993-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently bpf docs were converted to RST format.  The new files were not
added to the top level toctree.  This causes build system to emit a
warning of type

	WARNING: document isn't included in any toctree

Add bpf/index.rst to Documentation/index.rst

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 Documentation/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 5d310d960f82..24339a9c2ef8 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -92,6 +92,7 @@ needed).
    crypto/index
    filesystems/index
    vm/index
+   bpf/index
 
 Architecture-specific documentation
 -----------------------------------
-- 
2.17.1

