Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DF62177B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="Vi6ujWBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfA1RdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:33:03 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25457 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfA1RdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:33:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548696701; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YIyjRszvDDBO4ukdquYlxg4eSL4lUQ+76YchNpOvAK1JFOZnm6wbwDSpJdjScuKtKFxJx+08SfwfzzJKmA7TredE5UoUbVFaBqab4FsxqVdfEkUXVLfn1RnqQH7IU9PVgMCuKOKJhyARdx4UWPji7HNz938ph2R2hbIVg8ah2j8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548696701; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Hb4V+UUvIgOaR8+FOF5/tTTgrHynv8qZbzdGENKIw/Q=; 
        b=XVM0urhhPK9ey61YhnF/MvKgX7/pwlRHfKqG5VZA8VIt3351Z/jDIOldqJQnRRVUE1a5wyrnXYrp184z7lug88ZXPltpN6bCbYJntvRjZYqdeC7R9IMOax4G9OXZ1dxxggfPSdcXY5Z1eCv3n9rQqXZ8TU9Yxx53e5wboudn7jE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=v5YhN9/MkxYpgRBAN/Pcn302sEFc518gtDgjgI3Yv3KlJo3vpAUBUeeyMpXhg+kbqxAwH1WyVX66
    hmiuJ2iMyHnul8UPZt3rC1L9D5Ha+H+obTusVsnFI8JfFcTinUKe  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548696701;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=2150; bh=Hb4V+UUvIgOaR8+FOF5/tTTgrHynv8qZbzdGENKIw/Q=;
        b=Vi6ujWBWAwhzv4JQ46bQVmShIvKBfISlINOq/qYfwK3TVK40ZrhgiqTd7nT2ilIx
        ZD0qoR9iFNtNj+Z+amzYBF28PEbDVXP0nkMXEb144GAVn9GDHJidVbjDZAmo6FjSMnS
        DssU0H/0paMQsnEYkgSlEwYQyJovt6RmAKAgxorE=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548696698449303.6388026767029; Mon, 28 Jan 2019 09:31:38 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: [PATCH 3/3] RTC: Ingenic: Replace jz47xx with XBurst.
Date:   Tue, 29 Jan 2019 01:29:59 +0800
Message-Id: <1548696599-53639-4-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
References: <1548696599-53639-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingenic had changed their product code name.
Latest SoCs had divided to several series such as
T30/M200/X1000 and no longer called JZ47xx.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 drivers/rtc/Kconfig      |  4 ++--
 drivers/rtc/rtc-jz4740.c | 15 +++------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 225b0b8..8b41853 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1576,10 +1576,10 @@ config RTC_DRV_MPC5121
 	  will be called rtc-mpc5121.
 
 config RTC_DRV_JZ4740
-	tristate "Ingenic JZ4740 SoC"
+	tristate "Ingenic XBurst SoC"
 	depends on MIPS || COMPILE_TEST
 	help
-	  If you say yes here you get support for the Ingenic JZ47xx SoCs RTC
+	  If you say yes here you get support for the Ingenic XBurst SoCs RTC
 	  controllers.
 
 	  This driver can also be built as a module. If so, the module
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 0c7ae65..a262632 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
  *  Copyright (C) 2010, Paul Cercueil <paul@crapouillou.net>
- *	 JZ4740 SoC RTC driver
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of  the GNU General Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
+ *	Ingenic XBurst platform RTC support
  */
 
 #include <linux/clk.h>
@@ -450,5 +441,5 @@ module_platform_driver(jz4740_rtc_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
+MODULE_DESCRIPTION("RTC driver for Ingenic XBurst platform\n");
 MODULE_ALIAS("platform:jz4740-rtc");
-- 
2.7.4


