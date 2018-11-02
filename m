Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2162C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539052082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539052082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeKBUNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:13:50 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeKBUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:13:50 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV6G6-1g9DLc2mZy-00SAfA; Fri, 02 Nov 2018 12:06:54 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV6G6-1g9DLc2mZy-00SAfA; Fri, 02 Nov 2018 12:06:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
Date:   Fri,  2 Nov 2018 12:06:43 +0100
Message-Id: <20181102110653.118257-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:xkdK6a9ZQSeCCvMiGV+BrRwCFNLWlXYjLFsN1txAllwlA4OFMNg
 jrDVW5CWdk1bXUvKv9GoXFgV5eOPmjs0+bZSQt6QyApyRTmzS1NIMfOX10kCO/Kbpa7SKwe
 EMLIr09V2hGInpA/o2pE9rbwGBTanTpn28o3UvxAJgEqVYynTuYdFwWlFtdgwROeletb4HS
 Sc/UWfe3JPeWbc5pIxWzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GytcoM4tlNw=:gbpJYu5XsUBQq0b43GFCi0
 558sFersoyPvyP4nJcwwys/btOC5vFGQRt9ELOROgkBqvRIG/1P5PbFT44huCtYcVWJ4PzTMm
 /ZWey6aBPCdGXrQdFh5EeQkTYDzfY2Jk7JnQnhhZMq9bvnxxyz46QI+LUJDwbvjr96lSoPK1A
 k0P+vntdIIh6CI/w5+HY7xBGSHg3DW2JvfexqZqT4h/V7lERF1N91zqieHUsuYVE7RLM6UmWt
 CRSUjXi+auVQMLCuYwlTbptieG/in3r47RN4UD63cYIqpa4JXTBordyF1Ls+HAOSTwEhpkf8d
 f4rZ5CHhNZiOCphnJsyUZpRCCDlvTTJFcGGGHHeoMMdyyocpaTPnOEe+w9uFaqSxCpWGFY/Bc
 OncmChNQoAEZxjAsC3mxeGZzLh7ICRBTGRL6nq9BP5NLVoMcEptocZWHrCP+oKNwqZRZnWoFy
 iPTkREg7meXaLIUczXmmNz66xCNpozzbtPSyDtZqnxidMLlUVVBOZwDChD7rVLrRP5smYE2hx
 mgoUXLjsLqBCU/oviZYCk/w4l4iD9iJkTnU4VFxojn57XATxEI73E8QpoCheZlG449Ddoxoof
 bhlo99o9Qgts3vD9/80kPu7P2N91jUImwDv5sbXdSkLbPCulGOteR+GfcYYTTZwzyxCfCQcUR
 EXffGsmD093xdet1IX9Wj13MDm2ID+JyO9p4bxfltmRpTsYQp6VgKavYbhfuuhhHX1Nk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still get a link failure with IOSF_MBI=m when the xpower driver
is built-in:

drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'

This makes the dependency stronger, so we can only build when IOSF_MBI
is built-in.

Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 18851e7eedd5..31a3c4a03f61 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
 
 config XPOWER_PMIC_OPREGION
 	bool "ACPI operation region support for XPower AXP288 PMIC"
-	depends on MFD_AXP20X_I2C && IOSF_MBI
+	depends on MFD_AXP20X_I2C && IOSF_MBI=y
 	help
 	  This config adds ACPI operation region support for XPower AXP288 PMIC.
 
-- 
2.18.0

