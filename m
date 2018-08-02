Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DE4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF6F215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="H+kxaYVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWpdjENP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF6F215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbeHCAYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:24:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39875 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726989AbeHCAYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:24:25 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D73D421785;
        Thu,  2 Aug 2018 18:31:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Aug 2018 18:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=0/AztLt+OEDABGKoE4DLMeIZb8E4w1IHL8DhBIhmz
        sE=; b=H+kxaYVfeA2JHNlTa/5xtgMtDKVB4QsDGYZ5JmsvJCaO4mIOSQWKy3ycy
        jW3Aj5AbHTQd0SUvACmx2XA0+3OgNIr+bGVtO6KrFS2sDrVV6ubzVnKfimZeMH+2
        N4TrSVV+KvBWwcnTJ2rSJvOJFO9idIAi8ycmPnxkjKavlxjdSRV8p4aSqsF/ApFw
        7B27RJGv4QflyAlHnQtmVTZXC4ESiuRsvNk8c1NTnD4zhDpVfIlLlEqOigj0ahKa
        qRac7g7bJz8VZuc8E7IqaYHzks1HtLeFur3/w/dHVuFOkoQEpwxJ8B4yGe6jHP3c
        IBT4TNk7WRvRWG5IX94O0+NRMvCRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0/AztLt+OEDABGKoE
        4DLMeIZb8E4w1IHL8DhBIhmzsE=; b=XWpdjENPQXcAjBUmQxS8PoOeUhpMOByHX
        9S5HLZEqXLH0NddAaQLuvlfoAZ9rsLK1ITRzjUYSvflJNq5YCqrV8Di/haMmwF1S
        1XI8a/1iBhRkALwuDXhMDwhdrE/TNrA8ZSeuNEsv2E2jzOwpAV1QthAUXan6pHmD
        UIwIjcmCBjsn8B08YNqHwKWiwM8/d71nP9j1d9zZvnfzLq5oPhYohLfQWQUkoIdy
        cKfwaN+4aK7rksI15suz921AgRjkambDLUDFEi9N0UIUw2HFlfVatL/JM/Myqs2N
        fUMax+R/gqjkuVsFa/9djdhGVyRoVzc2I2qEnqyezwEN05jY+tKpA==
X-ME-Proxy: <xmx:LIZjW4WnmyFPSTPlU93n7KK-Pn7fqLw0CSjv9SDZ6mj1xqTR5QgUZA>
    <xmx:LIZjW8zHrCBbup9cY-rwWmbuAYQJ3LLgMH6ryerqsbZ5sxQCkbe8rA>
    <xmx:LIZjW-Oi_GStBr_ozE6OkeowadTh1g9AJsCFs_9pjNbrIg-Rv3TdZg>
    <xmx:LIZjW17K8-aJGBnZ2qndMSR1ftGrCoUzvU8p6_drZxMKBnddiZxcfA>
    <xmx:LIZjW3OJ3Q3DwbO5wxLG80dBy5nI0sMwetKU366ZMwUAMvdr8w_-CA>
    <xmx:LYZjW2QY8QNat33r6ZRXt3Kkkkp3cvcujkH2BmWkaxkwwklOuOTK4Q>
X-ME-Sender: <xms:LIZjW6AXSZPpzzMQb9_cwXpyhK0zQbAqeHcfWAfxbs1-jMKfMykBfA>
Received: from localhost (ppp121-44-199-247.bras1.syd2.internode.on.net [121.44.199.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 04BD3E4074;
        Thu,  2 Aug 2018 18:31:07 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC bpf-next v2 0/3] docs: Convert filter.txt to RST
Date:   Fri,  3 Aug 2018 08:30:57 +1000
Message-Id: <20180802223100.26236-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

v2 new and improved (with the actual files committed).

This is a documentation RFC for two reasons

1. The content is heavy and I don't fully understand it all, original
   authors are you ok with the document being split up like this?

2. I'm only the conversion monkey, I'd like someone with a bigger view
   of kernel docs in general to ok this please.

This RFC came out of this patch set

	[PATCH bpf-next 00/13] docs: Convert BPF filter.txt to RST

As such the first two patches are the only ones I could salvage from
that set.  Stating the obvious the mappings are:

Patch 1 was [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Patch 2 was [PATCH bpf-next 09/13] docs: net: Use lowercase 'k' for kernel

Patch 3 is the splitting of filter.txt into bpf/eBPF.rst and
core-api/bpf.rst 

Again, stating the obvious, if this RFC is ok I'll redo all the other
patches from the original set on top of this.


thanks,
Tobin.

v2:
 - Actually add the files to the commit
 - Check the _whole_ patch before sending
 - Use checkpatch like we are supposed to
 - Add licences

Tobin C. Harding (3):
  docs: net: Fix various minor typos
  docs: net: Use lowercase 'k' for kernel
  docs: Split filter.txt into separate documents.

 .../{networking/filter.txt => bpf/eBPF.rst}   | 648 ++----------------
 Documentation/core-api/bpf.rst                | 599 ++++++++++++++++
 2 files changed, 643 insertions(+), 604 deletions(-)
 rename Documentation/{networking/filter.txt => bpf/eBPF.rst} (60%)
 create mode 100644 Documentation/core-api/bpf.rst

-- 
2.17.1

