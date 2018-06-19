Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D0C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B9220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B9220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757365AbeFSVlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:41:01 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:36120 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757240AbeFSVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:40:57 -0400
Received: by mail-yb0-f193.google.com with SMTP id x128-v6so477718ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9HjIrMkZl8ax2NvVRwbdVOwXcmC+TUrZHQKdns42YsE=;
        b=N3XKzLRvnoGKqO6P/yMPpp6EUiK9iAIafEODqxBPncjA+EJmkHSBoV5gQD3cIaSBR5
         0UKhFm0g8bbhRVAoJavOT1i+UmYPxzd3cEFo3NxmuOnO7cwkYwqBcDsK8GSDusK4o7mC
         6sTvRUm2oJR/EmsSps4uGcTTUvNKvkxeFhKOTuSzkHLQtB7ZhjApw5GP3Ic1YJ8haudH
         f/ZhmnVu5DGWDlqpy03RDhQzB0iJNERlJJoIJwbHSdBDICJMjZJj6FSQkX2ZZywq+bgb
         2G89pgMUSDbkrUMNMOu/ajn9Jw6XVDWCtoQQBT2sB9IpnkeCLPDZDIlIxcZAvgUs95MB
         4Epg==
X-Gm-Message-State: APt69E0g9cnTpqiz+WTQfCV4vhuz5j7jkNjuv06rmDenfKy2YEqQi8DY
        BRw4lLdVXYiyvMq/zwABO1WGxU0=
X-Google-Smtp-Source: ADUXVKK47G+ftIdlLuw099dRuKCO0qI4DADNzexHja5GuU8aY6otQfkjfRCyxJ30x/yglMRoQd3Y+g==
X-Received: by 2002:a5b:487:: with SMTP id n7-v6mr9707112ybp.353.1529444456793;
        Tue, 19 Jun 2018 14:40:56 -0700 (PDT)
Received: from localhost.localdomain (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.googlemail.com with ESMTPSA id p82-v6sm298451ywe.1.2018.06.19.14.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:40:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH] h8300: remove unnecessary of_platform_populate call
Date:   Tue, 19 Jun 2018 15:40:54 -0600
Message-Id: <20180619214054.19326-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT core will call of_platform_populate, so it is not necessary for
arch specific code to call it unless there are custom match entries,
auxdata or parent device. Neither of those apply here, so remove the call.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/h8300/kernel/setup.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index a4d0470c10a9..b2b51f75774e 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -23,7 +23,6 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <linux/clk-provider.h>
 #include <linux/memblock.h>
@@ -188,15 +187,6 @@ const struct seq_operations cpuinfo_op = {
 	.show	= show_cpuinfo,
 };
 
-static int __init device_probe(void)
-{
-	of_platform_populate(NULL, NULL, NULL, NULL);
-
-	return 0;
-}
-
-device_initcall(device_probe);
-
 #if defined(CONFIG_CPU_H8300H)
 #define get_wait(base, addr) ({		\
 	int baddr;			\
-- 
2.17.1

