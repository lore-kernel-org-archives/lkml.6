Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0EC3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514B21721
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548110814;
	bh=3STcscJkZGmrz7FDbINGEJj+ZxfiXaoOgm/HCiQc7o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sxgAsvWl7ChidMuqeKZjS3ncbKXJNkEK9Udbekdx8CW22aU/TpcF8HC3eEWhqNAk8
	 aWuni5Zw7Y/3I7bUXGxrMTJ+5mu6edAk0UkMpcItxFns9RAD663EFNnbUUp9qyMYsL
	 OAxULrpDilCYokD+1IzCsAKLVW2xPXOoY33LY170=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfAUWqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfAUWqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:46:50 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.83.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA6E21019;
        Mon, 21 Jan 2019 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548110809;
        bh=3STcscJkZGmrz7FDbINGEJj+ZxfiXaoOgm/HCiQc7o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2/gMZVuDLpW6jTCSXZi55CZwnXkMBYKo7M0LGYIp/vJCU8CTUpHAhL/zDUGT3suj
         OFgCR+sg0ZIItKR/av/w2OY+izb2w8sqTcgrTsfB3+2D+s5379F+hEeAHzi+vTaAkZ
         9qvLcp1zy2/FQx27e75rfr7qQBHUHOIUMBZH9kSg=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [for next][PATCH 2/2] platform/x86: Fix unmet dependency warning for SAMSUNG_Q10
Date:   Mon, 21 Jan 2019 22:46:44 +0000
Message-Id: <20190121224644.26903-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190121224644.26903-1-okaya@kernel.org>
References: <20190121224644.26903-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BACKLIGHT_LCD_SUPPORT for SAMSUNG_Q10 to fix the
warning: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE.

SAMSUNG_Q10 selects BACKLIGHT_LCD_SUPPORT but BACKLIGHT_LCD_SUPPORT
depends on BACKLIGHT_LCD_SUPPORT.

Copy this dependency into SAMSUNG_Q10.

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

