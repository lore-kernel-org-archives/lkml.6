Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1602082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RogriKRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1602082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeLABfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:35:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38684 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLABf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:35:29 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so2885081pfi.5;
        Fri, 30 Nov 2018 06:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ydDBLBzctTC2fIO9B/6FFt1pdVoMrccIC39jwxoMeTA=;
        b=RogriKRus1gsVYdRCMhPF4KIcV7swYz8gzBeIALJ1+pxFJoND1A6v33f0fWlFbVS++
         4bO92WYaQXH4t0JOgqFmS9ynsHY7mYH2h+FEcy0HsmYtNaggNdKhwB4op6QviwgyTVl/
         mIzZRcDcXRV6VeV5S7d6EPH4ikHoxmRVftLCDvkY4cZd/pUr2EDKKR9sye6vDONgBiVY
         Z6Z2iziDXCTkBrPRmZX9c/VVsu0MTelZ5e/+sXIYzyy6CToDKKMqjf6ao4Do+xZAu6nK
         LYDe6Qo7zrKRhInTzT2Lw+5fDdwcWfDv2zZQbfRndBDamPwb2LBaiI43YX4lwg+ReM5Y
         Utnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ydDBLBzctTC2fIO9B/6FFt1pdVoMrccIC39jwxoMeTA=;
        b=kkmSiAsVyt4BQu4B+cLIjIEWwQbxRvo/8OH0QGmOXQni6eXm6LVmKOaIr06rQkk5Aw
         G3LliDVsagJteokTZuo8Pn+DgHKETDqvrAxjV9nLKpRKCKKpoWTR5K4m8+Gt0m6eJXPW
         JeKjI5yPMMSC+hszWQ7z+O8XwZtBj6dd+eNopPkYmbLCGgunAPf+qW6ZUVGLp1yMm6LX
         JFvLN3yEiWq8+l6bSWEZqaBM3o5KYUCotfmyMVKzo/XBtUEAHPNfgzcCph1bf/wTt+lK
         V3lWaEtVftPnZ/ZElXMDsTjBrqqA/ZXnMPl2/frnM27B+CBZ919tMiE+z2TWq2xIiBrV
         fJ7g==
X-Gm-Message-State: AA+aEWaEZhydwbMeXSCkiqo3A+6TkxX7++YevcFHRX0umj6RdTn9N97l
        4JI4jURcHECaOQgMk+BE5xo=
X-Google-Smtp-Source: AFSGD/XiKnwYoxBoMVXWy8/p2mq9x9pViJCO1R/tRukiTXJkItOgIdxjrzGaWAwvLvvMg486Lm7T7Q==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr5062697pgf.240.1543587960676;
        Fri, 30 Nov 2018 06:26:00 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a9sm5304193pgq.20.2018.11.30.06.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:26:00 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: nforce2: Remove meaningless return
Date:   Fri, 30 Nov 2018 09:25:57 -0500
Message-Id: <20181130142557.2623-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a function whose return type is void, returning on the last line is
not required.So remove it.Also move the module declaration to the end.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/cpufreq-nforce2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index dbf82f36d270..ccff1f2a7c25 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -47,10 +47,6 @@ static int fid;
 static int min_fsb;
 static int max_fsb;
 
-MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
-MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
-MODULE_LICENSE("GPL");
-
 module_param(fid, int, 0444);
 module_param(min_fsb, int, 0444);
 
@@ -123,8 +119,6 @@ static void nforce2_write_pll(int pll)
 	/* Now write the value in all 64 registers */
 	for (temp = 0; temp <= 0x3f; temp++)
 		pci_write_config_dword(nforce2_dev, NFORCE2_PLLREG, pll);
-
-	return;
 }
 
 /**
@@ -436,6 +430,9 @@ static void __exit nforce2_exit(void)
 	cpufreq_unregister_driver(&nforce2_driver);
 }
 
+MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
+MODULE_DESCRIPTION("nForce2 FSB changing cpufreq driver");
+MODULE_LICENSE("GPL");
+
 module_init(nforce2_init);
 module_exit(nforce2_exit);
-
-- 
2.17.0

