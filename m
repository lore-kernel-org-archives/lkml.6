Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB813C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7102020836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfaaAVbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7102020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966257AbeFSLD7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:03:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41922 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937604AbeFSLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:55 -0400
Received: by mail-lf0-f68.google.com with SMTP id d24-v6so29457253lfa.8;
        Tue, 19 Jun 2018 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pxYh6jL+znz1tCJ55OEGuSWPrbXHvzMiPRmuAWLzAkY=;
        b=WfaaAVbhi2CarT8csJGBY7fBF7hlyoylTJ8LRv0bZu4GH3OoHCeEY4cqtiU9DZZTnr
         3ArE/Y6Qrxfs6db0N3e+xOX2OJhX48Mpl2KohXlewS8+MYYPxpfXtcmb+4Mn0J59wDUM
         C4pb6h4QMVyzH38rre/9gG/absThvjtoqflWiRvwJ1DEJBRvI0UNRrOO8jYShjkWGYF+
         gx0/jxvosNDZ0EhlrlXDT52gRhqlyfbdgSXtYQSkL8AdH1sC4q2GubzJ7Fs4lFBlNGoh
         1G8+XSFRoGffU8JiddFqy6CbP35CkXmMGRoCEqPMH15fHLr8iCbfWwg7uwaBy/G25C4F
         1kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pxYh6jL+znz1tCJ55OEGuSWPrbXHvzMiPRmuAWLzAkY=;
        b=ssTRs7HQYBSf/aHpG4T5pEuUEkd4HMHSs0mpslW9/j6nQDuV6jPY0XJY97N4iqZguw
         65irU/O64l0eQ5wqrgomQKrO0vEGfUvoTIAMqyGC7bI720Qxa1mn3wuvbFsu74BQvdlo
         FuHFcsLHet9ldLxv9gSaPA3sYTFaK6g8ux0mo8B18/sxuk2XJ3ECItcR9f4p75b24qvU
         Hyy3ZW7S25rblOnBKxr8JJOK8w+KedD/AN8Mw3JGTwQx7AgFSSRsgEjBGrSvaDmWAFF9
         lPFwkZ14B8Am9DLnb80NJNxyaVpfWdaLQSZUoRvKRsBwF5ftXFTVArNLy9hT8ohJreYq
         cZcA==
X-Gm-Message-State: APt69E3ZoFH3UdZe0fi897anRWg55Vpow5Mxnlto0BlBD2Lj33oLDyIg
        R1y+6/43/CJpZc2UxYjymEI=
X-Google-Smtp-Source: ADUXVKIH/Awg/Kf9LnqnGaLnUbGEG9buBEQ67FdmkKQ92QiCmn7D4hC9XtN8lXagiU+Uoh9ISaJVhw==
X-Received: by 2002:a2e:82ce:: with SMTP id n14-v6mr10498493ljh.34.1529406173603;
        Tue, 19 Jun 2018 04:02:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/5] ARM: trusted_foundations: Implement L2 cache initialization callback
Date:   Tue, 19 Jun 2018 14:00:23 +0300
Message-Id: <20180619110027.16935-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement L2 cache initialization firmware callback that should be invoked
early in boot to enable cache HW.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3fb1b5a1dce9..30df6547020f 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -18,8 +18,13 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <asm/firmware.h>
+#include <asm/outercache.h>
 #include <asm/trusted_foundations.h>
 
+#define TF_CACHE_MAINT		0xfffff100
+
+#define TF_CACHE_INIT		1
+
 #define TF_SET_CPU_BOOT_ADDR_SMC 0xfffff200
 
 #define TF_CPU_PM		0xfffffffc
@@ -63,9 +68,31 @@ static int tf_prepare_idle(void)
 	return 0;
 }
 
+#ifdef CONFIG_CACHE_L2X0
+static void tf_cache_write_sec(unsigned long val, unsigned int reg)
+{
+	/*
+	 * The L2X0 cache driver shouldn't invoke a write to a secure registers,
+	 * though it's better to reinsure by printing a warning message.
+	 */
+	pr_warn("%s: Ignoring write [0x%x]: 0x%08lx\n", __func__, reg, val);
+}
+
+static int tf_init_cache(void)
+{
+	outer_cache.write_sec = tf_cache_write_sec;
+	tf_generic_smc(TF_CACHE_MAINT, TF_CACHE_INIT, 0);
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
2.17.1

