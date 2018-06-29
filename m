Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD2DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A92927AF3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9w8Uoas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92927AF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030520AbeF2CbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:31:02 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35547 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933679AbeF2Ca7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:30:59 -0400
Received: by mail-qk0-f194.google.com with SMTP id u21-v6so4187454qku.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 19:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=djDu+PIa1upI/bAjFRM2i263LjHkgnzhYw9JJWjbmtY=;
        b=k9w8Uoas56o/7k1a6DbvlCedX3G0Nf50HUQpQwtKHxqTFO3HXjEVRKSiwKhGpA3pTo
         0HJylj0h00QYT8cdQffYKC+1hdjPILfFYkvysBet1CefgKoD7RBvWczxEmF4hpjnLPMp
         l0jVQzOG3XGn9sCN2It8XP0gVWG1CL3sgOug4BQgELk1/4CZLW4wkZ4rw+Rd9nBGeXlm
         zEQ9ATXJt+3HRwGMlBScdCzBLdeEZZdCkHC7gxs7ZtTyxu6DTW5NL7hHlmIGmK0Q1R3J
         uWPtt0pX/2f68HDbOvtRcTgbZEG22fOet7kCeqrmGcBzTVI+Ekwty2cq2X3cCdEDX2EW
         sPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=djDu+PIa1upI/bAjFRM2i263LjHkgnzhYw9JJWjbmtY=;
        b=r5CiHdcdzNhLJ6OKzLMT9wHhqa21V9dxBQ9Z6kTrTN6TJvZAiilOL7IWpCEXVFMv6f
         sfDgpMvIVgUhYaKkvZWbENhu/rDAQpGRVITrt7aaxucEZGCUKHksBvKDW8ay0N0zC2NN
         WjLsRMS9opwsdwDs3YQR9Ia/Hi/1UL2MaLRrKj3RbTFJHKUo4dn7oPZqAz4EQdqUJWl6
         01F1cTQOI1hGce8P5Ks9iscQJWCheWdTPHvKpELvwWtrkHY+xs6jCfCQcYimVGBf79Q8
         0x/f6QvgAQc5+APiiVthhe774i1gWXghDe/7nJ7Q8ecQKBvLQqxGoo65yQzJQrIRWqFG
         mqIg==
X-Gm-Message-State: APt69E0v8qTphuMnMLUC9XA0FtddMkOl8bGzDNtkqzMUp/ZrrsdvWICy
        c8zC6yFtJ39idFx+WAVvtSQ=
X-Google-Smtp-Source: AAOMgpfiutho23lmYXN4eaiiYCChQWv1fAMYnDZiD/V16f8Gxbjiwq9ag4dMv7HuyBuB3cZiy8V8cQ==
X-Received: by 2002:a37:13e6:: with SMTP id 99-v6mr11106848qkt.252.1530239459275;
        Thu, 28 Jun 2018 19:30:59 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id y25-v6sm6390186qtc.48.2018.06.28.19.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 19:30:58 -0700 (PDT)
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
Subject: [PATCH v9 5/6] arm: arm64: introduce pfn_valid_region()
Date:   Fri, 29 Jun 2018 10:29:22 +0800
Message-Id: <1530239363-2356-6-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), we can record
the last returned memblock region. If current pfn and last pfn are in the
same memory region, we needn't do the unnecessary binary searches because
memblock_is_nomap is the same result for whole memory region.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/early_pfn.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/early_pfn.h b/include/linux/early_pfn.h
index f9e40c3..9609391 100644
--- a/include/linux/early_pfn.h
+++ b/include/linux/early_pfn.h
@@ -51,5 +51,29 @@ ulong __init_memblock memblock_next_valid_pfn(ulong pfn)
 	return PHYS_PFN(regions[early_region_idx].base);
 }
 EXPORT_SYMBOL(memblock_next_valid_pfn);
+
+int pfn_valid_region(ulong pfn)
+{
+	ulong start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
+
+	if (early_region_idx != -1) {
+		start_pfn = PFN_DOWN(regions[early_region_idx].base);
+		end_pfn = PFN_DOWN(regions[early_region_idx].base +
+					regions[early_region_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(
+					&regions[early_region_idx]);
+	}
+
+	early_region_idx = memblock_search_pfn_regions(pfn);
+	if (early_region_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&regions[early_region_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
 #endif /*CONFIG_HAVE_MEMBLOCK_PFN_VALID*/
 #endif /*__EARLY_PFN_H*/
-- 
1.8.3.1

