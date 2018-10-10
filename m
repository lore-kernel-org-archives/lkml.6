Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0662D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0662D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJJTEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:04:37 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:35800 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeJJTEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:04:37 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 1950FBFE63;
        Wed, 10 Oct 2018 13:42:51 +0200 (CEST)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 67DDAC100C; Wed, 10 Oct 2018 13:42:50 +0200 (CEST)
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 50AAEC0762;
        Wed, 10 Oct 2018 13:41:57 +0200 (CEST)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Mark Van den Borre <mark@fosdem.org>,
        Gerry Demaret <gerry@fosdem.org>,
        Luc Verhaegen <libv@skynet.be>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 3/4] ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888 pins
Date:   Wed, 10 Oct 2018 13:41:33 +0200
Message-Id: <20181010114134.8211-3-contact@paulk.fr>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010114134.8211-1-contact@paulk.fr>
References: <20181010114134.8211-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the pin muxing definition for configuring the PD pins in LCD0
mode for a RGB888 format to the sun7i device-tree.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 02e40da9f028..684dd008039d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -837,6 +837,17 @@
 				function = "ir1";
 			};
 
+			lcd0_rgb888_pins: lcd0-rgb888 {
+				pins = "PD0", "PD1", "PD2", "PD3",
+				       "PD4", "PD5", "PD6", "PD7",
+				       "PD8", "PD9", "PD10", "PD11",
+				       "PD12", "PD13", "PD14", "PD15",
+				       "PD16", "PD17", "PD18", "PD19",
+				       "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins_a: mmc0@0 {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.19.0

