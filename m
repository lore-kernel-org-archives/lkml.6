Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD605C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4C208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKZVDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:03:38 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:43272 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:03:37 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433N2H1GP4z1r0gT;
        Mon, 26 Nov 2018 11:09:59 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433N2G6YMcz1qrnK;
        Mon, 26 Nov 2018 11:09:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id YA6dKrFw3c2H; Mon, 26 Nov 2018 11:09:52 +0100 (CET)
X-Auth-Info: GYqq8Z3lT0JgIrNqaxKtblqGUa108p5/pPtwaE1KiDY=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 11:09:52 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.liau@actions-semi.com,
        mp-cs@actions-semi.com, linux@cubietech.com,
        edgar.righi@lsitec.org.br, laisa.costa@lsitec.org.br,
        guilherme.simoes@lsitec.org.br, mkzuffo@lsi.usp.br,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable SIRQ
Date:   Mon, 26 Nov 2018 11:09:40 +0100
Message-Id: <20181126100940.2944780-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl definitions for Actions Semiconductor S700 SIRQ external
interrupt controller.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 .../boot/dts/actions/s700-cubieboard7.dts     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
index 28f3f4a0f7f0..af44fd0456cf 100644
--- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
+++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
@@ -37,3 +37,22 @@
 &uart3 {
 	status = "okay";
 };
+
+&sirq {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sirq2_default>;
+};
+
+&pinctrl {
+	sirq2_default: sirq2_default {
+		pinmux {
+			groups = "sirq2_dummy";
+			function = "sirq2";
+		};
+
+		pinconf {
+			pins = "sirq2";
+			bias-pull-pin-default;
+		};
+	};
+};
-- 
2.17.2

