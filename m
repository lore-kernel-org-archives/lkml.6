Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D264BECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81120854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFoKOU0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B81120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeGVRdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:33:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40020 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730331AbeGVRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:33:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so14123277wma.5;
        Sun, 22 Jul 2018 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v++mViBsz/2P7hb3MFfeCqzMwwY362DL87GzlxpSqsw=;
        b=eFoKOU0hbtnfuj4umzFMWClh7+FccC8od6uRuCsLQ83ehkztN0X5FgvtrNuPj7+SWW
         6CGFHKt6lsxlRdocNjvY6RGWUJK12IAxrRTfRvMzHE2P8pfkifVOFt0ANHP4Ag9LCbOh
         frLQPBZGF9xFU9pmzas1i7Epi6NIpxHK9vNXqOUxKWGAOPWUmMMQ00mBHQdDi3X2lAER
         +nILjneWhbPYWDbdfmvSKTbsaFEO1K7x9pgVbfWyMSuwi3ae/8QD3Opo8sYyxscpTfuj
         WApPuX1AY/JwZQHhUr6TRGO/qc76Ia3i2odL/U2xxJx+7WvpzG93gUe7Di62L+Iuilra
         Ktiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v++mViBsz/2P7hb3MFfeCqzMwwY362DL87GzlxpSqsw=;
        b=h4FuzfCxnIm1dyMYeCXt1riQVDvLaZZZ+xNmWhGTRMeigLjZd58wucEDEjvCoIBa7Y
         JBwXTniCi6dt8c6Jpj3ZE087sXPiTpYBz5S6UmYYxYJ9NUII1zjO+GBcQJXX+/VrQQT9
         CFyARTVYjFk8AnUCZrPY2Si/bjLFSP7tury4eWceeWtTMLlnHRZYOHzDcZPW+dQHqv8M
         vjJZlwrl6Hllf5Uy7GaNOrtdhBlGf9OacvjffZAy3c/u7REdlIBnQyp9aU151NKQzc3U
         fQRIHu0Y/str3Xs3BqeM0IOltUzzIpqXXEIpRoS+AUPFmPzOPjA7QtFC8RX2gi4J480c
         uwzg==
X-Gm-Message-State: AOUpUlGijlse4uLc05yVDud+U+6Y6zOMR4bXNYryJ30d3/dPJCGee2GX
        hI0vYXiti+pbK7ifbyAxG5w=
X-Google-Smtp-Source: AAOMgpeGLOXn/3lZLmp8GtP0NhfFC/is1dlqeletBrdwfA9vTkWP6xdGuIRepYIykXi5OzsMjh/Gvg==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr5526058wmg.44.1532277383177;
        Sun, 22 Jul 2018 09:36:23 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.37.46])
        by smtp.gmail.com with ESMTPSA id z8-v6sm15195653wrp.54.2018.07.22.09.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 09:36:22 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi S700
Date:   Sun, 22 Jul 2018 18:36:01 +0200
Message-Id: <20180722163601.28346-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722163601.28346-1-sravanhome@gmail.com>
References: <20180722163601.28346-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 59d29e4ca404..88edac21e03f 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -179,5 +179,11 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl@e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+		};
 	};
 };
-- 
2.18.0

