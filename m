Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E7C468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D5C208E2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D5C208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbeGLLLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:11:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38467 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbeGLLLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:11:54 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00068Z-Rs; Thu, 12 Jul 2018 13:02:44 +0200
Received: from mfe by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdZMy-00014b-1m; Thu, 12 Jul 2018 13:02:44 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw binding
Date:   Thu, 12 Jul 2018 13:02:39 +0200
Message-Id: <20180712110240.3006-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712110240.3006-1-m.felsch@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is used to keep the backward compatibility with the current
dtb's [1]. The binding informs the driver that the unused switch regulators
can be disabled.
If it is not specified, the driver doesn't disable the switch regulators.

[1] https://patchwork.kernel.org/patch/10490381/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index 672c939045ff..1f17ab7c7123 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -4,6 +4,14 @@ Required properties:
 - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
 - reg: I2C slave address
 
+Optional properties:
+- pfuze-disable-sw: Disable all unused switch regulators to save power
+  consumption. Attention, some platforms are using the switch regulators as DDR
+  ref or supply voltage. Mark these regulators as "regulator-always-on" to skip
+  disabling these regulators. If not specified, the driver simualtes the
+  disabling. This means the state of the regulator is set to 'disabled' but the
+  driver don't disable the regulator.
+
 Required child node:
 - regulators: This is the list of child nodes that specify the regulator
   initialization data for defined regulators. Please refer to below doc
-- 
2.18.0

