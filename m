Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9822098A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="aCZ7BX0b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tG0fR33M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9822098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeHBISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:18:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36859 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbeHBISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:18:39 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 27D5321DE0;
        Thu,  2 Aug 2018 02:29:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Aug 2018 02:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=n0dAtfn9iC6EO9Tq9hgZtvQ4/ij8r9gVDz4hoyCSE
        T4=; b=aCZ7BX0bbUS6nAg2C5Mq6YzmOmIIycBjDw0UIbwY/ZliWemk6CJdBs25c
        1Cn+qkfWWiuVj/9QN8jRczlbd3tc3YBNRlqMRTF5xSW7LUmxgXL4VetloZnrroc8
        BNsvaOg4mdXprOgEj/Ok1wMGUMnm1bgkq/GUAKK81AFUSrF4GTKYOurc3mW/qV4G
        5aj0G0V7VyMmx5dZzWjfTaZxd6yjSSu7by9/PMhMYvcEbck6AwhNSrvgZe5HqBzv
        CwPoq8Fz2l8QjxAovOgUWBUzllo8JNLBsQLBKtxZjts4M7k99nypm7m+LJyurLfR
        FEbqPR1jmGSnZLNNh+LnPt0HUI5Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=n0dAtfn9iC6EO9Tq9
        hgZtvQ4/ij8r9gVDz4hoyCSET4=; b=tG0fR33MF1ApGRFCWUnsJmc0P7YrNHze3
        lmFzlMuJGKencsNFfUq5VqGf0hcfaIq8aAZ4UYPjGK6Ba9uRGAmaYqKKNUG/t/am
        j3zi0hed2zwBWNY27Y4Y7arvbFnGNdfIf/YfAVES8+XDjwM/yK7VXlKFP7QTwkGl
        TPJUcX5GR4aKOP3VX4DAw5vpHNlKLALg2RAPIyrlpigtnuMLJS4fjLrimNHUJaAc
        lb2+UEpoGCpydhWY2cDxHjg/nXy7+OwF17GxEPUznWGHYnFVNMaeug0syK/hBVFr
        mIT1Bj1aJ1PCDReLR//r5lE5/yerWym/lgs66n9DLGEaZAmZ5QnlA==
X-ME-Proxy: <xmx:raRiWyeK5kX5EnlOEZB8DwQh1ervc8PkogbLUl1adbztFrZNbPWKPg>
    <xmx:raRiW8py2lZqky7KkCMyz6fzlCb3Qo8vc6olUHDGjxrbdHyTQc8KoA>
    <xmx:raRiW6aeLhc-oAo1gkpMY7uof3rNMR7pqwOc5OjBqwx46Czy0i7gdQ>
    <xmx:raRiW2Mgfk3gGcoqf5X2qUeW0VNEdTswK0wl7sP_0XjNTqewvfxx2w>
    <xmx:raRiW7525QYSkfrvCi-6tVXB23IAssaRJpsbfWMVtB6LXSxrRLCGxw>
    <xmx:rqRiWxAU3N5ekcbjulkMCk37BtuRolwFEyX7Roh53ljSYb1x-j6h2w>
X-ME-Sender: <xms:raRiW8Cn8RAWxczfh_NhGnKsqq9Ux0QV7pnwGvg4Wj50GLZD1HescA>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id B223CE4818;
        Thu,  2 Aug 2018 02:29:00 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jay Schulist <jschlst@samba.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 0/3] docs: Convert filter.txt to RST
Date:   Thu,  2 Aug 2018 16:28:45 +1000
Message-Id: <20180802062848.14332-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a documentation RFC (come on now, serious faces please).   It is
an RFC for two reasons

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

Tobin C. Harding (3):
  docs: net: Fix various minor typos
  docs: net: Use lowercase 'k' for kernel
  docs: Split filter.txt into separate documents.

 Documentation/networking/filter.txt | 1476 ---------------------------
 1 file changed, 1476 deletions(-)
 delete mode 100644 Documentation/networking/filter.txt

-- 
2.17.1

