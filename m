Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A28C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4B4208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4B4208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGIVZb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:25:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38583 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeGIVZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:25:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so1512415pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Cuc9hwG1CcGXmvmKWnQTUtY35lr0XTKRn1pU5PO+lU=;
        b=c8SQhaIg0ujLXk3t9M5VdoHRLHGsHEMgiMCcdHchMbfV23l33Xp6MeED008KhZyrQR
         5+6qttcmiFVsrM9AY1hMbDsWJDy6JEHl+bI5guhSVZz046NXpoopu9oEPX15SfVnrCI2
         5K0cTUUOBaD5nVH1PdrOKfNerKsk4FLv8a5ZtBK6GDAqy2QR4HsDWAoUpZjotygOQRzE
         3m+S9Q2gOS5sX9/dkNIaLbZYnr+rE9UnQPBuyr4szmBdHuVFrVtSoqnoaQXyWHKG0YRS
         a2noAr+igMVKFamcbDR5X72TFMW5x86Iu5b4hFZm8A0eXZqmTV0gQpnXnwVb5gIfi8bO
         1xMg==
X-Gm-Message-State: APt69E1EJKLKtUuqH0/TjmaeEmZcTO6BbBqLgEXy/i9W8bjNo04Xsqc5
        clNTwuJH5WzQr7VWxrmsK74wFw==
X-Google-Smtp-Source: AAOMgpc9gumlF/KWP1VmBExBs/+tkU0+mWO4zd9SSkgbBumkOFVpBfd0QgHKjgX6bvjrRx0XnTup8A==
X-Received: by 2002:a63:7e1a:: with SMTP id z26-v6mr20196728pgc.278.1531171527632;
        Mon, 09 Jul 2018 14:25:27 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id m9-v6sm22566221pge.25.2018.07.09.14.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 14:25:26 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Mon,  9 Jul 2018 14:25:21 -0700
Message-Id: <20180709212522.187257-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
- removed controller register length value from 'reg'

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..7eea94701b23 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.203.gfac676dfb9-goog

