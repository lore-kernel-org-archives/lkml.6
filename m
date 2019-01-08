Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846EA20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HudiWqIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfAHMjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:39:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37588 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:39:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id t18-v6so3277168ljd.4;
        Tue, 08 Jan 2019 04:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjvACtL6TTLn7ppxv1WlIEmlkVSxwuKmGZTr2OytDA8=;
        b=HudiWqIH+WTrDtGkxmvuaZe8swIsqeP4Psg3GTUY2oTpa6AlQIsdEoZsbTEzoByyAi
         AXHaAh4f0XyXLsIOg+8impyZn8VX2ZaMx59jeDYdXRd5bM1v1tQKn5x7rFLfWP6jIG7k
         hl/53TE1KPfT1aFTQUxweTeinK+EcLzSl4vMoDjQroXvklhIyWnxf5pZn9dexgjvIG95
         dxwStSl66Gbxj1fyVIPF700NM6Gr4/BnNzM6N2dZc4s4p0znGdZEuaVpqhzb0h/8xtyW
         B8kqGSBpupIIzBX9NkqEOxGSwlm3kKtd5zC0XJOzbd72wOeiUD0DYjuL20tAqWtqBuVo
         jNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjvACtL6TTLn7ppxv1WlIEmlkVSxwuKmGZTr2OytDA8=;
        b=WUMdLuFAmdzJx6aj0uUhMCKgApqBEUIFgNVhaeRT0TUNSvF31qZkwRUIN/PjLmxfQU
         linnVvZkerQTnUDizrdNbYZKzxiKvcPJd7CX3F5H4dXmAjhyn6uuVxH4UGpS2lfzqKQO
         F82tvq0ce0Ng64nBKAgru/cb49Tg7fatFLkPL9yig2sIcftQMu0SjAUzFOdPAo3hDEdQ
         032fl9oY8dVcY50CQDAToKtOxqAmaGuFkSVL+PH7/oH4DHilSpNTavm/M6SV4PllNJGf
         64I4/8+nLPWOO7brj+rCqWqTGCjdetKFX2D2CpcspF7RXJjrpUVv4bKv5iX+9r2ka+4S
         g7lg==
X-Gm-Message-State: AJcUukfuqlAPDEbt3BiUIfpvnebdhNWE56XwMvoScltvuwCfrm7+gI+o
        +BZrsqIrkPAlnU1Iv2BwCmg=
X-Google-Smtp-Source: ALg8bN5khFs9nKQmaYxSlCpTHHAB69Ev5maPDobIo2HoTBHRbKln9sv64XC1jAfgcKRTlIItRnX6gw==
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr1069713ljj.13.1546951157364;
        Tue, 08 Jan 2019 04:39:17 -0800 (PST)
Received: from samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y24sm12829527lfj.17.2019.01.08.04.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 04:39:16 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use CRU syscon
Date:   Tue,  8 Jan 2019 13:39:06 +0100
Message-Id: <20190108123907.19816-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190107082545.5529-1-zajec5@gmail.com>
References: <20190107082545.5529-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

USB 2.0 PHY is a hardware block that happens to use two registers from
the CRU block to setup a single PLL. It's not part of the CRU or DMU
and so its binding shouldn't cover the whole DMU.

The correct way of handling this is to reference CRU block node using a
syscon. Document that & deprecate the old way.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: use syscon@ in example (thanks Ray)
---
 .../devicetree/bindings/phy/bcm-ns-usb2-phy.txt    | 27 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
index a7aee9ea8926..2cafee6b4a8b 100644
--- a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
@@ -2,19 +2,38 @@ Driver for Broadcom Northstar USB 2.0 PHY
 
 Required properties:
 - compatible: brcm,ns-usb2-phy
-- reg: iomem address range of DMU (Device Management Unit)
-- reg-names: "dmu", the only needed & supported reg right now
+- syscon-cru: phandle to the CRU (Central Resource Unit) syscon
 - clocks: USB PHY reference clock
 - clock-names: "phy-ref-clk", the only needed & supported clock right now
 
+Deprecated:
+
+PHY block should not claim the whole DMU so such a binding has been deprecated.
+It only requires to access few CRU (a DMU subblock) registers and that should be
+handled with a syscon since CRU is a MFD (Multi-Function Device).
+
+- reg: iomem address range of DMU (Device Management Unit)
+- reg-names: "dmu", the only needed & supported reg right now
+
 To initialize USB 2.0 PHY driver needs to setup PLL correctly. To do this it
 requires passing phandle to the USB PHY reference clock.
 
 Example:
+	dmu@1800c000 {
+		compatible = "simple-bus";
+		ranges = <0 0x1800c000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		cru: syscon@100 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x100 0x1a4>;
+		};
+	};
+
 	usb2-phy {
 		compatible = "brcm,ns-usb2-phy";
-		reg = <0x1800c000 0x1000>;
-		reg-names = "dmu";
+		syscon-cru = <&cru>;
 		#phy-cells = <0>;
 		clocks = <&genpll BCM_NSP_GENPLL_USB_PHY_REF_CLK>;
 		clock-names = "phy-ref-clk";
-- 
2.13.7

