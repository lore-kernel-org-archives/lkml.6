Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5904A21486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgtdYaKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5904A21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeHVSUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:20:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39472 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeHVSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:20:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id o37-v6so1861995wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JHxOm63VTrvea4O6il5h/P5dRlbhLFf8ay9BBBKebLQ=;
        b=LgtdYaKpm/jGP1mI7QSDxv9+YxXxaAxlk6Gth0B4FOWsTfl3k8NNoMho+50EtD1sH1
         Xqv19orAyPWKVxiEWjb/JrO6zHXLicmGnd9eUBhtzVl3sxobxSljniNFF7ryjQ1cvtzs
         4SlkOLYNyLgC1ehYPMFOPRMMaPx+Du8gfcfn7gvRtwFAdplo58A3l6eFdgDUnsuwozRD
         tUyR6W66WgbXFiuEorgpD9AWjfhN/b+UcQD5C1OHsgYaSy6taDBM/RyCzSlUWFJmG4f/
         vQ0jfYml9uphGZ+0hTQSTT5with+pRECaRFIU+lRsxLUvZzXvP0YaJd3S585ifJo2im5
         rxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JHxOm63VTrvea4O6il5h/P5dRlbhLFf8ay9BBBKebLQ=;
        b=oyBgNqoraL58zf+7JlfQiK7rkdo4y05T90EXY8ap4xrIexssSHjYDuwOtKBzHMBn4t
         KMoERf/+1AWcrNV3mvkkz0UoeOJFbFbBHWFGjtV92TqeUyXtLoEdoPno8gCKQXZiXWc8
         SnSOE6Rp2XFSsh/uMyhu3ak7EdOx1cvLkIdz0h38i8fo7LCvDw1uSUfVstEuwRxgnqdk
         3J+uIU5lZc4EsGamSvQb4cJLsa/iL34ryDXm6CUsUFEGl3/uogiWkr3M8dn6/jVk0jcM
         moSeaOYk3Xz5lfvRFxqIVIo1cjHIaaIZplBByEXgrxNY6GErfvScrXX01SN/w1K6QjDL
         38lQ==
X-Gm-Message-State: APzg51Ah2MIVhtTUWezZ2PUl9jJ661sFQBZAzdXaV3QYpkyT3uJ+7UJV
        n/OCBSOqyAJxe1n2/Xq+9VeXF2a9
X-Google-Smtp-Source: ANB0VdZTRabMC0+ND19O1dUoMRnKpJEEN4Q0p/BUuQiJXrgF/VxPQ+QWa/16QR44iF/M4hLUcWNyBw==
X-Received: by 2002:adf:be81:: with SMTP id i1-v6mr13592689wrh.235.1534949733848;
        Wed, 22 Aug 2018 07:55:33 -0700 (PDT)
Received: from gmail.com (net-31-27-146-90.cust.vodafonedsl.it. [31.27.146.90])
        by smtp.gmail.com with ESMTPSA id j6-v6sm1637677wrq.25.2018.08.22.07.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 07:55:32 -0700 (PDT)
From:   Paolo Pisati <p.pisati@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: tango: register pm ops only if running on tango hw
Date:   Wed, 22 Aug 2018 16:55:32 +0200
Message-Id: <1534949732-3824-1-git-send-email-p.pisati@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a multiplatform kernel, avoid invoking hardware specific pm ops,
when running on a different SOC.

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/arm/mach-tango/pm.c    | 5 +----
 arch/arm/mach-tango/setup.c | 7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tango/pm.c b/arch/arm/mach-tango/pm.c
index 028e50c..ea8fe20 100644
--- a/arch/arm/mach-tango/pm.c
+++ b/arch/arm/mach-tango/pm.c
@@ -24,10 +24,7 @@ static const struct platform_suspend_ops tango_pm_ops = {
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
diff --git a/arch/arm/mach-tango/setup.c b/arch/arm/mach-tango/setup.c
index 677dd7b..56a1c0c 100644
--- a/arch/arm/mach-tango/setup.c
+++ b/arch/arm/mach-tango/setup.c
@@ -11,8 +11,15 @@ static void tango_l2c_write(unsigned long val, unsigned int reg)
 
 static const char *const tango_dt_compat[] = { "sigma,tango4", NULL };
 
+#ifdef CONFIG_PM_SLEEP
+extern void tango_pm_init(void);
+#else
+static inline void tango_pm_init(void) {}
+#endif
+
 DT_MACHINE_START(TANGO_DT, "Sigma Tango DT")
 	.dt_compat	= tango_dt_compat,
+	.init_machine	= tango_pm_init,
 	.l2c_aux_mask	= ~0,
 	.l2c_write_sec	= tango_l2c_write,
 MACHINE_END
-- 
2.7.4

