Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E620322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zps0wWv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E620322360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeKNTKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:10:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38935 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeKNTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:10:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so7481038pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 01:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6T859OE4NJWTqvgX+TL0bubLH0enxBhyUjtGnzBSLI0=;
        b=Zps0wWv7/q7ZRQZ/iIe4l6G9gOy8DfuTwF5+MwHJD71ousE10RZOLRTwGN1HJWc09N
         n2juAVMnPBg+TCT3Khi77cMx/bUD9xoLHSdxKoXUXlOOzkhrOsBZNen+Fr1ZsoRVvzvv
         IVzTIoPjfi0hR1R3qZdwCGa3taAWv3pjcXYFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6T859OE4NJWTqvgX+TL0bubLH0enxBhyUjtGnzBSLI0=;
        b=n+EXmOCgTAWQOcwYZgMAGK+joZtLuB/LgQhnYwCNk4C6ihDTk2i9bHCWSsT2pRpFXL
         NohN623OoBKLtIsq7F5b3c0lwYEemHIwFQ9gag7BlG3lrftJFcPG7i47FuU2RB+mdkj3
         xV2ZUAjb7mlPEEXWFsBPEBvmfyQVR3lY1IgGCoQFvXDb/GbuLEhHSmN3K4WYGrdz42jv
         oi9OpkpmXv3jd/EEDIMnrqS71kSKHGgJHER3F97CuUvRnRcDAMQqsSUrHaT37axbgzzY
         GlrPox9U/s806OaHgNNfUGr77u/tHZDiDjikqe8oSrLpXczgz8NgkHyUpfnrcl4peU64
         1Niw==
X-Gm-Message-State: AGRZ1gIKsJku4zIn5BCCD9vQle8vr115Flcr44Zyp0W8D9h23ZIH5URs
        IwNVz6iuvXnuRe5n959kKnDhsg==
X-Google-Smtp-Source: AJdET5f9KenepdN4HJ6ifPtXw/elJ1lBsbR2AZ3rV0o/uKkRE3vKyI4mJwm8wx0u/KuqrB9pGjcEPA==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr1115186plb.151.1542186463648;
        Wed, 14 Nov 2018 01:07:43 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 127-v6sm25048814pfx.91.2018.11.14.01.07.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 01:07:42 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 0/5] Add new features for SC27XX fuel gauge driver
Date:   Wed, 14 Nov 2018 17:07:03 +0800
Message-Id: <cover.1542185618.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds some new features for SC27XX fuel gauge driver.

1. Read calibration data from eFuse device to calibrate fuel gauge.
2. Add low voltage alarm to adjust the battery capacity in lower
voltage stage.
3. Add power management interfaces
4. Save last optimized battery capacity to be used as the initial
battery capacity if system is not first power-on.

Baolin Wang (2):
  dt-bindings: power: supply: Add nvmem properties to calibrate FGU
  power: supply: sc27xx: Add fuel gauge calibration

Yuanjiang Yu (3):
  power: supply: sc27xx: Add fuel gauge low voltage alarm
  power: supply: sc27xx: Add suspend/resume interfaces
  power: supply: sc27xx: Save last battery capacity

 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    4 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |  453 +++++++++++++++++++-
 2 files changed, 444 insertions(+), 13 deletions(-)

-- 
1.7.9.5

