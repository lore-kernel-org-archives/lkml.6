Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209D321924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tk8sI1cT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbfBOEzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:55:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37059 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfBOEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:55:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so4339457plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=D7/RneycXXgs5+9wC9kC+gpuNNwAJvr8ojEXFhWO72Y=;
        b=Tk8sI1cT1A+es31pjCRVTsdUfW3xXQvG7BF/RXIWomcWBUmzsUxyLbBzy+Vh3LO2o8
         Ak4Ctq1CkUPDzwk6wTdnt6UfnXqxGYBC6iffHsSN8fZSShuDIvpGRBj3XWmNrUsW6tLY
         5fb0ZeyWWtivkBVnmkNHi0ssHaVdpfxNYYhCJmrwdpfL/JnBaxjVudCB/vhawh8KAMj8
         YB7T5rty/BhSamgUN6G9U1e9nBKtCno9Dv2xtp5AIJ2K/EG6DHvOmrXym48dUSUtuc4f
         urt1QwgSwr3ZMoJu+O3E+ndbg+IC6ebljmN6Ex5lX/vBOstGWyXD1mTcyHkkIOGJbFIS
         scgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D7/RneycXXgs5+9wC9kC+gpuNNwAJvr8ojEXFhWO72Y=;
        b=qvPOgXkjIGFgkCBEuiqP5KTxAI0HS5QJh+S9cdZ2up0m8Lzf9fpsQov2MooFHbcN80
         sFBgRiA+xKCt0wPYTVnHs0B7Aj5Kepme3cgokLXTtS4nxBB6l8L9xqNvFhLCwsB1A0+2
         05dXII7R1YbrAqAKKF3OtjT+o/Tn32mDGlrsbJZrQoTW11je8YBK/hb5+Vjn3bs5kz1Q
         OnLwsvHsJSnHvJCAQl/lgXPhMENuUVw8j3mNprZBy0AIz2WAY848HMeHPjn411xVbleu
         2KCMBcDRMzbtPzEx+nNXpyBGe3r2kIRQOxbeQpUfZnHpGTOmDNSHOsZGAxrEsTF6ouzB
         WU4Q==
X-Gm-Message-State: AHQUAubuDy1oAY+PM1vJI3ZyH03IaqnYCKeLsZPHRCVkGiPJXzqfu+66
        gdT+cG3+rmyNmKDj/0uBvHpqDw==
X-Google-Smtp-Source: AHgI3IZdHEqyvdOIUhiEAUJEv2DIMQ3aA9FAqxWlOI9AQdeRWjMjKU2/eEQSWhix+7dxbm+mEV2dUQ==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr7988979pll.68.1550206534188;
        Thu, 14 Feb 2019 20:55:34 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o1sm8600106pgn.63.2019.02.14.20.55.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 20:55:33 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: gpio: sprd: Use SoC compatible string instead of wildcard string
Date:   Fri, 15 Feb 2019 12:55:18 +0800
Message-Id: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SoC compatible string instead of wildcard string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add 'sprd' to indicate the module in subject line.
---
 .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
index 93d98d0..54040a2 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
@@ -33,7 +33,7 @@ Required properties:
   "sprd,sc9860-eic-latch",
   "sprd,sc9860-eic-async",
   "sprd,sc9860-eic-sync",
-  "sprd,sc27xx-eic".
+  "sprd,sc2731-eic".
 - reg: Define the base and range of the I/O address space containing
   the GPIO controller registers.
 - gpio-controller: Marks the device node as a GPIO controller.
@@ -86,7 +86,7 @@ Example:
 	};
 
 	pmic_eic: gpio@300 {
-		compatible = "sprd,sc27xx-eic";
+		compatible = "sprd,sc2731-eic";
 		reg = <0x300>;
 		interrupt-parent = <&sc2731_pmic>;
 		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5

