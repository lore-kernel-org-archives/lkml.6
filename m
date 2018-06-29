Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16427C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91FE27AEC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJNuAMqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91FE27AEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936531AbeF2Caa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:30:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39338 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934863AbeF2Ca2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:30:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id f3-v6so4177303qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNIVj8mcJRSFjcBxFmCRFF49bEt8xstenAEyW0ynDOk=;
        b=cJNuAMqYgKR6/ywwnfmcYs8TmmfnisDxpEtqVQvcMqxYjV8xnA4akS+ZZ6mm2XbCTm
         Mi691IRS30Ezbc3k+8ryL7i28Pj4Kbx6tflZisa//N6V5Pmgs3Tths9JgdO1/QavlFuM
         sG4bGizoS2gxT9S8Kll4g27oypwTBeG5avALJO9Lf/VQJxDnNVakvoVXkCl2TpBsuCmO
         U+8hytK8lnx88BaWFnr/Xai9wnQl+UgOdsLzr89a5eFJ5Kx4+K2M/lFSfiZcOqMUT4ES
         Q2msq0CCwi4Quypy/3gS50K8oT2rma4TwbIVbBfNw4p4wldd7bb82ZzHgrkAXax8S4/h
         E/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNIVj8mcJRSFjcBxFmCRFF49bEt8xstenAEyW0ynDOk=;
        b=sqB+ykvhzirhOSPe3vVBHv2D06XvqDrbxUAHGQ8szSCPP5GQil4HFI9xelmNmSrVzk
         msLp1HR6ajmOVcpHmB4z0MFPHISKX+Txg0TlU6DUcRAVqI2CrPubhDQkeyrA011CbKxY
         o92lW4dlqnmNlB8NqKOgMkEEcx7eVoA18B5RcVSWTo7rcu8ZUcmboK3TkwIg88jWl6sS
         fvwqaDgi9nk3HKX2V58Q3WnRRcc40fqjI2Q31lbnPqxxg1YnGD9ovJHTXaw2Zrord7dD
         CKwfw/qKAKZWGf8L3bwag4cVCGAlPg8Sspi7MyT6QxJxrNWXzi3XEqApfo/CSfLBFrr2
         WGCg==
X-Gm-Message-State: APt69E0zMeCZtwOGzBeEPzfNaj6xhbxlhLnfub/Gc9b0vvFu9Fomn6Wa
        gKLlD59/0qAwt24ZgSQdkq0=
X-Google-Smtp-Source: AAOMgpe+nWQI6ITpl1rEdIW/O5Q90VFlXNgX9jFJsFDW8Wls4wzWtbpF1gbX5jsE94qPZ9ToErJOZg==
X-Received: by 2002:ae9:e848:: with SMTP id a69-v6mr11395716qkg.161.1530239427234;
        Thu, 28 Jun 2018 19:30:27 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id y25-v6sm6390186qtc.48.2018.06.28.19.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 19:30:26 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
        Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
Date:   Fri, 29 Jun 2018 10:29:19 +0800
Message-Id: <1530239363-2356-3-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.

On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines.

And as verified by Eugeniu Rosca, arm can benifit from commit
b92df1de5d28. So it would  be better if we remain the
memblock_next_valid_pfn on arm/arm64 and move the related codes to
one file include/linux/early_pfn.h

Suggested-by: Daniel Vacek <neelx@redhat.com>
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/mm/init.c        |  1 +
 arch/arm64/mm/init.c      |  1 +
 include/linux/early_pfn.h | 34 ++++++++++++++++++++++++++++++++++
 include/linux/mmzone.h    | 11 +++++++++++
 mm/page_alloc.c           |  5 ++++-
 5 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/early_pfn.h

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c186474..aa99f4d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -25,6 +25,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
+#include <linux/early_pfn.h>
 
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 325cfb3..495e299 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -40,6 +40,7 @@
 #include <linux/mm.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
+#include <linux/early_pfn.h>
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
diff --git a/include/linux/early_pfn.h b/include/linux/early_pfn.h
new file mode 100644
index 0000000..1b001c7
--- /dev/null
+++ b/include/linux/early_pfn.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 HXT-semitech Corp. */
+#ifndef __EARLY_PFN_H
+#define __EARLY_PFN_H
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	unsigned int right = type->cnt;
+	unsigned int mid, left = 0;
+	phys_addr_t addr = PFN_PHYS(++pfn);
+
+	do {
+		mid = (right + left) / 2;
+
+		if (addr < type->regions[mid].base)
+			right = mid;
+		else if (addr >= (type->regions[mid].base +
+				  type->regions[mid].size))
+			left = mid + 1;
+		else {
+			/* addr is within the region, so pfn is valid */
+			return pfn;
+		}
+	} while (left < right);
+
+	if (right == type->cnt)
+		return -1UL;
+	else
+		return PHYS_PFN(type->regions[right].base);
+}
+EXPORT_SYMBOL(memblock_next_valid_pfn);
+#endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
+#endif /*__EARLY_PFN_H*/
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..57cdc42 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1241,6 +1241,8 @@ static inline int pfn_valid(unsigned long pfn)
 		return 0;
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
+
+#define next_valid_pfn(pfn)	(pfn + 1)
 #endif
 
 static inline int pfn_present(unsigned long pfn)
@@ -1266,6 +1268,10 @@ static inline int pfn_present(unsigned long pfn)
 #endif
 
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
+#ifdef CONFIG_HAVE_MEMBLOCK_PFN_VALID
+extern ulong memblock_next_valid_pfn(ulong pfn);
+#define next_valid_pfn(pfn)	memblock_next_valid_pfn(pfn)
+#endif
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1287,6 +1293,11 @@ struct mminit_pfnnid_cache {
 #define early_pfn_valid(pfn)	(1)
 #endif
 
+/* fallback to default definitions*/
+#ifndef next_valid_pfn
+#define next_valid_pfn(pfn)	(pfn + 1)
+#endif
+
 void memory_present(int nid, unsigned long start, unsigned long end);
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd3c7b9..607deff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5485,8 +5485,11 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn))
+		if (!early_pfn_valid(pfn)) {
+			pfn = next_valid_pfn(pfn) - 1;
 			continue;
+		}
+
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-- 
1.8.3.1

