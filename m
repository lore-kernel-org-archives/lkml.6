Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C1020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405069AbeHATFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:05:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47668 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403863AbeHATFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:05:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A92ED0A;
        Wed,  1 Aug 2018 17:18:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 142/246] ARM: dts: stih407-pinctrl: Fix complain about IRQ_TYPE_NONE usage
Date:   Wed,  1 Aug 2018 18:50:52 +0200
Message-Id: <20180801165018.531095156@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrice Chotard <patrice.chotard@st.com>

[ Upstream commit e95b8e718f9bd2386a29639dd21c633b4951dc21 ]

Since commit 83a86fbb5b56 ("irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE")
kernel is complaining about the IRQ_TYPE_NONE usage which shouldn't
be used.

Use IRQ_TYPE_LEVEL_HIGH instead.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -52,7 +52,7 @@
 			st,syscfg = <&syscfg_sbc>;
 			reg = <0x0961f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09610000 0x6000>;
 
@@ -376,7 +376,7 @@
 			st,syscfg = <&syscfg_front>;
 			reg = <0x0920f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 189 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09200000 0x10000>;
 
@@ -936,7 +936,7 @@
 			st,syscfg = <&syscfg_front>;
 			reg = <0x0921f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09210000 0x10000>;
 
@@ -969,7 +969,7 @@
 			st,syscfg = <&syscfg_rear>;
 			reg = <0x0922f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 191 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09220000 0x6000>;
 
@@ -1164,7 +1164,7 @@
 			st,syscfg = <&syscfg_flash>;
 			reg = <0x0923f080 0x4>;
 			reg-names = "irqmux";
-			interrupts = <GIC_SPI 192 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "irqmux";
 			ranges = <0 0x09230000 0x3000>;
 


