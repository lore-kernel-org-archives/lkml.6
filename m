Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A37ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811FD20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811FD20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGWLoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:44:13 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:48668 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbeGWLoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:44:11 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 14CA46ECB5;
        Mon, 23 Jul 2018 10:43:37 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 0D2F076310;
        Mon, 23 Jul 2018 10:43:36 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id D74039B94;
        Mon, 23 Jul 2018 10:43:34 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH 4/4] arm64: dts: allwinner: h5: Add SID for H5
Date:   Mon, 23 Jul 2018 12:42:55 +0200
Message-Id: <20180723104255.94244-4-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180723104255.94244-1-manu@freebsd.org>
References: <20180723104255.94244-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SID controller on H5 look the same as the one present in the A64.
But in case we find some difference one day at a compatible string
of it's own and a fallback to the A64 one.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 .../devicetree/bindings/nvmem/allwinner,sunxi-sid.txt        | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi                 | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index e319fe5e205a..99c4ba6a3f61 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -7,6 +7,7 @@ Required properties:
   "allwinner,sun8i-a83t-sid"
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
+  "allwinner,sun50i-h5-sid"
 
 - reg: Should contain registers location and length
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 62d646baac3c..28183bf77164 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -129,3 +129,8 @@
 		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 	compatible = "allwinner,sun50i-h5-pinctrl";
 };
+
+&sid {
+	compatible = "allwinner,sun50i-h5-sid",
+		     "allwinner,sun50i-a64-sid";
+};
-- 
2.17.0

