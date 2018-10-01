Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FECC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41392208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfE0HWEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41392208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeJAUrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:47:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33531 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:47:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id q40-v6so1141271qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GiHQfn4/nqpdVdbgVGxtlSle3IAlPwzLySQJsDBVWVc=;
        b=EfE0HWEZxSgnPYsb4gX+0o/vZYIbW4ZdaRvIOKscQf3NPENig66qPRMTSjSDefVh7y
         w1cELMbp6CO3dQPeMwsoImjF6JpKc1/TBj/Y+3W449oq+vTgRC+dNo7JPaJPJ92hNGP6
         7oRBp0v+1LsDnND6Y5phFMxS3JDLmHFJyq4XjLno8QLIsFtP6dR1WmSdEbigSGPAmk4c
         kIn5GA/KSq2qWLszGZ3l3OJrSufEpHFnyFCHpEeKqCY0sXH4wa/ngtyztF3S+OgigCSF
         uGrOkY+iCtrGHmf8NXfpZPx2HwkWxCla4uXkOrAN9t2qTjthvjjCFZhOU0CEzIZvwkK2
         wajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GiHQfn4/nqpdVdbgVGxtlSle3IAlPwzLySQJsDBVWVc=;
        b=mgQZ3a+3l4S0yGq5bMPq6e35psRbpiyO2NCT7VnbDyEUvXZnN361eXafveIX5iSlx3
         C6JF2U/LhAZnvZ0hPmbuSXQ6AmgG8AzU4wDaUDrjrn5JFd8wQCmLSlfajy5i5lE2aVUj
         C2cXral6mPB9tR3aSzL98bNpySV3yWcVbYIf1VBlSYCJ6w8FDj9waH9JAcjxNPgMq16m
         N2nVwJJE1hJaXCOln1UJ9dcdDFnFY5fV2KeVW5aksU10ZbcxCg8C61El6jH/ZZ8dqqf+
         bjcesZ+OQk+eYHcAN+4jyteNUh2KW4LetL1Fx3ZNwJGk5mM9J7G4V3du5+OW/IGIBLHC
         qJmw==
X-Gm-Message-State: ABuFfogv/kulThCctnxZhhkseAkfbugXghH8lJQ1E1DIuWedT2xQLzD8
        w79fcPh0607qaDS1hWQesg==
X-Google-Smtp-Source: ACcGV61TdMI1Zkc3olStAubepqrN2+jrM6hfA9Lfl41zJSZtmQ1INdrhcigt69NgBbQg/UKznOPL6w==
X-Received: by 2002:a0c:e803:: with SMTP id y3-v6mr2588078qvn.56.1538402949238;
        Mon, 01 Oct 2018 07:09:09 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j19-v6sm5714496qtr.6.2018.10.01.07.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 07:09:08 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] x86/mm: Add a kernel parameter to change the padding used for the physical memory mapping
Date:   Mon,  1 Oct 2018 10:08:41 -0400
Message-Id: <20181001140843.26137-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001140843.26137-1-msys.mizuma@gmail.com>
References: <20181001140843.26137-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

If each node of physical memory layout has huge space for hotplug,
the padding used for the physical memory mapping section is not enough.
For exapmle of the layout:
  SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
  SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
  SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
  SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
however, the needed padding size depends on the system environment.
The kernel option is better than changing the config.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b..00cf4ca 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -69,6 +70,20 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static int __init rand_mem_physical_padding_setup(char *str)
+{
+	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
+
+	get_option(&str, &rand_mem_physical_padding);
+	if (rand_mem_physical_padding < 0)
+		rand_mem_physical_padding = 0;
+	else if (rand_mem_physical_padding > max_padding)
+		rand_mem_physical_padding = max_padding;
+
+	return 0;
+}
+early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -102,7 +117,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		rand_mem_physical_padding;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.18.0

