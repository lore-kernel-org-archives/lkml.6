Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F58C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F37214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="poEtcwpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBJWv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:51:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54320 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBJWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:51:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so13949382wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 14:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UxJjrGC7S8wuLmEIVFRAlM1pKLfRQfIve9rD0DYFhcM=;
        b=poEtcwpA4f2mQKs6qAiivo18iaDEe7zxRU2bldCaLMf7lll0XSdV8/R4+SElYbzZtW
         5BRKDLmv64DKuYZbay9tKh1PtL0Vlu2IaR3alSYTR7FFv7/gLpHzrbo1qkVIPewwQ9q0
         vpqh/FZ6uMCiCKRXtRq9n2IUtKGpwq6258H2lomwZphLeqQT8zykHM56cj/fg+KiZZ3U
         iXZKxX1klaswCvgYcApmrli2Iu+kPjvajjjWP4JogvJsgmv7lmb6qThWJgGeJEnBeVq1
         wBPeIC9gaqZ+GkmjfPa19skmU5GHkKPBs5v+7o2t3btTsg30yuVY7sKTTXRhwuydTR46
         0rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UxJjrGC7S8wuLmEIVFRAlM1pKLfRQfIve9rD0DYFhcM=;
        b=CpLX61WqqCVFy2FrjEmyKywgb5eZWbK5wZSUnuGZ2YhAnA2VmEXDsH+ppBnrA4KGkk
         a13EtCZF5oLgYpvgkS1peXPYvQlHgR6e1NiCctM06g0XpSV0kvZTO7tTTizCGHwQI2W+
         VDcH6MH0f62PLJYGRvtNa3TplOQw3KCBSrGMOqJQXOdnL28vXitVZXSLWEyFvaj/FoGJ
         jKvgnZK3VnPdN/3QyBZaQIpE8XDllsBCoRRl/a9copCG8bnux3CTERSwCc6Qrp3eDvX1
         7S2faAJS86WLCUuWDrpnCedt8Hlx1ljLX4V8iTyaABwp1ihOWXGFvXe9rOpSg6oWgXRp
         ZSuQ==
X-Gm-Message-State: AHQUAuZqmlJ0Jww6/9FoSdmLJ6q32CMh3JNUCJwu8WSUGToIIODUtBP7
        laZ6aksVqLImyH+MnaJCcn8HCw==
X-Google-Smtp-Source: AHgI3IZectTBQRReNF8QKgvrBqrQimO7K4hqtf8S/K3t9zoe0a17CHmZfN+pasIL1lTb4VJZ8LxJgA==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr20533185wrr.271.1549839080355;
        Sun, 10 Feb 2019 14:51:20 -0800 (PST)
Received: from localhost.localdomain (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id c139sm3904325wmd.13.2019.02.10.14.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 14:51:19 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     linux-samsung-soc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH 2/2] clocksource: exynos_mct: Clear timer interrupt when shutdown
Date:   Sun, 10 Feb 2019 22:51:14 +0000
Message-Id: <20190210225114.20110-3-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shutting down the timer, ensure that after we have stopped the
timer any pending interrupts are cleared. This fixes a problem when
suspending, as interrupts are disabled before the timer is stopped,
so the timer interrupt may still be asserted, preventing the system
entering a low power state when the wfi is executed.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/clocksource/exynos_mct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 1e325f89d408..d55c30f6981d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -411,6 +411,7 @@ static int set_state_shutdown(struct clock_event_device *evt)
 
 	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
+	exynos4_mct_tick_clear(mevt);
 	return 0;
 }
 
-- 
2.13.6

