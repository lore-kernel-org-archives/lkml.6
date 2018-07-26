Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F23C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0520883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Ak4VDAsO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3Q3A5uC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F0520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeGZGS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:18:26 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59725 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbeGZGSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:18:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AF9421FEE;
        Thu, 26 Jul 2018 01:03:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8CcVBe7nFKx9jFKrb
        3lbH2vnLoc9LpA98dmP29qOWeA=; b=Ak4VDAsO0ycdT/KrpNwaWT8K9EH9ravYv
        U92QSWkE/aNJbwuK+YpI74Iwr+CVX5QuZJg9XV1hbULnpRtmTLp9v13sehN/HKme
        gV6wWzXF7D4IYbyZ3itM/qzsAe+W1NejcOYvw5+Ox/SS5AXWFFZ7kZcyGiec2Z+y
        Jt2Si4VhQG8LeA+98ZHiVgmpqFdUC4EwNZyfvgU5O+y7z9PemRuMOnS3XJQX7myv
        Z//6McoWT8NYqjNvwo7Ot/WjdX9T025I5E78+Is22pRgo0LSR35xJPMUb/Pifcze
        q51kZA8aZmoikOWZT+d9+e5VubAaALW4mRqJcRkJfwYRtWJLQuo2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=8CcVBe7nFKx9jFKrb3lbH2vnLoc9LpA98dmP29qOWeA=; b=f3Q3A5uC
        ooVs6MWrnU8YOi05zv+g4S6A8U9e+EgWcnF973G5zOsCpfYFOPq7Dxxaw5eavIEq
        fk6UgwWSN8ghzMzs+Wi7Fy19tTLlDfB6XuvfD+gx0Si3f7VzQxDm+svreXIiK76v
        xOT9Fnp0VGumYKhKwdHGGEkGwsRPFXB/lqBQZ9mk09edmn7dr70Jj+aKcJA0F5bC
        QQzX9HcAofxJPWTxKtIuQunFiIXbp8XAzIFPjqC7Qig+P5Tu49X0Yw4r99Vvp7O0
        dFDtqmjOR7vwrtONFquSqiRVUNQHQe0ZBaT2RN75ykc+YM5zfKG4AGT11BZLZYjo
        kEUmSaJUG1C+Bw==
X-ME-Proxy: <xmx:HFZZW4L5oiu9Y4Dvi-bgZJ0FL_oIKedBP7vg7mAOo8YLpyLZ5jcEog>
    <xmx:HFZZW2rzy4mEYMsfMqOpAgYLPv6ZCUr3NOg_5bEl-GTURRUzljFing>
    <xmx:HFZZW_Bkti4wpQ2M-G0b_6XkzdnZzt2apZSIB27SIflp_zsxhvtmUQ>
    <xmx:HFZZW7_VGTUD0mZHmf3Bh0T8Tqz7Z4On3aI3FS72e1kTndIASQsKcQ>
    <xmx:HFZZWzavt2q9-lN5DJ7bngJTuemanw7zMwMdOiryCr6CL9ohxdNBDQ>
    <xmx:HVZZW-VAEK5QLuMmeXb90RSlyYHnexhGwXXe2oOmFJZJStcM36e50g>
X-ME-Sender: <xms:HFZZW7PS-ZGiGcthxeZvS3PSD3n-Xj4GYjyQqF--rSQA-XyiEmMeDg>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 356B21026C;
        Thu, 26 Jul 2018 01:03:23 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] docs: Add bpf/index to top level index
Date:   Thu, 26 Jul 2018 15:03:04 +1000
Message-Id: <20180726050305.2147-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050305.2147-1-me@tobin.cc>
References: <20180726050305.2147-1-me@tobin.cc>
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

