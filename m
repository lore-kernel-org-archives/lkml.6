Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B047C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6ABC20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="XOCD3661";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQ5sCj9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ABC20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeGZGSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:18:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38985 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729133AbeGZGS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:18:29 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E088021DC0;
        Thu, 26 Jul 2018 01:03:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r5bh0PHJe3rhT0Dlp
        GtTL2v0AdRo0Kq4/FgSdnx8QsQ=; b=XOCD3661KRLQBusyry1X+kBSzn3E7hNJq
        dg9mGADAwWS7H/qNfcWfPKqQNP91a2Fn2/8WnzqTBsgkKjYt7InBqHYupNTtuZF6
        AtSjfQx4jIm0XbQ91XsHSSJZ/LQ9sI4LVYeK84tM155RovNtOzrMlXFYl/XAyiYF
        L+BW9F+FR8m3bJPqWU3/X6kXzfFaa+qNTeuajgeElTXAQ/glX6ONOB8Dr7xl/wRd
        h1wQWn8SKFbwmvnUG1quVznNofJgBUAHk268rJTjD6YE5cNAZjUpL339XM8Quxzq
        Kwk2VbSm8600lft4RQFf2VjN2aroSNHR6nAanvjHb6mH6LO9JYkbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=r5bh0PHJe3rhT0DlpGtTL2v0AdRo0Kq4/FgSdnx8QsQ=; b=lQ5sCj9h
        bkgt8JkJyrNsMLsM9Aqg/iCl5jPENJDVWHe3kghvaG3FVSh3DnlASG8oqyrf6iRY
        4fdrjFDbfTEPzYWS+dFNalg4nCLtcLuEH+rG5pceURYJ4J6W7ptrZO70GAiHUA4x
        DdTzWYI/SMkwNRTJh8FEmfqjWZJMsTxsw0tSgLsQJ7OBi1h0Dta/rp3iMvTAfQsX
        y33Y6oDC7ZqcXOwQMhCcVuJ1EOPC+JYpOwLe0O4vWbYG6ftMBH7CNPcp0B7S2QHR
        Gx3TeQYcv+GJfzKe6yAru5RjDuerYutd6tfu0AXFy3mSWR7JmQNK29Nir/SCEq0k
        fT1CGbjH0huK5Q==
X-ME-Proxy: <xmx:IFZZW6rPr9Q98Rf4hmFBYWHQ3AfvA0DNjCFQVjHAjXxckCipjqStOQ>
    <xmx:IFZZW3ARmbODp-ivIBlVZarTC-l4hXeyIQjhaOA9LdoNw8eg1DsdiQ>
    <xmx:IFZZW7PFgqwGuMt4ia37DdJF-GV4pcnI622lV6EMGAO6s8h9jnpkSw>
    <xmx:IFZZW9CVrCy_FipdyQt0ZxzPiqvxF3LwSMmDEFSQMPIQkdICV_8eIQ>
    <xmx:IFZZWx_LnpmRYGFuwo_T9SEKzCQqlr6g85XnYGi_Mdvu0pMY10nSLg>
    <xmx:IFZZW7D75udS7myP0S74Xf0pTgri0orP-XEBUPr3l0AJTmmdRFWLUA>
X-ME-Sender: <xms:IFZZW7fzdQs0iv6Qm2Buf6AfUvPEiUHN0Jzhn2-BIct7xN0mHNf2cw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 11EBEE435C;
        Thu, 26 Jul 2018 01:03:27 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] docs: bpf: Capitalise document heading
Date:   Thu, 26 Jul 2018 15:03:05 +1000
Message-Id: <20180726050305.2147-5-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726050305.2147-1-me@tobin.cc>
References: <20180726050305.2147-1-me@tobin.cc>
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

