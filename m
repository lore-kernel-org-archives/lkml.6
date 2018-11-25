Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AAEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF72520664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNuqnOq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF72520664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeKYSfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:35:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKYSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so15810387wrw.1;
        Sat, 24 Nov 2018 23:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=XNuqnOq9D0HKW/kpS1CRhuz7ixOhm9sqogq672JZ2E5s/9GhcEpjCdsoZms3JhqgXF
         8sy4AUyMfc2A1acXqs8HVDZP8HEBJ7FfR+CRsteDRMdvHydxFoFfwl4I5ZPGHGs8KAnO
         qVbJ1LyHsDMea08LUn0KWuB0A6PQWeKVG2USeNYOr2AKiGYmlQrMNAPzGTGFMD0qIyFE
         GoIWVnyZ3Rmq4+dHPLnxwbyAPGWh4GPlM5YUMxiYgZbXEJ2T3/IPYtKd2CbJO+lV7J78
         j59hEYdTOwDW3HOF+C1Uz1sH7gC/q5pxYCozqg+dkMKLSvl+H5T+CxUS6KXoM+trHBOd
         /lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=Ug0e8YYZcfazE7Cz28bXZzuNeZgzCN2fo6hF+8T8sWt3Px1e6jdOuwHeEwSJe3tybv
         kJjF8mjja794YUooFl707LlZZvcP22y+iCZr8jlqAWZlQ2KOjD9wnpQIdbeU8ojhrH4f
         wjvGjkJIJE5vMk3MGb+C31nMqvDCeriPM+z22AcrLrsV01erI0PehWHjTS2/8W1Ur159
         46PxCFKnk3VgVRUKJj8oG5bm+5RIr0saFCEXycX3u5AN/+wBCiCUf4g9ZItmKgqiEj3z
         fLz0o8TYTtuysDh/66CXP/Mj/hPhoxhlfIWuthN/2LvKVPXhObhzWpESNLkDMkLrahvC
         Ou6w==
X-Gm-Message-State: AA+aEWbr3gLNUYWEYfYhQynnZ71w/2N1jvtUMHO11UNScH66tY6S0/Fo
        mgO1PcBiaw58uUW/2zZ8aPeYTXcP4jM=
X-Google-Smtp-Source: AFSGD/VOpifyXyiJOsCKFmC0C+Y9d4xQBQ3LDpsETWDz7iPP8GnPqEMdbrrdwOO7YTEAnWEPvtboKg==
X-Received: by 2002:adf:aa94:: with SMTP id h20-v6mr19199503wrc.216.1543131841773;
        Sat, 24 Nov 2018 23:44:01 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:44:01 -0800 (PST)
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
Subject: [RFC PATCH v4 09/17] clocksource: sun4i: add a compatible for suniv
Date:   Sun, 25 Nov 2018 10:43:12 +0300
Message-Id: <c7f0f45f5da8e8b1842e9b71380b0e39783db27b.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6e0180a..65f38f6 100644
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
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4

