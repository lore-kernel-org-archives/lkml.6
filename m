Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFF32083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131735;
	bh=y9lwujiSNnT35xqilkRFLVdm165ND6RIOzcDSXyYYiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sF0ApPNqfeu2tReEVU2rYpziCTDm6meOUs4APciX5eBxoRJNA9ONKydeJBg1TFW5k
	 UosoaPS1hsE7UK3+UxUCTYBz3p4wEseJSlbMxzd/Rp/RtPx2FifcUDJjvZX4zPnyWI
	 WZ43ulaF4cvj/AAnVtwfV+960zs+kZqStkYR2hF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfBYVzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730728AbfBYVVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E376121871;
        Mon, 25 Feb 2019 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129705;
        bh=y9lwujiSNnT35xqilkRFLVdm165ND6RIOzcDSXyYYiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5jW4iPjVpyvz8pwx5IDoRekE4XFxzW2i7yD/XtvIICWGrmOQKgPc+nnZBGiS4LuF
         7M0gBKN/t8gJrceMOOz43O2o2RPAC+VrWbd4Q0LewqQZeTzdbNwRLWESLW/1lF6PqR
         FIedNyi3jFvK7HRyPFGN5yFc0j5ngEGqUqM++Zac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/152] watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem
Date:   Mon, 25 Feb 2019 22:10:33 +0100
Message-Id: <20190225195046.502705364@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



