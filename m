Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF67C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C12D20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sHuOXMkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C12D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLKMLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:11:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45094 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLKMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:11:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so13813694wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aMzDWZ5d4DsmLZNz4JpMbix0QWStbli61BCRMNkvIn8=;
        b=sHuOXMkIijV+0GoFjy5UiUhcyBUNL0DPDkE10nnUjD4g1hnSC1HVVUlSXnce04RaBJ
         uGIluta8QRMR4AI7AzHi06fRAWzwznKc5ynojJ8NQ+bE62cfUySIidBMzGbngY5WgNmR
         3tDlONSQaH1sp6opyfoAZvXiOvGiHH6efUP4JhHnxdEZKcnW8ZWrwavivRzRSKbBlxKw
         e1FDUZ77SKOR1tCFxfewVQSCgtDwhgtXc0O2I1doUZYxM6gdea/zEnaKccwNY97OQUo+
         VueGYPZB2tQDCVxEL03YRJPPWD7LtxUoDOmh0J1juCXZ+iRr8GCBxm+s+eAa1yHXtuLn
         3Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aMzDWZ5d4DsmLZNz4JpMbix0QWStbli61BCRMNkvIn8=;
        b=qSdYeMfWr+Y4aiZHeH8euHfFBnddvwezNdhl2lKXvNEbIRZ3ou0QeYcgmZCplT9IDI
         srDdceJRrn+p5zkxEYPMpREy5LzVYjfzOtOuzvsNTpiepBPSoLrYaZeSvwxwip09KZJV
         QfRo/w6OHu8srKZqWKcptjOGeZaQWYMxqIev8UK8raLULr6zN8PRnznwMlnARs6MZ7v4
         Y7PJ+IK6Y5i04jkhKwrf7pOzkknAglWfcpsWjuC/6fKquL/jyznBX+Wr2WnghaeJe/ix
         JSlJ3d4Cc3PcjDlrIJCYEhfUasAEgNOiyhsrLXR8E5jVlEglh1YAgWKYv8mo+2bWc0ZK
         Zj9A==
X-Gm-Message-State: AA+aEWbpmTnvuJvpKLXC2VM7SjXjZeHYMPCh5hJuassZDk86EbYfPYUo
        sr8gAFTfdpjJwfWwNbiPj6U2Eg==
X-Google-Smtp-Source: AFSGD/UbKywRizAEeEdkNhUkyhmMvOvNduFHnwgON+ZPGJGhZvILWUTmi64Y7sLghhD9YzgXo+7WCQ==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr12734890wrx.79.1544530274710;
        Tue, 11 Dec 2018 04:11:14 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p14sm9999629wrt.37.2018.12.11.04.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 04:11:14 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] sparc: Set "ARCH: sunxx" information on the same line
Date:   Tue, 11 Dec 2018 12:11:09 +0000
Message-Id: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking boot log from SPARC qemu, I saw that the "ARCH: sunxx"
information was split on two different line.
This patchs merge both line together.
In the meantime, thoses information need to be printed via pr_info
since printk print them by default via the warning loglevel.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/kernel/setup_32.c | 13 ++++++-------
 arch/sparc/kernel/setup_64.c |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 7df3d704284c..afe1592a6d08 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -311,25 +311,24 @@ void __init setup_arch(char **cmdline_p)
 
 	register_console(&prom_early_console);
 
-	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4m:
-		printk("SUN4M\n");
+		pr_info("ARCH: SUN4M\n");
 		break;
 	case sun4d:
-		printk("SUN4D\n");
+		pr_info("ARCH: SUN4D\n");
 		break;
 	case sun4e:
-		printk("SUN4E\n");
+		pr_info("ARCH: SUN4E\n");
 		break;
 	case sun4u:
-		printk("SUN4U\n");
+		pr_info("ARCH: SUN4U\n");
 		break;
 	case sparc_leon:
-		printk("LEON\n");
+		pr_info("ARCH: LEON\n");
 		break;
 	default:
-		printk("UNKNOWN!\n");
+		pr_info("ARCH: UNKNOWN!\n");
 		break;
 	}
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 014390950333..51c4d12c0853 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -643,9 +643,9 @@ void __init setup_arch(char **cmdline_p)
 		register_console(&prom_early_console);
 
 	if (tlb_type == hypervisor)
-		printk("ARCH: SUN4V\n");
+		pr_info("ARCH: SUN4V\n");
 	else
-		printk("ARCH: SUN4U\n");
+		pr_info("ARCH: SUN4U\n");
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
-- 
2.19.2

