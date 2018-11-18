Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09526C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C700F20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sElgiw+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C700F20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeKSAi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37218 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKSAi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so15080725wru.4;
        Sun, 18 Nov 2018 06:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oGuO4g5d4BywTnSWFeiSH0OPNxp/zYl7PCyVPQHD8Yk=;
        b=sElgiw+hYJBO0PQjhcVYNlAGxyhgXBSR7WiYFdMLsvlqK58H/fJpY8jKVD6U5SqR88
         IkPgmL/m9qXuwAhdPa2E8wkHH2pM/QffmRJvkV8nP1bq+BPG/gN41gVeNz4wNnM6q/EE
         9v5h2xtaaJizv9S8qOrTe5TpYwOy8gNfWFIs8V9MpGAphLWnJbtAF9dNmfE6K80GJmW/
         Ac4oyuxJk1x11ksjB/j14WDZzdSiIF8NannGCgRRZhfRNi52QvMwyIbm7R/NRxgEO21g
         QJ1P3Eyjs/UAD0M5PkMwjtBbMmfrEf7PsCaLqXfRSlXfgnweX6LpYGxXe0IDmPPGe6GW
         WQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oGuO4g5d4BywTnSWFeiSH0OPNxp/zYl7PCyVPQHD8Yk=;
        b=QXvGAobcxppQvTuy6xn+wJbwtvJMUn6aMI2mOxgb3mbv3hb7jRGgOrH52WqVLtg52h
         womXGEstKsBNnFJUJCZzOjoThp6p12TSoaxdFByI0SVuw8MS8Ae8rt6oA4d8rmyCBfyO
         fb9wnGoM61UcQJSZBHZiOydAAw6ket6jLRaNeQDdT+aF0+hi9tJMShyJsaW4CfGadPTH
         u3MNPcEKM8NtOziEdx0stih9s9MV1L5KXXMwySqjtDb0r3Jci+TKkXw0rlcfAq7t8wag
         WU0KeFo1qMToF+GqS4DoNUdlgI98iPxThAAoSBLa4ccOXxvNrSYl27tdvQgKNwC5dJvk
         2IKg==
X-Gm-Message-State: AA+aEWZwVr56y4PVWb7SuY1G7vsYeuRYYaignxR9RyPB85U5Qbqu26Uq
        tFmjt4e6qDOOXm0k4HwgeLwr4qrwfgk=
X-Google-Smtp-Source: AFSGD/UiZb28HJFBCaBxFmvxj87YRZJRXFPZ2ob5bOSngZaTCMSzkM6/d/ZiAXMYnhXwTt+McL2dkw==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr12730881wrr.329.1542550709892;
        Sun, 18 Nov 2018 06:18:29 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:29 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v2 07/14] clocksource: sun4i: add a compatible for suniv
Date:   Sun, 18 Nov 2018 17:17:06 +0300
Message-Id: <9edf969f763ecb7433a9d56adfc36cf8a0ec998d.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/clocksource/sun4i_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6e0180a..6b57187 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -218,3 +218,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4

