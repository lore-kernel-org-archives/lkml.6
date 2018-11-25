Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98114C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4A320855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 05:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rC70cro+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4A320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeKYP4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:56:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeKYP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:56:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so1651054pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 21:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4PiGEQ9bwEatBHlENEfVReEtjL1WZXz9nIkqZBIBZX0=;
        b=rC70cro+tfVt+kXFgXLXcuCNOinHTo19X7JtovNkIap0fbMChVZVd/zw9/knz0LHfV
         HaSZSF2s5VRMM7NG8lMJvc5LsnKDTBgoNdI5YJSAMP7jQk94x0JOYtin/dLExIvCx6Hi
         +pNYxvgKxEzVJWZoktWs1uZ5YmXq6/Hatgs3Bk19v41fPNaUcGdo8mIoW0V4QCmXru6m
         O9yYre6xjha3NKeXVL3yj/tyDU2dgACAsUxHlUYdoRktsrAT0pgGeBbZro08g4zs+Yo0
         RCfp2T3ReL+htS2b27IwOjlmcQE++vLHIqd1luQuDvK/IXznpOOXFQCgqOWa1Ny1idfU
         gMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4PiGEQ9bwEatBHlENEfVReEtjL1WZXz9nIkqZBIBZX0=;
        b=NUsDT0D/PY+ivQlkjTRlUTUl6go7vOx+2LOcYHjo50rH0dchM4pYVzJ4+TQSxECgqF
         kfwZa4PBPcxZK6TRhFRWC1AhcKFWTg32cSQWbVoKOh6vng4+MFck0FYrp+F7YF3c/+Jm
         MZJp5Wigso646TLYPnb8A4pVjzHYqCA2RkzuZyGS/sVZJDtW8wpiUSm2mMQdx+rKIH76
         3tlNNxa8d9Bep63B7FPjtmOgJklNJ/etJEutynp0E32ysc7yE31ZO4Xr5WeySFnH4/uM
         YdUKWmINyqUC5oK+zKeVlEyWeZVf5iWYFSYZGo/1nYJ2hMnM4uc4PD3DJVxyYsU78GQB
         TQfQ==
X-Gm-Message-State: AA+aEWbrzjkqjYHwFTMPIJvtOSGbURmXHjIMgu7E5MFDFYzopcct6zLr
        bt5IEg259IyNuPjBQ9vdt6o=
X-Google-Smtp-Source: AFSGD/Usbgvc5+tsEFDGVRhz/7DNE93I4NMrSdOi4jdkxnRiI98pkCm9RzeaPwNHVZHrVZG3tUJivw==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr6301556pll.51.1543122053462;
        Sat, 24 Nov 2018 21:00:53 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y26-v6sm20864774pfi.123.2018.11.24.21.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Nov 2018 21:00:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] clocksource/drivers/integrator-ap: add missing of_node_put()
Date:   Sun, 25 Nov 2018 00:00:49 -0500
Message-Id: <20181125050049.29685-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
integrator_ap_timer_init_of() doesn't do that.The pri_node and the
sec_node are used as an identifier to compare against the current node,
we can directly drop the refcount after getting the node from path as
it is not used aspointer. In addition, a single variable is needed,
so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
Changes in v2:
-update changeelog
-simplify fix
-change two variable to one
---
 drivers/clocksource/timer-integrator-ap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 76e526f58620..bbd0977d579a 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -181,8 +181,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	int irq;
 	struct clk *clk;
 	unsigned long rate;
-	struct device_node *pri_node;
-	struct device_node *sec_node;
+	struct device_node *alias_node;
 
 	base = of_io_request_and_map(node, 0, "integrator-timer");
 	if (IS_ERR(base))
@@ -204,7 +203,14 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
-	pri_node = of_find_node_by_path(path);
+	alias_node = of_find_node_by_path(path);
+
+	/* Drop the refcount of node */
+	of_node_put(alias_node);
+
+	if (node == alias_node)
+		/* The primary timer lacks IRQ, use as clocksource */
+		return integrator_clocksource_init(rate, base);
 
 	err = of_property_read_string(of_aliases,
 				"arm,timer-secondary", &path);
@@ -213,14 +219,12 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
+	alias_node = of_find_node_by_path(path);
 
-	sec_node = of_find_node_by_path(path);
-
-	if (node == pri_node)
-		/* The primary timer lacks IRQ, use as clocksource */
-		return integrator_clocksource_init(rate, base);
+	/* Drop the refcount of node */
+	of_node_put(alias_node);
 
-	if (node == sec_node) {
+	if (node == alias_node) {
 		/* The secondary timer will drive the clock event */
 		irq = irq_of_parse_and_map(node, 0);
 		return integrator_clockevent_init(rate, base, irq);
-- 
2.17.0

