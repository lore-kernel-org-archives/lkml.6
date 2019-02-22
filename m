Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4723FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187FC2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr0jW989"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfBVSEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32911 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBVSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id q12so2413423lfm.0;
        Fri, 22 Feb 2019 10:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
        b=Jr0jW989CtnvJYdr1+6TMimzDMHDAAoVRF14ZqAkbS+ynaSGXeM6MSV5Bkf53zo2sw
         cMcwDUVWDVkiUEtylnj+/O5tMTpvjcf4Rso0toLQr2iI9qoNbBLW/AtXg/PQMZyEe/4/
         EuQIHPIK4bBPh9MxEyyZLWLTS6bxhB70LMR9ucLfoGUZz0s2gqYG7XyaGMQxi9caGboz
         LTNntrRG9p2a/67XywcEtIC+NQH3CpVFC57sGgsOdA4MByGq/0nU6gALCPNIFm+n8k7I
         Ork95E6D+AX9YyWnHvHE0smBSThsaKRVD/oYZjBbXFIUIsmb18mNDWUfy37vlO71D9Qu
         7Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfjyKjJ4BPDlX5QQ+sFj1fRVuO9lVs7F3NH6shrTHtY=;
        b=HavTaJak1dVspTysoIIGTvrbMt7PwhF7fGkLxA1f4RjTdyUYwHU0QPc+ArIazxSziS
         Fgr9soWmDfpkw7t0c4mBHWeSDwQs8dTmmcrAkR3rk0QBy8+ipbtklmUa43ZFHlAZtC3P
         aUcvmDCtNyw5ZzU0fJsFQb2fLZ7strPgDd91jKmFD1hpmwP50N/AcmLssDRTr97w+2GM
         lADza5eabRfyFrdGP8afZBfCa5BTkaXpmdnz4kuwfo/IaaFtDQ3dZbRPDlPlfdUo2UKq
         BbHadteTm3FlRN65FfUhW8gF7Fqq+5afP9CXF55VsSv3uwi247BWl4/KhivGIulcmEuV
         /IUg==
X-Gm-Message-State: AHQUAuaHPUUd/jui5RC7K4y2UJYb4bTlNWOk3Y98UpNKXh2HnnGWPX7L
        ACHTiQ+9jm3vmBnqKyDfhBE=
X-Google-Smtp-Source: AHgI3IaJEsj3kn9P0hVwEv0sUqUfRwmR3ypjSmWOVPZXz4x78Cav6WUvuG8rxDGy31MSk1v3oRIJjg==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr3232954lfl.4.1550858673926;
        Fri, 22 Feb 2019 10:04:33 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] ARM: tegra: Set up L2 cache using Trusted Foundations firmware
Date:   Fri, 22 Feb 2019 20:59:22 +0300
Message-Id: <20190222175926.23366-5-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU is
running in insecure mode. Initialize L2 cache and set up the outer-cache
callbacks early during boot using the firmware API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..67d8ae60ac67 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -70,9 +71,18 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_trusted_foundations_l2x0_cache_init(void)
+{
+	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra30"))
+		call_firmware_op(l2x0_init);
+}
+
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
+	tegra_trusted_foundations_l2x0_cache_init();
 	tegra_cpu_reset_handler_init();
 }
 
-- 
2.20.1

