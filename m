Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD7DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B1F2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FlOsqtD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B1F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeLHQrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34625 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeLHQrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:47:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so6574183wrw.1;
        Sat, 08 Dec 2018 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
        b=FlOsqtD6yFpp+2FB6KFo1r+R/92R3amvtnxokZsX6tTttY9wVQvUIPyZrD3Vy3b15g
         TtYaZc9eyQcNHXd+zMzV9xc9LVN+nNb7QKmEC1a5jMmo3WgoFi/2pVeOsMvTJ/c5XSF4
         x8GqdvDquNblLK7KtOLOBRsntOJ8l6wzoY17HeIesaGrUBYs63Vo3H+/b1kZy1HgoOtk
         NZE58Zo8+61IU6g+t/VSAX5b8I/sVxxPVbKPEf5kKNHE19Ei1XQiTgFO4JyLjSbXK48a
         G+IrLazDAbRf1htnWdaq3MtuFV4LKPm0SFNsgdI02Sa837YYGMp2g9yz5nmlIFrCui34
         qZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
        b=iVX5yMI4RCxW59prHuWEhKGh3SzShMyZnH951TXEBLbAk77ux1Vzv7cbB0UxTPBK81
         4mw5cHTRloI42c22BJKIfObGTUCfOd0N9hf/NCHha3DwYnaUUjWkhze2Tx397UN9Apii
         BucROPksh710u4jzeUv0duwl+SDysVNxHN+XKDIB7V3KwEPo0x21iHPpbeGNFKPMRVQP
         GFB4zf5Pn9uwPiKwpEZOggSI4zVS18PF9RrShgnPnL8g+FgcHhgf1/LYGhMWAGqv0QTd
         80R5GQ9CtEEIMk3RAF48Cw0H7nCdbq/0gUY+yZY/ZAi8srq9qKHyeac+Tjk3wcVKkJCG
         2pLA==
X-Gm-Message-State: AA+aEWZPLr8vdSauaL9DiCwjq2GZgdt0qJl+XKQlRRqsHgMnortd8t35
        UDj8NnA7g0BNE2tuhWOAjMg=
X-Google-Smtp-Source: AFSGD/U6ogpB4HQqdyM91TzMjFd1lkAe5ZcTIHIB7n7H2lLUqIJ2Y0/GeQvLfohVeuBvrHypkMzTlA==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr5175789wru.263.1544287621284;
        Sat, 08 Dec 2018 08:47:01 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:47:00 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: add the APB bus
Date:   Sat,  8 Dec 2018 17:45:55 +0100
Message-Id: <20181208164555.26527-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various peripherals (Mali GPU, NAND controller, VPU; etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 22d775460767..5d036842c355 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -178,6 +178,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2

