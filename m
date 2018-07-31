Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98D5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777C6208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="K9AJ9VTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777C6208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbeGaIvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:51:50 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:8106 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbeGaIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021111;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=RGOreC3tp83O0ghPcOhCUnZZkduJkZSJJ1pfjFL75EM=;
        b=K9AJ9VTjtTnKhcstxU9UjkwYs7oqWsJlKfWN+jIhAYRupJVjPVxuwXU3BhS6+oG2B1
        Ono/IqMh77hKS77un0W1t4tbiJZobSAMFteGGFBkGNKmSJ1szVoZfJeMf4qG0NOLbFfi
        CcNMk2nur2vkEmzNOwOL+qqdXZnygazr2sO/QZtFrLUsSFhQpm+S6sVlOxw/e5wMNzPg
        Q6z94NexkhVxZ9KT+l4zeJUKWGpUNkbAqIYfXoxJcDJ/dyBgu6+okiLNf4rmK0vraVnp
        JlvDgqLQpqZ9Q5qHYIfTXY/O90Iij560GLXe5saxfOEFvWBiq4i+jW5mB5OctZ29o79j
        IsXA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BjwOn
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:45 +0200 (CEST)
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
Subject: [PATCH v2 22/32] ARM: dts: omap3-gta04a3: fix model name for A3 variant
Date:   Tue, 31 Jul 2018 09:11:25 +0200
Message-Id: <b5c85cd5ec35fe448253566526e6a5e052d1973b.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GTA04 is the project name and Letux 2804 the product name.
Report both.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04a3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a3.dts b/arch/arm/boot/dts/omap3-gta04a3.dts
index 3099a892cf50..cc9244956679 100644
--- a/arch/arm/boot/dts/omap3-gta04a3.dts
+++ b/arch/arm/boot/dts/omap3-gta04a3.dts
@@ -9,7 +9,7 @@
 #include "omap3-gta04.dtsi"
 
 / {
-	model = "Goldelico GTA04A3";
+	model = "Goldelico GTA04A3/Letux 2804";
 };
 
 &i2c2 {
-- 
2.12.2

