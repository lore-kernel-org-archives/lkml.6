Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE17C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4593620BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCBCn4Xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4593620BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbeGKK0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:26:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54978 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbeGKK0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:26:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so1886145wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7GoYzDLAtKHDNEwJP4P6UfHOpfVH9QvloZ3kY2/pwHQ=;
        b=KCBCn4XnxOFEOsS9fPdLLtc/urmSwi6/envSN1JfH+GIFVQH/PTIXncjs9zDXAqMVY
         j6k/uyIPbCDb/TPBO5r5knBHaW8Fp/T8OH0k8SHm8aSLs91PQtanuPdoOoZtPXj3MIxx
         JFPE3PK4/1HCbKVWmIVdIHq4I18voLtrx8YAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7GoYzDLAtKHDNEwJP4P6UfHOpfVH9QvloZ3kY2/pwHQ=;
        b=mQP1S0/uz6vBPpImd9hOSnqta0gi2f5Eh58RPuaWAVWicVicCz1Dkqhq419ohNtPgO
         0/JPhzeqgUXmpyQTMgx7GT6ZLMNyguR9iw435Lg3BvGW1KvYtToa72j0k7UO+/nZcBp8
         xL6AMBryZjoPItrgWFPWbOe56L8bGkdjAjno3RbBAGcN617oU06FLE15DIwuzEKAZNUO
         KUohhJ/t3JACNCB5uqn9RrI87ObwFHMN6xNFf2N7GBPbPk7i43bU4qVSNg7E5MtOqYP+
         VCtxf9ohdeGiR/OEwTnVu5igL2tCbT8fCfKPN/COiU0QvyKQ5G6RsfHffJSSYces4NRX
         9eFw==
X-Gm-Message-State: APt69E0YdahHHB77NaKvNH57fOi5LzEwwqsMcObxr646L5yE7tn8PlGo
        ixKMOX3Dbba/WVxHIOiiRhB4Tg==
X-Google-Smtp-Source: AAOMgpdXcbT/M8R377IRkFEcxiy43XGxG7G03cpbq6Z3Dhk5bSKDlnUMHdBanrDGI6lm8l1frQT4vA==
X-Received: by 2002:a1c:f308:: with SMTP id q8-v6mr16212307wmq.6.1531304572937;
        Wed, 11 Jul 2018 03:22:52 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2462032wmu.37.2018.07.11.03.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:22:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] dt-bindings: nvmem: Add Spreadtrum SC27XX efuse controller documentation
Date:   Wed, 11 Jul 2018 11:20:40 +0100
Message-Id: <20180711102043.24079-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
References: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs efuse controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/sc27xx-efuse.txt     | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
new file mode 100644
index 000000000000..586c08286aa9
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
@@ -0,0 +1,52 @@
+= Spreadtrum SC27XX PMIC eFuse device tree bindings =
+
+Required properties:
+- compatible: Should be one of the following.
+	"sprd,sc2720-efuse"
+	"sprd,sc2721-efuse"
+	"sprd,sc2723-efuse"
+	"sprd,sc2730-efuse"
+	"sprd,sc2731-efuse"
+- reg: Specify the address offset of efuse controller.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+
+= Data cells =
+Are child nodes of eFuse, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		efuse@380 {
+			compatible = "sprd,sc2731-efuse";
+			reg = <0x380>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			hwlocks = <&hwlock 12>;
+
+			/* Data cells */
+			thermal_calib: calib@10 {
+				reg = <0x10 0x2>;
+			};
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+Example:
+
+	thermal {
+		...
+		nvmem-cells = <&thermal_calib>;
+		nvmem-cell-names = "calibration";
+	};
-- 
2.16.2

