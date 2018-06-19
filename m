Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A88C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9F320836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGZCcgI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9F320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966225AbeFSLDj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:03:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33094 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937680AbeFSLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so29488700lfy.0;
        Tue, 19 Jun 2018 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wqBEXI/eK4btprn1ZlQif0SZPhK1vXHNPfXfXMAW+ao=;
        b=bGZCcgI4+1VgH+bDj4+Uvgk7Jrd+GlhFutSLaaaZPi13V/SmSw4QKP22h4nkTuWxMu
         k/DCRpReuRpTbOhwsuS5pIs0hQoyIUJjTxMj7WxAZhrXnj23N3c1gz8IE8wZjDayJiQM
         YKrrbQwYPO59hTWzuWbgAYcfk1huVnzzylqniaG98gGw436BU6EUibjG63UVAWCT29eF
         mv5SqJrgu1zculeFBpOcAFvKnd7Z8R9MA0co1vxhPWJ6VwJAZMbAPcOQ45mWBlDR71xz
         68dvT//1MgzqBmOxFFAFySY2KEJr4tY2EQurZJ89+zsHb3MKH78eg7u4zj1o4Ml15Kqm
         yubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wqBEXI/eK4btprn1ZlQif0SZPhK1vXHNPfXfXMAW+ao=;
        b=jME/Bipvz1QrXx6b9TfwUEV1BTWt2iiMKeKHo4Uhub2TW0hUdlW7eiAbdwE4U2rY5Z
         iy/CFFaPaqOxfNXYHxNYnjUDpf1fFBNVpwxKoY/0GpDzeiIHiRalZrNHye6ndCzYUKdf
         vG46xLX1hJwvmbXusMRRg18FCdJVJRdnScJGl6pSqoqkyMHXoHzgtghTfVZ6W1v3+W5V
         alhABrq9cQsbhXt0oKwelMDBxonxm6OpmAVPyJsT12wAWSvLh4nExdolGfzEaB7hhhqA
         /MQ7vTg9a6vjgLFuL75YqhayNCvYZGTf446+ZRifaZ+HtUoh3Ock4axfC/KBUJ25AYqk
         zBBg==
X-Gm-Message-State: APt69E09XPn9lM0I5vtCOfJrruRr8HL+uU3I02PI0Wc/1ahRmL6oeHGW
        GlkI8Ph92hRt/PdL2w2P2O0aONTU
X-Google-Smtp-Source: ADUXVKI/58IcEpOy2WiHYyrAaOPIaSlyubEKECO1ziSC6IIviV4QmXB5dW3st3TJdQd+H2h6EnNokA==
X-Received: by 2002:a2e:4942:: with SMTP id b2-v6mr11191138ljd.138.1529406175535;
        Tue, 19 Jun 2018 04:02:55 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/5] ARM: tegra: Setup L2 cache using Trusted Foundations firmware
Date:   Tue, 19 Jun 2018 14:00:25 +0300
Message-Id: <20180619110027.16935-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra20/30 L2 cache must be initialized using firmware call if CPU
is running in insecure mode. Initialize L2 cache and setup the outer-cache
callbacks in early boot using the firmware API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..590b1cf1a8c4 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -38,6 +38,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <asm/firmware.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
@@ -70,9 +71,23 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_trusted_foundations_l2x0_cache_init(void)
+{
+	if (IS_ENABLED(CONFIG_CACHE_L2X0) &&
+	    IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
+	    of_machine_is_compatible("nvidia,tegra20"))
+		call_firmware_op(l2x0_init);
+
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
2.17.1

