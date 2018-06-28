Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2DBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CAF27750
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ji7xVmIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CAF27750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030393AbeF1SMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:12:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42104 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030379AbeF1SMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:12:21 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so2812491pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKaIsRyzKhkDg6J6wTu4UQOBDgSWw0ctIoQUWUurWRc=;
        b=ji7xVmIFpaBfSXoP22cxp8bXZPqOWBonglvDMbdV7VGjMPYTt6gNpSmrnI1MqdGzn+
         PiEe5xE6h4U4z9SgwtXuLMu86ZTxQjWcnKEGuttIGyZ5YOw9L7d55Res/BGRNOFTKBSd
         sHPTFEQOrxA29jezCY/E9XSAqJInIRSusLkP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKaIsRyzKhkDg6J6wTu4UQOBDgSWw0ctIoQUWUurWRc=;
        b=Cgsb8MB7UJDXx7cxfbY1wMfLLiyptEKUqIj6yfjY5ibKUuEh0i8vx2A9JpnCWnAHQJ
         UTqZxZ8RxFUJQHvhlMDlN0bW9dLDgjhIHSVWQXZ6LWgxMwJAkJEHVo8eivUGcyaNRNZg
         mHUatSUiYnuZlxWBBkhPU3v1edBCJuKP8RYepWtYSTQ6nLvIO1yeZ9M7NR6kDpPHli2p
         7TEgfvJ9mWy2Lr3dawtKhMU3+4buzBP/77I1Aqy1gySYJJ+fsR5wqC8ykO1OxCmbCLNZ
         9EDKLwgAGASQP2rX3CxGsLWimlK9GDYb1Y5q4gDiOPhHlhllaibkDSCcusX9QpWlQFtl
         zy8A==
X-Gm-Message-State: APt69E20aKq8Sa2Oyhh0ZPsOnJuGmIJtR9/WcoDKJlDDG5tlANKcYyUd
        uNJpvibsx4zLmIZhKDLbMtVI
X-Google-Smtp-Source: ADUXVKKNXuf9U4Z0GxcH1hpb4xoLCMU50UOieja+PEOfgADLx0ZSuRQiPaKJ3a2Yq4uK9uL1wk3Ejg==
X-Received: by 2002:a63:3f05:: with SMTP id m5-v6mr9578133pga.51.1530209540867;
        Thu, 28 Jun 2018 11:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:12:20 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/6] arm64: dts: actions: Add pinctrl definition for S900 I2C controller
Date:   Thu, 28 Jun 2018 23:40:39 +0530
Message-Id: <20180628181042.2239-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definition for Actions Semi S900 I2C controller. Pinctrl
definitions are only available for I2C0, I2C1, and I2C2.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../dts/actions/s900-bubblegum-96-pins.dtsi   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
new file mode 100644
index 000000000000..95e8b31071f9
--- /dev/null
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+&pinctrl {
+
+	i2c0_default: i2c0_default {
+		pinmux {
+			groups = "i2c0_mfp";
+			function = "i2c0";
+		};
+		pinconf {
+			pins = "i2c0_sclk", "i2c0_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c1_default: i2c1_default {
+		pinconf {
+			pins = "i2c1_sclk", "i2c1_sdata";
+			bias-pull-up;
+		};
+	};
+
+	i2c2_default: i2c2_default {
+		pinconf {
+			pins = "i2c2_sclk", "i2c2_sdata";
+			bias-pull-up;
+		};
+	};
+};
-- 
2.17.1

