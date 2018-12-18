Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFFC21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6ivAqyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLRPD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:03:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47027 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeLRPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:03:54 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so8248313pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zcGwIisGD3xe1Hi10sfTFo4sWeyzLGuK/X6UgTn9Mq8=;
        b=f6ivAqyq0w5nlhZ64fTOLvUYLzZCviL2IHcDV94FRjYkb0hO0NBSAsTuGvvRQfhbLM
         IwTNxva5mndlup6iOhak/AtnTwbiJ1iKCa+CaAWCe4OaMy3a6ma33tcuxN8K8z8vFRvc
         DqKEee/E1gR9OIsfDHQ49/vXQfOAA3695ETos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcGwIisGD3xe1Hi10sfTFo4sWeyzLGuK/X6UgTn9Mq8=;
        b=kOSPHHWn9Tl/P3yoGnRerQ43bIY9pF7w6zt7UczGeBfBvrY2wpNCxzLKORXyPyw9Py
         aptDY797w5QI307RrCEcxTFpH/TpXv7qEjaqSlV8XajapWGDWvVdRGDGJD23K6PUPt5W
         UFHl9l53PP4Ob9VZRcnWBLjXJgh8UQJTMZXyG+BYM2Ztxy3YxcJMMCgyr/RyLWXkxO7C
         ePKvB0HEmo8V8LN6MHxKaazZaO6e4+JwHR4HuIevIQj9AMJHFG9s9PNrSx5l9aASpS8e
         0Fl405JjpadfQSaSEznn3WWeWbpvOt/uS3MOYWPTk+btZ0loQuKzAME24nEXOARVC2U+
         OCxA==
X-Gm-Message-State: AA+aEWbpBfa/kjNtBA7a/v9SAWa1lFbSGtqWDcxtXJagfsNu111tfewv
        XeQduQfdQ9v24csVOZju1yCT
X-Google-Smtp-Source: AFSGD/UPjymwPQoXl7pFQFBvNtOwB9L8rNCGFVk4qL2jb46eilT7lTlW0tBBQGWkPvdR9FeaISMxzA==
X-Received: by 2002:a63:8742:: with SMTP id i63mr3163859pge.298.1545145433135;
        Tue, 18 Dec 2018 07:03:53 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:03:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 07/11] ARM: dts: rda8810pl: Add timer support
Date:   Tue, 18 Dec 2018 20:32:34 +0530
Message-Id: <20181218150238.23010-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
References: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 15547b138977..84baa4c0a14c 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -50,6 +52,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
+
+		timer@10000 {
+			compatible = "rda,8810pl-timer";
+			reg = <0x10000 0x1000>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hwtimer", "ostimer";
+		};
 	};
 
 	apb@20a00000 {
-- 
2.17.1

