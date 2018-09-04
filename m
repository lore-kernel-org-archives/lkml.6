Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BBDC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7620843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jw+ZlrUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIDJXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:23:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35578 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeIDJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:23:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2-v6so70498plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gXPJN9soG+baASlFRGJNtCSqRvBu4NHCq/k4vbGCSXw=;
        b=Jw+ZlrUa/rmg9G9pfTW85jY2YxtzPctYs0vRsjjNHm5iQWSO0nEfQc9Ktj2JdsRvW9
         UYA0gG2jrLg+3T9q7TQzVnuHtRGPlXuv07OCdtvlrnqzUgeRpsdkTDKpFEVT6GTR1hQ6
         vkuKtzAmxf/UYWGVk+cMgjZNc2nEg569yblno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gXPJN9soG+baASlFRGJNtCSqRvBu4NHCq/k4vbGCSXw=;
        b=TiPe/fUCY60dD+oUykT5JbczJQCUT6pOpT6HailtBML6twn+b7jFYCycoXizeAiMpN
         XRGabVHU9ArP5gc8bf/L9qqMjtvv91Ga+cmlm9PEvNftVcbPS3TuE9w9Fs7Tsck7CnrM
         gkt/Py8JcMKrb+BTnC2Ba6yH8gt07mRgY2Rz+RiCc3NdhizonN3qmSwav5o01w4QlEAV
         u56m+if/JH1QwAGf47G7xo3rMHyQd/F4zhHUOI9IrXvEagz/UPTxX7KKmHRsP+Euw8d/
         XkxivZKxOsJI2WB/kG4cxldOBudiXxTOcEMo2HVRI+LimvoJeOpL/b1hMjimQKcfx2wg
         NNQw==
X-Gm-Message-State: APzg51C2YC2SpDZLDU58KJDB8pc4w8w0KyByp0SUHbgIPYXJAK2IHfN9
        eVYF64d8POITRsV5CTsA9HJxzAoklTo=
X-Google-Smtp-Source: ANB0VdYHBeGovXLpfZEvNhGl5XAeKrP/N45TLITUPbKn6l4MH9XQfykII5bUAbk1WB8Osw5HBU0OKQ==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr31165312pll.47.1536037183229;
        Mon, 03 Sep 2018 21:59:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v72-v6sm41180378pfj.22.2018.09.03.21.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 21:59:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] arm64: dts: qcom: msm8998: Add smp2p nodes
Date:   Mon,  3 Sep 2018 22:01:23 -0700
Message-Id: <20180904050123.26601-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904050123.26601-1-bjorn.andersson@linaro.org>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the adsp, modem and slpi smp2p nodes to msm8998.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 64 +++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0cdad91b6c9..820c75c7b484 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -275,6 +275,70 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-lpass {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 14>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 26>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	thermal-zones {
 		cpu-thermal0 {
 			polling-delay-passive = <250>;
-- 
2.18.0

