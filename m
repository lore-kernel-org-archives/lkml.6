Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4313120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkorS8bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4313120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbeGXOcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:32:36 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34548 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbeGXOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:32:36 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so4053646qth.1;
        Tue, 24 Jul 2018 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auQCGeAY6c3Kh11BEqKYCRJFkCr6bUkTToi+139yJQ0=;
        b=QkorS8bCv0gPIXjqFBLjVpp7uNNgejdhOJuIGxBP3i1WZOawi9WA/8n+0CaNi36F2g
         aDpcBSXbcVXBChkKZmQUAw6vQWUcAPhc9Nkj49tgtESYNxfq3ogMZzn/oicYizjkEftO
         rNcfFA9iPV1pwZbL944n5fhbjX5bIx9sqL/lNtCp+Bd9heDslC9UELpdrc0lWNtMWB/w
         Y5JmasB2a+nrhODud1b1OQ1av5DEFU2Pm05REnAcue2FO1mti2FWq1zxAa8Xy3iBd+fJ
         sY5gTA24kXkJsjKZ1m6AAfDEtoj7f8KHV2nCtXQM4Pr1vSP8+vkNr8abW+FdTEeIw+Gl
         1vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auQCGeAY6c3Kh11BEqKYCRJFkCr6bUkTToi+139yJQ0=;
        b=OQAotnfRWDysu0bE3CU+Qus7JH5C5qIoaVkhrahNGxGf9JBRItYZGyIno6bcIevnfP
         ZzrnBrc/NduJ3chpQeVuUuowluCO19cNJaK/L7tya1aVHo2pKoVezT7sdctzf1gIq9Oz
         ZSgYWHKxnFbVr3WsrHrcNzHJfnn2Gh9mR/EOZma7kc+BIvJP1ZQCG1hhPH1HNHcQAZcM
         WIhqYW3KGnzYG/2NEKLDGVeVAAvzP/bjeAPk8ReiRPBvqll08Kld/LfaIim/pN7ayB32
         mUbOblLqBktnoiMYngLHyd7T+A8FIFZRbj95dwdrIhcHE2nNhZ4w3X6yhVLNCXggF160
         SO6A==
X-Gm-Message-State: AOUpUlE/X4YB6TcteqKo1YvrK+x/SdLH933T9n0msRN6CpecwQHK99V3
        lE1rKBGfHZ9klq/kHUXqh/A=
X-Google-Smtp-Source: AAOMgpf2eWBbr+u2058KGc/P/jAnw0FyPExG6d6KOWxt7lclLCq+xhQqmItrs6TtVI+h5Ujg3f+8vw==
X-Received: by 2002:a0c:dd86:: with SMTP id v6-v6mr15110079qvk.148.1532438766229;
        Tue, 24 Jul 2018 06:26:06 -0700 (PDT)
Received: from master-laptop.pgwipeout.duckdns.org (111.sub-174-204-1.myvzw.com. [174.204.1.111])
        by smtp.gmail.com with ESMTPSA id e20-v6sm16543346qkh.32.2018.07.24.06.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:26:05 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v3 2/2] Add support for CPCAP regulators on Motorola Xoom devices.
Date:   Tue, 24 Jul 2018 09:25:41 -0400
Message-Id: <20180724132541.17039-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724132541.17039-1-pgwipeout@gmail.com>
References: <20180724132541.17039-1-pgwipeout@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for the CPCAP power management regulator functions on
Tegra based Motorola Xoom devices.
Added sw2_sw4 value tables, which provide power to the Tegra core and
aux devices.
Added the Xoom init tables and device tree compatibility match.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    |  1 +
 drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
index 675f4437ce92..36f5e2f5cc0f 100644
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
@@ -5,6 +5,7 @@ Requires node properties:
 - "compatible" value one of:
     "motorola,cpcap-regulator"
     "motorola,mapphone-cpcap-regulator"
+    "motorola,xoom-cpcap-regulator"
 
 Required regulator properties:
 - "regulator-name"
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c0b1e04bd90f..2131457937b7 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
 	{ /* sentinel */ },
 };
 
