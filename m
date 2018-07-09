Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863DC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580F220873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IZlLddmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580F220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGIPVx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:21:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45243 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeGIPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:21:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id u7-v6so11409258wrn.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iNRpc6hvom0VEZbqZNyiScnuUjzkmelLQg01kp6iYTk=;
        b=IZlLddmhMIluG6zZ78TqsXbgLXJr/mtG7Iy/BkHT0i4mZ1kCLCb40gXuP0OZh8XiPD
         Z7zQhiKhSK4zTMlNhu22O6K+KGCQObDAor6CQWaps4dMr8wPUWwmpDEPwe35aet/Ms/R
         UIptsaXOyqyBbH6Fj8g51Vxqs9Edb14TQVi0qI6Rwv0jh/YZ9uLZ7w5lFo8UbHR6fyBz
         Z1/SfI7LPg1h0ht5mpNt2icNwPvPtAjb6Q4tHQKmOe9+j806NASp7kswNHLTfO8l/ZWe
         jh+7+qv2gWsldL3JfbJR5GhTGXrM+Ar9WyaogKVNArSOCf+ld/yi4dQb+3wIhAoqFid5
         6T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iNRpc6hvom0VEZbqZNyiScnuUjzkmelLQg01kp6iYTk=;
        b=ihzr9VV/F57xirQdmwaySqQ0P6l6Jr2L5x7uqezBn5n9DAD3oHAzX0BWcQEpXqZ0AW
         hkfW5IYMUy5M/3Qhhe6EwJlAxPJvaOKRFvnrsh4AYH28QAo/sdakaKUQ1vbGasXmnknf
         vHDr9Z3ygx3BXKchGyeje/Us6lej5DK7rERIupcz8qSqexQpRAN0mPwc954DE17pRqGc
         oS3P9aJVRaxT/ZOX4zWbU9QTM8YuLiv7E+e49OiQ4Hqqj0WdIsD36nCCRyHfyOLzsVDR
         1sNrT4wcN+mj5CJJK/CpKEFiXln6L2PO5lBArFvQxLC63iELrgsRBWeUHL1y9HedYe03
         Bsjw==
X-Gm-Message-State: APt69E34E9xHHuUoD1F1YKxNhxo2YXxouKcbX7gouvJtpJP8wwGVKkh0
        /AcEYHuZRPi4leexADRqJJac6Q==
X-Google-Smtp-Source: AAOMgpdvSnrOVhzUyg55ks9Gi9qXp/NTXJEQuMKnmr5y8k1JPkfDx+TJ1zggYr9EvaB+pBbJA2iRMw==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr14323903wrg.230.1531149675475;
        Mon, 09 Jul 2018 08:21:15 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm14468474wrj.71.2018.07.09.08.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:21:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/4] ARM: dts: sun8i: r40: add sata node
Date:   Mon,  9 Jul 2018 15:20:57 +0000
Message-Id: <1531149658-27030-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 have a sata controller which is the same as A20.
This patch adds a DT node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index e366b76b47ce..df5b90faca59 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -551,6 +551,15 @@
 			#size-cells = <0>;
 		};
 
+		ahci: sata@1c18000 {
+			compatible = "allwinner,sun8i-r40-ahci";
+			reg = <0x01c18000 0x1000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
+			resets = <&ccu RST_BUS_SATA>;
+			status = "disabled";
+		};
+
 		gmac: ethernet@1c50000 {
 			compatible = "allwinner,sun8i-r40-gmac";
 			syscon = <&ccu>;
-- 
2.16.4

