Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5257C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C29222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083182;
	bh=wTirivqlVB5GfXo26mo10cQUr485H+sX4L13pqD0xT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FEC/1pr1fAfLX7eN3A2UYkmCJ0YAfOfsthdKNneSBSoPC5sXd6VHZqfydf/d8CUay
	 cw4i/yNMi2uC7+1Y9s2Jnr0cVqGktUHeMZ7v3n4k7sUaj6Kq8g5t3hz/kNf36m72B6
	 XSJE1oZDMBmr4mHI9CBSzXmXZfyK5WEqVQOhdfuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405248AbfBMSjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405232AbfBMSjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:39:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CFF222D6;
        Wed, 13 Feb 2019 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083175;
        bh=wTirivqlVB5GfXo26mo10cQUr485H+sX4L13pqD0xT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNjoMWpM9Ao5VHmfh9OMH0C0gQVhtB4H4rGVASi70xXp36nozdU+mG4bh9TtToxCk
         pHg4Do0OP4vY8IZtboDGFZw2IGNoUodPqb79ojU6UBRAkYlwd6LDQWJevxlVIRdZLN
         0CdnySjGgWLxOCoGDyp4FvfsoUpWHZeXuWdfVjEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Pisati <p.pisati@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 12/24] ARM: tango: Improve ARCH_MULTIPLATFORM compatibility
Date:   Wed, 13 Feb 2019 19:38:09 +0100
Message-Id: <20190213183648.371379267@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183647.333441569@linuxfoundation.org>
References: <20190213183647.333441569@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Gonzalez <marc.w.gonzalez@free.fr>

commit d0f9f16788e15d9eb40f68b047732d49658c5a3a upstream.

Calling platform-specific code unconditionally blows up when running
an ARCH_MULTIPLATFORM kernel on a different platform. Don't do it.

Reported-by: Paolo Pisati <p.pisati@gmail.com>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: stable@vger.kernel.org # v4.8+
Fixes: a30eceb7a59d ("ARM: tango: add Suspend-to-RAM support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-tango/pm.c    |    6 ++----
 arch/arm/mach-tango/pm.h    |    7 +++++++
 arch/arm/mach-tango/setup.c |    2 ++
 3 files changed, 11 insertions(+), 4 deletions(-)

--- a/arch/arm/mach-tango/pm.c
+++ b/arch/arm/mach-tango/pm.c
@@ -2,6 +2,7 @@
 #include <linux/suspend.h>
 #include <asm/suspend.h>
 #include "smc.h"
+#include "pm.h"
 
 static int tango_pm_powerdown(unsigned long arg)
 {
@@ -23,10 +24,7 @@ static const struct platform_suspend_ops
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init tango_pm_init(void)
+void __init tango_pm_init(void)
 {
 	suspend_set_ops(&tango_pm_ops);
-	return 0;
 }
-
-late_initcall(tango_pm_init);
--- /dev/null
+++ b/arch/arm/mach-tango/pm.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_SUSPEND
+void __init tango_pm_init(void);
+#else
+#define tango_pm_init NULL
+#endif
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -1,6 +1,7 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "smc.h"
+#include "pm.h"
 
 static void tango_l2c_write(unsigned long val, unsigned int reg)
 {
@@ -14,4 +15,5 @@ DT_MACHINE_START(TANGO_DT, "Sigma Tango
 	.dt_compat	= tango_dt_compat,
 	.l2c_aux_mask	= ~0,
 	.l2c_write_sec	= tango_l2c_write,
+	.init_late	= tango_pm_init,
 MACHINE_END


