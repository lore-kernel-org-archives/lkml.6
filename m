Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D5C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371D720855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lqbj5P2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfAUHjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:39:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36297 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfAUHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:39:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so9731247pfc.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
        b=Lqbj5P2AYTc1vqNowMzk+9mAq0t5KGdEZRfC24xoBJvA4nPl/uMfeBrkhVSN2uHSGj
         d+2gB+I+nHU8IWodcM6bxv9M+VjA1cd5vRciX1aP1ZAuAgjtDzMcZwNQL6KBS7llorsb
         ZfC4/Q79ujUzyOUUPeHPMGd0IqhACkiFM0MHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
        b=KSeTovPAzvzDnTucdMyqL2nD7gdEKFM+JmeWyrwE7rBgFdMRDk565NndnN6IUFGjTD
         qpR8pNNfdxg2vfX5Xl503vBLKN0rprTgUxeqsF1X+ckBBxdXacIHQOGRZcNLEIx0wzme
         N+xDl8KDsMRE63BEWSEmL6ojKf8rJZAB4+pIR//1aI2Ii+l8UZyxIgfqu4Tp6bkj0bun
         jCVwW3pbnxpedDU1Kl30axjDgXM92Pgn/sYmji7zgXSjkVq4XKo3oMF8r50vfisNHPXz
         pHf7xPhx3Lx7+j5MNYpf9N33oC2vI+TN2SaOHr7CL4sgdlx6nTpVFp/WtPM6X02d1SuW
         ZBJg==
X-Gm-Message-State: AJcUukcMAcl/y7ut+8EKbNithd7Nw/gOeRlvkQE8efOD0McuRQYhYng9
        Z2p57/4hs1nkv41bSGAGA8ijGQ==
X-Google-Smtp-Source: ALg8bN70IdbzIK8C757BC1LH/HJ/zz4z4OB64aQ9xlZS8m6j9OciJvs5CGfpUuQSBWuU++MKfEmIhA==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr27385499pgb.242.1548056374353;
        Sun, 20 Jan 2019 23:39:34 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 23:39:33 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de,
        olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 2/4] arm64: dts: sprd: Add ADC calibration support
Date:   Mon, 21 Jan 2019 15:38:29 +0800
Message-Id: <0213394a8e432e0ee0809f9032427d971ea9cde2.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1548052878.git.baolin.wang@linaro.org>
References: <cover.1548052878.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds phandles to the calibration cells provided by the Efuse
device, which is used to calibrate the ADC channel scales.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index f2f2aa5..a2edc25 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -63,6 +63,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			hwlocks = <&hwlock 12>;
+
+			adc_big_scale: calib@24 {
+				reg = <0x24 0x2>;
+			};
+
+			adc_small_scale: calib@26 {
+				reg = <0x26 0x2>;
+			};
 		};
 
 		pmic_adc: adc@480 {
@@ -72,6 +80,8 @@
 			interrupts = <0>;
 			#io-channel-cells = <1>;
 			hwlocks = <&hwlock 4>;
+			nvmem-cell-names = "big_scale_calib", "small_scale_calib";
+			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
 		vibrator@ec8 {
-- 
1.7.9.5

