Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF47ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E5120856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbeGXQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:53872 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388717AbeGXQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41ZhS75Gd8z1qymh;
        Tue, 24 Jul 2018 17:03:03 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41ZhS73R5Rz1tLP4;
        Tue, 24 Jul 2018 17:03:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Cj9tiFShPBrp; Tue, 24 Jul 2018 17:03:00 +0200 (CEST)
X-Auth-Info: HaSaoMOydQMI+C44EiyiqrMzBvXeSgGny3Yzqbhfcbg=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Jul 2018 17:03:00 +0200 (CEST)
From:   Parthiban Nallathambi <pn@denx.de>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br, Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 3/3] arm64: dts: actions: Add sirq node for Actions Semi S700
Date:   Tue, 24 Jul 2018 17:02:19 +0200
Message-Id: <20180724150219.1807724-4-pn@denx.de>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724150219.1807724-1-pn@denx.de>
References: <20180724150219.1807724-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sirq node for Actions Semi S700 SoC with 3 SIRQ pins support,
in which external interrupt controllers can be connected.

Example:
atc260x: atc2603c@65 {
	interrupt-parent = <&sirq>;
	interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
};

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..6f16eb081579 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -153,6 +153,17 @@
 			status = "disabled";
 		};
 
+		sirq: interrupt-controller@e01b0000 {
+			compatible = "actions,s700-sirq";
+			reg = <0 0xe01b0000 0 0x1000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			sampling-rate-24m = <0 0 0>;
+		};
+
 		sps: power-controller@e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.14.4

