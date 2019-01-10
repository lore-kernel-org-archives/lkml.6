Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F254C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24592173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AQDd3s2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfAJNhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:37:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:51550 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfAJNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547127436; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l0qAOBPaffwONMK7+ifbUrTiQtYss2IiXh7MoLJ/8+M=;
        b=AQDd3s2Yf6BrY4A3u79wxVsBZ1txbp81f6UzFlnqJ2S9J53KH6/JKPp/Kw8xKH/r+DpKu0
        G0YiEKcJv+fzEWQxtT19NwzB12iEi+bGlkNMG1DJVtY+flEOCRQh+0IK2pXjO5BiPYG9G5
        ROYIxmAy2WzHOkcCzwDu61TdpBcHg3Y=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] usb: musb: Kconfig: Drop dependency on MACH_JZ4740 for jz4740
Date:   Thu, 10 Jan 2019 10:36:59 -0300
Message-Id: <20190110133700.4471-3-paul@crapouillou.net>
In-Reply-To: <20190110133700.4471-1-paul@crapouillou.net>
References: <20190110133700.4471-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_INGENIC prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Remove info about adding COMPILE_TEST in commit message, as it was
    there before

 drivers/usb/musb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index ad08895e78f9..6f5b0ed6a507 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -111,7 +111,7 @@ config USB_MUSB_UX500
 config USB_MUSB_JZ4740
 	tristate "JZ4740"
 	depends on NOP_USB_XCEIV
-	depends on MACH_JZ4740 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	depends on USB_MUSB_GADGET
 	depends on USB_OTG_BLACKLIST_HUB
 
-- 
2.11.0

