Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0D2CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7E208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxSPzW27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE7E208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754245AbeFLFYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:24:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34311 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbeFLFYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:24:17 -0400
Received: by mail-pf0-f196.google.com with SMTP id a63-v6so11470568pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 22:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SRMRyCV4JLWJqhTv7bH4yLcksq83VPIf24vS6U3lsnY=;
        b=WxSPzW27WMTi5jxVCaJM6b6X0nO3WmyiC/HDwacDsaihXOo+2tZDMHgpiAmDl4WAy1
         HzuIdtDifuqSg9eZRqV5eSSoOeq6dwaKeNs5vYreL6P7z7gBI4YCtwngnV6EkMXr06hl
         S0Ih3EwDO7LjBjtSgvG32MlT+WusulhnKNNpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SRMRyCV4JLWJqhTv7bH4yLcksq83VPIf24vS6U3lsnY=;
        b=DHWKwv+hMVbnZl+rGupRRSJEUks28jyGolLZmKUG9cmvS1HewCbiZYI/9P/ZpsNBqx
         JqbUpNzDYHCzRW/FTgnQSRmyOu9dDghQftYMttR0+gYHsRRLBm9uukPcVgPYg4uh4TnW
         Ta1Uv4ek86ufg91BrKG6yhZ4zXhAJFOR2GOsp2cjiba6VC26/JS8LX5GkGtJwKL/vSwq
         4HyLgwGVzbI9LBU25ZS8ff8unXoy72bRB4q99CY69G55g+t7OMRQSQeX/ijrv8MeegCX
         0a8qmY1mA9U47YHqMvFnCIef0g5YiegkO1864swVMP/5pGhE7nlAGJR5XMBJlVbaKtCn
         hawQ==
X-Gm-Message-State: APt69E2WTFik5aZlDvZ3Kdn8CKv5s1MW9VkNL+MKToA29FowZtqIpLmd
        PnHHLn0W19K5mulp9MQehtrj7Q==
X-Google-Smtp-Source: ADUXVKLMQ7Rp578NmZxvq4NU48THqPYEFKjerDed3gsdxSF5atEAhocLPgwJMbfMJwvbTmO1I65n/w==
X-Received: by 2002:a62:d9c5:: with SMTP id b66-v6mr2244637pfl.41.1528781056659;
        Mon, 11 Jun 2018 22:24:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y17-v6sm140311pfe.33.2018.06.11.22.24.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 22:24:16 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        freeman.liu@spreadtrum.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: Add Spreadtrum SC27XX efuse controller documentation
Date:   Tue, 12 Jun 2018 13:24:01 +0800
Message-Id: <0a5444dd0646f4e1f1d8ce51870afe6cc864219e.1528780670.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs efuse controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/nvmem/sc27xx-efuse.txt     |   52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
new file mode 100644
index 0000000..586c082
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
1.7.9.5

