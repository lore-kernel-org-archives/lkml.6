Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795120883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="X011wR5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ds7nlQI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E795120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeGZGSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:18:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50597 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbeGZGSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:18:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EC4E921F6A;
        Thu, 26 Jul 2018 01:03:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=rxss1xBQnplQmD7ndHooT2XN83D0mPn4xVaEh8xnX
        3I=; b=X011wR5vFVR0+pj3oFAqZ2d/Udi2RiO5uPabjuCq8YGnhiMvfTJFEWkDu
        XWCowHq3R73GjQxu18BBbj1h1blORcvtl8pzS66hRszNVxgdcxp6A3vcN68w8HEu
        k/G4Z0GwDUSBfimFm3iltX/p2iubR0+1TfqFu0ePcI9LelzYtjReWyLcRt6GpxM6
        e6vg9/ZFm3vFrJjwvwFPjdU4oa8T0PokAPxx7SEkXr48bKMCr7oNB/1rmWp5+lT/
        Roenbxtn73kmFaXUfGH1g9rw4vc0mVMl/QVIoobdcAH7l/zb7ho+iHIqOGET19b3
        V4OdkUklqaJWVwXTaMeihTnqrrOWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rxss1xBQnplQmD7nd
        HooT2XN83D0mPn4xVaEh8xnX3I=; b=Ds7nlQI7BFEOALrWd41LF++ZOsjCR6Etg
        PkXhGySnU9ZUfnZKHOMi8ZSYthU+IE/3/LRnorQTSXX72skHa/SVC+sTz9aKSvKu
        /vi1roUwZmBOAwchiRmpvxlxih3FOvRCvhfPdkyInPJxXAxgjJe9Ra2elKcUlir8
        YfSFK/OZDacxfTs/Z+aEL5pIbinq6x+x6qh7y8z5WUatAFbWliHsS1iGLKwcakj5
        y2GdJhlmQmt0c9c0M6YqS8wP/NUiEGaGxPR+nlth1uHwl5H6ye9lmLT7QdP7hyGm
        3AkMWXkm5Xiq+6UgRCMIztd2hp/Qn4hM0yP2vrjYuL5IBa3wfk6fA==
X-ME-Proxy: <xmx:EVZZW5APOIuebXO6EYuxpo8k0LjcAhvwsPsOFig0QJQsXitJl9lq5g>
    <xmx:EVZZWyYcllO7bxqBZBVKUkUg47mJuyzjL02uXBQcZFH3VL-SVjSEMg>
    <xmx:EVZZW-xroiyWOK89pDh2SvVr-muNh718yaEJk6TtoRPd6m2uvZsgfA>
    <xmx:EVZZW1c5rePpLB86p1qhM_pcD_kOmerewEJuIFr63l1ObVgjnDHPgA>
    <xmx:EVZZW0ISshwyldgTDYWP-4g9gQ6k9fGUiKNyoVasm7Rwex21pEYMXw>
    <xmx:EVZZWypOllFJWO3CReAdcThjHhgrRU8ff7uMrbyGESWehkWJ5G0H4g>
X-ME-Sender: <xms:EVZZWzg2Zifn21ihOJqs-f_TAjmZ8-YbiKiedq9Y0lx8qZ3CF5drQw>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2EB01026C;
        Thu, 26 Jul 2018 01:03:12 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] docs: bpf: Fix RST conversion
Date:   Thu, 26 Jul 2018 15:03:01 +1000
Message-Id: <20180726050305.2147-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I'm sending v2 of this to you instead of to Jon.  Rationale: BPF is to
do with networking anyways and there is a broken link that requires
conversion of Documentation/networking/filter.txt to fix and that will
go to you.  FTR there are no merge conflicts between this set and the
other set I just sent (either can be applied on top of the other)

   [PATCH v2 net-next 0/3] docs: net: Convert netdev-FAQ to RST


Recently BPF docs were converted to RST format.  A couple of things were
missed.

 - Use 'index.rst' instead of 'README.rst'.  Although README.rst will
   work just fine it is more typical to keep the subdirectory indices
   in a file called 'index.rst'.

 - Integrate files Documentation/bpf/*.rst into build system using
   toctree in Documentation/bpf/index.rst

 - Include bpf/index in top level toctree so bpf is indexed in the main
   kernel docs.

 - Make anal change to heading format (inline with rest of Documentation/).


thanks,
Tobin.

v2:
 - Fix typo in commit log s/us/use (thanks Sergei)


Tobin C. Harding (4):
  docs: bpf: Rename README.rst to index.rst
  docs: bpf: Add toctree to index
  docs: Add bpf/index to top level index
  docs: bpf: Capitalise document heading

 Documentation/bpf/{README.rst => index.rst} | 10 +++++-----
 Documentation/index.rst                     |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)
 rename Documentation/bpf/{README.rst => index.rst} (82%)

-- 
2.17.1

