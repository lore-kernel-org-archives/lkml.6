Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76D8218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiFYjd/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBRAUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:20:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40849 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfBRAUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:20:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so7816425plb.7;
        Sun, 17 Feb 2019 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
        b=ZiFYjd/DceJ32azEOGg3cEeCfivgoHOn5pSsHhx6DOzudxTGZgsSdpN91KqrwkcBoj
         JE8F+vmR/wGEYqfBK5hlpgRzxkouMwDbbQM5dwg6yIW0TbTsAy0zyTBGqRcWPHI5bzvP
         J+fSm2HPUAEfqtMHbagvT4XTvcCzN7p0jKLCXqm+N9kbvcgmHlv7EbDvl342ov6wbdQX
         bRul/abgCPNwWLohKJJEZKkEzVhJthIKSszAxtG2cyxiztZvcZm1Moc+n8kXY4KL5k1j
         lalO2xETJno5ZoqgKjRTHoqiPDjYBHfrl+XH55pGccOaElQduEsGfAcmuJSVA1KZzb9J
         eFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FtVEGiGy9Eakv2EeSbS97SgOgiiipvDTd5Smr8Hxk8=;
        b=mZ85sLmeI1Q9aYNfj0sXJcIz4F7twqACFD4Z/fSQdR/l9H6OZ4wiZ1pcj+LwHy1tSw
         +qN47rqLY+U+8h6BaiA0+M0Un/5670AAzKQJfBzCw5/kPJ9/gJuiiq2cKwGb6GYxvACW
         Yo2aL7O78dK9M3c5XZmiAmaLFnyNVLnAdm+qagto5ZRRxrKpviQx42ZJwmaH7K5BNGoe
         ornP3qZLBL8EHev/gqdjjBPAfMJ1MgxSF9ztiVseJKhrHjmsn6OszSOKHMR3Vp5MyDUJ
         Hj/8x4AIPUFc9I4hRSG9e0+uat0x4VTufZJxzl5JHqqSOA4OSyIxafCEa5DUX4HRe1CF
         B5RQ==
X-Gm-Message-State: AHQUAubgmrma6ZAqn5pLPDZWtdIGA7+uofiv4KYeGzMwaJ83y/5ENDNz
        uxjBlnn5QGOk0Fui3LrEWsQ=
X-Google-Smtp-Source: AHgI3IYQ/SwO5F6rcNdfHclFv8bc9xGYpjbYXVBHjrn4VC4UNvGShKHQnUALs/pzHyCq3Fc5mml44Q==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr2982099plb.59.1550449204193;
        Sun, 17 Feb 2019 16:20:04 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:20:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] ARM: tegra: Support L2 cache maintenance done via firmware
Date:   Mon, 18 Feb 2019 03:17:25 +0300
Message-Id: <20190218001726.16785-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trusted Foundations firmware require MMU to be enabled for L2 cache
maintenance on Tegra30, hence perform the maintenance early/late on
suspend-resume respectively.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c    | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S | 11 +++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 1ad5719779b0..66c8cd63dd86 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -38,6 +38,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
+#include <asm/trusted_foundations.h>
 
 #include "iomap.h"
 #include "pm.h"
@@ -195,8 +196,27 @@ void tegra_idle_lp2_last(void)
 	cpu_cluster_pm_enter();
 	suspend_cpu_complex();
 
+	/*
+	 * L2 cache disabling using kernel API only allowed when all
+	 * secondary CPU's are offline. Cache have to be disabled early
+	 * if cache maintenance is done via Trusted Foundations firmware.
+	 * Note that CPUIDLE won't ever enter powergate on Tegra30 if any
+	 * of secondary CPU's is online and this is the LP2 codepath only
+	 * for Tegra20/30.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, &tegra_sleep_cpu);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	restore_cpu_complex();
 	cpu_cluster_pm_exit();
 }
@@ -340,8 +360,24 @@ static int tegra_suspend_enter(suspend_state_t state)
 		break;
 	}
 
+	/*
+	 * Cache have to be disabled early if cache maintenance is done
+	 * via Trusted Foundations firmware. Otherwise this is a no-op,
+	 * like on Tegra114+.
+	 */
+	if (trusted_foundations_registered())
+		outer_disable();
+
 	cpu_suspend(PHYS_OFFSET - PAGE_OFFSET, tegra_sleep_func);
 
+	/*
+	 * Resume L2 cache if it wasn't re-enabled early during resume,
+	 * which is the case for Tegra30 that has to re-enable the cache
+	 * via firmware call. In other cases cache is already enabled and
+	 * hence re-enabling is a no-op.
+	 */
+	outer_resume();
+
 	switch (mode) {
 	case TEGRA_SUSPEND_LP1:
 		tegra_suspend_exit_lp1();
diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index 5e3496753df1..0a8086d5a47a 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -132,10 +132,13 @@ ENTRY(tegra_shut_off_mmu)
 #ifdef CONFIG_CACHE_L2X0
 	/* Disable L2 cache */
 	check_cpu_part_num 0xc09, r9, r10
-	movweq	r2, #:lower16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	movteq	r2, #:upper16:(TEGRA_ARM_PERIF_BASE + 0x3000)
-	moveq	r3, #0
-	streq	r3, [r2, #L2X0_CTRL]
+	retne	r0
+
+	mov32	r2, TEGRA_ARM_PERIF_BASE + 0x3000
+	ldr	r3, [r2, #L2X0_CTRL]
+	mov	r9, #0
+	tst	r3, #1
+	strne	r9, [r2, #L2X0_CTRL]
 #endif
 	ret	r0
 ENDPROC(tegra_shut_off_mmu)
-- 
2.20.1

