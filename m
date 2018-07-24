Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FBBC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DCB20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DCB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeGYA4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:56:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeGYAz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:55:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so1224747pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k3gcbvn8mw2hRJRDyRUzU879qvsdG7D3H9+KZ2b2FUQ=;
        b=MVdsDc2xiCMYsRlv3upZpWXB2b+trm6dxhm64OAdGew13bzlDxuxKMaB5xmi0BfxgE
         JOXoEF4uEqX35mExnV/SFUu7Qq2Ss+x3De3NsQm47myyhG6tYOh6MFTyF5P8u0hUhdok
         +7NHxuo9IjWaoYojJhJT7bA0rV+mdKxTvd1bizt6zvI+n9gb3uSRnRNnMpGXU503TgLY
         B626uvtpsUQcbzwsb+FTMip3EyvGxAjRNYHylIBG8DMyJa2g7Jy79Vy+UpSMpsXYuQLM
         q9ooth2o2aFKUYCfkW+LfRSxvib/mDxfCtYBPABAG0PQNz5jrbhuVIqm3K8mei9Pqeva
         Nn0A==
X-Gm-Message-State: AOUpUlGhEDvR2ZK6s0sXEroabCzDDDwIQWfb4fr4xT/WhAGiPvuepIWA
        5+EvZHJpmlhUvYhRoo9PmMbA7g==
X-Google-Smtp-Source: AAOMgpfaN21mCYdFng4NMmn3XokDlrkROoWlFu14gh0nlmHt0TSF3n/Y6z42AT96FJYhIBvSxaDfhA==
X-Received: by 2002:a63:bf08:: with SMTP id v8-v6mr17757113pgf.3.1532476025890;
        Tue, 24 Jul 2018 16:47:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 12-v6sm17267970pfx.128.2018.07.24.16.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 16:47:05 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Tue, 24 Jul 2018 16:46:35 -0700
Message-Id: <20180724234636.57137-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v5:
- added tag 'Reviewed-by: Douglas Anderson <dianders@chromium.org>'

Changes in v4:
- none

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
2.18.0.233.g985f88cf7e-goog

