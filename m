Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA89C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0BC218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXfWORWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfB0GKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:10:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37470 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfB0GKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:10:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so7422056pgq.4;
        Tue, 26 Feb 2019 22:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwPZTTJhOjhmg5Olt2ccmRwKHWb54IUUO9/OTxRsJz4=;
        b=hXfWORWHZvE52X6lBQJlHJqYc9wSaNwRc8qKOJbNgfzlpzRyOqp9XTsyvSVT3NocdN
         AJn5xect5gl3qVy3OpWVdbJ+ZvwgH3KRFsHWsthrlJthkskadjqz+LhNNRKuK8BKVqlP
         EnjyhxOM/IKGEVkap8xvBRVTvoabYUYO8GLfmGR61DJyrU0ub3prWYduoexPaylmNk/E
         MZ221jCXVyQh88cG+2Qc+jXv9VrK2UDL7Uvs8mh8bYwK419lDds10Pkgr92hG86Y+1AF
         z4JUCPv+ExbsJFHM7NOEAz3u+Iu7NtwlIzi3wz64x32rjryj6JSPZH8u+kUrTQbi/Ahj
         AN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwPZTTJhOjhmg5Olt2ccmRwKHWb54IUUO9/OTxRsJz4=;
        b=dcoGN74lnQbQQ91dXmcxbpvhe3f8uObrYfvXAVewgk6aABo69lK2xViP/8jph2nhfT
         akSyxq3izv2M3b1SHy/bXpLJPiWVjMTqYg7HLfbcIuUBxyx5o+nhHpBRZZiKX5Y+vf1D
         DQnslJgFB+IP+6xcWjqJUdGYm48n/o6w4M0MUYV+hSmQ2BPLY8Sgp29PfabU3b4PdNDq
         cmaFlZyWgj1Ei0sWv7RbOdugYKJZSQQqhhhJSn4Q8bWNLN5YjFVWSzueESDcp18NYEfx
         aIA7B2fsMfPaYrgWWX5fAhuKUEMX26nqZVNGABNsPbTcLd/i5qhDIOl62OvK68OpsKdB
         /+JA==
X-Gm-Message-State: AHQUAuaDU9NlG9wFEv+7WjZyKgUGOgRyJfHMId4gZjtPEVPdh5MagD+r
        WTVSBqIWCEvluvydxkuvUdj5gz2jxsE=
X-Google-Smtp-Source: AHgI3Ia0+CalR1Ta2ezpOyBlwza0hrhgJ2SMpU2FkMX0GKi262Mk1/qiyxpZmdhsGNMoqUk0QA6nOw==
X-Received: by 2002:aa7:9286:: with SMTP id j6mr2608pfa.47.1551247812775;
        Tue, 26 Feb 2019 22:10:12 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:10:12 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] net/mlx4: use kzalloc instead of kmalloc
Date:   Tue, 26 Feb 2019 22:09:56 -0800
Message-Id: <b350ebb5410291e80e12244ccb41b4b4bae31e0c.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces a kmalloc/memset(,0) call with a call to kzalloc.
It also removes a memset(,0) call that always follows a *zalloc call.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/cmd.c   | 1 -
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index e65bc3c95630..7bfa6e850e5f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -3307,7 +3307,6 @@ int mlx4_get_counter_stats(struct mlx4_dev *dev, int counter_index,
 	if (IS_ERR(mailbox))
 		return PTR_ERR(mailbox);
 
-	memset(mailbox->buf, 0, sizeof(struct mlx4_counter));
 	if_stat_in_mod = counter_index;
 	if (reset)
 		if_stat_in_mod |= MLX4_QUERY_IF_STAT_RESET;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 9a0881cb7f51..f55805d206ef 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -1044,7 +1044,7 @@ static int mlx4_en_config_rss_qp(struct mlx4_en_priv *priv, int qpn,
 	struct mlx4_qp_context *context;
 	int err = 0;
 
-	context = kmalloc(sizeof(*context), GFP_KERNEL);
+	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
@@ -1055,7 +1055,6 @@ static int mlx4_en_config_rss_qp(struct mlx4_en_priv *priv, int qpn,
 	}
 	qp->event = mlx4_en_sqp_event;
 
-	memset(context, 0, sizeof(*context));
 	mlx4_en_fill_qp_context(priv, ring->actual_size, ring->stride, 0, 0,
 				qpn, ring->cqn, -1, context);
 	context->db_rec_addr = cpu_to_be64(ring->wqres.db.dma);
-- 
2.20.1

