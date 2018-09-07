Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93070C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFED2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/qODpBB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFED2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbeIGWFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:05:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39434 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbeIGWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:05:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id v77-v6so12643313lfa.6;
        Fri, 07 Sep 2018 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0XuIO/jwwbkrA/dGaqPCq8DyOayB0G1pbKNSu+Mm5vo=;
        b=N/qODpBBscn+KPIBg8H4O3hiHNYFrxGYMjmle1pXYypNs8hkbwlUPsZ+txTWwmcb6O
         yYrLNa8WMvtyzkpHWe+31V58zyDvD4OkU8bD5GhmFkuNGBFI4RfDFnsuirrz+Ncpvm7g
         Clv82UCAYBsoOF+YoDgE9I0EcbwaXPfDLOdQWSgkkxAcWbr/91FzXbWE7sGP+mc2zQcd
         BIR3EsgrfkF6U5T8S47eAoK2nOeauwiJiff2QGlxRgIlcmprwxZIZXhxp90xY7/Ck7/F
         ZcdNgl6I4eagNWYuUgwjbfttZKUuDEJwwQ4tHzLzP06fdajfA2BhInlKgp9bMZTvw51q
         L8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0XuIO/jwwbkrA/dGaqPCq8DyOayB0G1pbKNSu+Mm5vo=;
        b=uJ9IGHGClFVxyoRXdQweAPuuiY5lUaa5IZg8sdI2jcKLPzwfjzN6vX4Q2B6fYF4rJ6
         w3HMYaNZKkT1ScJNuMw0qqz9nuTCYFs5lCSOfUoCBOTpC91DEDuo6vDHEhjDhz0tHFNx
         zalvWbFbtyrmkQ0IuGpqDkMyn8qn9A78fRrwAgCXDL/dJrzoOceSlVznFjk7gkRbaBIy
         UyHDOZ0q+kAqmGSZF4C1+ptCkx0zjlIBiVjkFxBg80u9/0zBRFwQnwDpZtbYnkIihS/M
         P7wcuiaG8OeypTYBv36p52kWQwukh9kaUSlIN2YyyethpCWHSBaWzzSSoeBgWEWMwgd8
         Cq7w==
X-Gm-Message-State: APzg51DRnGnFe5tZuEmHaxhKztB+jepQJDkkg4qklgE6gixSyWEQY8kW
        Bc//XdtbaSsqSv3Y8x2SMnI=
X-Google-Smtp-Source: ANB0VdZmTzeqCoBlJpspr0y7MJkx0B9TlOl+3giiWuJHRkdYco7QY8cNyklaMGcXQB299ZjG48/ylw==
X-Received: by 2002:a19:9e85:: with SMTP id h127-v6mr5505067lfe.89.1536341006505;
        Fri, 07 Sep 2018 10:23:26 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id q16-v6sm1377686ljj.68.2018.09.07.10.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:23:25 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Madalin Bucur <madalin.bucur@nxp.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] freescale: ethernet: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 20:23:18 +0300
Message-Id: <20180907172318.29014-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both WARN_ON() and WARN_ONCE() already contain an unlikely(), so it's not
necessary to wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Madalin Bucur <madalin.bucur@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
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

