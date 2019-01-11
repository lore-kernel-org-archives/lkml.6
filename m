Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D37C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE7D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="lWLplKMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfAKRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:22:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbfAKRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so16008328wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVtO+nu/Gq60aTArb+P6QnW6Oh2zrZ3K6RvHVatJhiU=;
        b=lWLplKMF9uI3jzhYcYJFMJy6JUSIXtRhX/Cr8/whDeAozRjHgoQT7rtHAKX5qoWIFS
         YTgjaEpU4cvFVn6l8ONi6E4i3+K3GB+xDqqD1S4z7nE2oWTZ4jefhgmU6jabsjXlGNq7
         Lce7YdYUQahMvJlHYLuy/PM6Y8e7frFMSwLw5u3qiQmYEyXYXDkzhTcVBs83P83SY7v1
         0DuweP4DQ5M/x5Ml5eNuM8Zz76PjINa1m+PqGnaM9pgmpSEBQnVm2uG/IOMg82LG2RwM
         95E2t5mjWHwzI44Ag0LVCtOjzP91bRi+std4EYEvIrFMF8IaJOmyODtWrVuFV+2ns8m4
         XAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVtO+nu/Gq60aTArb+P6QnW6Oh2zrZ3K6RvHVatJhiU=;
        b=KpHjMxkVrCpN3JQ5GRgh9VZkfh0arOLy07bLeqJ3heTfXA4M9c2IndTWLU8QsIiHmU
         PXT/fbptr+fbT4bqUng4707A+q38LZCgFDd+6+ndJd12/xnrAa1VQiXzkS374/XlV744
         JU5jui10h3ExvBRpIMQKKWgfY4PQBvD+mxMTbCCUKBJHlo3z7aLwnemGT0I7Guw8v11a
         a5R7sdXsNlULcGONFTyu2AF2mG9zIO98II52GRNx/pFidH2RS5S9ipOtR6eJ8d55FtUs
         EturDYkBa53k5nSxepe14Asis3pc3KT5wjPn9SBSPhTcE0uWtvzvp7xfLtO1zjYbMtaD
         Ngkw==
X-Gm-Message-State: AJcUukcYPUq74OR7L2ceI1ckN0OhCpd7Imm5DpXTCOPiPsU8p4vYPUnl
        3SfPVnE5woM2CMUHxzVXrph7Fg==
X-Google-Smtp-Source: ALg8bN41MhWv/0vAb1r3Fk+hc1+GCFAZZSQtxdUrX4tGf0TJuEk3MPrz84xgLcB20x1ylnnQC/TTNw==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr14424684wrb.283.1547227317462;
        Fri, 11 Jan 2019 09:21:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/17] ARM: davinci: dm355: WARN() if clk_get() fails
Date:   Fri, 11 Jan 2019 18:21:23 +0100
Message-Id: <20190111172134.30147-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4c6e0bef4509..07ad9d6c9cae 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -745,6 +745,7 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1

