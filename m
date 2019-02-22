Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71522077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZbgRusd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfBVSEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:04:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40888 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfBVSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:04:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id t14so2392568lfk.7;
        Fri, 22 Feb 2019 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
        b=cZbgRusd72a50mwccguM+uOvw3Sh1jFcugmBmVOvqcHFb5L4VIL5dGYibZUnzArU/G
         QD/ZyCmle0YjHRq1HeIaWbcSLLin0BaAcMmdnXXNWpvsJTd2/ItBw1KbbSnzdSX6Ori5
         e3uLRt9+xrocHbXJhDSyo58n0KWO8DPqi0Jf/PA9HMQ6+VOZlRzcC/syIuEAR7JlHI4M
         n/ADzEfAX7CfgUmJ2w1KQO2aQ2L9LwLtU6eTvm0VhfP9OAwjz+srAHvq7LNY8i4AeE15
         E8KftaYB0MvtbW9WEzHDR1ogWYXhN52F1G8bbGYgQ3GIjoPdOq98Fs7cgFplR43hV9ET
         Xyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ef/pjs0sC4GxqdxxxUgy0sbHhpRnX1Oqj7kTNWdGqgw=;
        b=IqQcrhbmAmEuJS/hq8iR39cA/+LxvEMA1REusIsCdQV7CLbWcOcfts2LIUouy71YhS
         lDeyqfLTgT16YOqnkHIu/cyV1tg0Auhw5o1pX7BD4CjfWfhCczyEDEGawuX57lyDZ9aP
         sMH5XjeE/JhVu1TDkNtQ/Gqv34VF0vqJXK81YiemkKRHwXoulJrXDC5cELM6IkTI4FbY
         Nu84ix/xLEqkje/FHWKr4D6eDL43h07zW28PUs5IOVl6DCLyZ1qGlY3HGb06Afhdf/qw
         LDoqIa8N9CJDPClUHH2dzDaUdUFSMxApb9P9TAFv8/r89K1NjJsQWF6kcFKZWUmFBRfL
         dsoQ==
X-Gm-Message-State: AHQUAuYKizobbmGOzCimfTf0hHdUigBJesbhvXnCMEY7hRmTAjspcFpg
        fDqdfRTz7moJrrumtZUAZns=
X-Google-Smtp-Source: AHgI3IYnQ6oD50qOsv9TnBC67tgizIQXZFjPCspSSkQrz6HVU+af+EDGWwunpKr/XgULKo3ALiXkaA==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr3399373lfc.104.1550858670524;
        Fri, 22 Feb 2019 10:04:30 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id j12sm721202lfg.47.2019.02.22.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 10:04:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] ARM: trusted_foundations: Implement L2 cache initialization callback
Date:   Fri, 22 Feb 2019 20:59:19 +0300
Message-Id: <20190222175926.23366-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222175926.23366-1-digetx@gmail.com>
References: <20190222175926.23366-1-digetx@gmail.com>
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

