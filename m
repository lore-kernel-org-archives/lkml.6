Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696FC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647812133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="jkkcqThj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA0OYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:24:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0OYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:24:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so6825600pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 06:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOXaIGO07SqD6VX+hKWuJ/AUa7VvlqvEGsTfV5hokdw=;
        b=jkkcqThjxKvk2OTv81Yi23vewUSo8Y+9rPIpmKdUBRK4zXt7ZLSRNjxRJhgwIlxFdd
         RDzQiGOLRrb+HdBfYxgy+VQd/utKYB7Ys1+CK2dSDvkS0ggJhRAIkkVIfCBYfxpcStYT
         X/tcIlRfKm1PYjLq2/PRP7xtPYOWYROzyhl/YeStDdBIMiDhXY5PtE0lkS1E87kAP9mz
         ZhV/caAOC3Bup1zHqLTJq6rV7XexuApcHIRuntQqZqtSdFb1P03OEib6MlCx0MymO3ul
         MZA9m+r29w1DqNtk8iEXQZU2jrWky0oEo0q0sp7mTtgSsPJD9dHcqfTCfRN+6g9+VM8V
         QhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOXaIGO07SqD6VX+hKWuJ/AUa7VvlqvEGsTfV5hokdw=;
        b=uERSI29UhvSPzvyb5gbsyD+TMXvnFWLGZrfIvzuOIz2iYo712lPjPUPIIBvthU9B6r
         lQkJhVeuJAZrxBZBRKpTzcco+JKsd0pgRTE+LhcwT4QiDc/K8Hc8qpm5+fVpdXiW6z63
         kjHDYemF+wvwra9DJ/RA/KEAwzcvzY53EjRsQFm5Gqg9BO0OHVoqSLvYs5b0MssQwJfi
         WO2dUpRy+jPL/XJ97acasiUaoDTsNgOUBT0Vmdv6KFLzp5NTjnmnJpHzTs7WlyWe6jU6
         ugddpdUeK0eKAzJQtjQ6dzwpjxt5a4wOQlH/GZrvZSMcyLjOjImA4mvHzhdkAH9wHR9E
         tmRg==
X-Gm-Message-State: AJcUukcs8obTtFdTCexw5cJrxgK80kBVWUoUpRpEyuxjp1UVMxB6VDBZ
        Kpe/RsGFuULyUBnrioXlGatJXA==
X-Google-Smtp-Source: ALg8bN7vz+/u+W+jJ2DNkCAYXBu4fCVPC5CljVJMWE1VJXJ+LK0Rk8WDuiFTH9C/UMgp/1G3juG8aw==
X-Received: by 2002:a62:d005:: with SMTP id p5mr18487606pfg.175.1548599054561;
        Sun, 27 Jan 2019 06:24:14 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id f67sm46757219pfc.141.2019.01.27.06.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 06:24:13 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Zhong <zyw@rock-chips.com>,
        Wadim Egorov <w.egorov@phytec.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: rk808: Update module description to include RK805
Date:   Sun, 27 Jan 2019 22:23:44 +0800
Message-Id: <20190127142344.26612-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190127142344.26612-1-axel.lin@ingics.com>
References: <20190127142344.26612-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver also supports RK805 now.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index c18ed632c95d..08578f6d737d 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1,5 +1,5 @@
 /*
- * Regulator driver for Rockchip RK808/RK818
+ * Regulator driver for Rockchip RK805/RK808/RK818
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
@@ -796,7 +796,7 @@ static struct platform_driver rk808_regulator_driver = {
 
 module_platform_driver(rk808_regulator_driver);
 
-MODULE_DESCRIPTION("regulator driver for the RK808/RK818 series PMICs");
+MODULE_DESCRIPTION("regulator driver for the RK805/RK808/RK818 series PMICs");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
 MODULE_AUTHOR("Wadim Egorov <w.egorov@phytec.de>");
-- 
2.17.1

