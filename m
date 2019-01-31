Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A32AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB2420870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="aBL9xFVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6jiDaD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfAaELI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:11:08 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34865 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731290AbfAaELG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:11:06 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EC38C21E8C;
        Wed, 30 Jan 2019 23:11:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Jan 2019 23:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=aC7B1MclzAxY5
        cAw7rCoiRc+tqKP2Rf1XdmtonaI+7U=; b=aBL9xFVheOpszgdbPF39BdpiKaT/r
        RQKUB3uQG12e5tDoH0yUAbt+0WN1wS8SqcQLnyiDZFqXkWQqya/nVLoG/wj0M9+q
        O3KjGlbDeq2hw0Dg7eN2wrHYgspIzw0P62BcK68aWVqozbFwBbPpbPKjwHzAVa7Q
        W7oL/Muc/Pl7An05zo8YWEWAWimb1wpgzQIVy+dRkBVPRSb8VHC7bnfB7PHKeiD+
        6jZMNzwbpCVRwp/O2ZDTUF23fYuU7GaV6r8URUtUJJRRaoAnAIgBKY5nGc0TlMD2
        p7CWEiu8vu0+3cf1/L0nXPxpyRjYIxijVb8YEDXq8UAwAvgK2us07tFxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=aC7B1MclzAxY5cAw7rCoiRc+tqKP2Rf1XdmtonaI+7U=; b=l6jiDaD0
        F7Y9RiiCtMZqEGMNxrKY5v0tuw9uuh+Onj7mqJPo56BLO/btAu6VHJtVVFDLyPDK
        fMf6cJYyjwBkAWohm1tweSyc/oGmU1Tup6guD6IUTmQMCFrbNrppM3S7jy8ClIlG
        NqIrNpWsOXh+G4W74xnp+60x4PDHT1RyBMIMoGzsdhbu+WNBBQLOVfSrhA9nLmat
        zS9HN/pzB4VZkXB5vGVzkzdgZoymtznulSj0EEUu04srWsCwJWGcqwkfwoijYR91
        6i0NvrWlKAfkH2I/5BnYZzB7CoaAakblXh1lggJMLQ0eNrWIFSBNeuCaNkcEQfPt
        SnCvo2mQQVO99Q==
X-ME-Sender: <xms:WXVSXHO-aigguOVq1LAuoWe72ShGuBDzk6S2-sOI0Hb6hurZ2UDu9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppeduud
    ekrddvuddurddvudefrdduvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthho
    sghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:WXVSXCnZdcnMomshsaQT1fJ8s7qoUwWnbdFDxH2hqoCLyk4YF9afag>
    <xmx:WXVSXBYcpr79GTs9V44RGHdaK8xfIxLsZltRnG1Oo3QxGrkRgBoJcQ>
    <xmx:WXVSXATE6Hyhg-Yu_4HB52C245qZEXvbBoi3YQ_gbfLlwyM9wJVxHw>
    <xmx:WXVSXD6jd8LqDrs1Mth-JwwhYptl3gNhtdMfWW-Ubf7bP7nrFtPmuw>
Received: from eros.localdomain (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id E89C410310;
        Wed, 30 Jan 2019 23:11:02 -0500 (EST)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] slub: Capitialize comment string
Date:   Thu, 31 Jan 2019 15:10:02 +1100
Message-Id: <20190131041003.15772-3-me@tobin.cc>
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

SLUB include file has particularly clean comments, one comment string is
holding us back.

Capitialize comment string.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slub_def.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 201a635be846..d12d0e9300f5 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -110,7 +110,7 @@ struct kmem_cache {
 #endif
 #ifdef CONFIG_MEMCG
 	struct memcg_cache_params memcg_params;
-	/* for propagation, maximum size of a stored attr */
+	/* For propagation, maximum size of a stored attr */
 	unsigned int max_attr_size;
 #ifdef CONFIG_SYSFS
 	struct kset *memcg_kset;
-- 
2.20.1

