Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB27ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464A020871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0vUtQgRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464A020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbeGMLRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:17:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbeGMLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:17:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6-v6so24699809wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SfJgK+bi2J4jnNDfFkUldHkyAJ+BTKp6VkmyhXu1Liw=;
        b=0vUtQgRqrhrcCTCxiTyPB2gMyDKTjOtnwyhLR3z+T0lqxSPMoTXWSwRa7gwcZOq2l6
         lJmVmR3rg0oIsZodbjJL4422vtEPef7FoHcvpKe8qgyOq0bzDZzEI4JS4veKbi79GxSN
         fPnUZ+w4hRxHlTMcolJ5GYCm8jG2KW55vVoJBJ26Mu06bFOpuRQJ6MK25yJuxYLbvWpK
         7govz89z43l+lWqSh45/WDTSwjxtPP8MQeWc9TMDQHIWocJe94ANMrc9y/WSH7LHp0Bk
         GGEBSwG+aeQtIxPfTCW+5vNHAhUTWDUPYW7g9+EFeBEg1eB4CzEr45wutzKZBM43V0rq
         X+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SfJgK+bi2J4jnNDfFkUldHkyAJ+BTKp6VkmyhXu1Liw=;
        b=d3SJTF4fOudMqyC2dSOJi7QfhSqZayRXy4GHrSCLHevygGAB0rssEJxdElfBlAW1KX
         IwjowePJQn51lodckA9BQNWFQtyFOSHmZtxKhzpao3qLhppz9Qp31OnuTZ2LUZGSAYlc
         6qmPvc2I+F+GWfQvNowIXFqg1yqezcC5Jxeak/xORjir2B3bFQbMg5si/eKY59iN9dmd
         Iktwyk/dy5cOqbz1Fqn2MES3vCuhCYddkCt9DHl+X0ij8a0PKBIGdlRorSHIc79KbnGb
         hJ1lgJM4BZ+VaxpT3NHMGaXFpKSCBCAfJx9DR3ZtPYVdjc7sp0o27teXNfQzkMKXk+zH
         5pbA==
X-Gm-Message-State: AOUpUlHFGwwJwMiIrZw+TBfvcYPlsBZ8yDnSuFW4MyvX/Ll0rNTho8o3
        +Oljaa4VG3EhVwEpRhLui9Og/w==
X-Google-Smtp-Source: AAOMgpemNzvlOgDFPXh5okghH6kVXV8GINaY35f04D3N6LGr50cZy/lj5IuZkH+1fFLQdGa9Ya1djQ==
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr5009144wrb.155.1531479802631;
        Fri, 13 Jul 2018 04:03:22 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm4598045wrq.45.2018.07.13.04.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 04:03:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 9/9] ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
Date:   Fri, 13 Jul 2018 11:03:06 +0000
Message-Id: <1531479786-4911-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable the AHCI controller.
Since this controller need two regulator, this patch add them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index c39b9169ea64..07eaf6cd9d19 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -105,6 +105,11 @@
 	};
 };
 
+&ahci {
+	ahci-supply = <&reg_dldo4>;
+	status = "okay";
+};
+
 &de {
 	status = "okay";
 };
@@ -251,6 +256,22 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo4 {
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vdd2v5-sata";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd1v2-sata";
+};
+
+&sata_port0 {
+	port-supply = <&reg_eldo3>;
+};
+
 &tcon_tv0 {
 	status = "okay";
 };
-- 
2.16.4

