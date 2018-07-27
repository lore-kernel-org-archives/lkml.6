Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92F1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6932089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6932089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeG0NNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:13:50 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:32909 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbeG0NNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:13:49 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id AB69066289;
        Fri, 27 Jul 2018 11:52:15 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id EE68570F4D;
        Fri, 27 Jul 2018 11:52:14 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id C3A3BEAD2;
        Fri, 27 Jul 2018 11:52:13 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH v3 2/4] ARM: dts: sun8i: h3: Add SID compatible string
Date:   Fri, 27 Jul 2018 13:52:03 +0200
Message-Id: <20180727115205.20955-2-manu@freebsd.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727115205.20955-1-manu@freebsd.org>
References: <20180727115205.20955-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SID controller on H3 already have a binding but isn't present in the
dtsi file.
Add a node for it.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..614e2c2154c8 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -111,6 +111,11 @@
 	};
 
 	soc {
+		sid: eeprom@1c14000 {
+			compatible = "allwinner,sun8i-h3-sid";
+			reg = <0x1c14000 0x400>;
+		};
+
 		mali: gpu@1c40000 {
 			compatible = "allwinner,sun8i-h3-mali", "arm,mali-400";
 			reg = <0x01c40000 0x10000>;
-- 
2.18.0

