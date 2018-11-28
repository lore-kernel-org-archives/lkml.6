Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F185C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCF2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPI5b4tI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCF2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeK2Jhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeK2Jhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id k198so275071wmd.3;
        Wed, 28 Nov 2018 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=bPI5b4tIqowdj0Ud4jLiRICip+blzwO95SDrV2KPUwtVblR7T3rA34/m0pY0cj0K7A
         UrUNQk81MeL7EchjqwTo/SvIyuDwXZweitxGJA8Xcg6JpOn2mqvXlgHYVokhYk45q0pk
         jSLP2Wp2U9MS+DlN2fQSGi4FyYwqPs9Ip5ZJ29yNpJBjsDE3I3uGE3rFNwbONdX/GWOj
         FGSz4AevULt8k2KjzygDU5E8qmJ/TAjjZp8cyh9poW7f82gWjg8ZuECfY8eAIaZd3L7y
         VJmJGiSelKZKw+Uz2jFs36/XbsUnoQyBSNLu6y3xVrQoGHzjAk90F0TuR/LPbfZ9nOj6
         mStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=dt7ND7jGMCRkOwJ+rInFd90ktTChguDrN6USCxlsLm+TzhWyTaLCjMybgLwOZmFfgy
         /9syD7fHBEIfzWGUXA69yqfaiLHrXhQ4VHRb0Bjor7Avf7XboLGCP0sVm43suma2Feyw
         RFAV5RawFA0JEq0p1ewTSkBvPcTvKU+LDwFCsoFYGMBF+1xyrmy+mo2QvPm8yhWjqYoQ
         6e3DLEcwievIiXAsCgzLcBIlP+TEn0ZmfzUtXOBhB2Ehv6LhAgYpU2sKwq5JTh0WS3Ue
         WosbzZ08HzDtlM3l7iQc5lE5Pd7y2WME9W9euPKm6Aimlr6zJNpdog+VxFPR3Y7JwEpJ
         G7aw==
X-Gm-Message-State: AA+aEWaGMMR7tg05uHjHHv6W0P5gAzTSA/dmqdbL5WBZ7yKIGZtkxDzX
        MGPLY5NsTtWhhi3N/FRTEPWsznQdrPg=
X-Google-Smtp-Source: AFSGD/WoSjpGjprL0Q3/EM3UchYU6uZQ5aQRC8r/EsBc248WTRrORnOqycx2d602MIa5U9wCK0MX7w==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr4572266wmh.92.1543444466730;
        Wed, 28 Nov 2018 14:34:26 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:26 -0800 (PST)
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
Subject: [PATCH v5 09/17] clocksource: sun4i: add a compatible for suniv
Date:   Thu, 29 Nov 2018 01:33:19 +0300
Message-Id: <274bfd74bf3817065b6e5bdc733edecc520449b6.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

