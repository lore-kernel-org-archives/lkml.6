Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE63C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0707E2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRAQFBbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfBZTgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38665 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfBZTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so6686933pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pI4yPgzZ84XKblQbDTBB4uLpp98dYXickwI7aXAPp7g=;
        b=HRAQFBbF4QmVvGC47md5YX6at4CuD5bSUC49t0NPvv9xLIOzAesexN13K5zTNXn3QH
         LC5tGeX0EhpEGkKRR3oezVqbsUhEv5DwHHMkqfU1nYwo3LV6K+pJitFv+/JKgzmGI5q1
         dQS5bpk1K3a7Gf4B7n8eqkxY0w1fnZeeJtCnSOBEGD4xj9hosg10dKOsn/dCZz/40MMF
         qM5V+HfZ+LamJai8bDXkJ5E9AsLEHBRuLq7vhfKXrTamfgmTVWG0ZeWm9XAe6JztbeaM
         CDIQz34sqdow75da4CtVFuTDZUkuHaozuubUeT6VbifdJKNdX3u0Gw9YjKho0//YzpWW
         SJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pI4yPgzZ84XKblQbDTBB4uLpp98dYXickwI7aXAPp7g=;
        b=TIfUzUm+6Ww0Nr51y+gC3B2Gri9TCcI+FjOk16g664Dbu3tPa4749tTSv8eBCoS6m6
         tFOuQ6jVzbbBeUzGDAXeWsfCJKyJt86aiJHoreYBErz1Ml9VHWHYzwHdfMH8RLiYd/6x
         XbmfL8bQkE0n6j7UIZVlIKwz5hi9YVpJ/UdG5Z+b9bLV45WjUEfoUIPdUJU6Wec/0Kkp
         91+X45PUlnVIdq2NpoZ6hwLuCYA8tovOCJBpcRT0OhxlQ6R269AcStfiy4ace5bFwflC
         F0wuHpm2yIk8f/kyKmc+u7w0v3tbOcDiGBcVEaO7BnsGglMdr4AQtcG5D3QSicYHzCbu
         NZqg==
X-Gm-Message-State: AHQUAuaH2AdX83GZKorn0awYskDRoruyLlz0AO9DsP/pjgea+t7CmT9f
        3Ki11zsvV12JMr38c6s4guQ=
X-Google-Smtp-Source: AHgI3IYUHn9WI8cwRr5hkkvaU/rjwDIGjhsgBcNqz2rVnGfopvyQ6evHFqQtqAd9sXyppS4NO15leA==
X-Received: by 2002:a62:1c94:: with SMTP id c142mr13121004pfc.54.1551209799170;
        Tue, 26 Feb 2019 11:36:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:38 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] drm/bridge: tc358767: Drop tc_read() macro
Date:   Tue, 26 Feb 2019 11:36:09 -0800
Message-Id: <20190226193609.9862-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only one place where tc_read() is used, so it doesn't save us
much. Drop it. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 239b3aaa255d..3c574f1569aa 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -240,12 +240,6 @@ static inline struct tc_data *connector_to_tc(struct drm_connector *c)
 		if (ret)					\
 			goto err;				\
 	} while (0)
-#define tc_read(reg, var)					\
-	do {							\
-		ret = regmap_read(tc->regmap, reg, var);	\
-		if (ret)					\
-			goto err;				\
-	} while (0)
 
 static inline int tc_poll_timeout(struct regmap *map, unsigned int addr,
 				  unsigned int cond_mask,
@@ -337,8 +331,13 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 	if (request == DP_AUX_I2C_READ || request == DP_AUX_NATIVE_READ) {
 		/* Read data */
 		while (i < size) {
-			if ((i % 4) == 0)
-				tc_read(DP0_AUXRDATA(i >> 2), &tmp);
+			if ((i % 4) == 0) {
+				ret = regmap_read(tc->regmap,
+						  DP0_AUXRDATA(i >> 2),
+						  &tmp);
+				if (ret)
+					goto err;
+			}
 			buf[i] = tmp & 0xff;
 			tmp = tmp >> 8;
 			i++;
-- 
2.20.1

