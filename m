Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D425C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CE620862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da0LDtvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CE620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeICOVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46633 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeICOVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so17172782wrc.13;
        Mon, 03 Sep 2018 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNiJvsSjjdgkQ1ZQoChwHdQ+/Jgt1wIrgsMDUlZYcDA=;
        b=Da0LDtvUx2ZakB3RYUo5s50VYBxKrxaxV+rN/HJEZP6SHYGGVcSrxGBYkVVFuMkMGK
         +dZ4PFxRXHuinvFrz2NSHlL6k/o/UB/YrXcn4QG1DJkvyuwRfX2bN1vablMwBV49QSyj
         XwjLVLlKhF6uFG0A5JCkMvIy1O4/XiJ0o7eFc3J5GCqn578gGR+Fr+LINYLX3IRHVoNX
         KN20NGujdnZC8PY21heiL2hKIOMpmjFNSml33FC71sQNXceZPqA6zjckHFG47mEriDqC
         dMiRnnrUizmsNroMIjSt4wFl4jBng3f7bYzftyzYnSe9tO6zYFr1hD0qzSGUkx7rBcJv
         yoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNiJvsSjjdgkQ1ZQoChwHdQ+/Jgt1wIrgsMDUlZYcDA=;
        b=F9zcGqSFz8A4ddvzXRSFMLwWe3NF0EHSsyFCj3oV5WIWnEvvopZWoR1YC1uU3Y7q5j
         bwn2Llg1AobJxeBhzQ/WjBAEpRDHgVFDeWjFlcHrrqwsdKrsO9Kz9rEn9SfqLdJDHOqZ
         IzazOeZanuf2InsEkDOKwYnP7mtiOUBQOqO+I7CAnQBFUoTk/NAs2Nesre1FJN9BaCdx
         hV1q5QbdlpFhvDPu67NSwDdlp+79pPY0TGysX4wOM/Pjqz08je7aQQt1SFFHxT6RFXRi
         7HoLRrO/fB7cLdOXvupCmWgHDTuq0YJqGr/t5mKC1WFtB8N1oqWVKUKha1ShyNbMfdhk
         aXjg==
X-Gm-Message-State: APzg51BR1HM++MZJqQT/xFgEPkXQ3dFX9XBptoIZcDEInppDzt23ihbr
        3t7QI2J5NEtYpS1q19GPv0E=
X-Google-Smtp-Source: ANB0VdaNyNMsh0OqKfQXULzzxhfM4EIKfWqEDJ0m/NjlNsFiVZriZMTIOdT+FGXBpQeEF34mD+zj4Q==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr7407609wrm.136.1535968937245;
        Mon, 03 Sep 2018 03:02:17 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:16 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 8/9] ARM: dts: sun8i: r40: add sata node
Date:   Mon,  3 Sep 2018 12:02:00 +0200
Message-Id: <20180903100201.23131-9-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 852c2ccc3268..d27c522e1918 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -550,6 +550,19 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun8i-r40-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			resets-name = "ahci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4

