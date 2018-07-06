Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C403C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC24620871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm5pdDs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC24620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeGFJCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:02:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36428 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGFJC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:02:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so7887885pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QS6x3jx7JXO4MmhHqS26Yxw1c+NSMSy4IGrnFynFgEQ=;
        b=Lm5pdDs9QXa+vQlbDY8tzb6VmT11HogGxmVTLSZVWXKjoApQH2S/8K6ey0OQti287R
         8Dj/ayQDJFJx0/3ChVNfMU6g1ro3FqNZsjmA5l1I/Js5Q7GFWwGDKJQPCNuYyd3idtv8
         sg1LFvAJI/t0LVmZm9rWTaELjUNpjntJ86f6GuNzveIFLq42qPu1DGcjkQGuPShAp3+4
         vN5qH1G0+utDojn+ROf51Tf64OY8Ymqqi7tOtEMfD0O8mc11+MYXM9gZBUGgHvM0cwl6
         AER7Jo6eIlTxCBFKkT+YaPjrgWc7BIvsQNUNu0eVD6JIfNUZYuzyzzcrocj+K5X7Br8J
         TztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QS6x3jx7JXO4MmhHqS26Yxw1c+NSMSy4IGrnFynFgEQ=;
        b=pASP0Rv6ShsZVdojajbcBrZ8PYL1uRJXvKHUhgAHiXMrATdk5yJLlkiwlSD/gD1sc0
         56Nex1rnhxknaWNQJRjaNlOvKh/PML27P0uGU6znU0ZGwrqKYSPpSi9jgtKApZ5Qz2aj
         GbsQQ1cY3OFnokhsZwlP5gAzObVC2IPHLacmOwkOvjGLbn1fMDaNV+RlXgjlUTpzOZI2
         3c+E5botdjSOsmD+H/1fXxwshLOScmI6ThczrOWG8+UOCP+O3UTzeDtpGc+Xba+bcbHo
         ps74/z9v3QZYBP/9es6nsNJse2CytdjpMcHVN2DFp6Y/BtrBaMEPAF3L8Ck/VGJSMGxh
         QNcw==
X-Gm-Message-State: APt69E0DX/OZKLXsKYqJbPCM2fQWSmbKP7NSFsX/wU1y711ZuWTVimKo
        t9/Q6hCpaw0ZWdnqjdMmeoo=
X-Google-Smtp-Source: AAOMgpdrQogf7Agsnn4Fhl1vyVKv8GHnUUkHWQWKrCYczG4NV7lTbP+FGOMEo+WNQawOegDtDjCUhg==
X-Received: by 2002:a65:654d:: with SMTP id a13-v6mr4046734pgw.132.1530867747711;
        Fri, 06 Jul 2018 02:02:27 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id e5-v6sm10837092pgs.59.2018.07.06.02.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:02:26 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [RESEND PATCH v10 4/6] mm/memblock: introduce memblock_search_pfn_regions()
Date:   Fri,  6 Jul 2018 17:01:13 +0800
Message-Id: <1530867675-9018-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper is to find the memory region index of input pfn.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h | 2 ++
 mm/memblock.c            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ca59883..b0f0307 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+int memblock_search_pfn_regions(unsigned long pfn);
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index 84f7fa7..c783b1a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1676,6 +1676,15 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
 	return -1;
 }
 
+/* search memblock with the input pfn, return the region idx */
+int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	int mid = memblock_search(type, PFN_PHYS(pfn));
+
+	return mid;
+}
+
 bool __init memblock_is_reserved(phys_addr_t addr)
 {
 	return memblock_search(&memblock.reserved, addr) != -1;
-- 
1.8.3.1

