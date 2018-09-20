Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF650ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B2221531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW27HKpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeIUBCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37325 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id q5-v6so1321466pli.4;
        Thu, 20 Sep 2018 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eKHhL6tPYQF2Z6TFU+VhMdWFbaJCBnSlzfGFYG99ED4=;
        b=qW27HKpKY2BrZC0WYuyA3Bh24D7iW25ipwAMyEOxt6J1iFq0r/mrusLR9CGChKKz4e
         ZtpbebKQHItFAWhbTfh7/VOccnvaFuPqOSKNY4Wtf1Bp/0lJFvhV1M2qrxZcRUg8l3qp
         haGJxhzgKKJ9g4l2Qer8tl3yQ1GS35THVBCRYhCPy38UOZHh6VsqGnbVfgKTfDJ/gVg7
         qP7qmhmj9SBDAcwlewIhWmFI5qux7/ooI+86/GnNcseWDYK8vZ2+nu600TcqfV+pH4mN
         jHRgzB8q3ARWNBYF2EJuN68OyYrcYw4CvfDRl8a7mUL3IngKPSB1QbO+R1qFUDTiuVoL
         70lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eKHhL6tPYQF2Z6TFU+VhMdWFbaJCBnSlzfGFYG99ED4=;
        b=ZLeCHzVGLwSDHUogMHMUhEt/BoyUKi+uvWIf1AlSQqwJVsonxS/rPntM/3GDdW1C3O
         UvbE+RlybxuWZ4W+UkWm2ig12DxJ1/fYn6bF97qts4hZa6uavFdt+gfrODljPVFN5VcH
         UleMeQY7aLi09Cu0vX+1vk572j2uptFDuFRffzFT5UXefUlYboKUZLd5P4IxG7O0DsAu
         Ep9Xlpx1oA380jOExgTNto7EtTGuNJzFBj5Yb+4T7wXV9wor9/hyB/dsEvyyb9SlG+ox
         oQaXPXR53CVq7+zcE9xvgQU4yAs+aV/bRDYr+vaSj3V4T892QMveBN3kaFRGcBsXV6Xb
         swnw==
X-Gm-Message-State: APzg51Dqd47DwSva/pRpSFEQ2POSoGCdd+IZtrJg4X6mkSJ7y6Fh08Sn
        E0Q/MGyN63RW+fVG8uRHiT2Gh9su
X-Google-Smtp-Source: ANB0VdZa2LJQ1+06E7CRPqZINbwEZUozXtehn93+UbUfn4kHGVWipk4CcXGx9KUn3AKeZR2YpGFLxA==
X-Received: by 2002:a17:902:8f93:: with SMTP id z19-v6mr40385062plo.263.1537471041696;
        Thu, 20 Sep 2018 12:17:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 3/9] phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence
