Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D15C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE02120779
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="a8U0QMO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE02120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeFZP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:28:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:44832 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeFZP2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YVl30gjMfzJNY/U7TcpVpMSh6wOSq1RXEvH5tCkgy4k=; b=a8U0QMO3DSPO9+udUK+QgxguvI
        G9jJk66f/cYgjfEDhHoZPn93DEOHGiC2gESAduyVSnB1cEpF3PxYcyC/vDDWLKi9jIl+LVFVRgQTb
        /SK/NFsnsad12ACdeeI58shFEw9ApObwnYHd7X4ttZDTHld1zsvEtGKRNaxB7uJa55mWF6SYl9/dp
        jsVh8B1WnDDBlxI44ZcCl8mrpFVzYReWwzHxYHxNY2z03OGelNFX49JgwVZroNvT+sgENIuG7MqtQ
        wsI8H4+DnMqUrpWzq5rg/Z1LBqpWNqqq1hlGOLJqxliDmQ38lTjMGTkxugxh7YW68aF+c7EGvsVrS
        tp1Z1tHQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:48342 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXptR-005KZi-Jm; Tue, 26 Jun 2018 11:28:33 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: da850: Add power-domains to PWM nodes
Date:   Tue, 26 Jun 2018 10:28:17 -0500
Message-Id: <20180626152817.16803-1-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the power-domains property to both the ECAP and EHRPWM PWM
nodes. Both have drivers that use pm_runtime to enable the clocks, so
they need this property in order to find and enable the clock properly.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/da850.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index de9a8bea100e..d60198e2ae4e 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -532,6 +532,7 @@
 			reg = <0x300000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
 			clock-names = "fck", "tbclk";
+			power-domains = <&psc1 17>;
 			status = "disabled";
 		};
 		ehrpwm1: pwm@302000 {
@@ -541,6 +542,7 @@
 			reg = <0x302000 0x2000>;
 			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
 			clock-names = "fck", "tbclk";
+			power-domains = <&psc1 17>;
 			status = "disabled";
 		};
 		ecap0: ecap@306000 {
@@ -550,6 +552,7 @@
 			reg = <0x306000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		ecap1: ecap@307000 {
@@ -559,6 +562,7 @@
 			reg = <0x307000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		ecap2: ecap@308000 {
@@ -568,6 +572,7 @@
 			reg = <0x308000 0x80>;
 			clocks = <&psc1 20>;
 			clock-names = "fck";
+			power-domains = <&psc1 20>;
 			status = "disabled";
 		};
 		spi0: spi@41000 {
-- 
2.17.1

