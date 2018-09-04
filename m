Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45469C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF82082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImjVzBme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeIDTh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:37:27 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39455 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIDTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:37:27 -0400
Received: by mail-qt0-f194.google.com with SMTP id o15-v6so4343680qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dnWXI/sa66EZOxNCWqs3PPSXlFN/e61cI3IbK0Sz4BY=;
        b=ImjVzBmeg5+UrRuSeZvza+hdYTESfaf+uZ2EvIC9TibXyFHpb4t/mJZdOyYvTCiSM/
         Yl9qGs7qEo62+UoG5rCUnNG8TWlzwE/39nNRNbefEv/hjwma92OEnok1WhxuPOLpn8kd
         19ixAQXhbmFiEZxeEFuCrbr5sFhgr/HGxfeNENAVSBE7uNDUdVaKfjE6HUUeaq/Yk4cp
         4AubBf8UlFudeaAKz3zZYeBRTwkUAk1zFf85bx1ABJvGryKCCwrQqLYBtCgPVmKAt8To
         Bdj3Vnl1faNXZWDwnwPA/AdXftG1iZNZoUktil8SUaW+h9RAcClr+1F8KXzqK0m3j7fB
         mfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dnWXI/sa66EZOxNCWqs3PPSXlFN/e61cI3IbK0Sz4BY=;
        b=uk3mHH+MusdQP5H3v3ULsnh4VYHn/3CP/DO8lmtXuZwpXTY9zx/oNr64ampCIH17Z7
         nwK949KRBq+VdgwZ8hzxnzWkUaf9o9S/77LDEjHIz3C7+S1/23pUVJ01+vcgPHRnPzq5
         xxYLE0wFnz5v8ymBpMy9eQIF5+DjdxVpW+3agMwLSPd28n2/c8OCvaknVbvHZ8Cu2lZv
         im0l/F2rMnxAPeI2icbCRsaePHsdTyFLntxi7A5AQ7vr+1SOL5XiwAPy2bn/lJ0MYZFX
         4zsblyTWPtXv9Eu2XaUGEzXsMvQlg6Y9LbKNzpMVMWLpyUWCL0gunYsTGD4bJe1B0rmn
         rsPw==
X-Gm-Message-State: APzg51DqsgXkvHJBewYQoEKjzYM/KIyz814QbOLA1R7BjjGLDEEg5XWQ
        o5C3aLzJpgheL2wwCi/X9Q==
X-Google-Smtp-Source: ANB0VdZ0iJrce7psDK35G8yngoIze4FymH1HnWx/qblp/tSK9oPMGT0LTq4EEz+C1hRh5W+oQVGpnw==
X-Received: by 2002:a0c:acad:: with SMTP id m42-v6mr29025555qvc.27.1536073916835;
        Tue, 04 Sep 2018 08:11:56 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u72-v6sm13215237qki.89.2018.09.04.08.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:11:56 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: [PATCH v3 1/2] x86/mm: Add an option to change the padding used for the physical memory mapping
Date:   Tue,  4 Sep 2018 11:11:40 -0400
Message-Id: <20180904151141.20264-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Change log from v2:
 - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
   but a little different. Remove SGI UV description.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b0eda9..aeb62615bd46 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
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

