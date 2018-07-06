Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FF3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8226C23F4C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL6xuEtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8226C23F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeGFIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:15:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38576 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753610AbeGFIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:15:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7792863pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QS6x3jx7JXO4MmhHqS26Yxw1c+NSMSy4IGrnFynFgEQ=;
        b=qL6xuEtOi873cJNN8yBFvJs5J2KPvYVlz1Exa+eLyhmIEjv/WSJKIC6UsN2mTjk0gb
         6VOJSC6G22XEXdGatJt1pAnK4aFIpWi0l87jpTuZv/EknzJvhQZWQlpQmejXePFo1SCO
         zD18mecVcXhK138YJrjVVvUEUWXjb7055rOeK/QiQY/MGxOhaol0DZpTey0HISdu0SA0
         l/flRC4G8+bi2PcqbNkWtL3lHzG+L8zfOT84LzURF86Lq19lk1k1VOaVE9aQUjh79a4S
         QN7xTAuVW8cgEdi7KeiA7PmgRlJDYAttAVYyBBXSpZ7DMuvoWBQIw2r08InQcyUVu/2u
         BkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QS6x3jx7JXO4MmhHqS26Yxw1c+NSMSy4IGrnFynFgEQ=;
        b=S16rzW9K4WHyQ1VG357S3aLMThxRjFBG5ZBy3qnDO0g7j51Z0hocRN7e7od2cgwyyu
         BLfYKQUl6ox3FsAWyEpaOHzs3Vf75fiQgX+Krn31FpkCNl96qF6HN6p/0O5yTfCJtuCe
         lj8QKf1b0J4zaXrd4db+xFp7Rt7600pk7qph5o6U2lmf8WevsHbHAkHv97WSRawWBjAx
         EoURBhb3Rv6Z8Ft2aKVA7xTx4ca89Go9854gncOhI10cYiNw3sO+ERX7ZxzVu2UglJvM
         vwD/Lx4NGe5nnBYhnW4qAa0jemNHZQNfG+7N7aBUe/NccNWPU39Xyplj81ELmlU7wFWD
         HuVA==
X-Gm-Message-State: APt69E0Heh1M93nQ7Gg7U7SWIhEMR7veJS+RP+3VVIcHWBX0l/xAuLO2
        O6RqIbRAHuktq4PxOmZ5ge0=
X-Google-Smtp-Source: AAOMgpcLe2k9iOOlEKpuznSMye/t44iTuqQYI3UOihRsRGGhobmGVIcWWnjOOdQXe6YrLHkoCIKV9w==
X-Received: by 2002:a63:b256:: with SMTP id t22-v6mr8810324pgo.101.1530864939054;
        Fri, 06 Jul 2018 01:15:39 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id c141-v6sm4673049pfc.25.2018.07.06.01.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 01:15:38 -0700 (PDT)
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
Subject: [PATCH v10 4/6] mm/memblock: introduce memblock_search_pfn_regions()
Date:   Fri,  6 Jul 2018 16:14:18 +0800
Message-Id: <1530864860-7671-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
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

