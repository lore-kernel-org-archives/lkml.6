Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F5C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260FA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+c82aFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260FA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757385AbeFSVY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:24:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36673 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755457AbeFSVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:24:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so524619plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=2SN1+QVj2u6kpotc65bAell+KU/mT+txoqooXlBJNd0=;
        b=t+c82aFM8KsWXFbF/+tiOsmvkuZIORm7supe1pR3Cjahi2xMCHvUguw4ErfyWGoZtn
         B/urdh8c7m0aMJEO/0WFbglDCn3sJl+7Zw9fo8cRc25ihe8KedLhD9pJMCQTrZ5yoPwJ
         u+8cqZeEU2vtpAYov3Kby+jnaiskEwOA1I/cnglB4KminoheUN4iKPTKEbbNJrYIWEg/
         9eNvfLdy7zITqeInKfOI0gRKKNj2SAVX6gGEkmo7tvllfUthWdQ73bi4TI300/5NzM6H
         fveteT42viLFdSRthhkN/bkJVOfpRP5qmDbjs6PWUT5zHqPtOsmmYcVFGKGKLiXLAtrk
         ziog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=2SN1+QVj2u6kpotc65bAell+KU/mT+txoqooXlBJNd0=;
        b=YXdqeC96ThPWKchqyfLVhqHiMUIT+X77hq83MTQkwF5eXnkrx0GwAFpEGtELVD+s69
         zCZjtLrtQBSVA45dSlcmBTC8PjsABYDIfQfhkE3z+XrEqADLzleOWeN7qHULkdRMaKQ+
         2Q45NHXf6K/lZj/NtQD+vQT+pF1o3PQBEwPDTT+GogJMNFy/LP8YeHgiLlMrfkwzINhR
         qR2tZzYrlX2viB3ljQCdp1QO/b91xPGE67LPwxznzkL6mnoPjGM18s7dRRdDeAMxzsK1
         2GbFRjnRXpBO1iCjMY1M8YdB+ZzAY2X1rMO6Kdj+giKR38ofIvkRCKJsaW9Lt8RxbLA4
         s7WA==
X-Gm-Message-State: APt69E3V6ZbsFmUuAdjqMc7sVHLe3OFzDVrWUzV4w+bck2zZxwIg+COM
        JLvt0/mG7pyxnoMIasNUdZ4=
X-Google-Smtp-Source: ADUXVKL149OryxFg/M1CiMQ9OsJHGuwZ4qKIMKD1sWUDzSwVYnMnGPIFpZKevociRG/IemZm2vM5YQ==
X-Received: by 2002:a17:902:8549:: with SMTP id d9-v6mr5699308plo.81.1529443496303;
        Tue, 19 Jun 2018 14:24:56 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id t23-v6sm846203pfa.86.2018.06.19.14.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:24:55 -0700 (PDT)
From:   Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/5] arm64: mm: Add slow_virt_to_phys()
Date:   Tue, 19 Jun 2018 14:23:11 -0700
Message-Id: <1529443395-20874-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
References: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slow_virt_to_phys() function for ARM64 that parallels the same
function on x86/x64. This is needed by the architecture independent
Hyper-V VMbus driver at drivers/hv/channel.c.  The implementation
directly translates the virtual address using the ARM64 'at'
instruction.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
---
 arch/arm64/include/asm/memory.h |  6 ++++++
 arch/arm64/mm/pageattr.c        | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 49d9921..3f68dcf 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -265,6 +265,12 @@ static inline void *phys_to_virt(phys_addr_t x)
 }
 
 /*
+ * For memory where the underlying physical pages may not
+ * be contiguous.
+ */
+extern phys_addr_t slow_virt_to_phys(void *vaddr);
+
+/*
  * Drivers should NOT use these either.
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index a563593..8a42cac 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -19,6 +19,8 @@
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
+#include <asm/sysreg.h>
+#include <asm/barrier.h>
 
 struct page_change_data {
 	pgprot_t set_mask;
@@ -185,3 +187,38 @@ bool kernel_page_present(struct page *page)
 }
 #endif /* CONFIG_HIBERNATION */
 #endif /* CONFIG_DEBUG_PAGEALLOC */
+
+/*
+ * For virtual addresses where the underlyine physical memory may not be
+ * contiguous and the normal virt_to_phys gives the wrong result. This
+ * function does an actual translation using the 'at' instruction.
+ */
+phys_addr_t slow_virt_to_phys(void *virt_addr)
+{
+	phys_addr_t	result;
+	unsigned long	input = (unsigned long)virt_addr;
+	char		touch;
+	int		i;
+
+	/* Try up to 3 times (an arbitrary number) */
+	for (i = 0; i < 3; i++) {
+		/* Do the translation and check that it worked */
+		asm volatile("at s1e1r, %0" : : "r" (input));
+		isb();
+		result = read_sysreg(par_el1);
+		if (likely(!(result & 0x1)))
+			return (result & GENMASK_ULL(51, 12)) |
+				(input & GENMASK_ULL(11, 0));
+		/*
+		 * Something failed. Read the page to fault in anything
+		 * that isn't resident, then try again. "Anything"
+		 * could include the page itself or hypervisor page tables.
+		 */
+		touch = READ_ONCE(*(char *)input);
+		dmb(sy);
+	}
+
+	/* Let the caller sort it out. */
+	return  -1;
+}
+EXPORT_SYMBOL_GPL(slow_virt_to_phys);
-- 
1.8.3.1

