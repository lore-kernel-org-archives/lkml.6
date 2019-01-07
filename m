Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB8EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF62D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQcG6XC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfAGI0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:26:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43529 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfAGI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:26:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2-v6so37327337lji.10;
        Mon, 07 Jan 2019 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLXNvusCzUnhNF755AIrtvz3ssElMEIzt8W+f+xSlbQ=;
        b=AQcG6XC6quINw+T8yKUIzN/BbUyuBFEOVw9/KoxyiybiuQLAE4OM54hurIe0Hj8kuS
         PQmpDvBIcGbN4Bh6b10//U/IZjE8zdW/J7vYtDP+b2AtkiTW7VjN9WV4zCltXOap9JmH
         e19130N2GwL66W3DqQfmSplsR65XFDTzi5JohNK8rvZQce5qx1WmBy0a8CaV3iOUJ93k
         6o70gP4rwTEgzinv2ZtyrhNiH4Mz0vXaDs7za6/c5Cmq7FboZs0yEnuWZfEEMKd3rMyg
         pPlVq5iA2TA42ipnahtHDacn7XTr79kvZFBSh/cU0gv72CVBU5crKu6bM0e2SX1w7LhO
         T+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oLXNvusCzUnhNF755AIrtvz3ssElMEIzt8W+f+xSlbQ=;
        b=LlZWd/bAy8gqgYAdy/kHf5KdPJght2qw/JgIr2UvgC9gmNgnrCoxrrmACzXmi73ncm
         NtkWAk1loEbOmJYnkONusFJAiWhOaFshL84Qlf5sSvEOA1j0fvB+Nbm3/69SlxvxpXsW
         aBgDbv/nTA0FstbCvcCQPmimkJuTQa1z3zonGQEOM7GonTJYrXwEcFwi291z6GCiV7ux
         PzhWS0aDLzVEsoxZKo3Vtld4crOTNtfSwqhR/DGBgTt+4TUUBPKHiCxYZytkD42sH2LV
         8FQQgFbaK9GNZasouTH9ftno8dn+ouoFQ7loBuOQuEkzp22V+GajsQiMJcrA/khv0Ryn
         86uA==
X-Gm-Message-State: AJcUukfCQ3Y3VOZstkLO4tM+e7FoN6PBW29ZMn/LJxtM2my94zZPzXan
        QTRVDJczSXu+Qa4Ky3aaPMY=
X-Google-Smtp-Source: ALg8bN7Vm5Y6Vtcp1ytwHJ5ZvvtUHexfZNX03kbRA3ioqNSOlIZ9sfB4ZQOeooRZ3g9QeWqRlwKqgA==
X-Received: by 2002:a2e:2d4:: with SMTP id y81-v6mr33743007lje.62.1546849560547;
        Mon, 07 Jan 2019 00:26:00 -0800 (PST)
Received: from linux-veee.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 6sm13692196lfa.27.2019.01.07.00.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 00:25:58 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: bcm-ns-usb2-phy: rework binding to use CRU syscon
Date:   Mon,  7 Jan 2019 09:25:44 +0100
Message-Id: <20190107082545.5529-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.13.7
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
 .../devicetree/bindings/phy/bcm-ns-usb2-phy.txt    | 27 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt b/Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
index a7aee9ea8926..36b634d2f0ca 100644
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
+		cru: cru@100 {
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

