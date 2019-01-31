Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D904C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111E8218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="d2FPQjEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfAaSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:07:00 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:43822 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfAaSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wku6dQLtRyUUZeB96yaRL/k4Ft7DczuOjN9JrWMw8BY=; b=d2FPQjEaFbT+nPa2mInKbGd1A
        G4MwJDWjQAt4xPFaHl6kTe34lxG1SybFYFzvHEoTO/0sN0h6HI4ftnb36GiKSHZ8Sz2Dyu6IczeDL
        Qhl04wfq04rZBX5maA8EaGg0/NwNyk0I9HrYZ2UYcQFC7tyerUAlbrwQpATlFVUiCgsSI=;
Received: from p5dcc395f.dip0.t-ipconnect.de ([93.204.57.95] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGje-0001Iq-5T; Thu, 31 Jan 2019 19:06:46 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gpGjd-0003mZ-Ca; Thu, 31 Jan 2019 19:06:45 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/2] arm: dts: gta04: add ldo 3v3 regulator
Date:   Thu, 31 Jan 2019 19:06:39 +0100
Message-Id: <20190131180640.14480-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190131180640.14480-1-andreas@kemnade.info>
References: <20190131180640.14480-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Required for completeness sake to be able to specify
a regulator for devices having a non-optional regulator
property. It corresponds to the "3V3" net in the
schematics.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
new in v3

 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index e53d32691308..02d8274a2f47 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -32,6 +32,14 @@
 		display1 = &tv0;
 	};
 
+	ldo_3v3: fixedregulator {
+		compatible = "regulator-fixed";
+		regulator-name = "ldo_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	/* fixed 26MHz oscillator */
 	hfclk_26m: oscillator {
 		#clock-cells = <0>;
-- 
2.11.0

