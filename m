Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FBE2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKu/E/VK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FBE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeH3XFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:05:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40396 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeH3XFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:05:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so3042557wme.5;
        Thu, 30 Aug 2018 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qpn+V0z5TaoK+rCQvEV6gj7EtBpctPHnnDY7C6IV55A=;
        b=MKu/E/VKoTesFb4kDZjoXvEWLAK1SkUckVuiZ0xKt1zIFShbUEFE8aXAGfqIMlUeAq
         vsDkhu7VV9xNPStOe5WBw52JEN51Jy6u/0X7neLjIqRNfzElirChtpRQwZgogweYjLME
         3r/ktmQC5RSh3lidLvcKbCL7d+IKD1KRGnKOPa7faD/wI1COTLegDW1XjIKa8tUrwp48
         Yc6Mx0DLWNWBSKeplX956Om2LAem1kozSaBVRGaOkeFUQzQuLVpWc93Hd5rLuJ69R5bp
         DcrOMRjzhUulVPVQmIdE/ygC91NvzHT6HUj1dxf2G2Flqh6+v6k4CNAitJ/3U0Ce+kxe
         XlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qpn+V0z5TaoK+rCQvEV6gj7EtBpctPHnnDY7C6IV55A=;
        b=Tnlpj2tj+uIQ5vGmVa+IWAs6WsqJg+QT05bqxp1CaXxJFUty7JMRSmjbyBRC0+7BQZ
         Qzn4PQ29szpCJ7UITyAKn9EWMr4GjjH8gtiQ5HVLOyM7p85Rq80AiYMgrt2suRwTRrkf
         a8nxMH73ns/VMFJBCRY2ckVn9yOd5JWkiVhiaZ03raT4PMUFU6kUne05IxR6uRbcduzA
         IlKH50jaGVkKfEkLlnhN2Pdc5ElMICcqNywhTyvkV5a3KRavBjTIU4pgbB2C1Zm7m3j9
         79euHE0ZLHS8DSD/M2famgprI4FAMYATTvJQTtEqzDVOFhWkp/IiHgcb9UPw+f1nhnxc
         b2FA==
X-Gm-Message-State: APzg51B8ljl9ihn4quEDmFgXuQcjI3NG6+0Y2lWgzXU9E26npGzE3WWe
        I7zDSmWbwqBfZmccWwFAITQ=
X-Google-Smtp-Source: ANB0VdYRpTWwjGPy1ljIZrGwfeUuszBJDlGgN8Nhb2D2j7sxFbEyan8HkdEw/5rYJ3pTZ7pMyhOkFA==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr2828082wme.125.1535655702588;
        Thu, 30 Aug 2018 12:01:42 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id w17-v6sm2937095wmc.43.2018.08.30.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:01:41 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org, clabbe.montjoie@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Date:   Thu, 30 Aug 2018 21:01:16 +0200
Message-Id: <20180830190120.722-10-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 852c2ccc3268..d6b5820da850 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -550,6 +550,29 @@
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
+			sata_port: sata-port@0 {
+				reg = <0>;
+				phys = <&sata_phy>;
+			};
+		};
+
+		sata_phy: sata-phy@1c180c0  {
+			compatible = "allwinner,sun8i-r40-sata-phy";
+			reg = <0x1c180c0 0x200>;
+			#phy-cells = <0>;
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4

