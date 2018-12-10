Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E8CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EE820672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eP0uKIc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EE820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeLJQw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:52:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53086 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeLJQwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:52:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so11631134wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qjdnO2DNnqjz1/W8KEFUahSKSMHQuREy7uvLbg+oEK0=;
        b=eP0uKIc52V1TOcGjuR93gZ6CyDkkNnhbhQijGXK2fDlaJ7b60mX9Tl7pk0vcDooMv3
         ey71gnFTSvIoLU+Un+1o2OT1T1xQKuvRAG+D0QJJpltVXZegiiyYB34nRMHg0N+Pgh9h
         IG0/gvZeVdgzWLVLTgggF/9QZfcUvtRbb1jek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qjdnO2DNnqjz1/W8KEFUahSKSMHQuREy7uvLbg+oEK0=;
        b=j0NBXJXjjzDCIkbNxNPRvUpMU42X64LNxVwW6Jua0Ss/lQrkzfRvVJnMPa5jY86wv0
         16vYudv5Km/ZUq28C4m31u+fwQTpC/TzPptVG/aJY8qXrEADXzk2f4fPaFQcTz0Eu1x5
         6j07jQLDrUoBzZSdTEsJp0RRXt8BoJA4vZe/otepWc/XVYqydHcyu/SfiV1d9D67zjzp
         v/lNTAfEz7MYq8JTyg6zaL1WDYtSfKPx6XAv7DuNCgTTR5dxFfUlAmVG0h8wm5jNgpOY
         81VqmrFNUk2X81hMz4va8oa/y7e1qDCaXpC6/CTx+c2zINOGkBVEbphz6I+oJpBzKoQa
         78GA==
X-Gm-Message-State: AA+aEWYSC/+I/jQLW0R66PZDFSB/5HIz2cQ1m/gjtYkpwjOBlLSJFbPl
        V48ENpkZ1vn9HBtodP4UEjOzWA==
X-Google-Smtp-Source: AFSGD/VnApmHJ6d+D0TVTzc077Fp8tZzcyIXBDLICUm6x6Ung6UHjSLlhIxCxgZH4FGcwOnmQnqF5A==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr11174304wmc.138.1544460772653;
        Mon, 10 Dec 2018 08:52:52 -0800 (PST)
Received: from localhost.localdomain (73.59.88.92.rev.sfr.net. [92.88.59.73])
        by smtp.gmail.com with ESMTPSA id c77sm12877833wmh.12.2018.12.10.08.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:52:52 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS)
Subject: [PATCH 5/5] clocksource/drivers/meson6: Change name meson6_timer timer-meson6
Date:   Mon, 10 Dec 2018 17:52:42 +0100
Message-Id: <20181210165243.5625-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210165243.5625-1-daniel.lezcano@linaro.org>
References: <20181210165243.5625-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to unify the names in this directory, let's rename the driver to be
prefixed with timer-*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                           | 2 +-
 drivers/clocksource/{meson6_timer.c => timer-meson6.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{meson6_timer.c => timer-meson6.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 37732cb5710c..f475927d5140 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -34,7 +34,7 @@ obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
 obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
 obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+= timer-sun5i.o
-obj-$(CONFIG_MESON6_TIMER)	+= meson6_timer.o
+obj-$(CONFIG_MESON6_TIMER)	+= timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+= timer-tegra20.o
 obj-$(CONFIG_VT8500_TIMER)	+= timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+= timer-zevio.o
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/timer-meson6.c
similarity index 100%
rename from drivers/clocksource/meson6_timer.c
rename to drivers/clocksource/timer-meson6.c
-- 
2.17.1

