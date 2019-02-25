Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3772C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925DB20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131075;
	bh=V0KCiasvRlZ5YEYc/F2qa1/u/gcbGC1kDz44AvjPd+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWnaSSR2q2rBSHLGh+bPU5uLc+tm+372XCDydQdI7Gca+CrEpPkEwjEy7hyLH7ehL
	 AZd3KT6mjs4L5TgFfStV85V+YIvKCu2R4gr8cu8cJKwZfvU+0xLrveheRMa6fGzEQO
	 A3vOGho/oukgbDPYv5CutTlEyR1QTFMH2zqq/Xhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfBYVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbfBYVaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:30:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B262821848;
        Mon, 25 Feb 2019 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130214;
        bh=V0KCiasvRlZ5YEYc/F2qa1/u/gcbGC1kDz44AvjPd+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHHn1pwFPnMzf/zFABI7N0Um7zPmPp8ex3ZfLlY9AVeFOyM1O6Cn/R64sdhqnZLv0
         jRqNwN+Z/s8yZvjSNeHeN1ioKmlS4IoRewY6o4gJfjtrcBsP0PcWS5mOlmfhjzS5LU
         q2lN0D4fc1drHNTc8EvvzW2rgLzgxVDaWDWaqYT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 049/183] watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem
Date:   Mon, 25 Feb 2019 22:10:22 +0100
Message-Id: <20190225195102.833958773@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5c4a764717c4d..81208cd3f4ecb 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -17,6 +17,7 @@
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/mach-ralink/ralink_regs.h>
 
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 98967f0a7d10e..db7c57d82cfdc 100644
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



