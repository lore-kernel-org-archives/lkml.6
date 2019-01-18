Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBBF20652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547820284;
	bh=7FXx59WvLd1c0Mf/wXoQYWIGlJChPVCk0WeKN1K8y0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x1QVqDTTodKWO4Ax2rChOiKVP3U/7/hVC3QtrIDTaWrjtbhHvwIq/76xInJ2ji50o
	 VurN4Rhf3Oqg2RQA7N1PDm7fwfB+sscdzmliUl8eg0qqZV4P4diHRzt1HVhC0msR68
	 fhvOASXHAV6l8E/OM37elapJNWmlDJ2iQD2Bw+Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAROEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:04:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37584 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfAROEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:04:38 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so10588032lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUE4wXX4TJVPhb5KX9MWt1+d3yl5yS/n/x3TIPSxP/o=;
        b=ivFPjoFnFQlPGWbfC6D1tveyQ6XpBnkdAEMyZjqgwBcMv8gyM8iVwrVb0IynM/uuL7
         6nJPToQ763w0FmLUDf3de6ij4lkgtAPqBwPoOQQIj53MzC/U6QwqvxICp+KBBf8hVUgd
         VpA5EKffLNJniMQXYUIMHgqrP5ghuISGIg+a6wcs5Do852yphM5ZM1mQiHfHzSKhd3xM
         mZmTd6lkDpMrAdDI8QUXWRZn2e25yiJ3werKZdNHlnmIGTummoOR3VFl5uoyo49+QRas
         Kn60bh14rPEFktz2g51fHTf0MdGRCgsCLona99FH1MnkeBLOXZWdm+2v4xHUJqsqunu4
         Tltw==
X-Gm-Message-State: AJcUukcWQCen4xIfzCA/aMgL/G4StsDkV//fPis++/t08sXcQmejyWzZ
        hfIZrlOYrYYJSTbMy4H7c6o=
X-Google-Smtp-Source: ALg8bN6AvZBFYlhhXRJh6nq08nZfOMzdrlybPlCgKOHtBUEXc9NUoFatW3gzf/Vj9C/jPlTyK6lTdg==
X-Received: by 2002:ac2:53bc:: with SMTP id j28mr13296649lfh.86.1547820276569;
        Fri, 18 Jan 2019 06:04:36 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q67sm831214lfe.19.2019.01.18.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:04:35 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1gkUlB-0002Vq-60; Fri, 18 Jan 2019 15:04:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/5] riscv: add missing newlines to printk messages
Date:   Fri, 18 Jan 2019 15:03:04 +0100
Message-Id: <20190118140308.9599-2-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing newline characters to printk messages.

Also replace two pr_warning with the shorter pr_warn, and fix up the
tense of one error message while at it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/riscv/kernel/cpu.c        | 2 +-
 arch/riscv/kernel/cpufeature.c | 8 ++++----
 arch/riscv/kernel/ftrace.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f8fa2c63aa89..11ba67f010e7 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -106,7 +106,7 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
 	 * a bit of info describing what went wrong.
 	 */
 	if (isa[0] != '\0')
-		pr_info("unsupported ISA \"%s\" in device tree", orig_isa);
+		pr_info("unsupported ISA \"%s\" in device tree\n", orig_isa);
 }
 
 static void print_mmu(struct seq_file *f, const char *mmu_type)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a6e369edbbd7..4891fd62b95e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -50,12 +50,12 @@ void riscv_fill_hwcap(void)
 		if (riscv_of_processor_hartid(node) >= 0)
 			break;
 	if (!node) {
-		pr_warning("Unable to find \"cpu\" devicetree entry");
+		pr_warn("Unable to find \"cpu\" devicetree entry\n");
 		return;
 	}
 
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warning("Unable to find \"riscv,isa\" devicetree entry");
+		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
 		of_node_put(node);
 		return;
 	}
@@ -67,11 +67,11 @@ void riscv_fill_hwcap(void)
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-		pr_info("This kernel does not support systems with F but not D");
+		pr_info("This kernel does not support systems with F but not D\n");
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
 	}
 
-	pr_info("elf_hwcap is 0x%lx", elf_hwcap);
+	pr_info("elf_hwcap is 0x%lx\n", elf_hwcap);
 
 #ifdef CONFIG_FPU
 	if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index a840b7d074f7..b94d8db5ddcc 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -32,7 +32,7 @@ static int ftrace_check_current_call(unsigned long hook_pos,
 	 * return must be -EINVAL on failed comparison
 	 */
 	if (memcmp(expected, replaced, sizeof(replaced))) {
-		pr_err("%p: expected (%08x %08x) but get (%08x %08x)",
+		pr_err("%p: expected (%08x %08x) but got (%08x %08x)\n",
 		       (void *)hook_pos, expected[0], expected[1], replaced[0],
 		       replaced[1]);
 		return -EINVAL;
-- 
2.20.1

