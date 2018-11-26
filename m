Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C99E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C99E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeKZU6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:58:13 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:56191 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZU6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:58:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433Mvw5Bb5z1r0gg;
        Mon, 26 Nov 2018 11:04:28 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433Mvw37dtz1qrnF;
        Mon, 26 Nov 2018 11:04:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nRLbTjrzKojX; Mon, 26 Nov 2018 11:04:26 +0100 (CET)
X-Auth-Info: C40uYKx4URgmB4AezhcpmU2ShP15+sZuSK0uzPQjvtE=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 11:04:26 +0100 (CET)
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
        Parthiban Nallathambi <pn@denx.de>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 3/4] arm64: dts: actions: Add sirq node for Actions Semi S700
Date:   Mon, 26 Nov 2018 11:03:55 +0100
Message-Id: <20181126100356.2840578-4-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126100356.2840578-1-pn@denx.de>
References: <20181126100356.2840578-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sirq node for Actions Semi S700 SoC with 3 SIRQ pins support,
in which external interrupt controllers can be connected.

Example:
atc260x: atc2603c@65 {
        interrupt-parent = <&sirq>;
        interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
};

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 192c7b39c8c1..d87602ebd689 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -174,6 +174,16 @@
 			#clock-cells = <1>;
 		};
 
+		sirq: interrupt-controller@e01b0200 {
+			compatible = "actions,owl-sirq";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			actions,sirq-shared-reg;
+			actions,sirq-reg-offset = <0x200 0x200 0x200>;
+			actions,ext-irq-range = <13 15>;
+		};
+
 		sps: power-controller@e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.17.2

