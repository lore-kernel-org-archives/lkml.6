Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899AC3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E3021721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548110811;
	bh=OFX0YF9R48TS0Qr9AcjWCT58c5wEtgPYO9PEdkk+CS4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iNj+wpxU/wZZZm8kqtyFcSv93AZW/yQUIv9P7kYAJyMPRFUCBUZpui54TQf66nttH
	 Jzxjns9VoSF5vA/SiYBg71V3eezCABBqIgzN9rUH/9gQFeU5voq0OaQ+6uXP/iRyO7
	 GsGqel73MpiYAmauezMKNWP60ApuyZ58rQgKaYTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAUWqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfAUWqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:46:49 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.83.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 236072089F;
        Mon, 21 Jan 2019 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548110808;
        bh=OFX0YF9R48TS0Qr9AcjWCT58c5wEtgPYO9PEdkk+CS4=;
        h=From:To:Cc:Subject:Date:From;
        b=tMbz6SXLWrR6D1v2mN4DXWJ6giJUZIfn7ygSMBX4Nhl308COwbKEesPNbqjErgxxg
         MEzw3zjPzYE2iY8m2AAXKpCLo6tNLZfCd/SzvmtnRhvi9YYk9ZQwPy4Am2N/KLvbr2
         I3ggsVwoZl9+kQsAfEzH4F6HB954UDaooNGL6hBg=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [for next][PATCH 1/2] platform/x86: Fix unmet dependency warning for ACPI_CMPC
Date:   Mon, 21 Jan 2019 22:46:43 +0000
Message-Id: <20190121224644.26903-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BACKLIGHT_LCD_SUPPORT for ACPI_CMPC to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

ACPI_CMPC selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
depends on BACKLIGHT_LCD_SUPPORT.

Copy this dependency into ACPI_CMPC.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5e2109c54c7c..b84c2c5b6684 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -904,7 +904,7 @@ config TOSHIBA_WMI
 
 config ACPI_CMPC
 	tristate "CMPC Laptop Extras"
-	depends on ACPI && INPUT
+	depends on ACPI && INPUT && BACKLIGHT_LCD_SUPPORT
 	depends on RFKILL || RFKILL=n
 	select BACKLIGHT_CLASS_DEVICE
 	help
-- 
2.19.0

