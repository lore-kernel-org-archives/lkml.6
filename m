Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA8EECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99F820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99F820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbeGXLVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:21:25 -0400
Received: from mx2.freebsd.org ([8.8.178.116]:47763 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388260AbeGXLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:21:23 -0400
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 608A3888D8;
        Tue, 24 Jul 2018 10:15:38 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id A733A892B8;
        Tue, 24 Jul 2018 10:15:37 +0000 (UTC)
        (envelope-from manu@freebsd.org)
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: manu)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 626B512AAF;
        Tue, 24 Jul 2018 10:15:36 +0000 (UTC)
        (envelope-from manu@freebsd.org)
From:   Emmanuel Vadot <manu@freebsd.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH v2 3/5] ARM: dts: sun8i: h3: Add SID compatible string
Date:   Tue, 24 Jul 2018 12:15:20 +0200
Message-Id: <20180724101522.68165-3-manu@freebsd.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180724101522.68165-1-manu@freebsd.org>
References: <20180724101522.68165-1-manu@freebsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SID controller on H3 is one of it's kind (at least from what we
know).
Add a compatible string for it in the SoC dtsi.

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 41d57c76f290..f543aa1dc829 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -185,3 +185,7 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&sid {
+	compatible = "allwinner,sun8i-h3-sid";
+};
-- 
2.17.0