+static struct cpcap_regulator xoom_regulators[] = {
+	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW2, CPCAP_REG_S2C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW2_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x800, 0, 120),
+	CPCAP_REG(SW3, CPCAP_REG_S3C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW3_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(SW4, CPCAP_REG_S4C1, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW4_SEL, sw2_sw4_val_tbl,
+		  0xf00, 0x7f, 0, 0x900, 0, 100),
+	CPCAP_REG(SW5, CPCAP_REG_S5C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW5_SEL, sw5_val_tbl,
+		  0x2a, 0, 0, 0x22, 0, 0),
+	CPCAP_REG(SW6, CPCAP_REG_S6C, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_SW6_SEL, unknown_val_tbl,
+		  0, 0, 0, 0, 0, 0),
+	CPCAP_REG(VCAM, CPCAP_REG_VCAMC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VCAM_SEL, vcam_val_tbl,
+		  0x87, 0x30, 4, 0x7, 0, 420),
+	CPCAP_REG(VCSI, CPCAP_REG_VCSIC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VCSI_SEL, vcsi_val_tbl,
+		  0x47, 0x10, 4, 0x7, 0, 350),
+	CPCAP_REG(VDAC, CPCAP_REG_VDACC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VDAC_SEL, vdac_val_tbl,
+		  0x87, 0x30, 4, 0x3, 0, 420),
+	CPCAP_REG(VDIG, CPCAP_REG_VDIGC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VDIG_SEL, vdig_val_tbl,
+		  0x87, 0x30, 4, 0x5, 0, 420),
+	CPCAP_REG(VFUSE, CPCAP_REG_VFUSEC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VFUSE_SEL, vfuse_val_tbl,
+		  0x80, 0xf, 0, 0x80, 0, 420),
+	CPCAP_REG(VHVIO, CPCAP_REG_VHVIOC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VHVIO_SEL, vhvio_val_tbl,
+		  0x17, 0, 0, 0x2, 0, 0),
+	CPCAP_REG(VSDIO, CPCAP_REG_VSDIOC, CPCAP_REG_ASSIGN2,
+		  CPCAP_BIT_VSDIO_SEL, vsdio_val_tbl,
+		  0x87, 0x38, 3, 0x2, 0, 420),
+	CPCAP_REG(VPLL, CPCAP_REG_VPLLC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VPLL_SEL, vpll_val_tbl,
+		  0x43, 0x18, 3, 0x1, 0, 420),
+	CPCAP_REG(VRF1, CPCAP_REG_VRF1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF1_SEL, vrf1_val_tbl,
+		  0xac, 0x2, 1, 0xc, 0, 10),
+	CPCAP_REG(VRF2, CPCAP_REG_VRF2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRF2_SEL, vrf2_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 10),
+	CPCAP_REG(VRFREF, CPCAP_REG_VRFREFC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VRFREF_SEL, vrfref_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VWLAN1, CPCAP_REG_VWLAN1C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN1_SEL, vwlan1_val_tbl,
+		  0x47, 0x10, 4, 0x5, 0, 420),
+	CPCAP_REG(VWLAN2, CPCAP_REG_VWLAN2C, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VWLAN2_SEL, vwlan2_val_tbl,
+		  0x20c, 0xc0, 6, 0x8, 0, 420),
+	CPCAP_REG(VSIM, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsim_val_tbl,
+		  0x23, 0x8, 3, 0x3, 0, 420),
+	CPCAP_REG(VSIMCARD, CPCAP_REG_VSIMC, CPCAP_REG_ASSIGN3,
+		  0xffff, vsimcard_val_tbl,
+		  0x1e80, 0x8, 3, 0x1e00, 0, 420),
+	CPCAP_REG(VVIB, CPCAP_REG_VVIBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VVIB_SEL, vvib_val_tbl,
+		  0x1, 0xc, 2, 0, 0x1, 500),
+	CPCAP_REG(VUSB, CPCAP_REG_VUSBC, CPCAP_REG_ASSIGN3,
+		  CPCAP_BIT_VUSB_SEL, vusb_val_tbl,
+		  0x11c, 0x40, 6, 0xc, 0, 0),
+	CPCAP_REG(VAUDIO, CPCAP_REG_VAUDIOC, CPCAP_REG_ASSIGN4,
+		  CPCAP_BIT_VAUDIO_SEL, vaudio_val_tbl,
+		  0x16, 0x1, 0, 0x4, 0, 0),
+	{ /* sentinel */ },
+};
+
 static const struct of_device_id cpcap_regulator_id_table[] = {
 	{
 		.compatible = "motorola,cpcap-regulator",
@@ -420,6 +496,10 @@ static const struct of_device_id cpcap_regulator_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-regulator",
 		.data = omap4_regulators,
 	},
+	{
+		.compatible = "motorola,xoom-cpcap-regulator",
+		.data = xoom_regulators,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
-- 
2.17.1

