Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8597C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A668D20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0H7/W/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBVTf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:35:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBVTfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:35:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id m10so1515124plt.10;
        Fri, 22 Feb 2019 11:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s9q3gbd6+FFh+E4/n8m7zDglopcsbqNaagda1Y5Is1M=;
        b=E0H7/W/9+Wf7PUgt2VptNB69Q+9Gny+RBJ/5biERUq5qivm+sMpg/x1VxXQr4gN2G6
         aBcaoouwvS+bPxAfh3bq8IQXSD9OtgnyTJx6f6WV+1Lv4e4/rxO+g2vSmKYV9Tp5rQxu
         +Dqynre9s+MzK6BdHBTxNEJ2zfBKeC10T4ZrJshqMxm/KGepvS/CRQeUFoc5Ny9FnGW7
         CUSIyFCjH4aJOnOyk9TTUwtHq048PylZHuYuRwyEnnNGfweV9vxQtH+TM599Cw+yzK70
         mDy2ReYX2d7aPgRtvqM3Nmz18gmD0kvpiPpUkg19dq+bWxL4BAmjssJ/4PE68d5+k3vD
         MyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s9q3gbd6+FFh+E4/n8m7zDglopcsbqNaagda1Y5Is1M=;
        b=UkwR6ZB1wagpO2jIo3M5LtAKAxzyw3TH9bnNpluyrJ9L9aGuCoKzRnniam96DVWXAG
         vGqdXulSo9W+2hkNZR49QUbC3Dv9wAo8W0e8cPzFVXy/TFZ79UUPhxDe/ORhEoQflmnf
         FJlGuZrsusJhw1khBcS7EyuCZ2c+flBM7N3YfsEOsls32iE4tqsovhch4CnwreLcD4I5
         zWX39Rzpg5SGHRfnKtSwaqgnbUEdmBqGAwVsHHRjtpDAz1WHV1oGc4hqmbCjcsC5Rvpa
         z7Z2t+h+6DWjANLpRDILY2uQo78fXlOcFpPUmCcPh+jprh1v3Vo0D3ZIdlatLPjsQd9x
         gn3A==
X-Gm-Message-State: AHQUAua7LJDos+gGHvKmeX5Rl+1A0K5jTrjnvizmq5A6icahx7F6DO5P
        Gq2m99Vr8WLrr+m5H0DxZ70=
X-Google-Smtp-Source: AHgI3IagDA2ESNkuTD51pAeXz6/JGyrW/QEyxf0/GmHYePf/5JcaPtSwMprxlXCIyRIQUBEpN7utzA==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr5810807pla.246.1550864155323;
        Fri, 22 Feb 2019 11:35:55 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:35:54 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/7] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Fri, 22 Feb 2019 22:34:23 +0300
Message-Id: <20190222193426.10747-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU
is running in insecure mode. Set up the required outer-cache write_sec()
callback early during boot using the firmware API, it is always a NO-OP
on T114+ and is NO-OP on T20/30 if Trusted Foundations firmware node
isn't present in device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..1e89cfefbf68 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -74,6 +75,7 @@ static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
 	tegra_cpu_reset_handler_init();
+	call_firmware_op(l2x0_init);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.20.1

