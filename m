Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177F3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AC421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ry2VhwQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeLRV3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeLRV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so17438227wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dG64PjAuTOt/9OYn0uHXcM9weXS12CiGbv0zuOfNCyM=;
        b=Ry2VhwQjUK7GI9IEbVie8jr/gsD3Xh6IHOcWhZY8CS+XlWfSYDDUf3Ogb/rxQgnov6
         Gb/dRX1kZX2EFH6GyTN35tWKIysS/3EIDy8kyrqsF3+96GUgujcQUhMpbwzgt8AXkwXp
         mO11F8IzSoWfhliMO1NWoJzyUTqgo0lTlTBpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dG64PjAuTOt/9OYn0uHXcM9weXS12CiGbv0zuOfNCyM=;
        b=tc1Z/MJbxFUXIf4E8vmX2u0bHvPfT6qeX+Sq7jiWjjYOEOlLG69D1SjPYdYUywtrjj
         D37SfSpik4Hr11uxCimu1EcnWNlA3WDerXE2Ynam2cnYcC2OSgZ3ZMo+gyeQ/+/NxpmG
         Ov1BULOcXq+AIzaV9hMTKRTblSHt701nO28myLALBOUp7dyUfe7mDJwLeXdCDduBhTkO
         9bdR1+qSYVP5DM+gGcwGPu0ZExqyxxDv8yJuS82rTuMsRHqdNve+GctV6hAgloZFUDvS
         SdMDfzMx3bsjOjBmY2Oh/CayF6FXFwv74TuVstfYNeafRc94w8Cuht68CdetiYFiG6/6
         T3Eg==
X-Gm-Message-State: AA+aEWZ7QhKau8ZzyCqX7lqL1EJFRtzOpHHQzEIeB8ut5i5ZTsOWrBYG
        /36HPXURw0pm1DMroUV6hHmdpQ==
X-Google-Smtp-Source: AFSGD/XPb4N5yaTxvpbzzxLzAd07BvoHzxJMw8qA9vcrkwqtX6744NEmei3mzVnu1nKuoJXsFyrDjQ==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr8554643wrx.248.1545168577007;
        Tue, 18 Dec 2018 13:29:37 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <anson.huang@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 18/25] clocksource/drivers/timer-imx-tpm: Specify clock name for timer-of
Date:   Tue, 18 Dec 2018 22:28:36 +0100
Message-Id: <20181218212844.30445-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

i.MX TPM needs "ipg" clock for register access and "per" clock for
timer function, the driver gets "ipg" clock by searching the clock
name, but timer-of initialization will get first clock in device
tree TPM node since no clock name specified in of_clk, that means
the "per" clock MUST be the first clock entry in device tree TPM
node, this patch specifies clock name for of_clk to avoid this
restriction, it makes TPM driver work properly with different sequence
of clock entries in device tree TPM node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-imx-tpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index c3dd4d2f2a6e..c1d52d5264c2 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -139,6 +139,9 @@ static struct timer_of to_tpm = {
 		.handler		= tpm_timer_interrupt,
 		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
 	},
+	.of_clk = {
+		.name = "per",
+	},
 };
 
 static int __init tpm_clocksource_init(void)
-- 
2.17.1

