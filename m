Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AAFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A8920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A8920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbeLJNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:24:59 -0500
Received: from mail.ltec.ch ([95.143.48.181]:46314 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbeLJNY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:24:59 -0500
Received: from nebula.ltec ([172.27.11.2] helo=vm64.ltec)
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1gWLYK-00028J-Dl; Mon, 10 Dec 2018 14:24:52 +0100
From:   Felix Brack <fb@ltec.ch>
To:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tony@atomide.com, bcousson@baylibre.com, mpfj@newflow.co.uk,
        mark.rutland@arm.com, robh+dt@kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, Felix Brack <fb@ltec.ch>
Subject: [PATCH] ARM: dts: am33xx: Remove unnecessary properties
Date:   Mon, 10 Dec 2018 14:24:48 +0100
Message-Id: <20181210132448.7865-1-fb@ltec.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary properties #address-cells and #size-cells
of node pinmux as there are no child-nodes with property reg.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am33xx.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index d3dd6a16e70a..d640cdffe355 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -208,8 +208,6 @@
 				am33xx_pinmux: pinmux@800 {
 					compatible = "pinctrl-single";
 					reg = <0x800 0x238>;
-					#address-cells = <1>;
-					#size-cells = <0>;
 					#pinctrl-cells = <1>;
 					pinctrl-single,register-width = <32>;
 					pinctrl-single,function-mask = <0x7f>;
-- 
2.17.1

