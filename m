Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547EBFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1879420894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1879420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeG3LtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:49:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51394 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeG3LtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:49:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0788F200031;
        Mon, 30 Jul 2018 12:14:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F0ED200002;
        Mon, 30 Jul 2018 12:14:40 +0200 (CEST)
Received: from Tank.ap.freescale.net (tank.ap.freescale.net [10.193.20.104])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E2BC4402E1;
        Mon, 30 Jul 2018 18:14:32 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 2/3] powerpc/mpc85xx: add clocks property for fman ptp timer node
Date:   Mon, 30 Jul 2018 18:01:53 +0800
Message-Id: <20180730100154.27906-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180730100154.27906-1-yangbo.lu@nxp.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to add clocks property for fman ptp timer node.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi   |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi  |    1 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
index 6b124f7..9b6cf91 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
@@ -100,4 +100,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
index b80aaf5..e95c11f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
@@ -100,4 +100,5 @@ ptp_timer1: ptp-timer@5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
index d3720fd..d62b36c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
@@ -105,4 +105,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
index ae34c20..3102324 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
@@ -105,4 +105,5 @@ ptp_timer1: ptp-timer@5fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x5fe000 0x1000>;
 	interrupts = <97 2 0 0>;
+	clocks = <&clockgen 3 1>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
index 02f2755..c90702b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
@@ -93,4 +93,5 @@ ptp_timer0: ptp-timer@4fe000 {
 	compatible = "fsl,fman-ptp-timer";
 	reg = <0x4fe000 0x1000>;
 	interrupts = <96 2 0 0>;
+	clocks = <&clockgen 3 0>;
 };
-- 
1.7.1

