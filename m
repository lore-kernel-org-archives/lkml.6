Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F61C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C187320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C187320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967251AbeFSVk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:40:26 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33634 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757188AbeFSVkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:40:23 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so481953ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1TuWR6BmmhJF//ALmZxhGuMOBC4jPLrHbXFzJc1D/aI=;
        b=OkSK5mx5f6GmpbNHJ69NKqWIArzybj2xAhFOTd7zt1sJLHEraWOKFjBIzhRbrLMZHW
         tL5IFokrO1ducMcnGsb7uM+018i1QPp7rUr/b0WSXboUmG7GuNDaSlD0T2sIGplqcrrY
         W7GHRhgRvxdqnerE2+Q0oaRCvEfwwstMSNTDp8eXA51Cm/NwVxcIYph/BK4ISe9d+XQf
         cO2NkFy2BswgOXbxB8pWkCMgXv41rBH2bXQOQ1s460+U3ArREu65goxFgh6o6jR2Y/Sv
         mInV5XvCyD1Y+sDyTLYJJrPdeVJv2SvTIIoJ6AE/dd5oQg4bmXMTRC4xr00AoyIljHph
         Ke7w==
X-Gm-Message-State: APt69E3UhCBTL8HScOCdcY30hz/93WVLs/Pa2uU++/kWx0dJG7w7fLmx
        x2m4xVMrT5PsTGCfFLM0O3Yj4UA=
X-Google-Smtp-Source: ADUXVKJ4jkFBSQS+vM32bHtUE8P1H2cqMJWHo8XgVg0oOwvb1URnWx0GmvctdadlFZucQDC2Pe37aA==
X-Received: by 2002:a25:b6c2:: with SMTP id f2-v6mr9298053ybm.329.1529444422698;
        Tue, 19 Jun 2018 14:40:22 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id w6-v6sm282411ywg.98.2018.06.19.14.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:40:22 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: at91: remove unnecessary of_platform_default_populate calls
Date:   Tue, 19 Jun 2018 15:40:20 -0600
Message-Id: <20180619214020.18608-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will call of_platform_default_populate, so it is not
necessary for machine specific code to call it unless there are custom
match entries, auxdata or parent device. Neither of those apply here, so
remove the call.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-at91/at91rm9200.c | 5 -----
 arch/arm/mach-at91/at91sam9.c   | 5 -----
 arch/arm/mach-at91/sama5.c      | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 656ad409a253..42583261951e 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -8,17 +8,12 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 
 #include "generic.h"
 
 static void __init at91rm9200_dt_device_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
-
 	at91rm9200_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
index 3dbdef4d3cbf..863a0e7ba00f 100644
--- a/arch/arm/mach-at91/at91sam9.c
+++ b/arch/arm/mach-at91/at91sam9.c
@@ -7,9 +7,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 #include <asm/system_misc.h>
 
@@ -17,8 +14,6 @@
 
 static void __init at91sam9_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
-
 	at91sam9_pm_init();
 }
 
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 3d0bf95a56ae..e3a84a59db76 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -7,9 +7,6 @@
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/of.h>
-#include <linux/of_platform.h>
-
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
@@ -18,7 +15,6 @@
 
 static void __init sama5_dt_device_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
 	sama5_pm_init();
 }
 
@@ -47,7 +43,6 @@ MACHINE_END
 
 static void __init sama5d2_init(void)
 {
-	of_platform_default_populate(NULL, NULL, NULL);
 	sama5d2_pm_init();
 }
 
-- 
2.17.1

