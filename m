Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D808020877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbKTt1Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D808020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeGQI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:27:22 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36824 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGQI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:27:21 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so107076plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fGURDGdl/JLCtBIrVGtFaqQO0dTy+oPsnkiP/5Ymcxo=;
        b=DbKTt1SfiQN/3EpERHDZ86Yc05unP7Hnp69x23v3efs8lIun+IzKxeNiWx3lTxrni3
         vzMki2TYjsj72oWCUQKrfFDi4XJsrD1JevlEzZLR3EYbpUMGzZj4hs7ZF6qgYd1vGn7s
         TRzd0ij5/vBxzXktchBjrA7lWd07v4B2wnyEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fGURDGdl/JLCtBIrVGtFaqQO0dTy+oPsnkiP/5Ymcxo=;
        b=ZEqTh0YO97QMIKn+ICWQ7sIojQ49NVkojS7T1kk2HFJF6CC+ofKgRwWsCz6uY8Vz/p
         PCTI+aK1NA0dGdK5JPlyAW8LsmCb0Cr6oUWDZXiSwm5kOVQrMHttx6bGy1xy3BVpO2gF
         TTpBQhL451pu93lm9XnuW3d8iWMWOcBXKx7d27J4EZHLo1O7qIXn7nPSAncVtQH2+zJS
         Ouq7ng7Rz9RJu1J8EGZ78uyA61aGFvXE+TNyIsiVCtSW8djjimbCTHR4bWVXUmwznW4d
         0Xyy7WC+Lkie8rVckHV0o81w/XEfGCJvR577lV3zSKkeEBMVTX4Cdx1Ew1Ka0fSZ+DxB
         wZSg==
X-Gm-Message-State: AOUpUlF6zBs7mKl9cdG8tgovXgRgQ7xy/b935dyWUL3+Ze8mHVGR2/Kl
        0fpNEtA8vwotrFljvz6cnptj3buWLlE=
X-Google-Smtp-Source: AAOMgpf2KVVEZi9ncV6SuY86SS7gyv4qvGdk6+SsC8HAoQ+D+prhG5s5r9HACkiADOGNuiJGRf6a+w==
X-Received: by 2002:a17:902:201:: with SMTP id 1-v6mr594972plc.310.1531814161788;
        Tue, 17 Jul 2018 00:56:01 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j75-v6sm1462012pfj.102.2018.07.17.00.55.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 00:56:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        arnd@arndb.de, broonie@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/2] clocksource: sprd: Register one always-on timer to compensate suspend time
Date:   Tue, 17 Jul 2018 15:55:17 +0800
Message-Id: <3d6de641eabb8f36ad2b6d4e948bfdeb2282c96a.1531812082.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
In-Reply-To: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
References: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clocksource framework has introduced one suspend clocksource to
compensate the suspend time, this patch registers one always-on timer as
the suspend clocksource.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from RFC v1:
 - None.
---
 drivers/clocksource/timer-sprd.c |   50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..430cb99 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -156,4 +156,54 @@ static int __init sprd_timer_init(struct device_node *np)
 	return 0;
 }
 
+static struct timer_of suspend_to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+static u64 sprd_suspend_timer_read(struct clocksource *cs)
+{
+	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO) & cs->mask;
+}
+
+static int sprd_suspend_timer_enable(struct clocksource *cs)
+{
+	sprd_timer_update_counter(timer_of_base(&suspend_to),
+				  TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+
+	return 0;
+}
+
+static void sprd_suspend_timer_disable(struct clocksource *cs)
+{
+	sprd_timer_disable(timer_of_base(&suspend_to));
+}
+
+static struct clocksource suspend_clocksource = {
+	.name	= "sprd_suspend_timer",
+	.rating	= 200,
+	.read	= sprd_suspend_timer_read,
+	.enable = sprd_suspend_timer_enable,
+	.disable = sprd_suspend_timer_disable,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init sprd_suspend_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ret = timer_of_init(np, &suspend_to);
+	if (ret)
+		return ret;
+
+	clocksource_register_hz(&suspend_clocksource,
+				timer_of_rate(&suspend_to));
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
+		 sprd_suspend_timer_init);
-- 
1.7.9.5

