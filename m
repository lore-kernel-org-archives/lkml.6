Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554A4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B983218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="uteUYPBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uuzs2ZrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfAaELF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:11:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48803 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfAaELD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:11:03 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CB0E2228A;
        Wed, 30 Jan 2019 23:11:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Jan 2019 23:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=rauvfyZCPbYRm
        jy9jHi8eBrEGRdsrFO1TIKSyFZd+ow=; b=uteUYPBTPIXQO1ResTVzg+2Pjq6OH
        Pnlwo12SM69SmMG7cL/5TRaS4EU/lzAE+ahzwly6mPCZuQ0bqnWfHZaog+Nk7kUA
        J3vkh/EgUsXuBVnWgJMlS/ON6H6UfV829CGeb1gAMMydafVDdFTBamBeCYaUzo3m
        P/nPycsijs79AumMOginoW8oUMD705FUd7kgE6loAg687mg7FaQYp6bxY6fzTSaR
        08UsrRtNKDVrgQrLOVJI9F15xEfJI8JhBW1zc/q1rkt6cxXIUDYRP4KaMFI5PK03
        F/ie1+EceCkyRtZm6DAf/fjgiurcYP7eXkTV277GkzZfIb0LJcRtB4Xhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rauvfyZCPbYRmjy9jHi8eBrEGRdsrFO1TIKSyFZd+ow=; b=uuzs2ZrF
        3TuBy6aaDkOtqdfiLmf+IP8FlyNAGuMZ9ZgSMv/gaYJJpjMehsJ2RJUvc9vYttEN
        3+KWSc4xetWMFRUZSX+4iBBZ3PPBHxvhujvD2iD2vdj1SFvfnJjKGDLq0CQW2XCU
        yyt3ViHQ0U0lBB9Z2QFn/qMdh21WA5BR8SlQ1xgwiGBKbbmz4tbEBGNnlQHw3jD3
        R+ReBDmnj9MMAWTwgvDuB/QBIB8Ud2z5ROLLkrH83FLIrymMNTG1SeFuynm8A2jE
        Jf/oKtoIJ1jMVbKirbZJ1wXivef0wZXemwhTXp5NomiuFtmO4D1c3/cdXe9y7C0s
        4CpH45egLirn4w==
X-ME-Sender: <xms:VnVSXEbHv0EufiqjRAuGZh-OvQHwYiQD3gkUoLJRZlXk95KtoGrWMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduud
    ekrddvuddurddvudefrdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthho
    sghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:VnVSXKbNFCb2fUCd77ph5B4sO9trDHgcO-Z8Hgi40FTqm3B7rEh2UA>
    <xmx:VnVSXFkGbz-Z4nBIXvt4KgqtaIzmFDGioP7zPI6fke0d8E4otvQqFQ>
    <xmx:VnVSXMS7Tskg4hGtS04BC3-f4_mz3OMLO9YET_-qLyljMDhkguZGaA>
    <xmx:VnVSXODPwJ4zYx_6igWkgFhx0l6XwH-PD8Xb2Z5SGVlRv9cGNu6dzA>
Received: from eros.localdomain (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B45810288;
        Wed, 30 Jan 2019 23:10:58 -0500 (EST)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] slub: Fix comment spelling mistake
Date:   Thu, 31 Jan 2019 15:10:01 +1100
Message-Id: <20190131041003.15772-2-me@tobin.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131041003.15772-1-me@tobin.cc>
References: <20190131041003.15772-1-me@tobin.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tobin C. Harding" <tobin@kernel.org>

SLUB include file contains spelling mistake.

Fix up spelling mistake.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 3a1a1dbc6f49..201a635be846 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -81,7 +81,7 @@ struct kmem_cache_order_objects {
  */
 struct kmem_cache {
 	struct kmem_cache_cpu __percpu *cpu_slab;
-	/* Used for retriving partial slabs etc */
+	/* Used for retrieving partial slabs etc */
 	slab_flags_t flags;
 	unsigned long min_partial;
 	unsigned int size;	/* The size of an object including meta data */
-- 
2.20.1

