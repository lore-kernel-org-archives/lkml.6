Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BBEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1372083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGzk4Nc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1372083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeHaCkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44346 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaCkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id q127-v6so8553914ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rwg3Wa/c+I0slJQi39Rh66Z6GhyqNi3wNbH/a6Rd8S4=;
        b=OGzk4Nc8lc6Pgzzz+Uo/HRiGg/8bX82dvxLBvez4yd0JEfLLyKRNx0RGac7rkh8Hx+
         jU4a0EH1Lf1G3RN5tkUvs8McViFs3IbsMEU40YihzbCdzruDAPnVwd68rdXe7/RBp7ll
         YUEkuCJGZM1YGo0o6ybT8DOa6RhNCEegC/gmTfLFx4cihpWgfW4jgOYb7aOr0TDqyPCy
         cZ/zGzmo/0RCvrr/mMG0sNCBRmdOaBFfDc68VchmZ9vJqYPohIXyXDmf0MYKj1cE3RDm
         E/3Gk1Wl+sCwZ9lqbjgMm/TT9QU2cBHDtKLKOOmwBk7si0OG7uI9LQhW7NHo7DgLS8Hg
         OgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rwg3Wa/c+I0slJQi39Rh66Z6GhyqNi3wNbH/a6Rd8S4=;
        b=OiSsKb7nK01Lb9N8+28GNaMD+/cJKf7GBn0+OHk8n4xr/IqfkDLy70YaHBF3x8N+Ak
         nGwn9kD+4PtjXZOZQKu01ERMJ411w7gbBluO4TCCS2YHnt2UMcnZFNKqaSc9P0+xX/xd
         BpxqotRJiTnD8zHyf4bLc0piWwPc4x74eFz8uQJrdWgZLBqgP6XOuzRbtUqxyaZf3PYS
         GsGRmCaJx6WJoRf9clQv1Kfsxa62WngnuD4JDSAcOJ1t6rispiic7uJuEdT7NnO8EmOW
         yWMg7olhlvzLaBCPyY3YeJy74Vyeb82c+CI230cHnDmKV0q2ekqpvp80sflS308NLEPP
         qOUA==
X-Gm-Message-State: APzg51DHyaQdutQyLhV6FXtqS3M6KXaxTiJyPiz9ODtAcIJG3r0exJY6
        lUjfwxPhiY07t4bNhtYkZ9o7HvBdl30=
X-Google-Smtp-Source: ANB0VdbO50YuMvU1irZ58+OumPMadkl+zR0xvTAHfj7Y/mXvveVlQvgqIcfHg1qggLCwy+TJ2OW8KQ==
X-Received: by 2002:a2e:1517:: with SMTP id s23-v6mr8939043ljd.73.1535668541050;
        Thu, 30 Aug 2018 15:35:41 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:40 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 13/23] freescale: ethernet: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:19 +0300
Message-Id: <20180830223429.30051-14-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both WARN_ON() and WARN_ONCE() already contain an unlikely(), so it's not
necessary to wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 65a22cd9aef2..783134f1b779 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1280,7 +1280,7 @@ static int dpaa_bman_release(const struct dpaa_bp *dpaa_bp,
 
 	err = bman_release(dpaa_bp->pool, bmb, cnt);
 	/* Should never occur, address anyway to avoid leaking the buffers */
-	if (unlikely(WARN_ON(err)) && dpaa_bp->free_buf_cb)
+	if (WARN_ON(err) && dpaa_bp->free_buf_cb)
 		while (cnt-- > 0)
 			dpaa_bp->free_buf_cb(dpaa_bp, &bmb[cnt]);
 
@@ -1704,10 +1704,8 @@ static struct sk_buff *contig_fd_to_skb(const struct dpaa_priv *priv,
 
 	skb = build_skb(vaddr, dpaa_bp->size +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (unlikely(!skb)) {
-		WARN_ONCE(1, "Build skb failure on Rx\n");
+	if (WARN_ONCE(!skb, "Build skb failure on Rx\n"))
 		goto free_buffer;
-	}
 	WARN_ON(fd_off != priv->rx_headroom);
 	skb_reserve(skb, fd_off);
 	skb_put(skb, qm_fd_get_length(fd));
@@ -1770,7 +1768,7 @@ static struct sk_buff *sg_fd_to_skb(const struct dpaa_priv *priv,
 			sz = dpaa_bp->size +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 			skb = build_skb(sg_vaddr, sz);
-			if (WARN_ON(unlikely(!skb)))
+			if (WARN_ON(!skb))
 				goto free_buffers;
 
 			skb->ip_summed = rx_csum_offload(priv, fd);
-- 
2.17.1

