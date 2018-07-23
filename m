Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94ADECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF0E20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n09SdPlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF0E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbeGWUmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:42:45 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:47021 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbeGWUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:42:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so1838056qtn.13;
        Mon, 23 Jul 2018 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3omEZ3vVGIziZxnWon7S89NW399Sz3LBct46CTqtlg=;
        b=n09SdPlHZwHRE3DrSD2xrQxlU26LiVqqeh2JPF4KFTQmxmg0rw+J/Z1tBZPatXaa+U
         AawLJ/MQRC/EE2nqXKo3ZmxVA3SLmrCrVqrb0Mw44HVmP3JzQf47bJRoPFE82OyhLLk7
         CMhy14brvVgMAxwcPEpnFyHYX8mQvyHiWGEBDWVASTWcgYdZ7uC7Y6XoH3H2/NBeWH9U
         cu4g2thooIzR4C2pps2+4IYCBaeJjR+HhiiUYzLyKbbYn1tFXNUEZu8BJamZHqRdouJn
         odd7IWCv1Q++ZHW7rB3iDoPx2T8QnDgg/UvmJejfqh8Be1QCaonFD4dAU3nh0b1HETl+
         PI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3omEZ3vVGIziZxnWon7S89NW399Sz3LBct46CTqtlg=;
        b=exIQBWmHX58CnMtNcVeBlgtToHYCSECHjp4unAYui99fZmwo/X1QgVgKEg2zSICwxJ
         RBjgtz/rTDLfbp6li/RjbsU+oj/5sC19ddvkh0d0+VNVSxIOyub6p5TjTre+p2imMl0Y
         P1ef9Fl2LHg1sM6mxX0nz8ww1yLTPZmuNUe+skJJnxzvvAzyTz3wV5aNcrWZ8y4P4I00
         UAJAH3pp0mDMiBYVclp6P4tIL7mlMTXTo5V0bEr7SneX5cH69uPvP4qkzTrts7Zy/2YP
         Zc069SZ5JAFzgyrHZSrLpDUUl68rXtsyuDmRgyb6mOkxykUSToQdWeW+CT3y2/GPT0P2
         g2/A==
X-Gm-Message-State: AOUpUlE960BBjWUZWjchdJzx6IgUJcyXwJeo9aw5DzvQG54JeM/1vu+7
        7J6qwejch15O4MVfZ+VRK9KEjcHaASw=
X-Google-Smtp-Source: AAOMgpdlJ1aCA+OrMojPhFu7DUDmX7Q226gY3+IjLql8qsN5FGoL0D9FcbiYXU+2LLoRG8ubBQBH5w==
X-Received: by 2002:ac8:359b:: with SMTP id k27-v6mr13198734qtb.15.1532374800720;
        Mon, 23 Jul 2018 12:40:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-134-220-116.hsd1.md.comcast.net. [73.134.220.116])
        by smtp.gmail.com with ESMTPSA id 16-v6sm6863042qkd.93.2018.07.23.12.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 12:40:00 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 2/2 v2] Add support for CPCAP regulators on Tegra devices.
Date:   Mon, 23 Jul 2018 15:38:48 -0400
Message-Id: <20180723193848.32491-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723193848.32491-1-pgwipeout@gmail.com>
References: <20180723193848.32491-1-pgwipeout@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for the CPCAP power management regulator functions on
Tegra devices.
Added sw2_sw4 value tables, which provide power to the Tegra core and
aux devices.
Added the Tegra init tables and device tree compatibility match.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    |  1 +
 drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
index 675f4437ce92..3e2d33ab1731 100644
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
@@ -4,6 +4,7 @@ Motorola CPCAP PMIC voltage regulators
 Requires node properties:
 - "compatible" value one of:
     "motorola,cpcap-regulator"
+    "motorola,tegra-cpcap-regulator"
     "motorola,mapphone-cpcap-regulator"
 
 Required regulator properties:
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c0b1e04bd90f..cb3774be445d 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -412,6 +412,82 @@ static struct cpcap_regulator omap4_regulators[] = {
 	{ /* sentinel */ },
 };
 
+static struct cpcap_regulator tegra_regulators[] = {
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
+		.compatible = "motorola,tegra-cpcap-regulator",
+		.data = tegra_regulators,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, cpcap_regulator_id_table);
-- 
2.17.1

