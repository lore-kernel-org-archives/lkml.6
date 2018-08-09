Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C74721BC9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="LxCmTLAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpNrVE9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C74721BC9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHIHqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:46:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55433 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeHIHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:46:44 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F007721E0F;
        Thu,  9 Aug 2018 01:23:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 01:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=c3okl1OWYU1jpoJrDgPHDwwRHKmwQCYuiQ73nS5k+
        Qs=; b=LxCmTLASrTYKuu1zL6gBR6j1v2wnssJRVaxn+Jo3PZTArt8K8RTymhXGL
        8Fw9mRjKih59owhJB7M7M5pOV6gZVh+tPhe79apMFhpjohSJg7rrNvUZVtff1T4m
        xdj8XlmA3GaLoWf7tJ5fmVKZUeuVH6YHAvM876tuVUysVn7sI4mVj5iVmfdngJOK
        +75E0RrDXgD5DbQgrTsuPorUwTqOm+Le4iMFc28DNptfwdhsiBU+fmlwQ1xjjgZ1
        FtiyG8n5pXxhWaKvfuEFh5Tq0Gf9acq+uqRU+2aKPPaUejUERszA0PCqTcSHnx1z
        CMfL1E/MujvScDmpYQ7PQ1S5BxmFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=c3okl1OWYU1jpoJrD
        gPHDwwRHKmwQCYuiQ73nS5k+Qs=; b=YpNrVE9ApEZDu2ejtY7DesVUJCRc3LQ+t
        QMtPOh7WxujvVed4ISRwq5kScOx5/+mC+XYXgHc/f6Aj8IQRecECkW8odwoy5CNt
        uQXkI/fhb1YOqGeeKOgLaXqNwhqPj4kNup4Ndf5zVdpSApqwzBM7fdHxxXWbNEwB
        5qaaCIlyCT9OfkbfYEspsp+Jgr222TWr9HLiXxjay7cU0g776eK95yiVYpa2p7hU
        uiFtSF5Zn1DGc9mIWHSDRzeMJL2BVGiS2HwEwLKpLumzo9BU+OZU6Xcpoe73B07l
        EVJqU5p1Jc8giF1ayif+UV7bIulKEKaa0LLZBbhXz8zcmPPEmexdg==
X-ME-Proxy: <xmx:289rW_ogxiV5EGmh7cmYyLBYG3PvdStVYlz2r8J4jnO5ejohJPWgdA>
    <xmx:289rW5GA9yTWgJRRyMy67MgLC_MTRNwKl5hosyIhvqn0DyRQm9XWvQ>
    <xmx:289rW4nlmMpE4fJ03dltz0KJIoBCu4bFm9gL6lnc6ptZWpHL3N7rBw>
    <xmx:289rW9L8Mywe1HZzwMs7eWxnbPrX0N3r4qYYNBExuuzPlmtAoY7uyg>
    <xmx:289rWxyZ9MXWi7RNtfrh4m1yyWxqwK7uhiCvJGpg5l2bqM8zl8L6eQ>
    <xmx:3M9rW-TUVAokM-NdyR0F2rCK3TZV55OsvwB8AbhIY6gWKrWCY-Zcnw>
X-ME-Sender: <xms:289rW2NefRz0uoZoPdVWBipuHiLAG_h3erdtFE_F3qRusgfDu_BTTw>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34FAC10261;
        Thu,  9 Aug 2018 01:23:38 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/4] Convert filter.txt to RST
Date:   Thu,  9 Aug 2018 15:23:24 +1000
Message-Id: <20180809052328.27942-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my latest attempt at converting Documentation/filter.txt to RST
format.  Added to the CC list because of additional changes to
Documentation/userspace-api/seccomp_filter.rst

For reference this set is a progression of the follow sets (in order of
post date to LKML)

 1. [PATCH bpf-next 00/13] docs: Convert BPF filter.txt to RST
 2. [RFC bpf-next 0/3] docs: Convert filter.txt to RST
 3. [RFC bpf-next v2 0/3] docs: Convert filter.txt to RST

Sending this to BPF maintainers for hopeful inclusion in the bpf-next
tree.  As discussed on LKML this set does all the conversion in a single
patch.  This includes adding SPDX licence comments
(inc. seccomp_filter), adding RST labels, and updating references.

Please note this set adds three files to the MAINTAINERS file for the
BPF maintainers.  Is this rude?

Also this set adds a SPDX licence to all new files and also to
seccomp_filter.rst  I did this because checkpatch asked me to but I am
unsure on the protocol, is it acceptable to add a licence to
documentation that someone else wrote?

For the Record;

Daniel and Alexei, can I please have permission to add GPLv2+ to the BPF
docs?

Kees, Andy, and Drewry, can I please have permission to add GPLv2+ to
seccomp_filter.rst 

(added Cc: tag to patch 2 that adds the licence identifiers)

thanks,
Tobin.

Tobin C. Harding (4):
  docs: net: Fix various minor typos
  docs: Separate and convert filter.txt to RST
  docs: Judiciously use double ticks
  docs: Remove filter.txt from the tree

 Documentation/networking/filter.txt           | 1476 -----------------
 Documentation/userspace-api/cBPF.rst          |  432 +++++
 Documentation/userspace-api/eBPF.rst          | 1006 +++++++++++
 Documentation/userspace-api/index.rst         |    3 +
 .../userspace-api/seccomp_filter.rst          |   11 +
 Documentation/userspace-api/socket_filter.rst |  183 ++
 MAINTAINERS                                   |    4 +-
 7 files changed, 1638 insertions(+), 1477 deletions(-)
 delete mode 100644 Documentation/networking/filter.txt
 create mode 100644 Documentation/userspace-api/cBPF.rst
 create mode 100644 Documentation/userspace-api/eBPF.rst
 create mode 100644 Documentation/userspace-api/socket_filter.rst

-- 
2.17.1

