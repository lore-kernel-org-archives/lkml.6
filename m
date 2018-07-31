Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0D7208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="J1jWHHzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0D7208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbeGaIwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:52:16 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:16079 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGaIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021109;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zkyhEAqr/sYWROFmxzeiQN0lUOSoJieqoh1lyPwwflg=;
        b=J1jWHHzK/Sj3HILqNXAZSyKbGgnR06HJWgiPUhvF2zCaw8kehN+JQTQmi3dDEo5rEy
        GoX7sMMdObH/Y2chN1ax3dir049YZZ1cGmoxSej0UYhuJCrl5NFOOr2FpGlO3yP7IxoP
        DETresf4eEa23Hqpfu/Xg4ovXiqIsnK25jpX/hDsgV56PZ2W2Xy3j6VzdAR3hMeCoP74
        mUGFd98IRJyDJGJg4/f7PGBhF1dw90/8NbnoDHozT0eJ/2Y/X0iKxv8VnaoT1fMK9uJ2
        FOodUA3vwS/I13eF7TnqtRhwws1QwTC35iUjEgKCkAHfuK2eXAnC7zKySVrCGauTxS5t
        6ADA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BgwOg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:42 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 15/32] ARM: dts: omap3-gta04: make use of input event include file and constants
Date:   Tue, 31 Jul 2018 09:11:18 +0200
Message-Id: <76a8aaa94434b0aa1becc82be8211e4e9849b73d.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we can replace magic numbers by symbolic constants now.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index bb4c9ad62edb..98f31f1814d0 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "omap36xx.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "OMAP3 GTA04";
@@ -43,7 +44,7 @@
 
 		aux-button {
 			label = "aux";
-			linux,code = <169>;
+			linux,code = <KEY_PHONE>;
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			wakeup-source;
 		};
-- 
2.12.2

