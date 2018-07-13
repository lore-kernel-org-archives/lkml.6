Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2520836
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yS/aCRtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbeGMLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbeGMLRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so24744032wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=84iIu3wW7KctAJlF7h2Jo6jAitXTxaQ/EbKtt1dZYAY=;
        b=yS/aCRtjeUdaUfCwgI1BX3z5EIi0QWmB593q2D4hULHw1TNRwwm6GhNf3hKKVlnuVi
         RVy3AGKcYpIOqIH6UvLr+5TBS8VP+L9n6jsox8Upb5uDhMvQN2ZZ/LgyEYiLXchILkOB
         JLZQbL1sokAFftXOoGNBnXMkaUHc3t8JFKa8jc18BV284idRGtZORA/8cvX7OaM4eWWl
         yUbTdnGV4px5KSq1QDa8wU2Sii74bXqz1zy5cYog65XSYw+B783mvZFJ0qihseut2qhp
         KbvKHMNyS2KR4MWO4cPdQvOG4DICoxXbMhmvb31KNjcsHv72xRR5GjLpPmy+gDNdGYIa
         I9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=84iIu3wW7KctAJlF7h2Jo6jAitXTxaQ/EbKtt1dZYAY=;
        b=HDCBDPevRPTgVGDuYinF0w9rMcHsEHd+OwifUV8qqCaYkxjk2SemFdZGWVOooVz/Sj
         jpduFM+T+FyS4+AnDe7k4W4tVph8ae3xQTO0uPTrgk2EMTiC6B/AS16bXn/VR+UB4LAY
         AZodtN7cYxitRF4QOJ128gEltQStc1AosN0LEiKH494US8Q09TTdpomiASFCqUjYZuuK
         q2DKRvkx4PD0gmJ37qfb0Yqb9DfqAzHu69T34HqT2MvxN0XIBhcwk1rSx0+zN4PGcs+o
         b9HwoYktHIblGcj21gc9CSD7CiSrBt8x8NLY9L2zCSc+tjcSQnT3UfEoAH5cVDAOHA1w
         dPzQ==
X-Gm-Message-State: AOUpUlHU3kyTgwOhDtLYS0D9h280ipQyJCMGU2pYvUevSSlX7qD3KSoN
        sCock1c4Fg3sP4bI45gT+L9n2g==
X-Google-Smtp-Source: AAOMgpd+On2Tihi46NG4XZNju7z49EM4AltPA2PJcFSF9W5Oxx26DXrDe5QVFj0XXfINCmC981QZRA==
X-Received: by 2002:adf:c684:: with SMTP id j4-v6mr4744139wrg.243.1531479801801;
        Fri, 13 Jul 2018 04:03:21 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:21 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 8/9] ARM: dts: sun8i: r40: add sata node
Date:   Fri, 13 Jul 2018 11:03:05 +0000
Message-Id: <1531479786-4911-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index d4ad55eb2245..bd369112a400 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -550,6 +550,22 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun4i-a10-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			resets-name = "ahci";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			sata_port0: sata-port@0 {
+				reg = <0>;
+			};
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4

