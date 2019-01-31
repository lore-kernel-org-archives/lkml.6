Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E6EC282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E428B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K98Nseth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfAaAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:40:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45333 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfAaAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:40:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so618839plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zqMgGkIb/lmkxxcpxZ2tkpJB61LrzTeXczZtBhvgAUI=;
        b=K98Nsethky15DR/+12Vbu8+GLRgwXpIivQ9FZGpeYFxSWgMpVfmBzHrYP1sfiscuET
         FwKoKMucZiJytFJSpZiFNqYWq0e5J7XztiznoYP+j+520A2HT2LjcmiT7ZVyI0X0v+1z
         B3vTvdENOxFBfUK38hqEuzfIIX0JB+YCF2BIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zqMgGkIb/lmkxxcpxZ2tkpJB61LrzTeXczZtBhvgAUI=;
        b=J7r8G9kYIEbDIQru3qr2bqHGS7JEUWJd5ZlxRfgNOUCTXEgrU+h2U9JUaR0glQEIHh
         QQJWlVJwZGlMtraS6Iy3sdpH4/GbJN4HA3PH0E20ZSsg8gSRSO1BgwQOVHqj3t4rZ0x2
         uQOILw5vPt7f8U9lWm4pruOvkOxTcsuPiZFnfO75/ctM5iRuBqGW3m3u8eL0TZyovjmo
         qlaiASPb7nya8fbcrqBqspF/SWsAOl9q96v3vp1os88OhwHPZiEGoxlz8y8gfYmtQZGj
         pJVhowi3HJdiP71cwPEtyzq5HCOZivVyIFTf35pBILcV9NUG3xVpXH34jYDPQbtaznRh
         hLqw==
X-Gm-Message-State: AJcUukfUu+ErnTtPA51FnU1QCpAxxmsX2vhiNYwSRxWCOye15Ws5OVXj
        vZRQZLaBgNcWoQ4/aKWrqAA2Vg==
X-Google-Smtp-Source: ALg8bN7KD8VmxnCIWpml0nYn0fIVAMXNdLWnH355GzRZkYsHerPtrl6XIQKFMimbh1SQqTB5xENC6w==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr32654306plk.203.1548895203224;
        Wed, 30 Jan 2019 16:40:03 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:40:02 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 09/10] arm64: dts: qcom: Add AOSS QMP node
Date:   Wed, 30 Jan 2019 16:39:32 -0800
Message-Id: <20190131003933.11436-10-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP provides a number of power domains, used for QDSS and
PIL, add the node for this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

Changes since v3:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 07d9cd6fba7d..dc43fee8bb90 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/reset/qcom,sdm845-pdc.h>
@@ -2076,6 +2077,15 @@
 			#reset-cells = <1>;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sdm845-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
2.18.0

