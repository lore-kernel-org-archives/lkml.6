Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDDOfF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:35:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39436 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeDDOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:35:04 -0400
X-Google-Smtp-Source: AIpwx48avEzDkuCmMNrkxYhDL1qBu1tLDNdLhjj+CZKGPaePNJmbBNCyVVWKOwC443htpsP4Pjva7w==
Subject: Re: [PATCH v6 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <jia.he@hxt-semitech.com>
References: <1522810579-7466-2-git-send-email-hejianet@gmail.com>
 <201804042156.YTVq2WAJ%fengguang.wu@intel.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <dbc4a381-c952-6806-ed0d-b2a33748e7ac@gmail.com>
Date: Wed, 4 Apr 2018 22:34:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201804042156.YTVq2WAJ%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, will fix it right now

Cheer,

Jia


On 4/4/2018 10:19 PM, kbuild test robot Wrote:
> Hi Jia,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on v4.16 next-20180403]
> [cannot apply to linus/master mmotm/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Jia-He/mm-page_alloc-remain-memblock_next_valid_pfn-on-arm-and-arm64/20180404-200732
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: i386-randconfig-x013-201813 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All error/warnings (new ones prefixed by >>):
>
>     In file included from include/linux/gfp.h:6:0,
>                      from include/linux/mm.h:10,
>                      from mm/page_alloc.c:18:
>     mm/page_alloc.c: In function 'memmap_init_zone':
>>> include/linux/mmzone.h:1299:28: error: called object is not a function or function pointer
>      #define next_valid_pfn (pfn++)
>                             ~~~~^~~
>>> mm/page_alloc.c:5349:39: note: in expansion of macro 'next_valid_pfn'
>       for (pfn = start_pfn; pfn < end_pfn; next_valid_pfn(pfn)) {
>                                            ^~~~~~~~~~~~~~
>
> vim +1299 include/linux/mmzone.h
>
>    1296	
>    1297	/* fallback to default defitions*/
>    1298	#ifndef next_valid_pfn
>> 1299	#define next_valid_pfn	(pfn++)
>    1300	#endif
>    1301	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Cheers,
Jia
