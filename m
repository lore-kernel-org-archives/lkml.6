Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B401C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471FE217B9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+FAA2Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471FE217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeHMGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:06:13 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39396 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeHMGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:06:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so6327766plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 20:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=smitzV2APopDrlajmqrNET5vu+gR4RtdSjeAu12yHZ8=;
        b=Q+FAA2BznbSVjbKuhlI6m2Tv9lg27KIaviPRpavR6VECH4kZL1mhKmdUOJ567xay8y
         GBh84Va/Pkjgpfl8XOMTbYvhoLIK1gbuzYExzqnIj7NmbO7MO6muOSYI3M43d3UMcYF6
         TLGaPDBmoaqcd/dJcjn5ydkZNTsG4ffLhrNHzi/dLuqQ/XSaBkKQdnLMoJf0njH8dWU+
         obvY9sdWhxr2xHWCv6lEXr+qeSrtV5KfMP2De/fu6PolzS4Ip2Y2ZiHQerDjg3bWs476
         43eg64opNM4UeyQMRLAAz8Jp5SYQLJRVllMn+0aYKjftgt8RWIUOGt06mWxQ1UAgvBFp
         0uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=smitzV2APopDrlajmqrNET5vu+gR4RtdSjeAu12yHZ8=;
        b=o201cDrXnhs8RGx8sfY+RUi1adnLLaYwOFH3DI7t5UvzzvvpMVcToGLpFBo8siyiye
         whq2PrW6zadpUcgqis2RLdd1pYoQ1OaPpKck0vHQTh9Qq5yKSsdAvb1wp7x+IZQgCwjl
         rvX0CfYatvoWJ5HZlhVAb13WlNN4Lic81hvBgvZL4/ns6dElTgxnZPQEYI2cx9MWTvUO
         HYCrHMrvchFuCwebBixslGNhoiwtbu2LANWjrSeLE7P3DV5w4Q8BT6wNWyVxs7Uts98l
         9oe8aeE5AHBCtsf34J2djmH4T4gczHneE3SoBZXh2kMGMu1w3cA2CrdUQu4D/jlxZLZh
         hozg==
X-Gm-Message-State: AOUpUlG0UYZCejhdmLV+wQMUP8ajVamLzfOd1fA2EF6kjlnnG/iTNV4C
        dGyq0kupFera0tcNeUqyhV8=
X-Google-Smtp-Source: AA+uWPxcT2jG+CI7L7ud/sCftKw3nFZcD288JSUvELZW8gUPZBd881H4R+Ehy26/XFpdgYecKyL4aQ==
X-Received: by 2002:a17:902:988a:: with SMTP id s10-v6mr14848345plp.200.1534130756582;
        Sun, 12 Aug 2018 20:25:56 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:1c12:d766:6865:caf9])
        by smtp.gmail.com with ESMTPSA id v30-v6sm27095721pgn.80.2018.08.12.20.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:25:56 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     dwmw2@infradead.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] fs: jffs2: fix a sleep-in-atomic-context bug in jffs2_alloc_refblock()
Date:   Mon, 13 Aug 2018 11:25:47 +0800
Message-Id: <20180813032547.3156-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spin lock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kmem_cache_alloc(GFP_KERNEL)
fs/jffs2/malloc.c, 188: 
	kmem_cache_alloc in jffs2_alloc_refblock
fs/jffs2/malloc.c, 221: 
	jffs2_alloc_refblock in jffs2_prealloc_raw_node_refs
fs/jffs2/wbuf.c, 164: 
	jffs2_prealloc_raw_node_refs in jffs2_block_refile
fs/jffs2/wbuf.c, 927: 
	jffs2_block_refile in jffs2_flash_writev
fs/jffs2/wbuf.c, 924: 
	spin_lock in jffs2_flash_writev

To fix it, GFP_KERNEL in kmem_cache_alloc() is replaced with GFP_ATOMIC.
	
This is found by my static analysis tool (DSAC).

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 fs/jffs2/malloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
index ce1189793288..66496ef09716 100644
--- a/fs/jffs2/malloc.c
+++ b/fs/jffs2/malloc.c
@@ -185,7 +185,7 @@ static struct jffs2_raw_node_ref *jffs2_alloc_refblock(void)
 {
 	struct jffs2_raw_node_ref *ret;
 
-	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_KERNEL);
+	ret = kmem_cache_alloc(raw_node_ref_slab, GFP_ATOMIC);
 	if (ret) {
 		int i = 0;
 		for (i=0; i < REFS_PER_BLOCK; i++) {
-- 
2.17.0

