Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A541C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5B220684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzcH0a1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5B220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437651AbeKWCDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:03:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33140 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437635AbeKWCDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:03:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so1392833pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e9QZYbEbVJk+LhLGR3uqFlqIoOsuAlQF7p66rYaEtfI=;
        b=BzcH0a1GklJlwwrqPLnpi2GwBSYkdxi/r2+sSXLpC0To7HZts13Yqb1EY9CKAz5lD4
         XAEtw9PR8RT/zCp8VvcTaOfgFziMQxRkGflw5fK9M0Kq0OzXVGv6c0WsI0N1O9GMQhwM
         Lna+REsjHEi+R4o/k/zIHVNhr5pzjTpxgQinBoVi0z4dxCymAVaz5XxrOVZn4H/1v+Lk
         pQuBtH6SXVyq0narU5DMHJ6yC1tK/7IrvfiMLgG6hUc7GOoXLiFBjJFm5DdnO81FZdrw
         N+tVhAvBuAiXayRFMo0a/gmzQZQaomOSnSNlDq3KN0RyttZ496wYxsix91FNrzSI/yY7
         3+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e9QZYbEbVJk+LhLGR3uqFlqIoOsuAlQF7p66rYaEtfI=;
        b=KG7nktBImNf8CK6emu8kRYNxTFqoM5CxtSfMccjzd6SeKTAtVEwsQ5LNMdAiKz1e/f
         111fe5ZJjYy8WGl0GZXtHsvuJ6lPWnGzYDQOFX5LPSuV5rBu4qL5mHA4uAAthzSVH7Rd
         CBZph2kx7TTfBAH5zcY4IKnf+tRhwJM+Y3zWekPPVYYobGmZNiTf842gP74As2ZIb9Cb
         7fcPQNZRPcudY0l7yR6IC0Ij00yXiY0KsbeTTzE8PQXf1trsuQHgkDHohh+tqvF5Rt0a
         VoK9uZy7WvNFAzi7yM5ljns+RjOqDk3fE2/j9u0olKucekr5+19ZWJryYI0i0Q+cFmpz
         RWlQ==
X-Gm-Message-State: AA+aEWYxuok1het96IkUlWs8mHj42UoB4nqADftudb+oMOOBY9K1tVj7
        KMiy8BmqRSVNYPZLPXMl+k0=
X-Google-Smtp-Source: AFSGD/XtBZwZDGuV5XcefUogfXxACDPLuEuyRB5q1tMKAjKPieCxGk9Wr9DJ11WrmXcr2p/uQO0URw==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr10535015pgf.240.1542900215023;
        Thu, 22 Nov 2018 07:23:35 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x184-v6sm44394918pfx.42.2018.11.22.07.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 07:23:34 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource/drivers/integrator-ap: add missing of_node_put()
Date:   Thu, 22 Nov 2018 10:23:31 -0500
Message-Id: <20181122152331.25739-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
integrator_ap_timer_init_of() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/timer-integrator-ap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 76e526f58620..1f04069470bb 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -177,7 +177,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 {
 	const char *path;
 	void __iomem *base;
-	int err;
+	int err,rc = 0;
 	int irq;
 	struct clk *clk;
 	unsigned long rate;
@@ -210,26 +210,34 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 				"arm,timer-secondary", &path);
 	if (err) {
 		pr_warn("Failed to read property\n");
-		return err;
+		rc = err;
+		goto out_put_pri_node;
 	}
 
 
 	sec_node = of_find_node_by_path(path);
 
-	if (node == pri_node)
+	if (node == pri_node){
 		/* The primary timer lacks IRQ, use as clocksource */
-		return integrator_clocksource_init(rate, base);
+		rc = integrator_clocksource_init(rate, base);
+		goto out;
+	}
 
 	if (node == sec_node) {
 		/* The secondary timer will drive the clock event */
 		irq = irq_of_parse_and_map(node, 0);
-		return integrator_clockevent_init(rate, base, irq);
+		rc = integrator_clockevent_init(rate, base, irq);
+		goto out;
 	}
 
 	pr_info("Timer @%p unused\n", base);
 	clk_disable_unprepare(clk);
+out:
+	of_node_put(sec_node);
+out_put_pri_node:
+	of_node_put(pri_node);
 
-	return 0;
+	return rc;
 }
 
 TIMER_OF_DECLARE(integrator_ap_timer, "arm,integrator-timer",
-- 
2.17.0

