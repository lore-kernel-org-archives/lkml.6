Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BD420844
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M44SoKfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BD420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeH3WIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45017 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeH3WIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so8003790ljq.11;
        Thu, 30 Aug 2018 11:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bqXBzGttmLbwA1tWVcC4ztFYtQ17JkPgOJF7TeCjrQM=;
        b=M44SoKfTQYxXncRXe+sQpbpCcP6pB/OL8hJhMfpeIkPLnG7cMvIJkNOM3KpfbP2Koj
         sGsNxr7iIgyeBaaCHE3MSuhUu24lBDY+9T3DU0nRSiIVsN1X8lc8lOKVZV1kWXEGfZ39
         O/462rzfb66PswKqggEJDr4L8+p4W0U5kU31haTIUJBX8Is05loSZOAcxMqyHXKkY+BM
         +7jzPXmMwM0uvUxpV/GAeXFJRrx5DbWlAsYRV+qvkb2joqab0gvdWK5OIcwWOQW15JCo
         UgbulB/EmgR3PF/dpYzj9YSdpCTQLcQiAhjfVm7LATQImbZuLqHLJd4kJOyiDu6/9r3r
         mtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bqXBzGttmLbwA1tWVcC4ztFYtQ17JkPgOJF7TeCjrQM=;
        b=KQTrbrYN/S4O3N0Rj6szilr5qOxjAkg2cLJ7BjeAqcC25BPAuAtuz8M45FynQ5Odv7
         uGFsofULtPM/MsMAuGKyWIMVoq6+hbaqXWYv4C5wngUv98g48C8+sAI6XtbEpv4xDKqW
         0xt6DI6I0LOapAZWCOr7biHbxwjSb7/0T6AlLAk/V14oSyMCJfZmYanGOpgRHAeIR9UU
         FvRxCbaumFbwYjgi+/5s/gp7yne3i27zQHvJPQkvOah6N0N6YtfBWoNo6v6wKjLNGaiL
         RlyHDyJ6JTP5z4QkO5w1uy1R3ue26XrhOc5QTc5KghZWQUPxcJJvyb5TTu6zyMTZKLBa
         LmNA==
X-Gm-Message-State: APzg51DR7UBH3XTdHoq9hYlUyRfO0QdJAZeBY7hhO+4YJw0/dB1j2J8F
        lHkSTYzv/Yt/JSS8YZVB9+8=
X-Google-Smtp-Source: ANB0VdbxonLX3/tHfylXGtFG76UKRY87tiyShDKVhxYJyauhL0lsJJ3vB2b1tqj3CTwHtyBLN/rknQ==
X-Received: by 2002:a2e:990b:: with SMTP id v11-v6mr7955986lji.87.1535652325589;
        Thu, 30 Aug 2018 11:05:25 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] ARM: tegra: Setup L2 cache using Trusted Foundations firmware
Date:   Thu, 30 Aug 2018 21:04:17 +0300
Message-Id: <20180830180421.6415-5-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra30 L2 cache should be initialized using firmware call if CPU is
running in insecure mode. Initialize L2 cache and setup the outer-cache
callbacks in early boot using the firmware API.

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
2.18.0

