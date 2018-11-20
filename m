Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DCC04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DFC2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3EhX7tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DFC2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeKTXsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:48:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42968 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKTXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:48:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so986894pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TdrZ4MHaud8zjHSRn6gUtQfFv+hunpvvZBkQESGoITo=;
        b=C3EhX7tWc80SLZhjkLmZOuryTmeLgkKWFFSlM0fuigdRsw2Zq/mkzEWw/brJ7mY0Wz
         +ZNO3bJsnNVVF/HoFbxJ6KrarWkQz9Qrj7gN7w3k1Af+IVhgKKTMcKn4JoblE3M5lA2j
         WrxTO61lrjvpMhLYeaVnpWXLkW2ASHMNQmilrLo2/wEdwD9P81EXebLOk0CHws/sR+nw
         l+gRf60m6p0poldEBKrQEqqsWkZMw4hNeXg5oKH5rHGNrLWidWdTws3ViqCmEVcs9R/j
         +a07/L7fkndiCUmx456SiuPZeMP/PTOVdOHtp8f+q0k5UEtnLpzVXx7bcXLGBOujADLx
         WR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TdrZ4MHaud8zjHSRn6gUtQfFv+hunpvvZBkQESGoITo=;
        b=VuVmlLK8Td/PiCM3bzoO17ORv291MMgxyaM5vnZwEHXVlIxaZ3IZcSgrtU/ETdPoOg
         IxLS0HWY4+4YKI6Z0Kwdj6gQo8WTIGuXx3+92E9sIvLq7FxlVAHC/XGf6BEo2NM2aYWo
         KlnycVPAvPituPpUW560VEcexaFuhPSb5TuDzcrsWecPceHyfgjK2qN0ycuOG7VgjKJh
         6BIjzLRdT+CXLHYkKEtLLVaQ9qTK5kPVlDAlEseYCPpJztvnn1rppRJXu2NIhfR4dOsZ
         gzrfQGV+X5yaycWjHR7fy6LXGTwSS4oc4QueQ/l6lzKEnlWNlps4/1RHaRzg5bmHj5GO
         GlEA==
X-Gm-Message-State: AGRZ1gKQcK2/PhfWUxhgw/pwbtYOdCP/ZxnGRixXScATHs9cSraZWW9u
        fNE4yOyHT2UZ6nJsUV3t5A8=
X-Google-Smtp-Source: AJdET5eOqGDf/F7fpAeYB9O/j0FuE5QeMGgI18bIiLwKMKQ5vz1xeqpJQF0qv2d1USUGthqYSh0Vfg==
X-Received: by 2002:a62:5716:: with SMTP id l22mr1352797pfb.16.1542719937293;
        Tue, 20 Nov 2018 05:18:57 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q5sm33059902pfi.165.2018.11.20.05.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 05:18:56 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource/drivers/integrator-ap: add of_node_put()
Date:   Tue, 20 Nov 2018 08:18:53 -0500
Message-Id: <20181120131853.19710-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/timer-integrator-ap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 76e526f58620..50e0a9166f66 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -204,8 +204,6 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
-	pri_node = of_find_node_by_path(path);
-
 	err = of_property_read_string(of_aliases,
 				"arm,timer-secondary", &path);
 	if (err) {
@@ -213,14 +211,18 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
+	pri_node = of_find_node_by_path(path);
+	if (node == pri_node){
+		of_node_put(pri_node);
 
-	sec_node = of_find_node_by_path(path);
-
-	if (node == pri_node)
 		/* The primary timer lacks IRQ, use as clocksource */
 		return integrator_clocksource_init(rate, base);
+	}
 
+	sec_node = of_find_node_by_path(path);
 	if (node == sec_node) {
+		of_node_put(sec_node);
+
 		/* The secondary timer will drive the clock event */
 		irq = irq_of_parse_and_map(node, 0);
 		return integrator_clockevent_init(rate, base, irq);
-- 
2.17.0

