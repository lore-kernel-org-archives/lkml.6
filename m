Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A5623DA1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+lmnKZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A5623DA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeFVGIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:08:17 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35994 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFVGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:08:16 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so2493409pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=NjyTWEyy0AoCvGb9aqCqlmmYgtHs+UdfgBefCp6X4cc=;
        b=I+lmnKZ/qDnRbbNl5qIau8OOzWT5LoBNZupG4yLLHwc8UbDubKUHKZZPXBuBsVrRU1
         dcXZjl/z+uctB/5HniigBzIeY8ZQI++nuiCVC3tL1BxardeZ3B6oF0hIq2JbCXk7/DN3
         6sLp3doTV8kpL0uXOtr/Q3IMlD9dWJXEv2u29ZbawDgE9ABievEoTABxtxtkjyPmrjed
         WzAKUPkrfL1O7h4YGufx3Pmh5hFKR/sFct0j5O/RXQ/M2mRNwr2Elm5Dwsjb/o0E29An
         P1K0H15g2MPzoKgGH+XJVGr09tYsHrv8LspWZN5NjTmvt5pK+FMkMnvwNsZrh0kkgiOo
         +Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=NjyTWEyy0AoCvGb9aqCqlmmYgtHs+UdfgBefCp6X4cc=;
        b=cunF2lEPRNBzkoBvLiOFNfXw0gcqIJVVL347SSwSx1IG0woHqk5tAtOk/OlyhJGqEx
         Wmf0dy8tjnCvTTTb+jmx4mouf+jMdzyC5MyUtBycUaLaLoBECnGDE8MWeEG7Mw22OuLB
         8cfsZTX/FHtjvwR55K1r2ZwDK9IIZ0o4sHFu+0c5gEBlEZDTX1qNcR7jRgESkdOOkJp2
         ldntgfLGxZ8JSHDj6g5swrJfKN0v0JHgQqLQ8aUiGogUOI2XiBuqG9XqTAID0e3loBV4
         uFZ1Jy191lhVArRDyjJmHn7na2qzLeGQNdvsSLb3yV2gegNnfS9G8had9wgtkY/FCNf/
         /kzw==
X-Gm-Message-State: APt69E2qfavcamdd+y9fizeUmAA0+ikAKBNFiM0qoIxy7VFnN7QIam1C
        Hq1dj4A/zBMfn57dRTRGIw==
X-Google-Smtp-Source: ADUXVKIbQGCSDb6nq4KaW2Am68zbO3uDGuh9+1Exlu5dQtaikpNXAqwti9ZqOuO1Fq2TT6/HPPE9hA==
X-Received: by 2002:a62:50d6:: with SMTP id g83-v6mr299751pfj.31.1529647695965;
        Thu, 21 Jun 2018 23:08:15 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id g78-v6sm11916196pfe.39.2018.06.21.23.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 23:08:14 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v1] mm: initialize struct page for reserved pages in ZONE_DEVICE
Date:   Fri, 22 Jun 2018 15:08:03 +0900
Message-Id: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/kpageflags for pfns allocated by pmem namespace triggers
kernel panic with a message like "BUG: unable to handle kernel paging
request at fffffffffffffffe".

The first few pages (controlled by altmap passed to memmap_init_zone())
in the ZONE_DEVICE can skip struct page initialization, which causes
the reported issue.

This patch simply adds some initialization code for them.

Fixes: 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment vmemmap_populate()")
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/page_alloc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
index 1772513..0b36afe 100644
--- v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c
+++ v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
@@ -5574,8 +5574,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	 * Honor reservation requested by the driver for this ZONE_DEVICE
 	 * memory
 	 */
-	if (altmap && start_pfn == altmap->base_pfn)
+	if (altmap && start_pfn == altmap->base_pfn) {
+		unsigned long i;
+
+		for (i = 0; i < altmap->reserve; i++) {
+			page = pfn_to_page(start_pfn + i);
+			__init_single_page(page, start_pfn + i, zone, nid);
+			SetPageReserved(page);
+		}
 		start_pfn += altmap->reserve;
+	}
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		/*
-- 
2.7.0

