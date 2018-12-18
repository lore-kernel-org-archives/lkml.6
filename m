Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E37C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234342184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EukJAVq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeLRUmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:42:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56045 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:42:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so3946070wmc.5;
        Tue, 18 Dec 2018 12:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYLyS1g50TJQa49kFdipvwPmtjnQUW+eyqeXzNQ0+AQ=;
        b=EukJAVq1KktoWdzdFWg6yvtAEMEprWDMyARIHZPc7OLcyn5PmEdMG4EHhPPsFui25d
         kcEL06O0ba0+V9tE97SJnsQl4vPdYxciOCxxWOvWwrR6k8fT0RK6g7NWc1VvEO5lEtFx
         oR+K2zKgqMizMMAlvr4xtB0hzovt6EpH9zPCP12iEVDoUw7WduP0urGAr9fVLfJXk+FR
         pGtnPrVOEt5HGhvRKm8FopzwQVl6ZA5KZsxec9116UPrpgQnpWolg9tsxee39csmmQho
         jQ0sTclqyd2YdxJm4u7W4suQaGg/Q7TOO35nEczCnPLsgkkQcMX1XtszmX63nGUyYmt4
         aqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kYLyS1g50TJQa49kFdipvwPmtjnQUW+eyqeXzNQ0+AQ=;
        b=F0w2RmwnHskKc1QTA9JdxeInxYYmJK/v+R5SRvJmmLa85rlSQvDEZV8nty5Zfk626F
         oIjIvglNTsrWPziYIXQJy6xDkb74NPFj7NimlfYF06Hyr/bAf7t7chAgLizlPQKJGf2d
         U+roUoNUvzdVKmnIBZxIRzdnEhDgeUA9e/2x+9r1mK6PSii6rsBVqHcLKKOfgKMoxec6
         sMdzoq1ySp3tZmQNAkisyR8jwwVP0FIRZMUfKmoXDH3otPwULV8T38m3J8g0Fl5ihvYX
         g2tUUPC5uNLTD0DoJm0AvRruimiKyCCYYltj4iMl8V4TGFnvcvQoS4Hf55/nW1XBZQYo
         VhoQ==
X-Gm-Message-State: AA+aEWZTutGrbhkTHvXOmhuSP9Hd9Gm9D+EMFoE4vFfmGPHMs09r+nu5
        l+iiQeImrw650ABhYKaLUqM=
X-Google-Smtp-Source: AFSGD/XEhT0NXLo6ePgW3xhlbf+UIaFAIPu1KCQ5+kVbRq68b+uSz9aq3DMerRFb00bQzbIkZL+c1Q==
X-Received: by 2002:a1c:c70f:: with SMTP id x15mr4570157wmf.130.1545165742390;
        Tue, 18 Dec 2018 12:42:22 -0800 (PST)
Received: from localhost.localdomain (93-143-144-99.adsl.net.t-com.hr. [93.143.144.99])
        by smtp.gmail.com with ESMTPSA id l14sm8745409wrp.55.2018.12.18.12.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 12:42:21 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: [PATCH] ARM: dts: ipq4019: Remove skeleton.dtsi
Date:   Tue, 18 Dec 2018 21:42:04 +0100
Message-Id: <20181218204204.4771-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The skeleton.dtsi file was removed in ARM64 for different reasons as
explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

These also applies to ARM and it will also allow to get rid of the
following DTC warnings in the future:

"Node /memory has a reg or ranges property, but no unit name"

The disassembled DTB are almost the same besides an empty chosen
node being removed and nodes reordered, so it should not have
functional changes.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -13,12 +13,14 @@
 
 /dts-v1/;
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	model = "Qualcomm Technologies, Inc. IPQ4019";
 	compatible = "qcom,ipq4019";
 	interrupt-parent = <&intc>;
