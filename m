Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC107C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575F8214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="HdF2zIbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575F8214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeIYMKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:10:31 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:33142 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537855474;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=+j7AAWTnW1QM51gakyu5MnIY98uhChUgB5UxFe/3uhA=;
        b=HdF2zIbUGx/Ph/F4gS2OEoS044adag4Pue+0G54mke9kcVs2MTc5MVi3+QopovNx6u
        R/By/N6dALomPt8mXq3dhcb9Vq9zcyyrKdVilQL/uoiGZwZFr9gZ87JWirqPs7xi6npo
        yuZZl67OrKkjmLlBLTyqw7PGsarU9xzgPO5zr4UQmZB6yzGeoFZxCQCqBcKMFNQ3pDvk
        lTRyhstUMsATKyDSMWsDZkurds/8E1duPl2lfUEim2Xu9I5nEzVR8MiFeHfhqX8fxMAX
        m2dzyBqqIAhsnpgGLWbJ/NQ9cEnhs4ajum5AnZK7pwfMw66WMXp6v5hel1lHhyz8co33
        vG9w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLzB8ihjJ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.1 DYNA|AUTH)
        with ESMTPSA id 60b24bu8P64Qg7q
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 25 Sep 2018 08:04:26 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, tony@atomide.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: dts: add omap3-gta04a5one to Makefile
Date:   Tue, 25 Sep 2018 08:04:24 +0200
Message-Id: <6a9c49e78f93333f288f302ba880dc05308a5e0f.1537855461.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have defined a new DTS and it should be compiled.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b5bd3de87c33..8cb78264adee 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -649,6 +649,7 @@ dtb-$(CONFIG_ARCH_OMAP3) += \
 	omap3-gta04a3.dtb \
 	omap3-gta04a4.dtb \
 	omap3-gta04a5.dtb \
+	omap3-gta04a5one.dtb \
 	omap3-ha.dtb \
 	omap3-ha-lcd.dtb \
 	omap3-igep0020.dtb \
-- 
2.12.2

