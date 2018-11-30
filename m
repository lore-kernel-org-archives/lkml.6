Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87278C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBD120834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bmm6VKFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBD120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLABZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:25:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38778 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLABZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:25:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so2882099plb.5;
        Fri, 30 Nov 2018 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EcT3+3yb3kFE9mjJ6+4AT2SKNaayZJHbFADKJc/xL10=;
        b=Bmm6VKFVoHmAROvnD2THR20dZqvDN4Ge/TLDNbmCwuy5xtMvcV8ibK5Nx2PrrAyI2W
         O5/PQiB15+3rr7gBChehZYGbtPfRC6FXRyQhLeYfndxly5wZgEYGmQ2c51CgEFL30q/m
         13r/Qi/aP/rLalEatr/SVElfDuUQGrijpHslhY/pYZL4g6fuyifBm3uSimKIiq2s8927
         JZeanqe9FZRzpo3k7kDEYPsa8VhM1EeWSjCtWSefyDOKW3+8OARQwfvcYUEGlraMRD9K
         PiHKSMyIuRn0SsoEuTKezkGchh3dC5TyyeXEjycGi8eXjza3b5yNjHKrexZ81fCwQez5
         mcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EcT3+3yb3kFE9mjJ6+4AT2SKNaayZJHbFADKJc/xL10=;
        b=CvMRv/cwo1ruNblbIz2QeW7j50MUDMfVeqcVbEhw6GexbHBQpOEtr+A9AEUKBu0jZu
         EXMsz4rL35WSmE/wX8eviYUpeD/c6JF19KXrThoJC0iQg9M9uz0tBcOv/wjy2JUPI7Ve
         oOzE53jCMRPRbjz8MxX/yll71iXFrdF06W04OGkYlLm1EIOwfFjCk5ozhzmSEhUqnhTf
         Jh8zcUCyAWWkQK6JQu2lBs4VebhweNTo4BhvwXz2faUUfDkPNQeEpMA38/XSm5wBLZuo
         Z8dGmPFc/hYVSbm05ZPRBA1gRE+9JqfRcUx7/FnVJ1YvjUFGR1CCiABAOJM0rz4sNzv/
         Q9bw==
X-Gm-Message-State: AA+aEWaSlRFlMAZQSSOPIJKMlKALVBa8DqF6OP9NFJzW2rVD/W/dMFuk
        UDK8qXozzyJRRqd6Bq3D4p0=
X-Google-Smtp-Source: AFSGD/W78ygw5N8yCRqlTu7SGBratPEE80zEwTzkjgJMxIy0AS1sPhj8AMtYk+AcxcSzdWSaN+R+FA==
X-Received: by 2002:a17:902:7587:: with SMTP id j7mr5883122pll.191.1543587384093;
        Fri, 30 Nov 2018 06:16:24 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 85sm12195062pfw.17.2018.11.30.06.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 06:16:23 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: ia64: Remove unused header files
Date:   Fri, 30 Nov 2018 09:16:20 -0500
Message-Id: <20181130141620.2488-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_file.h does not need to be included,so remove it.Moreover deleted a
line of meaningless return and move the module declaration to the end.
In a function whose return type is void, returning on the last line is
not required.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/ia64-acpi-cpufreq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
index dd5440d3372d..43ac191fb46a 100644
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
@@ -24,11 +23,6 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
-MODULE_AUTHOR("Venkatesh Pallipadi");
-MODULE_DESCRIPTION("ACPI Processor P-States Driver");
-MODULE_LICENSE("GPL");
-
-
 struct cpufreq_acpi_io {
 	struct acpi_processor_performance	acpi_data;
 	unsigned int				resume;
@@ -348,9 +342,11 @@ acpi_cpufreq_exit (void)
 	pr_debug("acpi_cpufreq_exit\n");
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
-	return;
 }
 
+MODULE_AUTHOR("Venkatesh Pallipadi");
+MODULE_DESCRIPTION("ACPI Processor P-States Driver");
+MODULE_LICENSE("GPL");
 
 late_initcall(acpi_cpufreq_init);
 module_exit(acpi_cpufreq_exit);
-- 
2.17.0

