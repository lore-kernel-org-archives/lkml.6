Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3D9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B6A24FA9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B6A24FA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeGBSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:11:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41677 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeGBSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:02 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so7868171pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0IRjJb2eFpt1TBdmR5MhAa763fxtdR0aXOOhUWFEjQQ=;
        b=eAC7VwIGH0UzKw7ifutzmjuDoRCsGrQrc+usQ5GexHGq8HyL+yyl9gagXPX7dGvOLt
         REH4ZY5Nde+4pG0Uq7yLh0IqWBE95jTiDq+D8Kd6yoxUajt3OUY+7S5eybav0W/OQAKD
         Rc+oU/e+ig4zmZNl13PwE9Dfa5BAFzjeAt0Z2creIWI81AqrhPT9BmaOKiY9uZ1lHzqb
         +Ea2P+6xr4GLRy93CNKN7tlyUlfpqstu84u4Q2OVWpmadQMZJeI+bW/JjYPFhc09OaXk
         ZvS+0uBEwUOUll8AfkLSMVrSU0YUdK4+62dIijGZwLMC/JAZyM0xoIfkxQrlpVzHiZlQ
         oC/Q==
X-Gm-Message-State: APt69E1gjcD6FhvVlVe/kj8x9CNnk8o2oc+5i7DsqqO9a6Z3nbLZALiM
        xpC2lxTRiFH45wKnp4T6dbrA5Q==
X-Google-Smtp-Source: AAOMgpe7/wTFRBLpuY09TGHarAcY7W12dfqcOIZLpvKEKgX+JvzPNcZvjzdWEiPtfXm51j/0GUSjsg==
X-Received: by 2002:a62:f909:: with SMTP id o9-v6mr2371888pfh.141.1530555061708;
        Mon, 02 Jul 2018 11:11:01 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id h75-v6sm10048372pfh.86.2018.07.02.11.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:00 -0700 (PDT)
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
Subject: [PATCH v2 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date:   Mon,  2 Jul 2018 11:10:04 -0700
Message-Id: <20180702181005.18247-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- none

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..2f4989e7ef68 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: qcom,temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400 0x100>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.399.gad0ab374a1-goog

