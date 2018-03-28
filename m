Return-Path: <dvacek@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522233770; cv=none;
        d=google.com; s=arc-20160816;
        b=fdBciXKeoVDmfyZ6l75MCQMVkEjNtHyYMSf1GAkBW9orP2uO5b3G0bSwx3vflQXwvx
         2cz0gakUiN3+PReFv6SntK3KvyNGlx2E4ockyQkYFGJV65eBMOWFqTkHOMv7a0Z/S84h
         WAs2vK/MV3DFPU9g97WAu51/yah5iVcr/SQaVdFSK+7Uv4zGgYdbTK0XIbt9q4VB2aY3
         uDxR4/IojEAnThvATwfMfM/no62qNbmPVtUvRJBKQg1rOJs82EqclfuZ86Z7NvwZpUXd
         NPWFETGAs2QRglxgtTqcSotjMoKFepUb4ysP+tTuJB/OOxyjHnguDGQBBUbJsOmpDw0O
         6MsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=jhhQizLf3pKzV0BrT8sr1wus03yaC6qTXwtH+YATOJo=;
        b=bGwz3H0ukJd32DZgKlJmPnpLsPaAPepYgzRJRcx1xuAGC7c6Sw4fC4QtIqf0im/bO+
         GDaD06enSn02m0pzGgv7gy/+XYakAMYXrp4ZP6ZUf03QqwAH8DU5WfgsjOckgwSE+2ih
         m6+tvzfqTf5ZKoXwec+5BxnIO9WM/74Xz4GIbI8ex+LoBKW0uz56tUMoHKakcfp5DIdY
         /9rrfhKaVN2mO20rXJPwVrOVHhx2tzVosmbQ0axVIg6R7huFlSlDTJSDaOAjPxmqaaMW
         yISkHEvo5A4fdDWRN+hGtEtdXMNB3RcFktAi8q0BVNwvIXRhJqDif2kXNKavm2FQwmMi
         ocLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49O2BLk2C1V48+OStBP2wlHWZMhYSAnmXzg8D8p6KZgUUkofB7ZDTphqmK2Tx0J9V/zT+JtVjOg67faPvLEmc4=
MIME-Version: 1.0
In-Reply-To: <113cb8cf-7c59-4fbb-5ad2-4ae6eeb1193c@gmail.com>
References: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
 <1521894282-6454-2-git-send-email-hejianet@gmail.com> <CACjP9X-zvGa5OQpuJ1bUp+V=_eTOUDLfKkT1sbT84k5zJz=epA@mail.gmail.com>
 <113cb8cf-7c59-4fbb-5ad2-4ae6eeb1193c@gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Wed, 28 Mar 2018 12:42:49 +0200
Message-ID: <CACjP9X8_=ZsM9fK51+EdTGLLq2izfBBaGnPiPbuBV2TYPhEPyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 when CONFIG_HAVE_ARCH_PFN_VALID is enable
To: Jia He <hejianet@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>, open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	James Morse <james.morse@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steve Capper <steve.capper@arm.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>, Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>, Jia He <jia.he@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595821857199891353?=
X-GMAIL-MSGID: =?utf-8?q?1596177797820607377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:26 AM, Jia He <hejianet@gmail.com> wrote:
>
>
> On 3/28/2018 12:52 AM, Daniel Vacek Wrote:
>>
>> On Sat, Mar 24, 2018 at 1:24 PM, Jia He <hejianet@gmail.com> wrote:
>>>
>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>> where possible") optimized the loop in memmap_init_zone(). But it causes
>>> possible panic bug. So Daniel Vacek reverted it later.
>>>
>>> But memblock_next_valid_pfn is valid when CONFIG_HAVE_ARCH_PFN_VALID is
>>> enabled. And as verified by Eugeniu Rosca, arm can benifit from this
>>> commit. So remain the memblock_next_valid_pfn.
>>
>> It is not dependent on CONFIG_HAVE_ARCH_PFN_VALID option but on
>> arm(64) implementation of pfn_valid() function, IIUC. So it should
>> really be moved from generic source file to arm specific location. I'd
>> say somewhere close to the pfn_valid() implementation. Such as to
>> arch/arm{,64}/mm/ init.c-ish?
>>
>> --nX
>
> Hi Daniel
> I didn't catch the reason why "It is not dependent on
> CONFIG_HAVE_ARCH_PFN_VALID option but
> on arm(64) implementation of pfn_valid() function"? Can you explain more
> about it? Thanks

Arm implementation of pfn_valid() is actually based on memblock as
HAVE_MEMBLOCK is mandatory for arm so memblock is guaranteed to always
be available, IIUC. Correct me if I am wrong here.
With that said, you are fine with using memblock to skip gaps and
finding next valid frame.

