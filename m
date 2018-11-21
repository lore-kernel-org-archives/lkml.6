Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872A0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDE9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFn3PqgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDE9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbeKVFH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733189AbeKVFHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so6743681wrr.3;
        Wed, 21 Nov 2018 10:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SmtHuSS4Ju9nlqHeVEhtDy4G/FoQJSCxrU0Ad2ylIx0=;
        b=BFn3PqgHJ0GLvkvvVs2J993nyLHyoKEWlXuANbtaOY2tBymxlbLEqL4YHXQHf6lgPg
         s89M3Wn1XE7dyBRplI/wZ3dpRy8KKfmUdjiCHS1TxfpjAjNpab8nbJIJ+9aG54bmkdPR
         I9lqZ2xggnNLwKiX2DX4+3n9eUpGpNY24ZMbOO4aSh8DJqcBVthNwdcaNb67fyc61k8x
         KF8IbxChf4B+zVaxImDSgAEUHCFFmNh5OE2yDWRx7Shjhb9HJiRlo8bNm+DOX+YKEQPL
         7lyLT//oFsS3VLX9H/NOts934GOM1YE0novaT3tBBq8BhxJnPnJjSmbmmEIi6r2BgU+I
         Hnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SmtHuSS4Ju9nlqHeVEhtDy4G/FoQJSCxrU0Ad2ylIx0=;
        b=dtdCMFGAs59TcWY0MWvjtcISSBjA9gKeovpbtmQ2iCR18CX3PRidiIySFNdrakUPq/
         7YM9UUEJMkRHNW3OsTHJlTjCJ+imbrG5dZ2JCadLCKCjEsYDEJ37HndyBuwFJIGJtQ8C
         5HVahOEYOhAGzJUbcF1eF7P8hVQaKWVshksekHiCI8uc2UNFfI8X/dUMzkOCX6uZY2UG
         wWrD9kP2+V6z2EEqtvqo6/jZ84EkwPeIkm7ZfnxplKi9LUPs8JY9EpZi5B3eTQM+6EOn
         7tVOiRjCb2K+sDS9zuEsltapnjjiSXdMjRh/UmX6YRdrZ5UCPv9a7upHpcJYknPxliOK
         FMMQ==
X-Gm-Message-State: AA+aEWZt2sFqrdQERhc3wBoSGIZNKmTwz5+w6cKLrqyRqZx00TlvuiqY
        nra+4LIlcAe232wvOffGBU0nZ7SWOFE=
X-Google-Smtp-Source: AFSGD/WJsNDXnoHprpjRFJDU6SHPWaa9X1xlLqnSYVPffSF08Ev/MBlM5wmDwAQ4byhuQXG8B/X+OQ==
X-Received: by 2002:adf:f101:: with SMTP id r1mr7019879wro.32.1542825115091;
        Wed, 21 Nov 2018 10:31:55 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:54 -0800 (PST)
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
Subject: [RFC PATCH v3 07/17] clocksource: sun4i: add a compatible for suniv
Date:   Wed, 21 Nov 2018 21:30:40 +0300
Message-Id: <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
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

