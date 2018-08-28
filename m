Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BD5208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ol7wCxF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BD5208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeH1LAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:00:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46370 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeH1LAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:00:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so281474pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K7exVKA4QNpGL0btmMcAj+pwUY0QkummeTllnnzD48w=;
        b=Ol7wCxF86qVAXxHEVLRR0c8iHipnAd260dIFfNfOTl2hp447Mw4ebC/vxJk1zHsX00
         1kWETDobqBVcUxuhSMpzK8ZU/xD1iGK3OsDdd+d5z3ZiFJkn9O7IJNQW011dPvjID0uN
         i9Ydw7kr06dsprLdqr1TfQFfseh4v7t2ALBeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K7exVKA4QNpGL0btmMcAj+pwUY0QkummeTllnnzD48w=;
        b=kXZc6j/KC2A0X1ZUjri2EdvFQDODUtdAncODEjdscgG2sJKGwzl8UpNafWbG4Udh0O
         Ai3hPAufotbzZ8pWaJqWKOVloVF8IBrHeqvRjUpKXJJDAF6iowhVVI6oGAQ1zfaT6aHc
         zo+s8UZBeov4C2I4WSgUPO7FmLTjkUeq0ZDmQaONfKLHKnyORZqRsmt3P++1jfIG+6t3
         WRw3C5O+5JIZVkQYflypF1oHh9adLRFJfj4zIu6cdupHURUo5pF3kqvRv+iQvxaXqrdf
         pKwtrC5a67ZFyFJtbvChk93+PAZkQm6dvFdyrgs1z7I+RIFq/C2DMSvOZpkooQ51aXyi
         dY3A==
X-Gm-Message-State: APzg51B8cIQ7+uKQcMN58HsgMVPr90SiziyefMPjqssKaPVo9wI22RQt
        q+ug3TjdpEHClL52ntawG1dzPw==
X-Google-Smtp-Source: ANB0Vda3wod//M4bcpsc9ZvmDBWzpeu195nMfy9gJP91q4PhEo8ugsmRKOW8X7F1JySfbMrMgDoUJA==
X-Received: by 2002:a63:27c1:: with SMTP id n184-v6mr291126pgn.298.1535440227464;
        Tue, 28 Aug 2018 00:10:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j15-v6sm577547pfn.52.2018.08.28.00.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 00:10:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add smp2p nodes
Date:   Tue, 28 Aug 2018 00:12:03 -0700
Message-Id: <20180828071203.26740-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SMP2P nodes for the remoteproc states for adsp, cdsp, mpss and
slpi.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 88 ++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..d977117acac4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -230,6 +230,94 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lpass {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 10>;
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
+		mboxes = <&apss_shared 14>;
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
+		interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apss_shared 26>;
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
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.18.0

