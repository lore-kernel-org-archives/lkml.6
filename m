Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F71DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B363C23F40
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL8MA3EO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B363C23F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753791AbeGFJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:28:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46545 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeGFJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:27:59 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so2615877pld.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SLcMeywpHC+9GtZ8EVF9sseU0eBQCabkRiD6cDWVdgw=;
        b=eL8MA3EORoMee3WK3g7eAHc4tqhl3JcVBtqMf6fWlV5HvXt1ovNmJJjfWQZifwJTCi
         GkWvnes77y2vQFyHrIzV8EVaVs/e5MjP3taVjB7i+4OKl3l21QQgu9S1j02kPUkmJiNS
         dqGwI8M3Ss87ziCWOWb/c499E+9W3sE46Px2WdzirXoTfU/hNHCQI85CnW2IHxhQAGmJ
         i7XiRjyhN/vbJz1au7ya2Jn+KVpoaIl6tESrXGCCdwSaxR9Pz4A0IkNkXIDweVbLHJFL
         9/Ae5U5P5a+OoUwc4xAlm9A65q5RVNF7a/2jcHcAkQBR77EzpaV4UZWS8fENNk3a2J07
         GiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SLcMeywpHC+9GtZ8EVF9sseU0eBQCabkRiD6cDWVdgw=;
        b=Ce7+UMXUB7wFzUKtrLmb4tck/aEogjLej3GAu2NpGda7cR2oKybXaf6YOiISY3uIND
         68vQcovCvuto53ou1EiBgR7JhEw9IjkzOpDbeBvz53rcU8SHQ3vWswTa6Zxsilq95ZMj
         K7xBk6a61/LLTDTRZ7QcUf9rb0Tjj7vXyNbeIZOlZ1/9njt7eBKwDx9IOis2wsDheYY2
         S5wvFQxPOcrjGitmKVLwcrZ7K7XCCSMddvRU2ZeBk6YsvVGUwaU+AFlzYhWrUiI0jXhL
         pLhDG0gQQWwGe6L82n4bW4ytQRvkFE9/JUnuPnuNEFEgbRTokAoobw0e2J4bd4EtXU4d
         Gw5Q==
X-Gm-Message-State: APt69E1eSoVL/cJ5lJUMuXTaKDpjcnf8Cd57pId7mvuJJTXFZLltgnnZ
        uEAn1//Md1JVmQNxX0jgWeM=
X-Google-Smtp-Source: AAOMgpdM2+8gnkruJJYP7MQC4C1VWWLOh04VnkYCbBuVEg2Tv04Xl4+UNXopcthapHaIB3kOATqESQ==
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr9638523plc.294.1530869279279;
        Fri, 06 Jul 2018 02:27:59 -0700 (PDT)
Received: from [0.0.0.0] (65.49.234.56.16clouds.com. [65.49.234.56])
        by smtp.gmail.com with ESMTPSA id l28-v6sm18423664pfi.4.2018.07.06.02.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:27:58 -0700 (PDT)
Subject: Re: [PATCH v10 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
To:     Jia He <hejianet@gmail.com>, Russell King <linux@armlinux.org.uk>,
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
        Jia He <jia.he@hxt-semitech.com>
References: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
From:   Jia He <hejianet@gmail.com>
Message-ID: <bd0a48b6-0a1d-79cc-0985-16a808aaf824@gmail.com>
Date:   Fri, 6 Jul 2018 17:27:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530864860-7671-1-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my mistake, I have to resend this set because I missed some
important maillists. Please ignore this thread.
Terribly sorry about it

Cheers，
Jia

On 7/6/2018 4:14 PM, Jia He Wrote:
> From: Jia He <jia.he@hxt-semitech.com>
> 
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
> 
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
> 
> More from what Daniel said:
> "On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines."
> 
> About the performance consideration:
> As said by James in b92df1de5,
> "I have tested this patch on a virtual model of a Samurai CPU with a
> sparse memory map.  The kernel boot time drops from 109 to 62 seconds."
> Thus it would be better if we remain memblock_next_valid_pfn on arm/arm64.
> 
> Besides we can remain memblock_next_valid_pfn, there is still some room
> for improvement. After this set, I can see the time overhead of memmap_init
> is reduced from 27956us to 13537us in my armv8a server(QDF2400 with 96G
> memory, pagesize 64k). I believe arm server will benefit more if memory is
> larger than TBs
> 
> Patch 1 introduces new config to make codes more generic
> Patch 2 remains the memblock_next_valid_pfn on arm and arm64,this patch is
> 	originated from b92df1de5
> Patch 3 optimizes the memblock_next_valid_pfn()
> Patch 4~6 optimizes the early_pfn_valid()
> 
> Changelog:
> V10:- move codes to memblock.c, refine the performance consideration
> V9: - rebase to mmotm master, refine the log description. No major changes
> V8: - introduce new config and move generic code to early_pfn.h
>     - optimize memblock_next_valid_pfn as suggested by Matthew Wilcox
> V7: - fix i386 compilation error. refine the commit description
> V6: - simplify the codes, move arm/arm64 common codes to one file.
>     - refine patches as suggested by Danial Vacek and Ard Biesheuvel
> V5: - further refining as suggested by Danial Vacek. Make codes
>       arm/arm64 more arch specific
> V4: - refine patches as suggested by Danial Vacek and Wei Yang
>     - optimized on arm besides arm64
> V3: - fix 2 issues reported by kbuild test robot
> V2: - rebase to mmotm latest
>     - remain memblock_next_valid_pfn on arm64
>     - refine memblock_search_pfn_regions and pfn_valid_region
> 
> Jia He (6):
>   arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
>   mm: page_alloc: remain memblock_next_valid_pfn() on arm/arm64
>   mm: page_alloc: reduce unnecessary binary search in
>     memblock_next_valid_pfn()
>   mm/memblock: introduce memblock_search_pfn_regions()
>   mm/memblock: introduce pfn_valid_region()
>   mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
> 
>  arch/arm/Kconfig         |  4 +++
>  arch/arm64/Kconfig       |  4 +++
>  include/linux/memblock.h |  2 ++
>  include/linux/mmzone.h   | 16 +++++++++
>  mm/Kconfig               |  3 ++
>  mm/memblock.c            | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/page_alloc.c          |  5 ++-
>  7 files changed, 117 insertions(+), 1 deletion(-)
> 

-- 
Cheers,
Jia