Though the generic version of pfn_valid() is based on mem sections and
memblock_next_valid_pfn() does not always return the next valid one
but skips more resulting in some valid frames to be skipped (as if
they were invalid). And that's why kernel was eventually crashing on
some !arm machines.

Now, if any other architecture defines CONFIG_HAVE_ARCH_PFN_VALID and
implements it's own version of pfn_valid(), there is no guarantee that
it will be based on memblock data or somehow equivalent to the arm
implementation, right?

At this moment only arm implements CONFIG_HAVE_ARCH_PFN_VALID. Maybe
it could be generalized to something like CONFIG_MEMBLOCK_PFN_VALID
and moved to generic code. And then you can base your changes on that.
But I am not sure if that is possible.

> What's your thought if I changed the codes as followed?
> in include/linux/memblock.h
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
> extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
> #else
> #define memblock_next_valid_pfn(pfn) (pfn + 1)
> #endif

I think I'd rather do something like this:

                if (!early_pfn_valid(pfn)) {
                        pfn = skip_to_last_invalid_pfn(pfn);
                        continue;
                }

And than for arm define:

#if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn,
&early_idx) - 1)
#endif

And for the generic fallback:

#ifndef skip_to_last_invalid_pfn
#define skip_to_last_invalid_pfn(pfn) (pfn)
#endif

--nX

> Cheers,
> Jia
>
>>
>>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>>> ---
>>>   include/linux/memblock.h |  4 ++++
>>>   mm/memblock.c            | 29 +++++++++++++++++++++++++++++
>>>   mm/page_alloc.c          | 11 ++++++++++-
>>>   3 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> index 0257aee..efbbe4b 100644
>>> --- a/include/linux/memblock.h
>>> +++ b/include/linux/memblock.h
>>> @@ -203,6 +203,10 @@ void __next_mem_pfn_range(int *idx, int nid,
>>> unsigned long *out_start_pfn,
>>>               i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end,
>>> p_nid))
>>>   #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>>
>>> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
>>> +unsigned long memblock_next_valid_pfn(unsigned long pfn);
>>> +#endif
>>> +
>>>   /**
>>>    * for_each_free_mem_range - iterate through free memblock areas
>>>    * @i: u64 used as loop variable
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index ba7c878..bea5a9c 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -1102,6 +1102,35 @@ void __init_memblock __next_mem_pfn_range(int
>>> *idx, int nid,
>>>                  *out_nid = r->nid;
>>>   }
>>>
>>> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
>>> +unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>>> +{
>>> +       struct memblock_type *type = &memblock.memory;
>>> +       unsigned int right = type->cnt;
>>> +       unsigned int mid, left = 0;
>>> +       phys_addr_t addr = PFN_PHYS(++pfn);
>>> +
>>> +       do {
>>> +               mid = (right + left) / 2;
>>> +
>>> +               if (addr < type->regions[mid].base)
>>> +                       right = mid;
>>> +               else if (addr >= (type->regions[mid].base +
>>> +                                 type->regions[mid].size))
>>> +                       left = mid + 1;
>>> +               else {
>>> +                       /* addr is within the region, so pfn is valid */
>>> +                       return pfn;
>>> +               }
>>> +       } while (left < right);
>>> +
>>> +       if (right == type->cnt)
>>> +               return -1UL;
>>> +       else
>>> +               return PHYS_PFN(type->regions[right].base);
>>> +}
>>> +#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>>> +
>>>   /**
>>>    * memblock_set_node - set node ID on memblock regions
>>>    * @base: base of area to set node ID for
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index c19f5ac..2a967f7 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -5483,8 +5483,17 @@ void __meminit memmap_init_zone(unsigned long
>>> size, int nid, unsigned long zone,
>>>                  if (context != MEMMAP_EARLY)
>>>                          goto not_early;
>>>
>>> -               if (!early_pfn_valid(pfn))
>>> +               if (!early_pfn_valid(pfn)) {
>>> +#if (defined CONFIG_HAVE_MEMBLOCK) && (defined
>>> CONFIG_HAVE_ARCH_PFN_VALID)
>>> +                       /*
>>> +                        * Skip to the pfn preceding the next valid one
>>> (or
>>> +                        * end_pfn), such that we hit a valid pfn (or
>>> end_pfn)
>>> +                        * on our next iteration of the loop.
>>> +                        */
>>> +                       pfn = memblock_next_valid_pfn(pfn) - 1;
>>> +#endif
>>>                          continue;
>>> +               }
>>>                  if (!early_pfn_in_nid(pfn, nid))
>>>                          continue;
>>>                  if (!update_defer_init(pgdat, pfn, end_pfn,
>>> &nr_initialised))
>>> --
>>> 2.7.4
>>>
>
> --
> Cheers,
> Jia
>
