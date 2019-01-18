Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8578D20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="CBg7inCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfARNcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:32:21 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36606 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfARNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:32:21 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 84DDE5C1713;
        Fri, 18 Jan 2019 14:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547818339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=erd4vDac163qgB9A/AU5uPwipvsYhblMeb+AlJzom/0=;
        b=CBg7inCaZMAXsHRqL68VkhQtml3rJ8Yf2tJh2YsHPNnnCFdBwxOA3GecruLppGtX6+ajno
        xLV8nlzWhQhmxt4hPW8nHMKhxwwdVoal9tI19Mcx6jT456Lh1PjVhi79iaKlAV7gKsaj/c
        hfk2CGQu1CI7uUYaggzyAcMalLkfvA4=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
Date:   Fri, 18 Jan 2019 14:32:18 +0100
Message-Id: <20190118133218.19917-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the VDD I/O rail as phy-supply regulator. Technically, the
regulator has multiple rails, but currently the driver only
supports a single phy-supply. The VDD I/O rail has the highest
power consumption when software power down is used and hence
the highest saving potential.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 0b47aecf336a..cf66f9ececbd 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -241,6 +241,7 @@
 	phy-handle = <&ethphy>;
 	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+	phy-supply = <&vgen5_reg>;
 	status = "okay";
 
 	mdio {
-- 
2.20.1

