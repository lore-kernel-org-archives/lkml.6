Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE334C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F6320989
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="1HHP2v8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfA0Ivf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:51:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37364 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfA0Ive (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:51:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so6421532plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 00:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3j1tnJn6chV8NybL+pzH4UR0FshETpkANJg0PhFiLu0=;
        b=1HHP2v8TK/FxyU5hGCzqdOVNidz2toX0d5jXBYkufqU5l1RlCB040W+pgi5wgwcAfq
         Oi1OL3ifqq5GwPMW7x3H0UM8QsW1VnmUxOnsLzEET4gVGLyWD95vAY8lWfK/FYnTcc1u
         Ap3nchs3/78KCHnwoUKgm+hRVqsvg8yAV19F6aBwNgZgL8+e/9zGhauV0AxBqF3hKyJU
         AkwnG3GiUD+MDfefnVE5uOlNQYYW4g/gQtfjwKNZQaWB1nlZwAgzw/JF6wSRKlDtDnEB
         nD7vQT20U4Ct/qY+4Fc8ycKJbRXuHFIcr15z3oAcYm8kkuv+6mOY0sMohiznhu3rm15Q
         Xo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3j1tnJn6chV8NybL+pzH4UR0FshETpkANJg0PhFiLu0=;
        b=ZyRISQMep+n5wZdArm8DIQL2ualqE38dQJukDGSJrxb9iEyaz7zUPJHqD83YOAzJDc
         EJdVHpLLf7+cjKCyB+ErCKAuhdLrSf7oIMX6pi1EtWrQlj+ohNG+VS6bE2BKfkTaUViH
         +nZlvVBk7yxNT7wEWpbhNESt9VUH4KaAAmd/5nLEQ27rMxvhyvINZ2+1E3Y/Ut4Q0Yjz
         SDg2s5rNZja0cDV9sH0gZ7ovge5ff9Z/iWy+qYLsVwmh7mHxFf/D4r+f26lq3DeRDlzF
         nH2e49N/Xe4RLc7zcv8O0PvjOwinAStFugK8bsfOMljzs+pwFv4gZBMT51UrbhVbBdxb
         HbpA==
X-Gm-Message-State: AJcUukeQY0xN+YHWSEv0qt2HRvtCj5/OHQ4ajo04hqtgp7jk4EYUBy6y
        nZCpUr6vgk2ISxFMeJl57WzucQ==
X-Google-Smtp-Source: ALg8bN6eqwQrJwyVjPcsqaMEYBts1ZFTGrW53qeJr6V3FaT95horzDetMnFCPpsyS3QBPPYCRLQ4AQ==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr17899561plb.10.1548579093770;
        Sun, 27 Jan 2019 00:51:33 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id z9sm74282234pfd.99.2019.01.27.00.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 00:51:32 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas.Ferre@microchip.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Include linux/gpio/consumer.h to fix build error
Date:   Sun, 27 Jan 2019 16:51:22 +0800
Message-Id: <20190127085122.11821-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below build error:
drivers/regulator/mcp16502.c: In function ‘mcp16502_gpio_set_mode’:
drivers/regulator/mcp16502.c:135:3: error: implicit declaration of function ‘gpiod_set_value’; did you mean ‘gpio_set_value’? [-Werror=implicit-function-declaration]
   gpiod_set_value(mcp->lpm, 0);
   ^~~~~~~~~~~~~~~
   gpio_set_value
drivers/regulator/mcp16502.c: In function ‘mcp16502_probe’:
drivers/regulator/mcp16502.c:486:13: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_gpio_free’? [-Werror=implicit-function-declaration]
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~~
             devm_gpio_free
drivers/regulator/mcp16502.c:486:40: error: ‘GPIOD_OUT_LOW’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_LOW’?
  mcp->lpm = devm_gpiod_get(dev, "lpm", GPIOD_OUT_LOW);
                                        ^~~~~~~~~~~~~
                                        GPIOF_INIT_LOW

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 3479ae009b0b..0fc4963bd5b0 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -17,6 +17,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/suspend.h>
+#include <linux/gpio/consumer.h>
 
 #define VDD_LOW_SEL 0x0D
 #define VDD_HIGH_SEL 0x3F
-- 
2.17.1

