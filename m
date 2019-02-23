Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E21C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D81A20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCTVRhxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfBWNI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35686 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfBWNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so4279973wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zFlPFLyFgw01uA6gH5DBSfpAPaQdL6b18fd1L1abNfo=;
        b=qCTVRhxSjTt0U3zJ0NMauK/Ow3C81niTgV18bDQl5O7MyJKqS48db1RIyRccJ/MoHJ
         QHFsg57Od+VSZ9aO029rREstBfZYqniKr1HH8WQ1XL/i6O1fcjiNYWkr6H551oKzxo40
         XMVCiF59GEpVBVTNNM+h9Fua1ikEE/izBxBgRQ6PV9G846nWIxTpJ0Bcu78SInttzwem
         Sbj/BjdtpHy/RVdFBgHvvdhKthwhGipG2k/B9hAo/6O1dfhhSNLp5q8FQy7JGmnkAvYO
         vpgjb9gBfSUwkJgiEncI8ZhpXO61Pd4oJ3hp0NOlgwHqktGaEmsJMXefUq7kmBeexzd0
         IxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zFlPFLyFgw01uA6gH5DBSfpAPaQdL6b18fd1L1abNfo=;
        b=RVo4RqBV3nF6oM2RWBoAO5Ou0r/zfgGC60N09C+9qIlK3Wh2PxVuQ0Se6oRpM7PNsE
         KGdsuRBIgjmYY9hqV1I2WngA/ItqAiIxNcYNnBI4rd3hnse3R9GTU8y1YyINcNnlxEFM
         hiFiyuf82cHOAsiJXvWP0llPCD435+NIdgQvOls5PdS7nhCeKZtHuQqEPNzL/yQpUhSE
         vR3ElWGjOKb27nqwQc3W+KovenUly8fgCOt6f29Aj3DNgwyhSlMjc9F69BmhJfMlpWo+
         RIGrufPtYzYaXyN0igC/wwFfLN9VH6fX6/NsBQpYtecmXAV9Wx3+foVV071VV5yp9O+w
         409w==
X-Gm-Message-State: AHQUAuYqum7CDutDu6ZgTpDuyIP2hlA0fTkZIdSWaARLIDRMaPJN1IjR
        yRebY3TlnD1r5U/YSAVTH+oPtT6uBz0=
X-Google-Smtp-Source: AHgI3IYfMrxVPzWn7cvYcKgaNOfjSYWYeAPrywB2HO44NZASbbCH6tw+0m/sBOfcUHk9+QQP2nolQQ==
X-Received: by 2002:a7b:cf03:: with SMTP id l3mr5457451wmg.14.1550927297661;
        Sat, 23 Feb 2019 05:08:17 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:17 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] clocksource/drivers/tango-xtal: Rename the file for consistency
Date:   Sat, 23 Feb 2019 14:07:01 +0100
Message-Id: <20190223130707.16704-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                             | 2 +-
 drivers/clocksource/{tango_xtal.c => timer-tango-xtal.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{tango_xtal.c => timer-tango-xtal.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210ff89ea..47052ea15f20 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -69,7 +69,7 @@ obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
 obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
-obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
+obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/timer-tango-xtal.c
similarity index 100%
rename from drivers/clocksource/tango_xtal.c
rename to drivers/clocksource/timer-tango-xtal.c
-- 
2.17.1

