Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D37C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06C6208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SWLYs87X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06C6208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeH1EwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:52:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56642 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeH1EwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:52:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S13507121190;
        Mon, 27 Aug 2018 20:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535418185;
        bh=Afqp3lXNMmKu9i8Pca0yxG5iRN6JwZGvDg/CLnTIzGs=;
        h=From:To:CC:Subject:Date;
        b=SWLYs87X2KEbyIUuHFf3QyJN8lssBhO49gBwoO8X8iwVGTaOTk5VA+gMoB6dEob1I
         D5vrK6KDTKqfbQPiEcQ2LEPV6faVRS+hslHK+gQ/k9zG3GxuTyRwtW+HAPTUN25CUS
         vgGDg+NfrfN5gmtr2Y59HAVMsaa0YmW1J/5bMPQU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S134fU014394;
        Mon, 27 Aug 2018 20:03:04 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 20:03:03 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 20:03:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S1338O017308;
        Mon, 27 Aug 2018 20:03:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] serial: 8250_omap: Make 8250_omap driver driver depend on ARCH_K3
Date:   Mon, 27 Aug 2018 20:03:02 -0500
Message-ID: <20180828010302.2751-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Allow 8250 omap serial driver to be used for K3 platforms.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Now that we have the device tree support merged integrated AND we have ARCH_K3,
Lets enable the 820 OMAP Driver to build for ARCH_K3 and make it operational.

 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f005eaf8bc57..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -375,7 +375,7 @@ config SERIAL_8250_RT288X
 
 config SERIAL_8250_OMAP
 	tristate "Support for OMAP internal UART (8250 based driver)"
-	depends on SERIAL_8250 && ARCH_OMAP2PLUS
+	depends on SERIAL_8250 && (ARCH_OMAP2PLUS || ARCH_K3)
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
 	  can enable its onboard serial ports by enabling this option.
-- 
2.15.1

