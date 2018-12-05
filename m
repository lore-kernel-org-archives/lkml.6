Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE31C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED8206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA4GwHl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeLEPox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:44:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32774 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLEPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:44:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so10207120pfb.0;
        Wed, 05 Dec 2018 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9REQr19w9mU8jHIC9uOgL/eGCLKrhkT+ptyiJjrO2tQ=;
        b=cA4GwHl9almY9Sa9dBIjODzGXtarfYHwPJnu+3eFYMOFjvp4/kMIc+Mp19L6F2YuFb
         sHfKN3wv1g43d/W7dfJScxZvrfwDDwdE379QsGXEZP65nra34eWF7UZZTF5353z5skrx
         UP5YnVOpNdH0aROrdgH354whv7oaMgdpY8fLH0yIYiKarRBC7jKt1iXS/IBQY+38eAok
         RxbYQNLZfcErGyJrVVF/xRvzz6sTc5kBXtzBbN2j8BGhh5vfvm75ruKbwnwbNaNlRW2r
         WkK6KpGjd3gckJmUYuy50FwfypsfLShUY8px06fvxz22NV5dvMggaqAPpfLp9V/FDeMB
         bEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9REQr19w9mU8jHIC9uOgL/eGCLKrhkT+ptyiJjrO2tQ=;
        b=XRqqwrrVob4BRYNafETB6h68d/r8c5wAvjDjfeZEaqZBm2A8WT9ttKf6EUW4YzAMWQ
         fkKK+SDW8JZ/YclnTOuUq5udEtN/UXqrh05TVLUYuH2vIpmVD5mhcape7ch/TzLwfJ3b
         ltBizvHsX9YC2cwlsnIzXAbhu6RYhqul41E3Iu+4CkX35AF4egj7ePX/5FEbT+jw240E
         rF2PxCJw9Dpi4yIjcBGG983f1uJEHMLrhxeNWSwtw4+kZDoq26973YoE4piJDGOMcPi8
         /zryG4PK0fH64+wNqsrcuH53mvNyXn+SyH7tkJmyD2/mJL6nTttS3LEcn9akRzhywX0c
         4gkQ==
X-Gm-Message-State: AA+aEWauq9ol4ipEXuStRhk8jrrhKAnWyy3fQcUOoTunGA42RrWclUhF
        jxm9rSPgmpma2/At97LBmdF0I7PPETA=
X-Google-Smtp-Source: AFSGD/WKlptpOSm62jI6i/izU2hAakE6Z4SClRqXhpItTxylnr3q3fxxUZl5xVl/IfzjNGbEy2yKpA==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr20434086pgk.213.1544024692323;
        Wed, 05 Dec 2018 07:44:52 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id t87sm55781960pfk.122.2018.12.05.07.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 07:44:51 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: ia64: Remove unused header files
Date:   Wed,  5 Dec 2018 10:44:49 -0500
Message-Id: <20181205154449.15725-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file.h does not need to be included, so remove it. Moreover deleted
a line of meaningless return and some useless blank lines. In a function
whose return type is void, returning on the last line is not required.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
changes in v2:
-revert modify of MODULE_
-delete some blank lines
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index dd5440d3372d..80c5bf590acb 100644
--- a/drivers/cpufreq/ia64-acpi-cpufreq.c
+++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
@@ -16,7 +16,6 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 #include <linux/proc_fs.h>
-#include <linux/seq_file.h>
 #include <asm/io.h>
 #include <linux/uaccess.h>
 #include <asm/pal.h>
@@ -28,7 +27,6 @@ MODULE_AUTHOR("Venkatesh Pallipadi");
 MODULE_DESCRIPTION("ACPI Processor P-States Driver");
 MODULE_LICENSE("GPL");
 
-
 struct cpufreq_acpi_io {
 	struct acpi_processor_performance	acpi_data;
 	unsigned int				resume;
@@ -348,10 +346,7 @@ acpi_cpufreq_exit (void)
 	pr_debug("acpi_cpufreq_exit\n");
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
-	return;
 }
 
-
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
-
-- 
2.17.0

