Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC09F208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDGCcTCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC09F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeKOXkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:40:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41263 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388290AbeKOXkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:40:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so14135822lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KUan3OzAdZ8g7FaQ0bp8nq8b/qVWijqdlEjN9w8ObM4=;
        b=dDGCcTClUlsV9dWCLEtW5f0S8V5MhLLsNnQeQ45ZkG6zEUFn7nh8Wc3U6lV0BJ8ZUj
         6f17EtFTgR49AnhKEhiB1frnjfZw5mmwUxN183kE2UXFkcD8qvRL3Zi3OpWwgMpUol1H
         neG6lF5wDuCU9pyxjUI8G1fi4cBlmUhi0ZYVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KUan3OzAdZ8g7FaQ0bp8nq8b/qVWijqdlEjN9w8ObM4=;
        b=K8tpzp+wgsXxp5UDmOZz4ecpnNHJOrJu8zbfQR8LoUb2AfBlkxQi5hRO518+uO0hxV
         5KzPW6VuezO4HRTFkODuWwjYyNrEeFOg8ObzdkF4kDa+W3cmhmAZIqDgOBfgWgzIWB81
         E+n/CMKXzjfPgAk05SCH3CJlanDJUsf+M3sHnLrANoI6G5TE102pjQW/nSAYyZifQhOm
         QIM3N+P/xfRJBVT5uT6ibMpZvErsqOz6RUNyOwrSjwyKEFlId9kY9m2moj4Hy5qup0pn
         zDl4ah+zfLTvvrRx499KDRzOX6EYgqnjTqIJWM0dae0cyDdS5LEBGFlT3PCHgmlRZaCb
         HV8A==
X-Gm-Message-State: AGRZ1gLnWsiJj7eK8Wy0cT4SUB1og/n+MBHpJVz7qACeUyA7tlQhtTYX
        JeNc7SD3kr3D9e5jg2UKM3cnfH3TO6jwhQ==
X-Google-Smtp-Source: AJdET5chX+FoiEVNp1V7KzhzUoq2brPZi/s9YIrk+Q5wSn0yC+ff+S5nHu9xfi2dAEi/mfk2QMTDhg==
X-Received: by 2002:a19:f813:: with SMTP id a19mr3325289lff.67.1542288728568;
        Thu, 15 Nov 2018 05:32:08 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f76sm4291949lfl.74.2018.11.15.05.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 05:32:07 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/2] clocksource: Demote dbx500 PRCMU clocksource
Date:   Thu, 15 Nov 2018 14:32:02 +0100
Message-Id: <20181115133203.28567-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote the DBx500 PRCMU clocksource to quality 100 and
mark it as NONSTOP so it will still be used for
timekeeping across suspend/resume.

The Nomadik MTU timer which has higher precision will
be used when the system is up and running, thanks to
the recent changes properly utilizing the suspend
clocksources.

This was discussed back in 2011 when the driver was
written, but the infrastructure was not available
upstream to use this timer properly. Now the
infrastructure is there, so let's finalize the work.

Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clocksource/clksrc-dbx500-prcmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c1b96dc5f444..4054539fe066 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -46,10 +46,10 @@ static u64 notrace clksrc_dbx500_prcmu_read(struct clocksource *cs)
 
 static struct clocksource clocksource_dbx500_prcmu = {
 	.name		= "dbx500-prcmu-timer",
-	.rating		= 300,
+	.rating		= 100,
 	.read		= clksrc_dbx500_prcmu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
 };
 
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU_SCHED_CLOCK
-- 
2.17.2

