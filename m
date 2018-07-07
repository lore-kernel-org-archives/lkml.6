Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61252C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C390224D8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZywuTeKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C390224D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeGGAS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:18:56 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41293 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932769AbeGGASv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:18:51 -0400
Received: by mail-qt0-f193.google.com with SMTP id y20-v6so11344030qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rH/8dYy2/B1xbTEnv0b4k1bCoDjEJvgNJWFChFL2PLM=;
        b=ZywuTeKdzmkW/9xsHyW62b6mkXB5Y7X9bC9EB8aiX6FX2uizFJq/QAQBtR6MYR8qJt
         rPpA1KBv65yFysheVddRZt7mO1BMzpnRt1bz1t1eVhGLZ2dqCG1J2Mp89ayOZwMQZfD4
         eoGYjy87PfYXySB1XLXKDlRibCCXRRJODxwNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rH/8dYy2/B1xbTEnv0b4k1bCoDjEJvgNJWFChFL2PLM=;
        b=FoHbuRIVy+gFEXJk+Ax46pbbwLVo84g+UMFf+XMmEwE8UfsBLdJ0S20h9TkbN6lZGt
         jpjxA6BZgH4OX0jTN89EwtgguCtX0dReNyesajRxzBhaefqIoYV7spk5bmGYj7CtpUwx
         EPPNcNJrx+xxkc0rAoiOMaRDj52SQRBtAeBRBIJL5HGnwNXHgz6YhUlhKFm8a9+TTl7z
         bdWiPGL+lPDVuCa+Q5ZCLXki1tS0nKY6supq2BFOxrqh2Rn6WS1JyqPS0TYuj9MFAYII
         c3l6cObZ6tfsLd6zayFNKxhyXGr3J4TrCTK46yA0NauHJDxl+FbiZvoU10xjNpdkVdzL
         09Xg==
X-Gm-Message-State: APt69E2ur03r0YJ688DCkxPb2XDyh08a5IfV1l5fjU5mYjxYSJE2+1XI
        waz3QOB/ZWpGpQn85Iy+aeBYoA==
X-Google-Smtp-Source: AAOMgpdY/HVDj+oZpC07AjqUpfb38Ii7nrjm/2/SgO1r5YSkcpP4yH8mkjhEXVGaByZQfh9tBt4bow==
X-Received: by 2002:ac8:460b:: with SMTP id p11-v6mr11447137qtn.418.1530922730191;
        Fri, 06 Jul 2018 17:18:50 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m128-v6sm6385780qkd.33.2018.07.06.17.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 17:18:49 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 1/2] dt-bindings: phy: Add binding doc for Stingray PCIe PHY
Date:   Fri,  6 Jul 2018 17:18:32 -0700
Message-Id: <1530922713-22964-2-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1530922713-22964-1-git-send-email-ray.jui@broadcom.com>
References: <1530922713-22964-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for Stingray PCIe PHYs for both PAXB and PAXC based
root complex

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/brcm,sr-pcie-phy.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
new file mode 100644
index 0000000..e8d8228
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,sr-pcie-phy.txt
@@ -0,0 +1,41 @@
+Broadcom Stingray PCIe PHY
+
+Required properties:
+- compatible: must be "brcm,sr-pcie-phy"
+- reg: base address and length of the PCIe SS register space
+- brcm,sr-cdru: phandle to the CDRU syscon node
+- brcm,sr-mhb: phandle to the MHB syscon node
+- #phy-cells: Must be 1, denotes the PHY index
+
+For PAXB based root complex, one can have a configuration of up to 8 PHYs
+PHY index goes from 0 to 7
+
+For the internal PAXC based root complex, PHY index is always 8
+
+Example:
+	mhb: syscon@60401000 {
+		compatible = "brcm,sr-mhb", "syscon";
+		reg = <0 0x60401000 0 0x38c>;
+	};
+
+	cdru: syscon@6641d000 {
+		compatible = "brcm,sr-cdru", "syscon";
+		reg = <0 0x6641d000 0 0x400>;
+	};
+
+	pcie_phy: phy@40000000 {
+		compatible = "brcm,sr-pcie-phy";
+		reg = <0 0x40000000 0 0x800>;
+		brcm,sr-cdru = <&cdru>;
+		brcm,sr-mhb = <&mhb>;
+		#phy-cells = <1>;
+	};
+
+	/* users of the PCIe PHY */
+
+	pcie0: pcie@48000000 {
+		...
+		...
+		phys = <&pcie_phy 0>;
+		phy-names = "pcie-phy";
+	};
-- 
2.1.4

