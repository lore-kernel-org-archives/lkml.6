Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F251C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B87F218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="QnDDhtXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389888AbeLTVMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:12:21 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36038 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389874AbeLTVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:12:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 17B92CCD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 21:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F7jI_vqkwRbK for <linux-kernel@vger.kernel.org>;
        Thu, 20 Dec 2018 15:12:18 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id DF047836
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 15:12:18 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 135so2917488itk.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 13:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HO4RukVZdcBf5b6leDS1zyG1u0jFNmcDfd4j+T0qC4o=;
        b=QnDDhtXO8beaNSHXHorg/R1Ry62j3Fu4ilfHycOshdY9AXGIpLjZuWBLVTTvKCirjj
         FodasbHwqgTmuWv+5oaVRF1e8eljbUskK+j5dWJEhKyh8S7wViXsjCJemBTy0Oe74eSm
         JX1ewkSQF8sBpjj3mzptVfRde1wxNb9V+3XuuB3ZiQNNhg5yAHSIenQCctVLjpuUmELK
         PSIIaInDzAegZ+w6mK0o3qXKdBW0Tt4JjjgZvB4rObiaIfcBQfAdVNDMkcc4HYnRpIUP
         4S2KqzcHEAfLI6AyRcgFiwXogQAeJf3wSA59swrwr2Z5kqkUGtFrsw53WrToXMeTul1P
         ZAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HO4RukVZdcBf5b6leDS1zyG1u0jFNmcDfd4j+T0qC4o=;
        b=fTN5eaOZBBCVIURQVdf3u0+3ZTfravXZNSaDjZATZFRk0j/ow3nnZyXtCJBawerpKX
         w+WM3yh1SkQLosHKw1jCw/R983ftTamIy+zlIvZKlX3/yB9NrWIxuvim9rvh+UHqIKpE
         QkGTkysOtePaGNTDaicj4AgHlg78BPUGjOeKofcadAVKXQSTtx2w5VupBVndN7r1/Jiv
         NURVKgZf+6srSJRzHUpER3/hiOZg8OhqfQWL9mDH38twPE/rSmgT0F/u3cTK69B5/9CC
         kAU2wjYLK8ENDKgX3vhrfKxT8SFMC2v/hAbrTbe9OyQ5c+hGkh9+4VVCSc9sJu3kTh3l
         Xj7Q==
X-Gm-Message-State: AA+aEWbWFpiH1R2YUjYbUsNz8CqIWeI4QwuEsACFiHylDf245eqlBEPg
        MxwDx5jtxuNn6TbfGC3xA5BcFU4W1IKWjacHpeGEDqVPlKNTks+asvd4wdaigmAigponv5PWOh+
        UYTRJs2/VzGDqzFacjpCRmQ0YTOG6
X-Received: by 2002:a5d:8491:: with SMTP id t17mr22163911iom.11.1545340338541;
        Thu, 20 Dec 2018 13:12:18 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UspP00BI0HvLBezAguFyW5WAoWmTbeaa+OcKsi1xQFv184yiZ8rpQmUVQgQgyB1UuqfBU8Xw==
X-Received: by 2002:a5d:8491:: with SMTP id t17mr22163897iom.11.1545340338247;
        Thu, 20 Dec 2018 13:12:18 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id 15sm5164770itv.11.2018.12.20.13.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:12:17 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: mc13xxx: fix a missing check of a register-read failure
Date:   Thu, 20 Dec 2018 15:12:11 -0600
Message-Id: <20181220211211.32608-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When mc13xxx_reg_read() fails, "old_adc0" is uninitialized and will
contain random value. Further execution uses "old_adc0" even when
mc13xxx_reg_read() fails.
The fix checks the return value of mc13xxx_reg_read(), and exits
the execution when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/mfd/mc13xxx-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index f475e848252f..d0bf50e3568d 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -274,7 +274,9 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 
 	mc13xxx->adcflags |= MC13XXX_ADC_WORKING;
 
-	mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	ret = mc13xxx_reg_read(mc13xxx, MC13XXX_ADC0, &old_adc0);
+	if (ret)
+		goto out;
 
 	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
 	       MC13XXX_ADC0_CHRGRAWDIV;
-- 
2.17.1

