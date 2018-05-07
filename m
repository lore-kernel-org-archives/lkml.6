Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeEGBLA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 21:11:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40721 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeEGBK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 21:10:57 -0400
X-Google-Smtp-Source: AB8JxZoNSJzNnU+ig2K41jeAJeCCllqfnsWFuK15hq9ZIrVUnA0OcJW5uC6XlQ5TodM8j+CnZPsAwQ==
Subject: Re: [PATCH v8 0/6] optimize memblock_next_valid_pfn and
 early_pfn_valid on arm and arm64
To: Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Vacek <neelx@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
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
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <1523431317-30612-1-git-send-email-hejianet@gmail.com>
 <05b0fcf2-7670-101e-d4ab-1f656ff6b02f@gmail.com>
 <CACjP9X8bHmrxmd7ZPcfQq6Eq0Mzwmt0saOR3Ph53gp2n-dcKBQ@mail.gmail.com>
 <23b14717-0f4a-10f2-5118-7cb8445fbdab@oracle.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <448ad581-6635-e732-c49d-9240cdb385b5@gmail.com>
Date: Mon, 7 May 2018 09:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <23b14717-0f4a-10f2-5118-7cb8445fbdab@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/5/2018 12:53 AM, Pavel Tatashin Wrote:
>> I'm wondering, ain't simple enabling of config
>> DEFERRED_STRUCT_PAGE_INIT provide even better speed-up? If that is the
>> case then it seems like this series is not needed at all, right?
>> I am not sure why is this config optional. It looks like it could be
>> enabled by default or even unconditionally considering that with
>> commit c9e97a1997fb ("mm: initialize pages on demand during boot") the
>> deferred code is statically disabled after all the pages are
>> initialized.
> Hi Daniel,
>
> Currently, deferred struct pages are initialized in parallel only on NUMA machines. I would like to make a change to use all the available CPUs even on a single socket systems, but that is not there yet. So, I believe Jia's performance improvements are still relevant.
Thanks for the information. I checked the config in my armv8a server,
DEFERRED_STRUCT_PAGE_INIT has not been enabled yet.And my server is
single socket.

Cheers.
Jia