Date:   Thu, 20 Sep 2018 12:16:38 -0700
Message-Id: <20180920191646.18198-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM63138 SATA PHY requires a special initialization sequence in
order to operate correctly, mostly tuning incorrect default values.
Implement that sequence and match the documented compatible string as an
entry point into that sequence.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-sata.c | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 8708ea3b4d6d..218735305d85 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -47,6 +47,7 @@ enum brcm_sata_phy_version {
 	BRCM_SATA_PHY_IPROC_NS2,
 	BRCM_SATA_PHY_IPROC_NSP,
 	BRCM_SATA_PHY_IPROC_SR,
+	BRCM_SATA_PHY_DSL_28NM,
 };
 
 enum brcm_sata_phy_rxaeq_mode {
@@ -96,7 +97,10 @@ enum sata_phy_regs {
 	PLLCONTROL_0_FREQ_DET_RESTART		= BIT(13),
 	PLLCONTROL_0_FREQ_MONITOR		= BIT(12),
 	PLLCONTROL_0_SEQ_START			= BIT(15),
+	PLL_CAP_CHARGE_TIME			= 0x83,
+	PLL_VCO_CAL_THRESH			= 0x84,
 	PLL_CAP_CONTROL				= 0x85,
+	PLL_FREQ_DET_TIME			= 0x86,
 	PLL_ACTRL2				= 0x8b,
 	PLL_ACTRL2_SELDIV_MASK			= 0x1f,
 	PLL_ACTRL2_SELDIV_SHIFT			= 9,
@@ -106,6 +110,9 @@ enum sata_phy_regs {
 	PLL1_ACTRL2				= 0x82,
 	PLL1_ACTRL3				= 0x83,
 	PLL1_ACTRL4				= 0x84,
+	PLL1_ACTRL5				= 0x85,
+	PLL1_ACTRL6				= 0x86,
+	PLL1_ACTRL7				= 0x87,
 
 	TX_REG_BANK				= 0x070,
 	TX_ACTRL0				= 0x80,
@@ -119,6 +126,8 @@ enum sata_phy_regs {
 	AEQ_FRC_EQ_FORCE			= BIT(0),
 	AEQ_FRC_EQ_FORCE_VAL			= BIT(1),
 	AEQRX_REG_BANK_1			= 0xe0,
+	AEQRX_SLCAL0_CTRL0			= 0x82,
+	AEQRX_SLCAL1_CTRL0			= 0x86,
 
 	OOB_REG_BANK				= 0x150,
 	OOB1_REG_BANK				= 0x160,
@@ -168,6 +177,7 @@ static inline void __iomem *brcm_sata_pcb_base(struct brcm_sata_port *port)
 	switch (priv->version) {
 	case BRCM_SATA_PHY_STB_28NM:
 	case BRCM_SATA_PHY_IPROC_NS2:
+	case BRCM_SATA_PHY_DSL_28NM:
 		size = SATA_PCB_REG_28NM_SPACE_SIZE;
 		break;
 	case BRCM_SATA_PHY_STB_40NM:
@@ -482,6 +492,61 @@ static int brcm_sr_sata_init(struct brcm_sata_port *port)
 	return 0;
 }
 
+static int brcm_dsl_sata_init(struct brcm_sata_port *port)
+{
+	void __iomem *base = brcm_sata_pcb_base(port);
+	struct device *dev = port->phy_priv->dev;
+	unsigned int try;
+	u32 tmp;
+
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL7, 0, 0x873);
+
+	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0xc000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+			 0, 0x3089);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+			 0, 0x3088);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL0_CTRL0,
+			 0, 0x3000);
+
+	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL1_CTRL0,
+			 0, 0x3000);
+	usleep_range(1000, 2000);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_CAP_CHARGE_TIME, 0, 0x32);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_VCO_CAL_THRESH, 0, 0xa);
+
+	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_FREQ_DET_TIME, 0, 0x64);
+	usleep_range(1000, 2000);
+
+	/* Acquire PLL lock */
+	try = 50;
+	while (try) {
+		tmp = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+				       BLOCK0_XGXSSTATUS);
+		if (tmp & BLOCK0_XGXSSTATUS_PLL_LOCK)
+			break;
+		msleep(20);
+		try--;
+	};
+
+	if (!try) {
+		/* PLL did not lock; give up */
+		dev_err(dev, "port%d PLL did not lock\n", port->portnum);
+		return -ETIMEDOUT;
+	}
+
+	dev_dbg(dev, "port%d initialized\n", port->portnum);
+
+	return 0;
+}
+
 static int brcm_sata_phy_init(struct phy *phy)
 {
 	int rc;
@@ -501,6 +566,9 @@ static int brcm_sata_phy_init(struct phy *phy)
 	case BRCM_SATA_PHY_IPROC_SR:
 		rc = brcm_sr_sata_init(port);
 		break;
+	case BRCM_SATA_PHY_DSL_28NM:
+		rc = brcm_dsl_sata_init(port);
+		break;
 	default:
 		rc = -ENODEV;
 	}
@@ -552,6 +620,8 @@ static const struct of_device_id brcm_sata_phy_of_match[] = {
 	  .data = (void *)BRCM_SATA_PHY_IPROC_NSP },
 	{ .compatible	= "brcm,iproc-sr-sata-phy",
 	  .data = (void *)BRCM_SATA_PHY_IPROC_SR },
+	{ .compatible	= "brcm,bcm63138-sata-phy",
+	  .data = (void *)BRCM_SATA_PHY_DSL_28NM },
 	{},
 };
 MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
-- 
2.17.1

