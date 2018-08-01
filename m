Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B9920841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="QYbYcKct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTKnKYo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B9920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbeHAGxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:53:13 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48651 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732959AbeHAGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:53:13 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 8A656578;
        Wed,  1 Aug 2018 01:09:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 Aug 2018 01:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=D+lfbyy0jxMvtFJI4j2O4hkLvJJLz6se8+bfYSiRo
        Ys=; b=QYbYcKctkzbvJbHY4sAToURm6mSzsa5tO91D4gEAA7kdbhwkDHeSV9/KJ
        8spwx2DoQiVNMd8nLSMZcn362fX9Q3Il5mns1hkpKHP2trAvkv5mGNPGDb9z556G
        Jc51cfO28SAZE4LzVRvF6PM2oc4A+VPKTneOq5d9W77LBZpLD0hUOYR+g5bojQVT
        LsB9g8/5FtJ4YDfoJ4LrwVurQr+cOsuHkNEcXCOm9bYh3rRVyRlw5MEuIbM1bgEB
        p8XGeYxcPNUHnPeheuNBVycXjEMgqal3ed3j9JCq5n2cKYwb21246IlaCuSOX15G
        DCVaD547J0xjBRzSWkLuqL8f6JGsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=D+lfbyy0jxMvtFJI4
        j2O4hkLvJJLz6se8+bfYSiRoYs=; b=dTKnKYo9WolJa1nkAHa42ptsAjhzjerSP
        3o7Guhk0ywv483ryXAjqLMFaZDSJ0B/VpHpX7Nm2NqybNCJS02PZkIT0rOgDDuD8
        MNZ1gcBWPDh0PkiuxsHt0/CvBnvhkgt5ckpVwYrO4suQf4Vkjs0zjRMklneiPR7H
        D5/Rg4TC0/yOX7bvt1yJvu+PIR9RNJ0SgJRCF2nrjKOvkmXQshoJVvkwIJgxaeUD
        KH/t3g/irHGk/Wfedov0Hs6dBNJZuUjfkNTzb9KZCqKBohZzwhcj6cZYUIP7MM+B
        Hqlg891TwuO+bi7lrw+Ym4T1Nrl33k8bwo98Ae5LDm1X0XEdJJVqg==
X-ME-Proxy: <xmx:hUBhWzR7uR1stL82XOjWeC0m9mnlyDf92BOLQJTJhhOC32Uuqz0Pig>
    <xmx:hUBhW5XAFdtW3R3I2Rh_CqPiwS3oBJQ0jjbcHK_CFQCMj7N-WpoWLQ>
    <xmx:hUBhW19dhdNcZ-2e6-1mDQVCC0y6m-m8IUivQZzwAYsDsKNg87-KIQ>
    <xmx:hUBhW52s-5ky-r2HsoyPzg9BBIYkuNzrg1SSfk0HgB4t618_hG7L7g>
    <xmx:hUBhW6ehLnvJpgBiAjFzA5M2UW0vbZupP0yTl6q2asEl0p0m6U2uEA>
    <xmx:hkBhW5zZ0X0IFLppJ8eyohW5_dzHY2hcbgeV-4IhrB-i1RjQ5P6Jbw>
X-ME-Sender: <xms:hUBhW0ReiuRArlgSr9hq-9qZtwW3mMwLdGeXV4scLZdpcQd1TCy3aA>
Received: from localhost (124-169-17-12.dyn.iinet.net.au [124.169.17.12])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9889E4621;
        Wed,  1 Aug 2018 01:09:24 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 00/13] docs: Convert BPF filter.txt to RST
Date:   Wed,  1 Aug 2018 15:08:55 +1000
Message-Id: <20180801050908.29970-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sending this to BPF maintainers.  Recent patch set to Documentation/bpf
went through bpf tree so I'm guessing this one will too.  I rekon there
will be less merge conflicts through your tree.  I do not know exactly
the path for docs into the mainline or who fixes up merge conflicts
though so if this is better done another way please say so.

Patch set applies on top of bpf-next commit: ("2e96187b6967 Merge branch
'bpf-docs-rst-improvements'")


Use of --subject-prefix='PATCH bpf-next' was a guess.

While doing the final read over of this set I realised that perhaps we
should have just moved this file to Documentation/bpf?

Anyways, here is the conversion of filter.txt to filter.rst split up
into a bunch of patches to ease review.  I failed to fully grok the
contents of this file so there may be mistakes in the 'Fix various
minor tyos' patch.

Also the diff looks like it contains spurious whitespace changes in
places, I think this is when spaces have been replaced by tabs.  I'm
guessing you guys are experienced at reading patches so can tell this
already - it took me a bit of thinking :)

Some of the formatting for code snippets is subjective, if you'd like me
to change it please say so.  In particular I added a line of whitespace
before error output in a bunch of the snippets.  Also indented slightly
differently to the original so it looks okay in HTML.  I did not check
any other rendered format.

thanks,
Tobin.


Tobin C. Harding (13):
  docs: net: Rename filter.txt to filter.rst
  docs: Update references to filter.rst
  docs: net: Add filter to index toctree
  docs: net: Use correct heading adornments
  docs: net: Fix indentation issues for code snippets
  docs: net: Remove non-standard identifiers
  docs: net: Use double ticks instead of single quote
  docs: net: Use double ticks instead of single tick
  docs: net: Use lowercase 'k' for kernel
  docs: net: Embed reference to seccomp_filter
  docs: net: Use correct RST list construct
  docs: net: Fix various minor typos
  docs: net: Fix authors list to render as a list

 Documentation/bpf/index.rst                   |    9 +-
 Documentation/networking/00-INDEX             |    2 -
 .../networking/{filter.txt => filter.rst}     | 1007 +++++++++--------
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/packet_mmap.txt      |    2 +-
 .../userspace-api/seccomp_filter.rst          |    2 +
 MAINTAINERS                                   |    2 +-
 tools/bpf/bpf_asm.c                           |    2 +-
 tools/bpf/bpf_dbg.c                           |    2 +-
 9 files changed, 545 insertions(+), 484 deletions(-)
 rename Documentation/networking/{filter.txt => filter.rst} (69%)

-- 
2.17.1

