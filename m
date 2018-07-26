Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17D9C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2320891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2320891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeGZKi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:38:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49677 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbeGZKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:38:27 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ficTX-0002at-Qe; Thu, 26 Jul 2018 11:22:23 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ficTW-0004WK-0r; Thu, 26 Jul 2018 11:22:22 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, linux-imx@nxp.com,
        yibin.gong@nxp.com, "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH v8 4/6] regulator: pfuze100: add fsl,pmic-stby-poweroff property
Date:   Thu, 26 Jul 2018 11:22:18 +0200
Message-Id: <20180726092220.17250-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726092220.17250-1-o.rempel@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new optional "fsl,pmic-stby-poweroff" property.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index f0ada3b14d70..f3b922f5a11f 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -4,6 +4,13 @@ Required properties:
 - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000"
 - reg: I2C slave address
 
+Optional properties:
+- fsl,pmic-stby-poweroff: if present, configure the PMIC to shutdown all
+  power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
+  Use this option if the SoC should be powered off by external power
+  management IC (PMIC) on PMIC_STBY_REQ signal.
+  As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
+
 Required child node:
 - regulators: This is the list of child nodes that specify the regulator
   initialization data for defined regulators. Please refer to below doc
-- 
2.18.0

