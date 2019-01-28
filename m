Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0BFC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF53E2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="oQm/bh2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfA1QDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:03:10 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:44150 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731309AbfA1QDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:08 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8D00F5C12C0;
        Mon, 28 Jan 2019 17:03:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548691386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=VeXmcozwECjM26oL4MDFZh+Af5qc4NALgZoHZI5oO8c=;
        b=oQm/bh2D56XMuWq/N9YN6wJTeFzYzSfrB+Ox1fSA62ba+pEFt1zplHK63ZVYAWezYhTaG+
        oTzWOn6TRlgD57cki8zapbkfMl8t3b0/2O/GT2BPhJuTDdPx18BfMc3efAfrSgTCHKe0vT
        qoM0rm4ULdP4sy9Z6+bm4ZGXVDMLpTw=
From:   Stefan Agner <stefan@agner.ch>
To:     dmitry.torokhov@gmail.com
Cc:     arnd@arndb.de, peng.fan@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] input: keyboard: allow to select IMX SNVS Power Key driver for i.MX 7D
Date:   Mon, 28 Jan 2019 17:03:05 +0100
Message-Id: <20190128160305.22398-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX SNVS Power Key driver supports the i.MX 7D SoC family too.
Allow to enable the i.MX SNVS Power Key driver even if only i.MX 7D
SoC is selected.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 4713957b0cbb..a878351f1643 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -420,7 +420,7 @@ config KEYBOARD_MPR121
 
 config KEYBOARD_SNVS_PWRKEY
 	tristate "IMX SNVS Power Key Driver"
-	depends on SOC_IMX6SX
+	depends on SOC_IMX6SX || SOC_IMX7D
 	depends on OF
 	help
 	  This is the snvs powerkey driver for the Freescale i.MX application
-- 
2.20.1

