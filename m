Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92016ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEB32150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGq5bJfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEB32150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeITXnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:23 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:33689 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeITXnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:22 -0400
Received: by mail-pg1-f174.google.com with SMTP id y18-v6so1484923pge.0;
        Thu, 20 Sep 2018 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HyWERppOT+dY5sIQg5xrHJOi8fgr0viDyMcOe/mBKtY=;
        b=tGq5bJfhQln5YVazIUS+nFJB/3+lA6QWdvuMP8Y0HnTnsHUx5O/jlC+bkDUXO6eupr
         VYJP7TxxHjCZu1AxeLVXECCSikIH9zci+hWP7iakVtp4dci9WnZjwUzS+SzmCyhQwslP
         Cl2OJE1GjGb2teQznRB29+WdMwgLT4+M6Vpel1TTYvjXanwbM2AXXXLRthalhVhVAAm6
         27NV2M2OO+EFigfR8qld1L2yX8Dx1kYajGYoDwi3Xx0YcxnipDY4kruXUCRtPPxTKYP6
         ta5KO1tYZ9u8Bay+ZVDRGf+VuOHjV35bzQBXnOV/xvDhoSlq3wGnTA8IsYkBeHVapGMz
         vlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HyWERppOT+dY5sIQg5xrHJOi8fgr0viDyMcOe/mBKtY=;
        b=r6XGxbAiERUke5Lm4lsyzfJdXa+9TzETTf2C5GSl1neYe+oKxfANbrCcQ2keb8UbOG
         2Wem4e3L18zGbB1/8k3bNSO2zaSXZMUXGvqkwN4vEQmr0yHR+7F2D6UHuIJ0WEchNL98
         VEViEFa+qfnEbCskfobfP0xO3gm55jWcV6zZ0QY0pDjQHmh0xk6gLpigdoUfVluVxXmw
         9a/4Q/prrZ0ivetMfRig16VbzrJRqVeDXqqa4ob5nB22v/+oTwlrWM7YdeXZ8QwwtbWD
         vFT06fjX2iux3wCozaSWV6EpFNVEXx2A/m/xNneOLdYymiI1F0WOU60VcAMqqe22PBZ1
         7+jw==
X-Gm-Message-State: APzg51DEg/s1WeaOkjwhg/laoLrBCsFDZreLXKu3G3dtrr70EVKPTx2g
        Fk32fe0ITsYkBMUHeVQxo6k=
X-Google-Smtp-Source: ANB0Vda7Z8K2AFKZDh2v1p393FxOBD7tD1Ngp8cG0MfQTFH4EWf6pYS0BpEiUFmLWATz+ekxZJ4n/A==
X-Received: by 2002:a63:f14d:: with SMTP id o13-v6mr37566409pgk.236.1537466323103;
        Thu, 20 Sep 2018 10:58:43 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:58:42 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
Date:   Thu, 20 Sep 2018 17:58:19 +0000
Message-Id: <20180920175826.1284-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is series v3 since my previous patches we incomplete with driver
changes missing.

These changes add UHS-I tuning for dw_mmc-exynos driver.
Some new patches are added to enhance the performace.

Anand Moon (7):
  ARM: dts: exynos5422: Added UHS-I bus speed support
  ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
    XU3/XU4
  ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
  ARM: dts: exynos5422: use cd-gpio method to detect sd-card
  ARM: dts: exynos5422: use wp-gpio method to detect sd-card
  ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.17.1

