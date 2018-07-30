Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8257420881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8257420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeG3LtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:49:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43064 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbeG3LtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:49:02 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCE0A1A003B;
        Mon, 30 Jul 2018 12:14:44 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 105091A0013;
        Mon, 30 Jul 2018 12:14:39 +0200 (CEST)
Received: from Tank.ap.freescale.net (tank.ap.freescale.net [10.193.20.104])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A6CD2402D7;
        Mon, 30 Jul 2018 18:14:31 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/3] arm64: dts: fsl: add clocks property for fman ptp timer node
Date:   Mon, 30 Jul 2018 18:01:52 +0800
Message-Id: <20180730100154.27906-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add clocks property for fman ptp timer node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
index a56a408..4664c33 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-fman3-0.dtsi
@@ -80,4 +80,5 @@ ptp_timer0: ptp-timer@1afe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x0 0x1afe000 0x0 0x1000>;
 	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clockgen 3 0>;
 };
-- 
1.7.1

