Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E173DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8844320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbeGXLtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:32 -0400
Received: from mout.perfora.net ([74.208.4.194]:37999 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388313AbeGXLtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:31 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LyTxo-1g2WTh0bQM-015rOy; Tue, 24 Jul 2018 12:43:35 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 10/15] ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
Date:   Tue, 24 Jul 2018 12:43:04 +0200
Message-Id: <20180724104309.21741-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724104309.21741-1-marcel@ziswiler.com>
References: <20180724104309.21741-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:RoCvnwxZs3Y/xqOqLPYUWdkxpYd4M1YMqtD72hVwimLjzgN0gf8
 WPdwks30Gucht3C7e/uiIow29mcMNuHSIsJQImzAUK9qclpsMRqrttc4dQYQRxAd15KxAwg
 veB7Zokq5c4GKTHYP3A4LZwh5sCzvRghM/MbrTSxMFprgYHBk31Un42H8IF7k/0sb9tif8o
 2K6jRf/Mib2FI45stlQJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oqxd4PPsIvY=:N7ZcSd5ybbwaogD9rtWSAX
 GLbVXiCPinHpDwXcDp86nLeOk1I0HVEaKWVe3cUwWHvizIdDaHKxIikfU7l0Xr66vuq0qPpMX
 Egm69FiCYYZWzV/SuzExncRBuLGsLeGyRO0wenRYPTSQCp9+nqmPKDTZejZY1K2cwcoMbWTMo
 scXCwKz5rqtQgzUrU9w35aRjHOArMM6pLUCtM2if8yqtRldtdLmBEtlpWdoX+sAILxPbgzuTI
 +lVj0kZhXsqjm5jClMqSsXSLCE0CKIXAN1ddACl9nngMUM5UQD6Zd2nqFCMl2tHZlWHHqY/8W
 oVcLrIwJfvrOL/0DSuNubHN/C7Lda+Np1xcnIrUNQBHzF7HdsJueV+cdJFHqpqKeWbqtUOR77
 ux2XEHluws7Pm6qVGvD8YIFv2+Gl5xFrNiItyCXcEJpDVn+U2GIor0C4PCJ85rs7mcgiTRlto
 DcLJHAFUM7GUvCt+ekIbwArTCpiYAfvRXTW1iN2EncblT21/JMDZqj5SvDgUxvbNuzAj94too
 RA+6LBCziKI1JMAQC6uwZR0/6uZvv+Rj92ynWIQK3Tda9IiIpC68hrb24hJrpy2Twx/ix1o1y
 PfQQAkittieksXtzmhas4bUjVswo0sIRvWTo1BlUwKTrTCCeZ0WK0+UZT5mUPdxLpyaefwz4n
 q/MhKP5AI+NQZvBYowFeo/u8TcAqMLx2Ii018MYCLoIlVOZdwm8q9SYkV3Dd7CTeUfg8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 2 ++
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 8ea696c91341..6c255cb70339 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -1917,6 +1917,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
 	};
 
 	/* CPU DFLL clock */
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index ab63e5653d73..72253d918ebd 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -1946,6 +1946,8 @@
 		status = "okay";
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vddio>; /* VCCQ */
 	};
 
 	/* CPU DFLL clock */
-- 
2.14.4

