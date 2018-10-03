Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75977C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11120878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llLulb44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B11120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJCITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:19:49 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33037 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:19:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id m127-v6so1651875ywb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QM8tewhIDDsfSjJHipjZ6bwNCU5e0DtctNmA+zLf4e4=;
        b=llLulb44MqWvlwtrr1wFgu/1p62PHWK6Ac7CNXfvZBPfobYXSv8BmIQSCDIEz7xUVs
         bmwzBpzNXINMYK0gTeLAOBNntOvOs7dqo0SbDBx/Mnx3w6dqtldIkkmmE+Vv68MQhcPb
         M/0gKZkAQZbs5CZoGy76h5drAlEImiMRhyovvPILWKgPjL+MpjuJes4oZedQD0s1Sc/d
         N/CLkifzE8EI9tAzQVD+fMi51X/3yZRmleGXsfplyXrPBDV+aGxDuJpO+kyYJQp3oRwH
         MWo0/PiTaiEQnQMsFoE2TkG/XNd5xFNfHO0q2OD+1bbrZElodWSU0imgTO3+CAWjVTVC
         g3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QM8tewhIDDsfSjJHipjZ6bwNCU5e0DtctNmA+zLf4e4=;
        b=Ge+mYt6EiPLcdIP2quVYeIDeaVSLyxBBGAHkLAY6IWYUAojcE4tpsdIYIJiQ5to9Zf
         eiozEcevyUuNCqOEnqZwe9ACnI7vkN+q2a6esJOX22HrAfWnhnSGL8+kuRO1HKS/WkEx
         0ga+B3M+Nkp2suTzLR8OIMZ24ieQGeX8XTkdGMWF+88bDlQl/Q42DsmHqPMB0bfiKzP6
         eaVEpcydy0bcDg2ke5Y7usXO279M1dyudzRePwc+uMp/6NG+h5wl820KZzzdU87yxojO
         cbGIybGzvtUe9w/AUX589TbrhXHLiGL8reD2kArSTpnvH2BRprj2pAQXvtQJYtwPgfiN
         FRsQ==
X-Gm-Message-State: ABuFfojypG3DYE5O0FZADJpgVAXe50reWws3d9Gbb8svMSo+MaNtY7gQ
        RL9T0oiom6aVmDkDGUaSgg==
X-Google-Smtp-Source: ACcGV62Go3BcCivAOQBK7Fp7Bb6ftbGyqGaXtuaPWUkBxhZW5203IcnWpkBNpcbQlB7A1tkisGqWbQ==
X-Received: by 2002:a81:e243:: with SMTP id z3-v6mr10300664ywl.25.1538530420047;
        Tue, 02 Oct 2018 18:33:40 -0700 (PDT)
Received: from gabell.hsd1.ma.comcast.net (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5908556ywx.103.2018.10.02.18.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 18:33:39 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] x86/mm: Add a kernel parameter to change the padding used for the physical memory mapping
Date:   Tue,  2 Oct 2018 21:33:21 -0400
Message-Id: <20181003013323.4162-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003013323.4162-1-msys.mizuma@gmail.com>
References: <20181003013323.4162-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If each node of physical memory layout has huge space for hotplug,
the padding used for the physical memory mapping section is not enough.
For exapmle of the layout:

  SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
  SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
  SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
  SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

We can increase the padding via CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
however, the needed padding size depends on the system environment.
The kernel option is better than changing the config.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/include/asm/setup.h |  9 +++++++++
 arch/x86/mm/kaslr.c          | 22 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ae13bc9..1765a15 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -80,6 +80,15 @@ static inline unsigned long kaslr_offset(void)
 	return (unsigned long)&_text - __START_KERNEL;
 }
 
+#ifdef CONFIG_RANDOMIZE_MEMORY
+extern inline int __init get_rand_mem_physical_padding(void);
+#else
+static inline int __init get_rand_mem_physical_padding(void)
+{
+	return 0;
+}
+#endif
+
 /*
  * Do NOT EVER look at the BIOS memory size location.
  * It does not work on many machines.
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b..eb47f05 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+static int rand_mem_physical_padding __initdata = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -69,6 +70,25 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+inline int __init get_rand_mem_physical_padding(void)
+{
+	return rand_mem_physical_padding;
+}
+
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
@@ -102,7 +122,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		get_rand_mem_physical_padding();
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
-- 
2.18.0

