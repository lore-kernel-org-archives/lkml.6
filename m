Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA371C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB91E222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSoR2YWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbfBMMea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:34:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47103 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732209AbfBMMeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:34:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1057386pgp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1Ftil2JC2XMfueJ0xbXmoE9WbLO/vJyO48RDROHSDf0=;
        b=OSoR2YWHmdDR0TDR0DDK+/GdBK1YYrgUQhsHJFLsbFRkAFflM/s+JBorKv1keFVe/g
         G3WqTYVQfjWh428+yj8hIUKf2o3TfTSpJNrICx6PEjLtFAOzY40uXayS5vPSWgLb12zK
         6x97NWMknbiZgNm8oqbwQMRaYGzrbXcNfsU+owOiAkuJaiqpkOKejjmRPS2fpaC/+p46
         xGjrBfLDHT3bsvLpb28JPjDNEkm7QsmsT4fUuKpYkaOcULj6FsBH9EGukBiRmarVCvQd
         AoW/FRr/i4aFl0KXtniSeunNac6cBvKh3GDVOWdvFtXTjJK9dlJIKyTpXW7bzq4S9KfE
         vOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1Ftil2JC2XMfueJ0xbXmoE9WbLO/vJyO48RDROHSDf0=;
        b=UQPv9qF5UWKoydTjvpeXWlezR+/WmA/tMRCe1x18kQ6KIUP+bg4HsPfhlMO/OJvdnt
         ti6d5NIYHr9+KIQk9jFh+RA1w6ZVRU+TDLDpwHYfrdDqzTbFbGoDymPwNYlBrb451q7a
         Okx+v2fen42o13+VhVQDQ4k07v+ljM1NxSuNj0Md9kMQ0aSoia3XnURuCZmPE1JAOvic
         aw/abYO6tvANKDFZqAFXURamO4+UyqLs8ByYMCKoYMNwSlO9BMxTtL96JljQx8fLHprF
         UyGRsCKMXIlN3ucNYNdw8JJcIGE5lzeBcjnU8fV/ANA6sMtj0QG4++XuyRGKdp2jdnDF
         Hl1w==
X-Gm-Message-State: AHQUAuYtvbu9wJE92IARHKqJw93Vrm1aX9Ulbe+6KIoV9wgLr8LjKKlT
        /yaY+ged7iZ6umC7jsI+Pd73pg==
X-Google-Smtp-Source: AHgI3IaK6Wa7iLqOWxwNxcPopviGukSLhRAOTKcWTlf1/MHf1annhvER9HpSF5TrQ2X73RS6hu+3nQ==
X-Received: by 2002:a65:6294:: with SMTP id f20mr293397pgv.174.1550061263973;
        Wed, 13 Feb 2019 04:34:23 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:34:23 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de
Cc:     olof@lixom.net, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v2 4/5] arm64: dts: sprd: Add SC27XX fuel gauge device
Date:   Wed, 13 Feb 2019 20:32:48 +0800
Message-Id: <46be35679912ffa446d67bb9b81f0cee065c1ca2.1550060544.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1550060543.git.baolin.wang@linaro.org>
References: <cover.1550060543.git.baolin.wang@linaro.org>
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
index dbf6242..4a79ddf 100644
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
+			compatible = "sprd,sc2731-fgu";
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

