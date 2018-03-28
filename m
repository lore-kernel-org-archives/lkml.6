Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522203053; cv=none;
        d=google.com; s=arc-20160816;
        b=azf++A7uv6UcRTW9ZwfiQl5symiUGGkQGtTiwyXWkFoFo1vmDv8+/ITFZjmXlxvOlU
         RMpONcn+N3/qJCGCK0LRBf0DETTi0ircZHE5bwVjYBHsRAEnmEhlRn3/mfsDFZx5e2KH
         dDXpJ7WpSxhCbIwAaRCkivyqfonnTKLz5luln/OHmco6YPiEEueb3VgdEMUCecLPVpVm
         ilkMHFlvq1XGmOyP0yvBWl8m4MSsDA9Rn5j5Ii0IHPtuArLhfd6oygqQoLLVxFGW84ey
         h3zmcHKdg3CuKT518Ryi+hXZJtHL/fXnFrIwJCdEFcWHJDAU5ExlKXIOe2FjeQIbwWn+
         6mEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=pM6Zr7JvJiK2VjNOxIPe2Q1usvS6zA6cJdptKQ73/Ck=;
        b=nj7dxklwxukTW3a+ngw6mRudEUkI7ssRSQ3VB0j0Rw6XMvWHc6e2ux2EiSvdFt0xnl
         2ctG14eDqz85Wq2xiTykc3MJ/kI+ETXjIUGIsSjZDo0n4hzKmYusMD6FSHEh3NXgvkY7
         ILQGRrPZfWlehJL3biTt+/AkQHqN7wdXIdTo3812xJ05fVkqWlDaDyJOTKNzG/MvwnbU
         +pZALy84YFlidj5BghWTi+sRKl4e7R4TTM1JO28rcSTsInUBcsXn9W7Vy6XWWCCApNrY
         pAuXy82Xd7c2QYtfzFcfNecy5wHPaM/wzoL/lCxLpFQzdaUbo3g2ZSRh9hyVG/QcHy0G
         LxwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gnlxmqh2;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gnlxmqh2;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48uEsmVYTAyKWQoAV4RBTMH/krBhI0DAp7a0BMIUXWbA5Jse1PSZgPTgtgIlK/r673pifnBaA==
Subject: Re: [PATCH v3 5/5] mm: page_alloc: reduce unnecessary binary search
 in early_pfn_valid()
To: Daniel Vacek <neelx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Pavel Tatashin
 <pasha.tatashin@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Gioh Kim <gi-oh.kim@profitbricks.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Vlastimil Babka <vbabka@suse.cz>,
 open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Steve Capper <steve.capper@arm.com>,
 x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemi Wang <kemi.wang@intel.com>,
 Petr Tesarik <ptesarik@suse.com>, YASUAKI ISHIMATSU
 <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
 <1522033340-6575-6-git-send-email-hejianet@gmail.com>
 <CACjP9X_MNrL_4VdR+oMVb4nAfwAmWrUy-cK88V_i0ft71S2bJA@mail.gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <55b15841-bac7-7576-6da8-edff0fe0e9b2@gmail.com>
Date: Wed, 28 Mar 2018 10:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X_MNrL_4VdR+oMVb4nAfwAmWrUy-cK88V_i0ft71S2bJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967726824287600?=
X-GMAIL-MSGID: =?utf-8?q?1596145588780757615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/28/2018 1:51 AM, Daniel Vacek Wrote:
> On Mon, Mar 26, 2018 at 5:02 AM, Jia He <hejianet@gmail.com> wrote:
>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>> where possible") optimized the loop in memmap_init_zone(). But there is
>> still some room for improvement. E.g. in early_pfn_valid(), if pfn and
>> pfn+1 are in the same memblock region, we can record the last returned
>> memblock region index and check check pfn++ is still in the same region.
>>
>> Currently it only improve the performance on arm64 and will have no
>> impact on other arches.
>>
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> ---
>>   arch/x86/include/asm/mmzone_32.h |  2 +-
>>   include/linux/mmzone.h           | 12 +++++++++---
>>   mm/page_alloc.c                  |  2 +-
>>   3 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mmzone_32.h b/arch/x86/include/asm/mmzone_32.h
>> index 73d8dd1..329d3ba 100644
>> --- a/arch/x86/include/asm/mmzone_32.h
>> +++ b/arch/x86/include/asm/mmzone_32.h
>> @@ -49,7 +49,7 @@ static inline int pfn_valid(int pfn)
>>          return 0;
>>   }
>>
>> -#define early_pfn_valid(pfn)   pfn_valid((pfn))
>> +#define early_pfn_valid(pfn, last_region_idx)  pfn_valid((pfn))
>>
>>   #endif /* CONFIG_DISCONTIGMEM */
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index d797716..3a686af 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1267,9 +1267,15 @@ static inline int pfn_present(unsigned long pfn)
>>   })
>>   #else
>>   #define pfn_to_nid(pfn)                (0)
>> -#endif
>> +#endif /*CONFIG_NUMA*/
>> +
>> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
>> +#define early_pfn_valid(pfn, last_region_idx) \
>> +                               pfn_valid_region(pfn, last_region_idx)
>> +#else
>> +#define early_pfn_valid(pfn, last_region_idx)  pfn_valid(pfn)
>> +#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>>
>> -#define early_pfn_valid(pfn)   pfn_valid(pfn)
>>   void sparse_init(void);
>>   #else
>>   #define sparse_init()  do {} while (0)
>> @@ -1288,7 +1294,7 @@ struct mminit_pfnnid_cache {
>>   };
>>
>>   #ifndef early_pfn_valid
>> -#define early_pfn_valid(pfn)   (1)
>> +#define early_pfn_valid(pfn, last_region_idx)  (1)
>>   #endif
>>
>>   void memory_present(int nid, unsigned long start, unsigned long end);
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0bb0274..debccf3 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5484,7 +5484,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>                  if (context != MEMMAP_EARLY)
>>                          goto not_early;
>>
>> -               if (!early_pfn_valid(pfn)) {
>> +               if (!early_pfn_valid(pfn, &idx)) {
>>   #if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
>>                          /*
>>                           * Skip to the pfn preceding the next valid one (or
>> --
>> 2.7.4
>>
> Hmm, what about making index global variable instead of changing all
> the prototypes? Similar to early_pfnnid_cache for example. Something
> like:
>
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> extern int early_region_idx __meminitdata;
> #define early_pfn_valid(pfn) \
>                                 pfn_valid_region(pfn, &early_region_idx)
> #else
> #define early_pfn_valid(pfn)  pfn_valid(pfn)
> #endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>
> And move this to arch/arm64/include/asm/page.h ?
>
> --nX
>
Yes. ok with me

-- 
Cheers,
Jia
