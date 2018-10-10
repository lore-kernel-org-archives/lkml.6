Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D38421502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuOPv/HR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D38421502
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJJPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:51:24 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:33739 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbeJJPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:51:23 -0400
Received: by mail-vs1-f73.google.com with SMTP id v12-v6so1748523vso.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AwXMCKKMNpz1qsc+WgZgrCNuaJKNUnwlWlsdRSUucxU=;
        b=HuOPv/HROKDk/joAfAgm23acOqU86A3lQUS5MbJruvamIOLrRTnK0xD05L/Y0Hv0+3
         hfaJRaeMbewzjwBW79G/sgCaUnO+T+pJ+6lEq10HQXanRQgF3CsSyyH4AiPAbr89PNBN
         KfVvBFR0SDpFUpynifw8cMD/eDYnoJ13RZ0s5wU3Sed4kIA5IhTkQTrMLMHfVgtaMjeI
         3cYZYA7X/ueMcaw3HbCuZFJ6ce/8vCXD2jPWOEZDUmJunr84Z+rFaWjdWoEwndrRdPut
         WmgV/8Xk+KUpBoMu9YzNqAvCRA5MmGpoKwn+b/TIllCvWnWbC0At57llDz1L62wxRBwT
         5N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AwXMCKKMNpz1qsc+WgZgrCNuaJKNUnwlWlsdRSUucxU=;
        b=iT8nnKWm08OcUrEEdiQX5e80/r305dLjAX7IpVYTVJqDgNEFoUvJfp+3HCylNnC3yX
         uilPLLc/8dVvXAydK61eC80Qf2I14ElJoQaVJfYghq1FqtHATG5VvtTCPn+af+82y4yA
         dUfQ4T7x28PQidwIhOm8KNB/5VtezDtkekXEsQRLRyxvtSWJ+xgH6kIvvNXQjhylLL0m
         FPZVpPUxbBsfbWNRT/wc4NicK4nkPoYTLPGp3MLJN+VzBaIp6BqbszpnfEX0wu44z2Gl
         /CUH7+ZXzRO8/60/U2vhcbbqWvDmUQ8xtZQ2d3Tq6cXf9ZjcDmPh8CV8Rnr5EPVCPg/n
         LZsQ==
X-Gm-Message-State: ABuFfojDpT6jFPUHrUOBw1himnNooJvgsiUUS+d4i2zjpMuQ1/glfjPK
        CoGYBfAA9wJN64Cr9x0aB+MTYvpUzuilBY1XZ9gL7XwIdr/7yOQBL1T/xw2IzwVcXw8F6qoOLir
        F1q6jMXBMb/ult9GcTmKLfj6HaA4tczHXQu83O76R5uG2BXyRkTm1L+4EC6Y1OK1LCryd3Dbfr3
        Un4RzABQw+t2psxBs=
X-Google-Smtp-Source: ACcGV63H2EeWwvLBTuqcI4Svfa8jvuRXASqq2W6zxj4ZWQ0jHSsh0zspu6XEjS6VnJqqUS5mAH6TE0galBOKhWGA1NaKjg==
X-Received: by 2002:ab0:9d8:: with SMTP id e24mr27765583uah.12.1539160218219;
 Wed, 10 Oct 2018 01:30:18 -0700 (PDT)
Date:   Wed, 10 Oct 2018 01:30:07 -0700
In-Reply-To: <20181010083007.239938-1-matthewgarrett@google.com>
Message-Id: <20181010083007.239938-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20181010083007.239938-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 2/2] thermal/int340x_thermal: fix mode setting
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

int3400 only pushes the UUID into the firmware when the mode is flipped
to "enable". The current code only exposes the mode flag if the firmware
supports the PASSIVE_1 UUID, which not all machines do. Remove the
restriction.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 51c9097eaf7a..e9d58de8b5da 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -316,10 +316,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
-		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
-		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
-	}
+	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
+	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
+
 	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
 						priv, &int3400_thermal_ops,
 						&int3400_thermal_params, 0, 0);
-- 
2.19.0.605.g01d371f741-goog

