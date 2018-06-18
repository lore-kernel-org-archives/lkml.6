Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E61C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA50320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA50320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeFRIQE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:16:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbeFRIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22A70C77;
        Mon, 18 Jun 2018 08:15:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 027/279] ARM: dts: Fix cm2 and prm sizes for omap4
Date:   Mon, 18 Jun 2018 10:10:12 +0200
Message-Id: <20180618080609.967950941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit bc8a3ef1940c9a6dfa316b31e063fdd4fbab0add ]

The size of these modules is 0x2000, not 0x3000. The extra 0x1000
after 0x2000 is for the interconnect target agent which is a separate
device.

Fixes: 7415b0b4c645 ("ARM: dts: omap4: add minimal l4 bus layout with
control module support")
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap4.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -163,10 +163,10 @@
 
 			cm2: cm2@8000 {
 				compatible = "ti,omap4-cm2", "simple-bus";
-				reg = <0x8000 0x3000>;
+				reg = <0x8000 0x2000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
-				ranges = <0 0x8000 0x3000>;
+				ranges = <0 0x8000 0x2000>;
 
 				cm2_clocks: clocks {
 					#address-cells = <1>;
@@ -250,11 +250,11 @@
 
 				prm: prm@6000 {
 					compatible = "ti,omap4-prm";
-					reg = <0x6000 0x3000>;
+					reg = <0x6000 0x2000>;
 					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-					ranges = <0 0x6000 0x3000>;
+					ranges = <0 0x6000 0x2000>;
 
 					prm_clocks: clocks {
 						#address-cells = <1>;


