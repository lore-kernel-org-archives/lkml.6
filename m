Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A34CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ADD218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8/B3ioT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfBRAT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:19:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37228 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfBRAT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:19:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so444495pll.4;
        Sun, 17 Feb 2019 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
        b=c8/B3ioT16kwbIY57ldLRWsLeuksRs6DL7eObvDSD7CIYQDr4mo1jA7eC5a5IYos3J
         CK0e+wFmVeDzvYhZK7uh6rbtvbTJacNO7x6DTfNaKUWFNTAfPGbgM0t53hhtwG7ZMy/G
         46RNrn08ANjrWs4C5f7snzDtFGMG9Wo9mJnuUCWv87EDlD3EjDquDVKR9+z9I+ONElHP
         eoO1lrEja2TA4omz13wup+lnnHi5QYNoZjxOw53v35otFUdlidKkpuBmS4RdcDLQDspA
         gMms3I5BrWgB0rEwsahmHQu/TKGsNqIa/YtFVVMPAO9mwXQOL5fWzdjW2qXXybvyfh0D
         9EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
        b=KZcFu6BoUK4E0pXjm2ItU/XB8oj2I68ZWm/4lEIGj1/sndzb/7JTVRGcPwQ8qcV2K+
         XpCVx2jBKT8eOGO6bx8V6Zh9lO4JZaYaz3Z8FuKO+8uH82dLf/yTXWKjFOS5aTPcZRub
         cJj+/zu53vogCeBtAFOqgQbL8PS7WFtQhtjA6dNb8sfLj7474+8lB8hubJ0bVLfDOMeX
         42rz8d07DJWxyZnaKABLcekgjMyL2TmixGAZ+J1/t8xcDGqV9GPb5JYNlUv8BCU9prkY
         fNCVVqY+yxCbFO+Npe3HW/VpEG5TY5Zx6lqKf42Jq20aii/CtqchGNlKZM+R5zpT0hTj
         GhCA==
X-Gm-Message-State: AHQUAuZ/5DN+ltbCLSKGtdgmSWZRNK3JQsWL5eEaiHQM/LpfHn103dvE
        yt5X+ML0Yo7NF2/u443wsI+4uG4d
X-Google-Smtp-Source: AHgI3IavcXNoo+tvv02/VjCX7nswKHG9gUmWMgJhu/m3mD9L83zn/gjNjqRlZOm/3F0YEj2sNtbjDw==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr22405596plb.238.1550449166237;
        Sun, 17 Feb 2019 16:19:26 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id s73sm31518071pfi.124.2019.02.17.16.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 16:19:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] ARM: trusted_foundations: Implement L2 cache initialization callback
Date:   Mon, 18 Feb 2019 03:17:19 +0300
Message-Id: <20190218001726.16785-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218001726.16785-1-digetx@gmail.com>
References: <20190218001726.16785-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be
invoked early during boot in order to set up the required outer cache
driver's callbacks.

Partially based on work done by Michał Mirosław [1].

[1] https://www.spinics.net/lists/arm-kernel/msg594765.html

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 689e6565abfc..3bf61a5933b9 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_ENABLE		1
+#define TF_CACHE_DISABLE	2
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -67,9 +74,48 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	static u32 l2x0_way_mask = 0xff;
+	static u32 l2x0_aux_ctrl = 0;
+
+	switch (reg) {
+	case L2X0_AUX_CTRL:
+		l2x0_aux_ctrl = val;
+
+		if (l2x0_aux_ctrl & BIT(16))
+			l2x0_way_mask = 0xffff;
+		break;
+
+	case L2X0_CTRL:
+		if (val == L2X0_CTRL_EN)
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_ENABLE,
+				       l2x0_aux_ctrl);
+		else
+			tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_DISABLE,
+				       l2x0_way_mask);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+
+	return 0;
+}
+#endif /* CONFIG_CACHE_L2X0 */
+
 static const struct firmware_ops trusted_foundations_ops = {
 	.set_cpu_boot_addr = tf_set_cpu_boot_addr,
 	.prepare_idle = tf_prepare_idle,
+#ifdef CONFIG_CACHE_L2X0
+	.l2x0_init = tf_init_cache,
+#endif
 };
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
-- 
2.20.1

