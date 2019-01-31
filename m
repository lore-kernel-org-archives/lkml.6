Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCBFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472620870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gFuf3Z/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrSMkMyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfAaELB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:11:01 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39489 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfAaELB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:11:01 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 208EF22585;
        Wed, 30 Jan 2019 23:11:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Jan 2019 23:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=UCPkQVr58oLjGKAE0TNmYYJbUl
        DgbRTbB4YKF6U2JnA=; b=gFuf3Z/OkS09yKXYlsAL/7W5VvjtfwJx5QhImbobuV
        uucHzHst4AJBV4XxkEheCsM+jFuS/cwgYs8g5Y+NFFzTT+bNdSc4oBNzfGnM9GW7
        aUxappBvuXi9KDI0rLCuilDxwUPGhOv0gIehJUU5eYfxphS9CcnMM3Mj2nvmYCV9
        Lhzppuh2Ez5Q7xZmKZWLnFWS4norG5vCo4GBmYutma74UyWUOqGc9Sg4qeSgM/wf
        E88MKB+VhNahAa5e9T/Xk+/SLQ9KGBiww2nhD9CQhdIt54Lm4XkDJFLyCd6xlNPs
        /xeZ3Yy6OcrQSheIP0ZVIiAkNrSWrT/sC+UJFz2sMsrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UCPkQVr58oLjGKAE0
        TNmYYJbUlDgbRTbB4YKF6U2JnA=; b=DrSMkMyrNG5tH5JX+piTsczKXPR3huzxL
        GPxt4KA12q2BCTuQbtsJdlV9irAmS/kZqMWur/J0/6ccExCncAZI49ot22AGoNhX
        dxxzK/O6hJyTXI9HcRfl7UEGQgEuj43kNfyuSHJVsy3+/de23hFRW+Q4+Ug8R+4B
        MD/7LgySm0Ehlf0G1EaYCov4AgVKr2Oi3/cS3W+19dKqUDpT0BaakM7HTPry36KX
        C0JnS3zzjal3/kIGczDRC9hRgefDl4JEkES1kMa27yKSBIgMlpU2nXUIz/LTaFwu
        am04Mv+rTPio96KhefOhenLED65XEwVTuIvdjOyI8spQKWl5DwhZw==
X-ME-Sender: <xms:UnVSXDZEai83HuG2-YWxKjXNJ_H9q4apiM8LgwJo4dSERK8baxSmlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduudekrd
    dvuddurddvudefrdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghi
    nhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:UnVSXCmFmJMIA5Q9or5w2LDdZNcjMGovSRYUeSv6fRTr9U0M4X5MPw>
    <xmx:UnVSXHzROVf0f5QK0uYMTpXytrPXUholVXOUc4dq2kH2VgetZ7vqlw>
    <xmx:UnVSXIMX6qVPPhTAHzmk3JXWk0V_EPjVoZXGRciDvG-yOgBPhTHo_g>
    <xmx:VHVSXEjz5bNjAMoieimHsxDNY4KdScwjArov4wcgFiffEuWJljh_0Q>
Received: from eros.localdomain (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id DCB7910086;
        Wed, 30 Jan 2019 23:10:55 -0500 (EST)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] slub: Do trivial comments fixes
Date:   Thu, 31 Jan 2019 15:10:00 +1100
Message-Id: <20190131041003.15772-1-me@tobin.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>

Hi Christopher,

Here is a trivial patchset to wet my toes. This is my first patchset to
mm, if there are some mm specific nuances in relation to when in the dev
cycle (if ever) that minor (*cough* trivial) pathsets are acceptable
please say so

This patchset fixes comments strings in the SLUB subsystem.

As per discussion at LCA I am working on getting my head around the SLUB
allocator.  If you specifically do *not* want me to do minor clean up
while I'm reading please say so, I will not be offended.

thanks,
Tobin.


Tobin C. Harding (3):
  slub: Fix comment spelling mistake
  slub: Capitialize comment string
  slub: Use C89 comment style

 include/linux/slub_def.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.20.1

