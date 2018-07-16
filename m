Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21614ECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD7B208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KbKp7GhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD7B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeGPVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:08:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42458 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731093AbeGPVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:08:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so13641552wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeMFc/VSYYcl0SR+YLkTypqiD/OgX/XYa/k4d/5p16g=;
        b=KbKp7GhHh2UPQvxe31nyih1VSMfOp/d04g7au45VwAua2OAf8lTFPCPik1PcxGeEbD
         mXR0DtJpNcEj61wInxcn0DkZttIQwECeaJsFjBW7FS6uWI2EyxCoz35sVv7d8+/5P/ri
         MZICa7Itp6bsaYY3i67rx1lHWUgYg/Zr2Y6JChp16majJZB11FGrzaH6kfkmouFBVvja
         uYwPOCXogaH8/a4OsTBbvt6Iep2kUyD6m9D9tlKUQxepKu4hDkv0rIY4n8y7rrnkKhnn
         RXEVGiXZxCHZgTKsWqtmVsSg2epVB6tp+EZnsjy0WSUYoqhr7yxmEKC5NqTPnbBVU/cH
         8mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeMFc/VSYYcl0SR+YLkTypqiD/OgX/XYa/k4d/5p16g=;
        b=iCAc5jCuhLMxcDO+iF+m8ZrxgbKPpWCtO2gHX72exAxTGlpgsmQYshOTDZGq0Sgz05
         WJ5oH73ROylW1wYeApDF0pBC3h1/zuwh79Z65sQUHp/Nog/hLoCg8xGjUjF4X43fS/zY
         xfq5b9qXoCYnRmxT43Gc2PVV1nx4bjsV389wDqaaqxVKiSfEuIQpBDNR+fI691wAJk2g
         kHR2/UlVJgxh9xS25gF54CxlkI11y/JXGyMl9/s2Z4/JRKiVPRuRiPuKojJYE/qEiyuq
         xZooDgWMMjL5WxD703LqqV8K2+uTyMihrKy9JtU2Y7OJOqheya/2SiC0Uih9UpY5ySbo
         ULVw==
X-Gm-Message-State: AOUpUlFytRBU+LoTNxIiZqWM7FhgfjHbOSwpwW3yDdz5ze7NVMvc/1WS
        xUwwWcw/vgtHCbxgDsNHsZPKeQ==
X-Google-Smtp-Source: AAOMgpeGU1o2MRFjeir1SlGD5Z+Cl8sBzOQRvssxeNf7/5vlgN9sRH0XZQfLrU6mHROVrSafixbuOw==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr13822973wrl.270.1531773550928;
        Mon, 16 Jul 2018 13:39:10 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id j43-v6sm53533686wrj.1.2018.07.16.13.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 13:39:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com, daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, drivshin@awxrd.com
Subject: [RFC PATCH 4/4] timer-ti-dm: Fix omap_dm_timer_of_set_source()
Date:   Mon, 16 Jul 2018 22:39:02 +0200
Message-Id: <1531773542-15736-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the move to clocksource, the omap_dm_timer_of_set_source() broke
because the "fclk" clock is now defined in the DT.
The omap_dm_timer_of_set_source() was using the first clock declared in the
timer node, but now this clock must be named as "src" and clk_get() use
"src" as clock name to permit specifiying the parent clock of the timer "fclk".

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 4cce6b2..868bc78 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -150,7 +150,7 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
 	if (!timer->fclk)
 		return -ENODEV;
 
-	parent = clk_get(&timer->pdev->dev, NULL);
+	parent = clk_get(&timer->pdev->dev, "src");
 	if (IS_ERR(parent))
 		return -ENODEV;
 
-- 
2.7.4

