Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8DC64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E2320989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aTTqA5yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E2320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeK3KIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:08:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36287 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3KIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:08:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id u3so3514488wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgEGBuoz9h2uPSAs6bKXqf+FVku1NvUv0A9IlTooBCE=;
        b=aTTqA5yoJYqeb6pa9W1pehcTqxQvd4Mi9KRnvWpd88qSjI5Xasr8F3YxjLVaRH4pmL
         L7AKeU218+qh9cAvtmkeblipzMc5nlW7ieaU6s+KZPNoYnuZr+eMD+H3hD41up0SiU7s
         YDxT0PSIy29KOi7HjDP3xcUckQvPJKjPgroFcMLmJ1gTFLmS+RuHbx9W4/TdcIUz2xRB
         fMsDtBAe7A5GuWMGXUZLQ6mRManUsdWs1F4r8NpwR0FA511lQlpstzNF/mNK0pcD4Y+E
         rfBvL+IEDTm856gKDXoCQahkrL6K9ubpCrJ98D7YuNumUuNC2paTWjNQjHuW88I7L6Y4
         6Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgEGBuoz9h2uPSAs6bKXqf+FVku1NvUv0A9IlTooBCE=;
        b=bqdmq/GgNIstWm7tpqspVWJLmTXCFklfo1nGodgmD7zqXCStcb2pwjztzCrvJ6L6kI
         Z5TkHQ7jG75h6bsESDpCRLurKjWPq3/WNbqYXfSRlterCsljE2DZBXJe8Z6/0ZK47EP0
         BXSprdVOC4JMCn/vVmsfLmIDwXR1FmSw5qR5u4/e8csw6lAEAYdl59jgyofRay3VV5FV
         afia75Z4JHiIyWq4dsRk6NFdrTniQ/DjCmiuPiGxBFyh46OA47uIZzKONnlvZcaNjo5H
         yyri3qm1Ekm19+DwnsUjCbvejAVdN9ohpL9NwLr65O9Mwx+53ouMNG2dhU84q9Dzl8+J
         5Lvg==
X-Gm-Message-State: AA+aEWbCfzt/g4XpU6hkrXUcDw4s4jFXGg/kHYZmY1fP3TBwiZeJCDVM
        qedmzBLfDttfcxCmvl4/wmU=
X-Google-Smtp-Source: AFSGD/X97hcGVmebTFAjAYdFr3gdCh9VtOWHyhnLzvOlCOc9qsSMv4FODwhhZCJL5uGZeu6fs9sGtA==
X-Received: by 2002:a5d:6aca:: with SMTP id u10mr2841466wrw.310.1543532489548;
        Thu, 29 Nov 2018 15:01:29 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id k15sm2944895wru.8.2018.11.29.15.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:01:28 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] ARM: dts: meson: meson8: add the CPU OPP table
Date:   Fri, 30 Nov 2018 00:00:43 +0100
Message-Id: <20181129230044.21358-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
References: <20181129230044.21358-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values are taken from Amlogic's 3.10 kernel sources. Their sources
have a "meson8m2_n200_2G.dtd" which defines a different voltage table:
- 0.86V for 96MHz
- (values in between omitted)
- 1.14V for 1.992GHz

The reason for this is simply the hardware design because the voltage
regulator on this board is has a minimum output of 0.86V and a maximum
output of 1.14V. The recommended settings are added with this patch
instead of using the values that are only valid for one board.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 2575a5835567..e5cd325d7ea8 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -64,6 +64,8 @@
 			reg = <0x200>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu1: cpu@201 {
@@ -73,6 +75,8 @@
 			reg = <0x201>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu2: cpu@202 {
@@ -82,6 +86,8 @@
 			reg = <0x202>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
 		};
 
 		cpu3: cpu@203 {
@@ -91,6 +97,72 @@
 			reg = <0x203>;
 			enable-method = "amlogic,meson8-smp";
 			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
+			operating-points-v2 = <&cpu_opp_table>;
+			clocks = <&clkc CLKID_CPUCLK>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-96000000 {
+			opp-hz = /bits/ 64 <96000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-816000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <875000>;
+		};
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <925000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <975000>;
+		};
+		opp-1416000000 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp-1800000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1125000>;
+		};
+		opp-1992000000 {
+			status = "disabled";
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1150000>;
 		};
 	};
 
-- 
2.19.2

