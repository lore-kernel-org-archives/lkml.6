Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12D5C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4D52184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548352637;
	bh=Mmikw7mc3Aeoj9wCjHnnbDSKLveuAC5HoWVPExUg/JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOMjQyWBIB8h15ZodzVDzvkK6mULZZK7pKC1sMoCe+Qv17rGNNzcWwq3234bYvgOE
	 i5p+RsA66qxsFu7jO0fTUUfVBWo6NpVxoKCB5UDgWCLnAEFLAP2dbqYRhQ4+lRo/LZ
	 oQDQNg2Oa+olo5yISNia+WiUWyd9TFn91DtOWrjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfAXR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:57:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAXR5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:57:12 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.121.135.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E24B218AF;
        Thu, 24 Jan 2019 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548352632;
        bh=Mmikw7mc3Aeoj9wCjHnnbDSKLveuAC5HoWVPExUg/JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYCfhEe+DAM+4YYhrq5DDIqYXKwkPfNmt/KhMiCvvwnWrEowlGL7ka3vlRM3mA6U+
         ZAqy9fvL3RtIdtfpZq22rSbgUwZin9VMjHaiifglYVB/vB8asCed6CYeiH29RA2NmF
         eYvUdMA3XQvWKXQytCiD+6o3A+xlvJsZLkjCvdrw=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [for next][PATCH v2 2/2] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Thu, 24 Jan 2019 17:57:02 +0000
Message-Id: <20190124175702.4801-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190124175702.4801-1-okaya@kernel.org>
References: <20190124175702.4801-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

SAMSUNG_Q10 selects BACKLIGHT_CLASS_DEVICE but BACKLIGHT_CLASS_DEVICE
depends on BACKLIGHT_LCD_SUPPORT.

Copy BACKLIGHT_LCD_SUPPORT dependency into SAMSUNG_Q10 to fix:

WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
  Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
  Selected by [y]:
  - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b84c2c5b6684..129e37c296a7 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1127,7 +1127,7 @@ config INTEL_OAKTRAIL
 
 config SAMSUNG_Q10
 	tristate "Samsung Q10 Extras"
-	depends on ACPI
+	depends on ACPI && BACKLIGHT_LCD_SUPPORT
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
 	  This driver provides support for backlight control on Samsung Q10
-- 
2.19.0

