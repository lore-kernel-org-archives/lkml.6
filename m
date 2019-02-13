Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E16C222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+u2BXE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392158AbfBMMeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45669 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388400AbfBMMeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so1056822pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
        b=K+u2BXE8igH9mZ5PXj92nX6kf00B7E4SIonYnZdN76QA5DDQe+PbEmkmz8iP2a49Mc
         uE5vBYjcHExxmpQT2+jeCXEbGfxlZLpDUD0NFNA+H3nDVZvPV/Wa6fEup4fZUomy0hbC
         69/VDJuxrS+cNBBlVnAZuptQnAIzO+bZMe7BN6E1ZIYliug9BFIXqB1qerjLskzPOmlW
         wNGZEYi128Ls+AATJPire+8gcSzsxxBAOi+Jfh2MRTWJ1A9lbIhYOGJROro6VeBKb8xc
         Lv+zNRmnYMKofHCyLEZxM8+TlUvChbvJc40bSJpvJoc18NkN3OzpRyRnXyK3Sn2GZ2Q9
         nkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TsYSQ/G0YznTAgTKSekGveHgCX9PxIa5Y7B9m7W0j9A=;
        b=Oi3y4CdeqgeYApNdtl/Lft6jUuWNG7tJ0rLgiuRjx3AMjJhjmAJeo6B67uPCzsRhaC
         OeuEXMAqUMNiE2919jKjfe7qMQjcOLagf4pIDMucshVOQSWKVNywWBMui8e9zYQ4PzFq
         nFcjOIPg1IfwShWdw4B/rNZdh1Wze9MMSPhKmWftB0aKPIp9ekkb8goP3kHYdFj7D4az
         T8SCMRLQWUUj6GDmdKUZM6NPuSvqWDmFkPtNBBXsfWIaxoiHChDkx5BkuHiHwpLDxodT
         KTkzwJVZSuPlygyH91piOwULjL0Iiba52lpAPuweWEnnhK4kc5v9NMmlWsdGesGt7Wo3
         bu7g==
X-Gm-Message-State: AHQUAuYIaq3fHbmbCm+Pk2XgoqMPbr6GRJGEGPz3LIb9jU8OvOOSFyH5
        7RHQFHmA0Ke0rD1iVSBJlvjUhg==
X-Google-Smtp-Source: AHgI3IasfNSW9A1fNEEBfWE7qbZtE4VaXKaB3tivIDyCvYJl0ojIazlXhuIdAmvJqFEljsjrumLvuQ==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr275245pgc.25.1550061255741;
        Wed, 13 Feb 2019 04:34:15 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:15 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 2/5] arm64: dts: sprd: Add ADC calibration support
Date:   Wed, 13 Feb 2019 20:32:46 +0800
Message-Id: <0213394a8e432e0ee0809f9032427d971ea9cde2.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
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

