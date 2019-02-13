Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D34C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BDB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026517;
	bh=FzrSBgh3AeJmDI+fU2g8Rx+oVRaGBnAVnmfCi3hlrFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evopEGCtK6vPpkyKck6ZPWyIMUGIgno8azFRTE1Mmkn/CC6HRCATkDoXZUAWHO/Gq
	 VKsW/6+r/G/MyJ6BTxDQ/l6ho844zPSAqkzImleAN8d2xCNWYGMfQ/JHWRHtPfzWon
	 PsPuvkQUDQcBsnceMR/l6Md8senC3zqwMY7e8kUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbfBMCzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732802AbfBMChe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA01B222C9;
        Wed, 13 Feb 2019 02:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025453;
        bh=FzrSBgh3AeJmDI+fU2g8Rx+oVRaGBnAVnmfCi3hlrFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RchDoxHN4cOHKkltmfdeKOI6L5Xe+9KVRzHsT4+uqB0Too+KwP4RsaUZe/GR0Hnhx
         WK/7WduQ9uNsg+vdv+hp1lLpLZoTB8boe4whE+wTBlSbOhgaq12FGeV8d5rCWH8v1k
         Dr3Jz/DvBq51Xw9jE/n7dER6/O6H2NzgrwZ1MFrE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     NeilBrown <neil@brown.name>, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/83] watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem
Date:   Tue, 12 Feb 2019 21:36:04 -0500
Message-Id: <20190213023701.20286-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neil@brown.name>

[ Upstream commit 3aa8b8bbc142eeaac89891de584535ceb7fce405 ]

These files need
   #include <linux/mod_devicetable.h>
to compile correctly.

Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/mt7621_wdt.c | 1 +
 drivers/watchdog/rt2880_wdt.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 5c4a764717c4..81208cd3f4ec 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 98967f0a7d10..db7c57d82cfd 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
-- 
2.19.1

