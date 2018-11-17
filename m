Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2522080C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2522080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeKRFAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 00:00:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKRFAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 00:00:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAHIgtHL1757956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 17 Nov 2018 10:42:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAHIgtsC1757953;
        Sat, 17 Nov 2018 10:42:55 -0800
Date:   Sat, 17 Nov 2018 10:42:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rob Herring <tipbot@zytor.com>
Message-ID: <tip-c04e55388a4f2184e37827a1d2e733cded52d653@git.kernel.org>
Cc:     x86@kernel.org, lkundrak@v3.sk, robh@kernel.org, mingo@redhat.com,
        mingo@kernel.org, bp@suse.de, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, x86@kernel.org, robh@kernel.org,
          lkundrak@v3.sk, mingo@redhat.com, mingo@kernel.org
In-Reply-To: <20181116201820.10065-1-robh@kernel.org>
References: <20181116201820.10065-1-robh@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/olpc: Do not call
 of_platform_bus_probe()
Git-Commit-ID: c04e55388a4f2184e37827a1d2e733cded52d653
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c04e55388a4f2184e37827a1d2e733cded52d653
Gitweb:     https://git.kernel.org/tip/c04e55388a4f2184e37827a1d2e733cded52d653
Author:     Rob Herring <robh@kernel.org>
AuthorDate: Fri, 16 Nov 2018 14:18:20 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 17 Nov 2018 19:29:55 +0100

x86/platform/olpc: Do not call of_platform_bus_probe()

The DT core will probe the DT by default now, so the OLPC platform code
calling of_platform_bus_probe() is not necessary. The algorithm for what
nodes are probed is a little different in how compatible is handled, but
since OLPC uses compatible strings for matching it is not affected by
this difference.

Also, only the battery node located at the root level gets a device
created as the dcon is a PCI device and the RTC device is created in
olpc-xo1-rtc.c.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Lubomir Rintel <lkundrak@v3.sk>
Cc: Thomas Gleixner <tglx@linutronix.de>
CC: devicetree@vger.kernel.org
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181116201820.10065-1-robh@kernel.org
---
 arch/x86/platform/olpc/olpc_dt.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
index 24d2175a9480..b4ab779f1d47 100644
--- a/arch/x86/platform/olpc/olpc_dt.c
+++ b/arch/x86/platform/olpc/olpc_dt.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/of_pdt.h>
 #include <asm/olpc.h>
 #include <asm/olpc_ofw.h>
@@ -285,20 +284,3 @@ void __init olpc_dt_build_devicetree(void)
 	pr_info("PROM DT: Built device tree with %u bytes of memory.\n",
 			prom_early_allocated);
 }
-
-/* A list of DT node/bus matches that we want to expose as platform devices */
-static struct of_device_id __initdata of_ids[] = {
-	{ .compatible = "olpc,xo1-battery" },
-	{ .compatible = "olpc,xo1-dcon" },
-	{ .compatible = "olpc,xo1-rtc" },
-	{},
-};
-
-static int __init olpc_create_platform_devices(void)
-{
-	if (machine_is_olpc())
-		return of_platform_bus_probe(NULL, of_ids, NULL);
-	else
-		return 0;
-}
-device_initcall(olpc_create_platform_devices);
