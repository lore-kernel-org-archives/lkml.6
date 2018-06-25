Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E590AC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90621254B5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="INB5AQTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90621254B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeFYGcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:32:16 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43605 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752217AbeFYGcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:32:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id a14-v6so5627268pgw.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/UNu/CLhqFnzV9bQjqwHyQYU11lH5b2KA6eT6bzd3xk=;
        b=INB5AQTsw6NOqFOWiwkHlEm/g7p17Di9+t+wjztaz1W+HMygsfkecebcBMmN8ODwY6
         CEiiT18R3glk3vINqrqL/A5XxmF4Pbg9/apcStxFEt8m9P0nhsjq5BSlNhJDcMmToKe/
         9S9UYlezL18OB+Oj5CMKfn2KhBcS/QjjLzzsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/UNu/CLhqFnzV9bQjqwHyQYU11lH5b2KA6eT6bzd3xk=;
        b=a6PToZ18sPxzHZpTVvS4ItWymus8PpL8ipWBkF/COILeT0SiGd8UKbGCVNCt663lke
         PyolsIzNbR6cbWDkBQ/sfiwq5GD5n/i8fNH1sv7TlgvOfOKiH/hn15qJyUiLTr6yxi/I
         Wx7Wm2fhJa1eKYjgr4sx7Xc3nJkVeT2I63cfD9yRB30zl+vrgPu3GPTZSiSdMjFHdC1Z
         baeuEibK8en6x99GNSsXYox+N4QDAMQd6NV3HYGnneiKx0F8sxzJc2sP6ePW4vKXfZtv
         5B6Wq2iNzPOT+7u8CuJLw7TWqUkV4hKJF57cl4DGUcm1Y+nBz6GawxKCg0gCYcurVPOf
         6hpg==
X-Gm-Message-State: APt69E3x+s3a9v+Psz+ff9ot7QKPFs+Uv7z4pTzsjjD8+o+gFt0AKia5
        D0upjtgS6AAaO7XBo7sa7YpdBw==
X-Google-Smtp-Source: ADUXVKKLTjSsRH/gSarUHZeK798sxjd61Pm63kwXTWXc7si62XnlfLhtU+Xkzitili+JaKiMXGNBMw==
X-Received: by 2002:a62:da07:: with SMTP id c7-v6mr11693878pfh.106.1529908334424;
        Sun, 24 Jun 2018 23:32:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k15-v6sm20267911pfi.37.2018.06.24.23.32.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jun 2018 23:32:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     broonie@kernel.org, freeman.liu@spreadtrum.com,
        baolin.wang@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: Add Spreadtrum SC27XX efuse controller documentation
Date:   Mon, 25 Jun 2018 14:31:20 +0800
Message-Id: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC27XX series
PMICs efuse controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v1:
 - Add reviewed tag from Rob.
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

