Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B7920868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="STQu6Hnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfAQWdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:33:51 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:34228 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfAQWdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547764427; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0H2ZxxmHlwDBLBjxf3qBA4HY0EDYSy6XqQd3wt2XW+0=;
        b=STQu6HnzOtq+DO51TCk4Ku3WsKML6jzxL87t3W0SiZSPlUMfXgxbcWHlNtgk3QN24WkBR/
        xFdUGtwbYTZF5wg68tjFCGlaNnljfpCrlhjH1FzVDgLfwDZw91C0zwV4bAiz+vgK9oV0gX
        cx+46H9pQkS1gaJqmMfOdw+/0k7xTOg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 3/4] usb: musb: Kconfig: Drop dependency on MACH_JZ4740 for jz4740
Date:   Thu, 17 Jan 2019 19:33:29 -0300
Message-Id: <20190117223330.16631-3-paul@crapouillou.net>
In-Reply-To: <20190117223330.16631-1-paul@crapouillou.net>
References: <20190117223330.16631-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4740 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

v2: Remove info about adding COMPILE_TEST in commit message, as it was
    there before

v3: Change MACH_INGENIC to MACH_JZ4740 in commit message

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

