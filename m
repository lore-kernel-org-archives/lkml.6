Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCBFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A1B2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="ayXCV5tX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A1B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeLDOL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:11:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40648 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeLDOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:11:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so7419557pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JjE3m3KhoW/fupLlyitIScJqRKLQdmncQOfWLq2YHj4=;
        b=ayXCV5tXDBvefnE96niiHdR1lxYBaQDf/OrEr6JpIHqyUIcgHz5rwM5VBe5W+Q30aw
         pNA5lzvZNDJnqOyz/XFSRdDbmsr4rfCajEGmZNNfUB54sUfcd3+HqGvFlmazQLbDcSKx
         GgWKvD7lrGXYCFsFPeJFtaF8nGrbSG9pes/pGxJjRisFIBDZNp6QxJfJVoP/d+KsvYJA
         QTPbfCRrnadMdcOgaZnlNWWJtB0bbbF6mzUuh0E1V9XuZIAJtrrEkeiiHdbwnjSzpn4/
         cRtYiHgzNdZFjt0lHdFyWuGcC8FVw7Ilr3vwewmCp4RhaJbw/GXlPlzthQDkdomd+7VF
         l5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JjE3m3KhoW/fupLlyitIScJqRKLQdmncQOfWLq2YHj4=;
        b=snxQd8ts8uyv03Kvb35BTXFJFxLW+N0c/K2Ac7xrJmSFozOdOiwWnqOSV1jmvmPVKj
         Ldoqy3FL1sQvPtlw/x/yRZZl5MPONsMhcQ6VXinf6BdgiXYgKAZhV+Rx9wS0VrIYaYPf
         S3GqKwxKpwLDE+V4aYVteth3TsekAjI3/59b24PTIp/FSyRv/pseIBvVw+Szrycabtkk
         7r03fnLlzJLLNRUnrY+xe7U0AtHHywthuAmXvPlBZnQc6E/NR5xhK49FiVSvWMhYW8dQ
         9ZH1B0XgViiOAX2PM3eXTZ24bbRNkZ+XihLtY7Xn6/tZj9KBGibaiaK6uFjgch2QHgKQ
         JYSA==
X-Gm-Message-State: AA+aEWYfpa/Qs4YZ97LQ4cP5SkGaj7+WCB2cAsSKj9efWEhZl+Xu6yj7
        aYGv6ODHe/OxvF2a6EaFLl+GtmeyDwbAPg==
X-Google-Smtp-Source: AFSGD/WFzf2OlR+iBlm92g06JcgbMovmeH6PyBxCULu5iF8ycg+wb//PssBQCzrDSC4V7y7QtGsM4g==
X-Received: by 2002:a63:4706:: with SMTP id u6mr15986664pga.95.1543932687281;
        Tue, 04 Dec 2018 06:11:27 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([49.207.53.58])
        by smtp.googlemail.com with ESMTPSA id k129sm31298884pgk.29.2018.12.04.06.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:11:26 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH 3/3] RISC-V: Remove EARLY_PRINTK support
Date:   Tue,  4 Dec 2018 19:25:07 +0530
Message-Id: <20181204135507.3706-4-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204135507.3706-1-anup@brainfault.org>
References: <20181204135507.3706-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EARLY_PRINTK using SBI console calls is not required
any more because we now have RISC-V SBI support in generic
earlycon framework.

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig.debug  |  2 --
 arch/riscv/kernel/setup.c | 28 ----------------------------
 2 files changed, 30 deletions(-)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index c5a72f17c469..e69de29bb2d1 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -1,2 +0,0 @@
-config EARLY_PRINTK
-	def_bool y
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 2c290e6aaa6e..fc8006a042eb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -35,31 +35,9 @@
 #include <asm/sections.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
-#ifdef CONFIG_EARLY_PRINTK
-static void sbi_console_write(struct console *co, const char *buf,
-			      unsigned int n)
-{
-	int i;
-
-	for (i = 0; i < n; ++i) {
-		if (buf[i] == '\n')
-			sbi_console_putchar('\r');
-		sbi_console_putchar(buf[i]);
-	}
-}
-
-struct console riscv_sbi_early_console_dev __initdata = {
-	.name	= "early",
-	.write	= sbi_console_write,
-	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
-	.index	= -1
-};
-#endif
-
 #ifdef CONFIG_DUMMY_CONSOLE
 struct screen_info screen_info = {
 	.orig_video_lines	= 30,
@@ -219,12 +197,6 @@ static void __init setup_bootmem(void)
 
 void __init setup_arch(char **cmdline_p)
 {
-#if defined(CONFIG_EARLY_PRINTK)
-       if (likely(early_console == NULL)) {
-               early_console = &riscv_sbi_early_console_dev;
-               register_console(early_console);
-       }
-#endif
 	*cmdline_p = boot_command_line;
 
 	parse_early_param();
-- 
2.17.1

