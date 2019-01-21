Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5953DC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A6120855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gq03+voe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfAUHjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34338 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfAUHjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so9409889plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WBoPfqiD62qTyJHnIBLq11r66Gu0wg7pVtNBOKSgwDA=;
        b=Gq03+voeUhoaNn1/WdFxKHlzxB7lgh+usqPpa0k3YSSAvc268qEWfw3w701UgteYEX
         hw0FGqP7PBlt/PdldjvEV+eeasLrF5OnvbajQ1IKtIL6XUfQq6EVX2/WOIApBsQO723B
         VeDTEqdS9cPQWabO+jhVVaFliQuxwZWcCKeKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WBoPfqiD62qTyJHnIBLq11r66Gu0wg7pVtNBOKSgwDA=;
        b=EwMD5PMp8mMJennOZ0n+kVO386pQTCSZ5YuqgodqpuPElMbTCRY2R5q5Ib04iZ8gfn
         qYb24eEKYPhv8eYA6KQxAYgyin02MiZcW2b6RbKl1dOY81zW0Egxpfx5GGlouuCqg+/y
         s1KGXDtiI5vfYKxfpoeZcLsJNDeemFSuaaIgDgRfi6or+7r8t6Quzlg073H49NvI3Ce0
         DPqRO0sFU7Wio8zPrU8G8YN7TiISDyBCOpSLqyNGVVlabWnx8g0feIsWNvLJZCuQvJeO
         ODCNheKkV3fmayxT42WPbBa4R3q8VMjqKtVC/o8vUKqURbwc+Io/PNospurB7oa4IsfY
         nCmQ==
X-Gm-Message-State: AJcUukeiZ5KOpIymAa8FJw2/tQDpCYUiS34g9aYORXf21zMTjDHYpZ/k
        h2CmluBnxtvT6ZRxqsHIu1PR/A==
X-Google-Smtp-Source: ALg8bN6Nfvze4fYHv/A8yGMcDY1+zsxKPpIb1rosgM7lsw5yc9e8aGDCxHXbpFgdNRnAmdU33X95yQ==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr29154224pll.111.1548056382729;
        Sun, 20 Jan 2019 23:39:42 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 23:39:42 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 4/4] arm64: dts: sprd: Add SC27XX fuel gauge device
Date:   Mon, 21 Jan 2019 15:38:31 +0800
Message-Id: <4f66af3b47ba241380f8092e08879aca6d7c35b3.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Spreadtrum SC27XX fuel gauge device node to calculate the
battery capacity.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index b52eaf0..1110d13 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -70,6 +70,11 @@
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
 
+			fgu_calib: calib@6 {
+				reg = <0x6 0x2>;
+				bits = <0 9>;
+			};
+
 			adc_big_scale: calib@24 {
 				reg = <0x24 0x2>;
 			};
@@ -90,6 +95,19 @@
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
+		fgu@a00 {
+			compatible = "sprd,sc27xx-fgu", "sprd,sc2731-fgu";
+			reg = <0xa00>;
+			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
+			io-channel-names = "bat-temp", "charge-vol";
+			monitored-battery = <&bat>;
+			nvmem-cell-names = "fgu_calib";
+			nvmem-cells = <&fgu_calib>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <4>;
+		};
+
 		vibrator@ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5

