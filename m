Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9EC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LGzX55+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAQWdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:33:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34292 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfAQWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547764430; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FGQBy8kKS4W6KhMWkkRoiTN+EPx+mmeprc0v0hXkFlE=;
        b=LGzX55+m3fuePMBM5fxIv489vBDUQn717ObR3Jrq56eXzazCl13Z01wzSd9ICFnzK8QQf7
        yxrrC5Ui9+G4HR28rFbuO2bJuY1a2MmNXtzRLVfwnb+yl/lCS5MjhrxBJ+uanuhsaPfABv
        QIVQ3ZG7waa/4IuI7faeg4R2OP3Q4pE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 4/4] usb: musb: Kconfig: Drop dependency on CONFIG_USB for jz4740
Date:   Thu, 17 Jan 2019 19:33:30 -0300
Message-Id: <20190117223330.16631-4-paul@crapouillou.net>
In-Reply-To: <20190117223330.16631-1-paul@crapouillou.net>
References: <20190117223330.16631-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig entry previously depended on USB_OTG_BLACKLIST_HUB
unconditionally, which is an option that is only available when
CONFIG_USB is enabled. However, the USB IP in the JZ4740 SoC does not
support host mode, only gadget mode, so it makes sense to allow it to
build when CONFIG_USB is not set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Instead of removing the dependency on USB_OTG_BLACKLIST_HUB, we now
    depend on (USB=n || USB_OTG_BLACKLIST_HUB)

v3: No change

 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 6f5b0ed6a507..fda7691bf173 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -113,7 +113,7 @@ config USB_MUSB_JZ4740
 	depends on NOP_USB_XCEIV
 	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
-	depends on USB_OTG_BLACKLIST_HUB
+	depends on USB=n || USB_OTG_BLACKLIST_HUB
 
 config USB_MUSB_AM335X_CHILD
 	tristate
-- 
2.11.0

