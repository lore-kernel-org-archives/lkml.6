Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E41ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF92520779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5mF7Fya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF92520779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbeGWRAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:00:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38362 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387998AbeGWRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:00:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so1726912wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usbvpM84D03PVtnGQhVCdxXJhk8fO01uK4ITF8UQWmY=;
        b=B5mF7Fyarhrc3QWrxoy2h4hQg7HRWWaOrV/VnRwXr7pEp9uUP6POsDTV2MU73Q9sLG
         Rl+gIMVkiH+EjPlhB7nhO5pTpcx0B0Swn1fhgwdxEo58GILaGooLBldbvCUU/M97HyYH
         zFZDxRV0HGkUcok5fc7YlIgdkZELDQn33/sHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=usbvpM84D03PVtnGQhVCdxXJhk8fO01uK4ITF8UQWmY=;
        b=DKRY5P7NpezB4eZmYb3pcdbGYT9WLN0M+97U1k6Tiy+6o9ae9LqgQVid+E4Rajx0vn
         e37DxiMRU8Vd+3Fiv9+lb+KAR+XPbV0+mBgDrKsUgk792YCVCffob8JHdzRkh+obyU/U
         1jCc2L8JYn1SDqo3e+s0q1+j+KalI8x0RLEwXb4j93aJUYJhpLI6i4xp51CVxfRtWfNw
         AJoMiiKD7ux/kfEHbOJd07MJ6IZUo4GcNcB2jgfR1oNPQJjsxgG9wCdPZ94pbUjpFNxt
         WK+ilRiHbxRqeDSDDlhuUo901yTo8mHS/67aXKAYusD8M2dDDy7rz/86+7MLuw4Oiw0l
         UInQ==
X-Gm-Message-State: AOUpUlHYtzfzGTIjKrprQnJzavjalnb0cIYu88b2D6hoGKXpI//yGpdY
        qodMi3HzoumyDr38UBQT/5EeXaUc8vA=
X-Google-Smtp-Source: AAOMgpfYZX79xog3eIdjZ67JmfH8gktXkLHw5HWqYZUQSvyJwrFMJ7Mjmdidwx9UAzM4dILYC/1IaQ==
X-Received: by 2002:a1c:5e08:: with SMTP id s8-v6mr8293652wmb.88.1532361496869;
        Mon, 23 Jul 2018 08:58:16 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 14-v6sm206385wmt.1.2018.07.23.08.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 08:58:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/12] mfd: dt-bindings: Add wcd9335 mfd bindings
Date:   Mon, 23 Jul 2018 16:53:59 +0100
Message-Id: <20180723155410.9494-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build
Soundwire controller, interrupt mux. It supports both I2S/I2C and
SLIMbus audio interfaces.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/mfd/qcom,wcd9335.txt       | 130 +++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt

diff --git a/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt b/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
new file mode 100644
index 000000000000..1f8c9e8d4e3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
@@ -0,0 +1,130 @@
+QCOM WCD9335 Codec
+
+Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
+Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
+the MSM8996, MSM8976, and MSM8956 chipsets. It has in-build
+Soundwire controller, interrupt mux. It supports both I2S/I2C and
+SLIMbus audio interfaces.
+
+Required properties with SLIMbus Interface:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: For SLIMbus interface it should be "slimMID,PID",
+		    textual representation of Manufacturer ID, Product Code,
+		    shall be in lower case hexadecimal with leading zeroes
+		    suppressed.  Refer to slimbus/bus.txt for details.
+		    Should be:
+		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
+
+- reg
+	Usage: required
+	Value type: <u32 u32>
+	Definition: Should be ('Device index', 'Instance ID')
+
+- interrupts
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Interrupts via WCD INTR1 and INTR2 pins
+
+- interrupt-names:
+	Usage: required
+	Value type: <String array>
+	Definition: Interrupt names of WCD INTR1 and INTR2
+	Should be: "intr1", "intr2"
+
+- reset-gpio:
+	Usage: required
+	Value type: <String Array>
+	Definition: Reset gpio line
+
+- qcom,ifd:
+	Usage: required
+	Value type: <phandle>
+	Definition: SLIM interface device
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: See clock-bindings.txt section "consumers". List of
+                three clock specifiers for mclk, mclk2 and slimbus clock.
+
+- clock-names:
+	Usage: required
+	Value type: <string>
+	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
+
+- vdd-buck-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V buck supply
+
+- vdd-buck-sido-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V SIDO buck supply
+
+- vdd-rx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V rx supply
+
+- vdd-tx-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V tx supply
+
+- vdd-vbat-supply:
+	Usage: Optional
+	Value type: <phandle>
+	Definition: Should contain a reference to the vbat supply
+
+- vdd-micbias-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the micbias supply
+
+- vdd-io-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: Should contain a reference to the 1.8V io supply
+
+- interrupt-controller:
+	Usage: required
+	Definition: Indicating that this is a interrupt controller
+
+- #interrupt-cells:
+	Usage: required
+	Value type: <int>
+	Definition: should be 1
+
+= WCD9335 Child devices
+Each subnode of WCD9335 represents a functional blocks like
+"audio codec", "soundwire Controller" of WCD. The name of the
+nodes are not important. The properties of these nodes are
+defined by the individual bindings for the specific device.
+
+Example:
+
+wcd9335@1 {
+	compatible = "slim217,1a0";
+	reg  = <1 0>;
+	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "intr2"
+	reset-gpio = <&msmgpio 64 0>;
+	qcom,ifd  = <&wc9335_ifd>;
+	clock-names = "mclk", "native";
+	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
+		 <&rpmcc RPM_SMD_BB_CLK1>;
+	vdd-buck-supply = <&pm8994_s4>;
+	vdd-rx-supply = <&pm8994_s4>;
+	vdd-buck-sido-supply = <&pm8994_s4>;
+	vdd-tx-supply = <&pm8994_s4>;
+	vdd-io-supply = <&pm8994_s4>;
+
+	codec {
+		compatible = "qcom,wcd9335-codec";
+		#sound-dai-cells = <1>;
+	};
+}
-- 
2.16.2

