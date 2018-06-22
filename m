Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C102C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C524944
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NeUKGFkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C524944
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeFVWTC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:19:02 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46600 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754543AbeFVWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so3810016pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=7n/n0GZ1fT7uqme1QP3PnoK9kmSVy0/xv553QRNYgTE=;
        b=NeUKGFkIaQ+oIm/3qg+7vczE2b9yy1DsWWyAFFWrHu7C08orEVLJ/4er7IpxRsof8C
         TG8Le+BhUgURhKCN47WRm+zxm59A4DJe0ejYpAaCIuPWh51maU3cQY0MW9yyXZYwOs3Z
         ZsaIJI581G9jB0M1Wpj5kpKzc9ab7KtmotweVSx6ufYmgC72ml5vMd0zQsiy96mspLwW
         uykQOL9kU6CDgqrIojtlOYvwrtsJluMnz2568/scTVbxO/gMf6mBII1vMwyhslMeYi7k
         ZbZxyZYEWjAFo7j0a81x7Gvn3+soi8V6zZbSqUCZGb3WxvboNQeXNT3WWuC2r3VdBT+H
         1Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=7n/n0GZ1fT7uqme1QP3PnoK9kmSVy0/xv553QRNYgTE=;
        b=mTtxU47JwsKglB94CeY8k4PiHhlQcXMmokJMjUT9pXiiYwYX/n/tVmM08exCTyQAFV
         N+/KXxqUcCpFk1JlVinkvMGXOV6u4r21GBLGyzzJbkAcAMQYwdGOCw93Jak6ORZYMAwd
         YYG0wCah8Hb0ExkQd7xWRLGUbwLXv8iQWhew4yLvoLHlgWa7PuksxtkDqPpOElLdR0wd
         WiewjkdNo/C+CPCCHu8Q1kuF6lyk5e0TUpyFCnJMJYqInFAOrSi4j34gAqsHP3oPWY8j
         D57h12ps5CaEMcnGanE9b64gsSNzObB6v+UdNXNConxZM98TY2j5wiLREZToCaxRpIA/
         k6rw==
X-Gm-Message-State: APt69E1Ipk1X4mNN4Tt2eQdVYD3C3ktr2RYRKp5ds41g8+FIoukfJKPq
        AGPVvalQLaCtbYn2EimRWtLBdw==
X-Google-Smtp-Source: ADUXVKJjmMN1k2dW2B1h4AHMaYAtxBRiHGER9iiGtXJvZwKv7DroSg7rbIneOZuCwK9MZ1zkcbTfOA==
X-Received: by 2002:a65:49cb:: with SMTP id t11-v6mr2898856pgs.218.1529705940720;
        Fri, 22 Jun 2018 15:19:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j23-v6sm12978981pfi.137.2018.06.22.15.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 15:18:59 -0700 (PDT)
Subject: [PATCH] RISC-V: Add early printk support via the SBI console
Date:   Fri, 22 Jun 2018 15:18:14 -0700
Message-Id: <20180622221814.29025-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Olof Johansson <olof@lixom.net>,
        Michael Clark <michaeljclark@mac.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code lives entirely within the RISC-V arch code.  I've left it
within an "#ifdef CONFIG_EARLY_PRINTK" despite always having
EARLY_PRINTK support on RISC-V just in case someone wants to remove
it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/setup.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ee44a48faf79..494c15ba4610 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -39,6 +39,27 @@
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
 
+#ifdef CONFIG_EARLY_PRINTK
+static void sbi_console_write(struct console *co, const char *buf,
+			      unsigned int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i) {
+		if (buf[i] == '\n')
+			sbi_console_putchar('\r');
+		sbi_console_putchar(buf[i]);
+	}
+}
+
+struct console riscv_sbi_early_console_dev __initdata = {
+	.name	= "early",
+	.write	= sbi_console_write,
+	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
+	.index	= -1
+};
+#endif
+
 #ifdef CONFIG_DUMMY_CONSOLE
 struct screen_info screen_info = {
 	.orig_video_lines	= 30,
@@ -195,6 +216,12 @@ static void __init setup_bootmem(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+#if defined(CONFIG_EARLY_PRINTK)
+       if (likely(early_console == NULL)) {
+               early_console = &riscv_sbi_early_console_dev;
+               register_console(early_console);
+       }
+#endif
 	*cmdline_p = boot_command_line;
 
 	parse_early_param();
-- 
2.16.4

