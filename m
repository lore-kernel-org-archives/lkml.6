Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F6C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57B922445
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvSWRheY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57B922445
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGGDxM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:53:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932635AbeGGDxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zsTKV6LtJ2BHSqzOPf+q9/IDBtTfAyHOi0k09SMY1BY=; b=SvSWRheYk58kdWyEqxSKy9rKN
        6PNWFFwc8dZ29GbjS3aAjDMl908XwzmtjhdTj8Zt92Vy80AeFsAJxskoUSaLHisjcYOI+6iGxHJOs
        ftCs67LotndUhhgAdZBRTOzWA9/3xBVtx6yYzUlHBivc2CvGkurWZigtwIjrCjnL+oFvB/6kmJs65
        Sq7tNSJJgQmqe2buk6ONFcoXlRt4zQsKwVlsM6anT0YFue64fc3Skl5FcIoEAhRZoTzKdw/fTEsuS
        uvhDcQQfNV3rTOmB4aI4JpbWL8/9JFY41NlsTKQWHe2M0/ZgVoHQp414syH5lCf5n79pqn1p2ffJD
        uw2uwQ4cg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbeHW-0001Gt-NS; Sat, 07 Jul 2018 03:53:10 +0000
To:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Azael Avalos <coproscefalo@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] platform/x86/toshiba_acpi.c: fix defined but not used build
 warnings
Message-ID: <59774e7f-103c-70b1-11bf-b2af16947dc8@infradead.org>
Date:   Fri, 6 Jul 2018 20:53:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a build warning in toshiba_acpi.c when CONFIG_PROC_FS is not enabled
by marking the unused function as __maybe_unused.

../drivers/platform/x86/toshiba_acpi.c:1685:12: warning: 'version_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Azael Avalos <coproscefalo@gmail.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
---
 drivers/platform/x86/toshiba_acpi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20180706.orig/drivers/platform/x86/toshiba_acpi.c
+++ linux-next-20180706/drivers/platform/x86/toshiba_acpi.c
@@ -34,6 +34,7 @@
 #define TOSHIBA_ACPI_VERSION	"0.24"
 #define PROC_INTERFACE_VERSION	1
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -1682,7 +1683,7 @@ static const struct file_operations keys
 	.write		= keys_proc_write,
 };
 
-static int version_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused version_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "driver:                  %s\n", TOSHIBA_ACPI_VERSION);
 	seq_printf(m, "proc_interface:          %d\n", PROC_INTERFACE_VERSION);


