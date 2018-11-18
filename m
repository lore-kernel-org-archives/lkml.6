Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB818C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B56020869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM08RfzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B56020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeKSAjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:39:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52554 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeKSAjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so2816264wmb.2;
        Sun, 18 Nov 2018 06:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOWCmF7nU3ccya4YN9rbWAijBsLEbSVxqe2kT30yoK8=;
        b=gM08RfzRh7oxMGyyvxU7Nb+mwt8uopmtlJcbDXbuw5O/7gun4iV8O8lUXigBvmWwUG
         0X0i3KN44ezJ5kMY2DYzzsu5X6nllr939V3VMBKt6G4oJne+UJ+ixl0aoUYxmpSG9ACW
         ARc6Qeg4AtVM50uJ4/Woaye1d0HqJhhEh8iJdFPnzExh7hlJXG7agEOeVN0+ORbhvqUd
         8iOwOkAkPcMmCEDA4N65wWBJfHApYx6nhTUFuZhf9yp8PUTMqMb8Bh9rk7mx8IcRmQ9t
         lemcSglmwd8RL497od4RIVFf6RtskrHJwdP4D6JAN4+rUHD/C1klbG+Q+7yd9jBeyDk+
         7WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nOWCmF7nU3ccya4YN9rbWAijBsLEbSVxqe2kT30yoK8=;
        b=j9+zvcX/WBSAVq+mlWg5sVjSsoO9IShBk/Q0QrK7x8bgAEgeTz7O31Wq0B2A677K9x
         Ld85ZIT/GmxUk5GAxjWTyDur9PsZawYNo93yvnt0UB5aZ5sl2buaFtCvciSYrno4swO/
         WHSfZa6HbYu2KLPCz4Oq8ljldqJNNPNlk9qhDBdW13JJ1aqFKBmpwsi50Yizcw+CzAm+
         h7yXCllukohTTSYLT3PCg/cqcxqvC03DABB3eJ+paD+Vg9CZ/5u++1dOA4kGdB80FPNp
         T2xnM9f5tHlK2v0Ko8I3R2D79l+hEnaXPTwOlqnXfF9NZbVqwAN/pVFeAi81ssDDyNXE
         WqHA==
X-Gm-Message-State: AA+aEWYjOQzl4/NNQyCnFKcYPDyGYl4PSoLFRnfFSo4NMrXLu1S1mkRg
        bHd72kVJ/y9xixh66L3cHSWO7z7zkpQ=
X-Google-Smtp-Source: AJdET5dzgXfJvWLPs/9AKObcoIH/A1ISLaEEO/kKPV1MZ1mpcIefoTpNAXD/K7WtMZJBN2Z1rYBGxw==
X-Received: by 2002:a1c:5788:: with SMTP id l130-v6mr4306653wmb.60.1542550711887;
        Sun, 18 Nov 2018 06:18:31 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:31 -0800 (PST)
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
Subject: [RFC PATCH v2 08/14] clocksource/drivers/sun4i: register as sched_clock on suniv
Date:   Sun, 18 Nov 2018 17:17:07 +0300
Message-Id: <6f4773bdef8979bff71e958c9ca2c832c68ada0d.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv chip (newer F-series Allwinner SoCs) is based on ARM926EJ-S
CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/clocksource/sun4i_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6b57187..65f38f6 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
-- 
2.7.4

