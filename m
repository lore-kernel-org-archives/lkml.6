Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37FFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58228217B4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j08/c2bX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58228217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeHVGa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:30:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35856 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:30:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so287434pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 20:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gKWS16jdzfXAD+G98kjPe+iqSsLmnu/5WshYoGJhp9Q=;
        b=j08/c2bXG/IDzydP+ckK37VLifklpleBpvCoU1sgxU0kxRe0/C0ZIGIiL96DsmdgEM
         crpEdfjxb9vUpP2BiW0ay7921Ryxn77/FsSS4WFPhrtRZlJ/04xFKSPXaYJfC8JwJPwk
         AbUaSj7aRZ5vIqgG3XEKJxHDfTDtPcjkVCC/JRdcmsQ4yKdk+gcFjVSYHDS6DAAlREx8
         bnVg8UxhFK03KU/ZlLPMn5lj/Y5PT1oRbdyGAFl4GF9JagghLVrW7JjlOUv+r99cVqkD
         TFe4Orf3dKMeO07d0ijE3O1pOjBk7enzUUF7/wxIuPddrd8Fnr/F1iVTfOKswyf99f5Z
         F74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gKWS16jdzfXAD+G98kjPe+iqSsLmnu/5WshYoGJhp9Q=;
        b=Rw5WPP4eoxwFeUeJLVIw7ZnNpB7pPCNaDm3UaNniXjYNjPyVQVjm3CgdxZ7YfbKkfx
         MF0hTVxOQMrMOsrauOW+zLCxuhbUvQrH9B7YKvGe0NAHegeRhKDbG2TtdOIsh+9VExIY
         SmaP9NHDvzfF6shZNnHA5v7aIwdLdL+pVSEGHMjHzcgmx78dTN3ZHzd40mHlRvjEchXj
         PO4Vf2716ilVbynxZ1nOn4M5miBTXU18dRqaVQpL8/XviXHEprtdyknA6HIdgdZYFDL5
         tSo6Xt1rED0AJT9n+3KeMOBYx1R/itiqqCVmlR2Ois83FSGQoulYxgRdlroaUi9MBVBT
         5CCg==
X-Gm-Message-State: AOUpUlE1uGcbyagocZK6u0z2cCDHTFRacM6GJYjNTGgFi7y+GyrmYfrL
        T23ZygNi3rZ1FNGNxsSLAPE=
X-Google-Smtp-Source: AA+uWPzKNhtszuCWsOs3l4LCJ6kKE+mMa8LyV1g3KzqU1LhA7P2OiPUVeOQlYHLPHbZf3uxeSsuThA==
X-Received: by 2002:a62:1157:: with SMTP id z84-v6mr55905319pfi.66.1534907257365;
        Tue, 21 Aug 2018 20:07:37 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id q7-v6sm440165pfq.43.2018.08.21.20.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 20:07:36 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
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
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on arm and arm64
Date:   Wed, 22 Aug 2018 11:07:14 +0800
Message-Id: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.

More from what Daniel said:
"On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines."

About the performance consideration:
As said by James in b92df1de5,
"I have tested this patch on a virtual model of a Samurai CPU with a
sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.

Besides we can remain memblock_next_valid_pfn, there is still some room
for improvement. After this set, I can see the time overhead of memmap_init
is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
memory, pagesize 64k). I believe arm server will benefit more if memory is
larger than TBs

Patch 1 introduces new config to make codes more generic
Patch 2 remains the memblock_next_valid_pfn on arm and arm64,this patch is
        originated from b92df1de5
Patch 3 optimizes the memblock_next_valid_pfn()

Changelog:
V11:- drop patch#4-6, refine the codes
V10:- move codes to memblock.c, refine the performance consideration
V9: - rebase to mmotm master, refine the log description. No major changes
V8: - introduce new config and move generic code to early_pfn.h
    - optimize memblock_next_valid_pfn as suggested by Matthew Wilcox
V7: - fix i386 compilation error. refine the commit description
V6: - simplify the codes, move arm/arm64 common codes to one file.
    - refine patches as suggested by Danial Vacek and Ard Biesheuvel
V5: - further refining as suggested by Danial Vacek. Make codes
      arm/arm64 more arch specific
V4: - refine patches as suggested by Danial Vacek and Wei Yang
    - optimized on arm besides arm64
V3: - fix 2 issues reported by kbuild test robot
V2: - rebase to mmotm latest
    - remain memblock_next_valid_pfn on arm64
    - refine memblock_search_pfn_regions and pfn_valid_region

Jia He (3):
  arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
  mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
  mm: page_alloc: reduce unnecessary binary search in
    memblock_next_valid_pfn

 arch/arm/Kconfig       |  1 +
 arch/arm64/Kconfig     |  1 +
 include/linux/mmzone.h |  9 +++++++++
 mm/Kconfig             |  3 +++
 mm/memblock.c          | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c        |  5 ++++-
 6 files changed, 69 insertions(+), 1 deletion(-)

-- 
1.8.3.1

