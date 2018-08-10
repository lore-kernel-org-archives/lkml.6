Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC9BC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FB0223B7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="CJefqNpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IIMb3Dsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FB0223B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeHJEwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:52:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36719 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725724AbeHJEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:52:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 08D5821E72;
        Thu,  9 Aug 2018 22:24:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Aug 2018 22:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=lCMHG/j4cmAj28uIDcx7ix7FFgOPzX7RkPDTQoqeN
        gA=; b=CJefqNpph0HFIQ4bqTHK1NjswL187gc8C3P0vvo7iFyceKSHishtTLhme
        gYkzWOPl8d1QdNVgktqMDqkGAfU8LC5ThU4wqC9gDfkp6zG4/2UvnKIRXO2YLtky
        E6Z+NeXOucXxKbhIGx0bIjw7pPxeC4Gt5Pusa6aMzFtu2JQGKpT7zMhslZsuPQ/E
        ShWySOGeLHPlsORTWTNdgPndm5pwtJZ0aWr2sM5n9V9wVAXFal23qLzH7N3ME2vP
        rLGTRguoSA2LZ5YA7vnTLlbnipu7UHAhM6PvXwXYUtTpsJwhL8iyUsv9MrCwcQsV
        RjynbEypKjxhTw8DUaHyRQ9Oeuygg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lCMHG/j4cmAj28uID
        cx7ix7FFgOPzX7RkPDTQoqeNgA=; b=IIMb3DsmUJ3oHEktCf/JS5HmYEMzt9P/A
        tjGJgqOWrxbevBFJAiXT8qiPPZf+ecjelS70TNd4OGplfQYHG69lLCFdZJj1ahWl
        hO2+IFtXjxQCo6s/gyGWvUeDZ8GrOz76eBirbovuWLmH6LNGHiJM54cOKgShYboq
        0c6NA4PMPutS+JdmUz3wV1WMfir+lsSAGLtYayZExoNSXu0A/ZOj+VDoY6/NBDbv
        orcS7EbxA6lDw8hNRJc2PdZIj6hLDoBJG0EcTbAJB++X7QVXREhFvNM4dIjF0POu
        H8RzvP672HHx9tIK08W7NJRQkZQoBgNBqfSnhG86UBghTw8QgaPJA==
X-ME-Proxy: <xmx:evdsW-Phsl31uD34UqFwi9irE7XuihngzUx_DTMIMcwSLriBtZ8U2A>
    <xmx:evdsW7kTECRaU7S8lW7QeR7WEMovpx7FznviT4i6yx8BLOcfWYR3Jw>
    <xmx:evdsW04r163k7WqOiNIGU48iLCsTfubgXfvXOyDWyBsAh-ZMyGR_Dw>
    <xmx:evdsW07l9mUNWt6UYeteR70ObRjn_KrFmLm548pZNADukBla04XWBQ>
    <xmx:evdsW7tNsnNcccSZZJTx2FrrJgYsoSMCtuvPn2hLkV2r6YgVIRPlqQ>
    <xmx:evdsW7bWirRqBI53yQLtPUviXZyoFmSQZZGBuEdGbx_B4srFGWhOBQ>
X-ME-Sender: <xms:evdsW1j6iHAQPIh0qUkujScQuzYRjxYWvbsYGG2fymmMvFo5Vck0Xg>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1209B10273;
        Thu,  9 Aug 2018 22:24:57 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Convert filter.txt to RST
Date:   Fri, 10 Aug 2018 12:24:46 +1000
Message-Id: <20180810022450.1237-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp_filter.rst change removed from set, leaving CC list same as v1
for continuity.

Hi,

This is my latest attempt at converting Documentation/filter.txt to RST
format.  This version removes the SPDX licence identifiers added in the
previous version.

This work has gotten a bit mixed up; for reference this set is a
progression of the follow sets (newest set last)

 1. [PATCH bpf-next 00/13] docs: Convert BPF filter.txt to RST
 2. [RFC bpf-next 0/3] docs: Convert filter.txt to RST
 3. [RFC bpf-next v2 0/3] docs: Convert filter.txt to RST
 4. [PATCH bpf-next 0/4] Convert filter.txt to RST

As discussed on LKML this set does all the conversion in a single
patch.

Please note this set adds three files to the MAINTAINERS file for the
BPF maintainers.


thanks,
Tobin.

v2:
 - Remove SPDX licence identifiers
 - Update old intree references to filter.txt


Tobin C. Harding (4):
  docs: net: Fix various minor typos
  docs: Separate and convert filter.txt to RST
  docs: Judiciously use double ticks
  docs: Remove filter.txt from the tree

 Documentation/bpf/index.rst                   |   15 +-
 Documentation/networking/00-INDEX             |    2 -
 Documentation/networking/filter.txt           | 1476 -----------------
 Documentation/networking/packet_mmap.txt      |    2 +-
 Documentation/userspace-api/cBPF.rst          |  430 +++++
 Documentation/userspace-api/eBPF.rst          | 1004 +++++++++++
 Documentation/userspace-api/index.rst         |    3 +
 .../userspace-api/seccomp_filter.rst          |    9 +
 Documentation/userspace-api/socket_filter.rst |  181 ++
 MAINTAINERS                                   |    4 +-
 tools/bpf/bpf_asm.c                           |    6 +-
 tools/bpf/bpf_dbg.c                           |    9 +-
 12 files changed, 1653 insertions(+), 1488 deletions(-)
 delete mode 100644 Documentation/networking/filter.txt
 create mode 100644 Documentation/userspace-api/cBPF.rst
 create mode 100644 Documentation/userspace-api/eBPF.rst
 create mode 100644 Documentation/userspace-api/socket_filter.rst

-- 
2.17.1

