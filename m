Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E94C20830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Snm6SDTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E94C20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeKAPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 11:21:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35757 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbeKAPVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 11:21:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so7869089plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=Snm6SDTSaQ/l9o/BDxsYhovdRRy7N0i5fR2cZZfef37nN9PjGnA+rMCdnX6RsyCAlD
         ZymcH1BGFDclxRrORDjM168L+4PvtuDJmGFfDg6L850rocpCHBeS+b1WSNiGevOhkFbg
         BWYlFz/1JLjexGEEJ/jZXIwaXpN8LIokdaVzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=ljKWrD8LcmYxoAXtXqeQWIjAx4DDWZax0kaVYUcsSUbPDoKINOSEGLhSE/vjYEC4lC
         z0AkE6VsRMHnbx5e2m+p7tx3i+oWgxlazfPC+rrLNuiQF6IT2/gvyhS7Ei+/gZs6KgvQ
         tMgcMZYNhaCoVkGudC7h81dG7Fc2DxbpUM178n++3MAVbHmMqaXXdr6M5KgXEK+dDHVU
         xadDdV7xOY11IDQ6rf3Hma7VzqsAqf2O2iB+tpuQTMMwp2mwjQVbMA87M7Z+794MvIub
         aCeh9polYtLj6SyuFvFDQgR0c8y5nra6RwR3laK/Rgr7fOop7Cnt68Eg5P/8WkpnPEUm
         wBWg==
X-Gm-Message-State: AGRZ1gKsmoYbsVynFhuVW8C0mHG+tb/CgngYU1a8wnEL78AjyjoTRwyr
        jWrfiv5FA/q5sAGYZvgpqnIr
X-Google-Smtp-Source: AJdET5fzt8PSavu2YFb9NIyU1Or50n7Fl//3FpwgMpUOuJ4OldcCb7Fl6nm4koVQRoBOijVCuRnhUQ==
X-Received: by 2002:a17:902:9698:: with SMTP id n24-v6mr6625515plp.9.1541053174418;
        Wed, 31 Oct 2018 23:19:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:900:77c6:7824:4800:6aa6:75b4])
        by smtp.gmail.com with ESMTPSA id u190-v6sm71346726pgu.3.2018.10.31.23.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 23:19:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt6797: Add pinctrl support
Date:   Thu,  1 Nov 2018 11:49:05 +0530
Message-Id: <20181101061907.20224-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101061907.20224-1-manivannan.sadhasivam@linaro.org>
References: <20181101061907.20224-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 4beaa71107d7..231230d32d09 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt6797-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
 
 / {
 	compatible = "mediatek,mt6797";
@@ -129,6 +130,19 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt6797-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x10002000 0 0x400>,
+		      <0 0x10002400 0 0x400>,
+		      <0 0x10002800 0 0x400>,
+		      <0 0x10002C00 0 0x400>;
+		reg-names = "gpio", "iocfgl", "iocfgb",
+			    "iocfgr", "iocfgt";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt6797-scpsys";
 		#power-domain-cells = <1>;
-- 
2.17.1

