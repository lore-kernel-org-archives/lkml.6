Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07754C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB90021934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="wR4EEsRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404289AbfBMWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:25:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34963 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404265AbfBMWZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:25:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so4373319wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEWpcrAzfnrCaSQuYe7fm49TUBEKGhf/xqry+uLQyng=;
        b=wR4EEsRlXSmqKa1MPOaBx78S3klJIcl3XtmzAdKfYqBpSeVfaQyxbKi2a9bibiIeoK
         qW6tEvQcO1HflLHMig3R2+gb3Hfl47rk9aP+5xKrZEUPjd4w6tTl16Wy92pwR+zVHVgS
         Z9/aXGtUCcWbt+6eGS5em+I7QweDMwPBNl/n5VMNbk+r+O/IYYxZLFvdBu7wBJUaNMlD
         x78OmUWaVhTBdd20DX0Zc2XCRU6u4CxgOfypCbpzr8c5F3RiKaeTXcH6fmR4vPy4CWXs
         qqGRBrJQ1Zj3u82ToeNXVYdz3GB8B+Clvo/T4AuLo25jykzjOKxNX9koUH3ETOs7WGq8
         BTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEWpcrAzfnrCaSQuYe7fm49TUBEKGhf/xqry+uLQyng=;
        b=MKtnYP8v1RdnN5NErxaS3AUR9xUEidrL4zjH2rGu/Di8OXJHK0Sk8nXoebrymVN6pE
         MWepo0zTVFLKaqmkLMgPXZOUZqcu6t+ggF6chk/yifkDabz3Y39RGlcTm3Vs8qpumLg7
         oEUh4vKT5SyYeq+QTBAoXyv4Sr/7r+eWgTi0a4IJREuShA4rLsdZH82/wzie4AK1bZqO
         Fu32MEfctG1fXnMXYutRkOt7Y7Kp2Ga8wliSckFMR2jtg9QoDn1bzEuRlqbrBckcAOcD
         Jrs5g9/8NPu0xNIkP38tkvt1pQOqLqiX0oYj6UJQmTf4RDGVzj9u8w7GCrHrEmAy2S2D
         zNXg==
X-Gm-Message-State: AHQUAuZ/G7BRBo0JIWlYMh1jJW5gQbjL567Sx0RwLLjZT2gFjzT7UAF0
        xA4Pec6D/EHLX83YheWi9DP5iA==
X-Google-Smtp-Source: AHgI3IYgPMDeFKq9B0jF4bIuhkXOPdI5t5MQanvGHeIAHYWsVAg5FW0nq+RWXMXFLEfw/903RWFsiA==
X-Received: by 2002:adf:dc10:: with SMTP id t16mr288086wri.40.1550096701900;
        Wed, 13 Feb 2019 14:25:01 -0800 (PST)
Received: from diamond.mathembedded.com (host86-176-243-198.range86-176.btcentralplus.com. [86.176.243.198])
        by smtp.gmail.com with ESMTPSA id h71sm788330wme.20.2019.02.13.14.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 14:25:01 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH v3 2/2] mfd: sec: Add support for the RTC on S2MPA01
Date:   Wed, 13 Feb 2019 22:24:02 +0000
Message-Id: <20190213222402.20541-3-stuart.menefy@mathembedded.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
References: <20190213222402.20541-1-stuart.menefy@mathembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC portion of the S2MPA01 appears to have the same
register layout as the S2MPS14.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/mfd/sec-core.c | 1 +
 drivers/mfd/sec-irq.c  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 5ff3fd726f9e..8a299080cb55 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -86,6 +86,7 @@ static const struct mfd_cell s2mps15_devs[] = {
 
 static const struct mfd_cell s2mpa01_devs[] = {
 	{ .name = "s2mpa01-pmic", },
+	{ .name = "s2mps14-rtc", },
 };
 
 static const struct mfd_cell s2mpu02_devs[] = {
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index ad0099077e7e..a98c5d165039 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -455,6 +455,9 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 	case S5M8767X:
 		sec_irq_chip = &s5m8767_irq_chip;
 		break;
+	case S2MPA01:
+		sec_irq_chip = &s2mps14_irq_chip;
+		break;
 	case S2MPS11X:
 		sec_irq_chip = &s2mps11_irq_chip;
 		break;
-- 
2.13.6

