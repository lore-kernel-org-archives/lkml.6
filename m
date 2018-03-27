Return-Path: <dvacek@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169534; cv=none;
        d=google.com; s=arc-20160816;
        b=Y0cL4EwqPAjcnjRnhDX1inHOe3DLja1mItJXrtY73x865ujrhV9MvknI9z5w4S/tKs
         L6TFjsgLr4eeD3k1c6NzhfGqUp6hortUrUdb0nTMa3LTxoHqmcOWiuTR+FyUJEhRsOBG
         ruP+E+PdnzgZTjvXd3abTRQ8+EpjEPjtsOHj4qO/I1t03WhypkhhoAc51wDTqVDbMHVA
         MOonc6hn4mLBk28pYe/AZHrl4k7r7SV1FS+8tBKpJ1Yj3eR/NTTJQRJb25EyZmpPqwtU
         opYiNeUtO/w268ZT1JqbBudvrQNqe8Q0xAZEIYxxlyejUwnGpC94HDq1yOF2txffEH9v
         KFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=fpTu0XMT7RHL0wQ8oipUUHDiPWFNbA8LO8g2LeHdXz4=;
        b=rprwaJQpCbb+msr7zjyQsUi348jxUSR62n/RUJdwHdC2WZ3VxElJ2iXg1FxwzXABqH
         HtnQzbh66wBehhCoy0TQWqoauz8r0FtoGTuBfSXYu12U9BwxVIFNqwfQ8EGcq8K1ZNeG
         VviZ0JM6j0xDITU1hQupqRoeWtYUfrWBG9zqAsLgQ8kV0WvW5uCNtxs5imCdrXqBdtE+
         O2OwV8v7px/T0ShYVJjPZGJudeOunzUJb5s4AozuW3LWAiMkW+uKWtSz5EOUflZ8Isqj
         D7MXjKyhii9TJsJ1CMSPrYbZqS46mEjEpYeCq9aloLrRVf90C3pbEPZbuj1ze+hZ3fPg
         YJcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49ob9hcTtqasxqry/WotEBx+XpCl6wA4GqrY51SsR/mVs1ZqH6OpTmEBSVpzDxLhWREjsttUPMoDx3Y5HVZ0Hs=
MIME-Version: 1.0
In-Reply-To: <1521894282-6454-2-git-send-email-hejianet@gmail.com>
References: <1521894282-6454-1-git-send-email-hejianet@gmail.com> <1521894282-6454-2-git-send-email-hejianet@gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Tue, 27 Mar 2018 18:52:13 +0200
Message-ID: <CACjP9X-zvGa5OQpuJ1bUp+V=_eTOUDLfKkT1sbT84k5zJz=epA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596110442017548118?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 1:24 PM, Jia He <hejianet@gmail.com> wrote:
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
>
> But memblock_next_valid_pfn is valid when CONFIG_HAVE_ARCH_PFN_VALID is
> enabled. And as verified by Eugeniu Rosca, arm can benifit from this
> commit. So remain the memblock_next_valid_pfn.

It is not dependent on CONFIG_HAVE_ARCH_PFN_VALID option but on
arm(64) implementation of pfn_valid() function, IIUC. So it should
really be moved from generic source file to arm specific location. I'd
say somewhere close to the pfn_valid() implementation. Such as to
arch/arm{,64}/mm/ init.c-ish?

--nX

> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  include/linux/memblock.h |  4 ++++
>  mm/memblock.c            | 29 +++++++++++++++++++++++++++++
>  mm/page_alloc.c          | 11 ++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 0257aee..efbbe4b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -203,6 +203,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>              i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
> +unsigned long memblock_next_valid_pfn(unsigned long pfn);
> +#endif
> +
>  /**
>   * for_each_free_mem_range - iterate through free memblock areas
>   * @i: u64 used as loop variable
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ba7c878..bea5a9c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1102,6 +1102,35 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
>                 *out_nid = r->nid;
>  }
>
> +#ifdef CONFIG_HAVE_ARCH_PFN_VALID
> +unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
> +{
> +       struct memblock_type *type = &memblock.memory;
> +       unsigned int right = type->cnt;
> +       unsigned int mid, left = 0;
> +       phys_addr_t addr = PFN_PHYS(++pfn);
> +
> +       do {
> +               mid = (right + left) / 2;
> +
> +               if (addr < type->regions[mid].base)
> +                       right = mid;
> +               else if (addr >= (type->regions[mid].base +
> +                                 type->regions[mid].size))
> +                       left = mid + 1;
> +               else {
> +                       /* addr is within the region, so pfn is valid */
> +                       return pfn;
> +               }
> +       } while (left < right);
> +
> +       if (right == type->cnt)
> +               return -1UL;
> +       else
> +               return PHYS_PFN(type->regions[right].base);
> +}
> +#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
> +
>  /**
>   * memblock_set_node - set node ID on memblock regions
>   * @base: base of area to set node ID for
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c19f5ac..2a967f7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5483,8 +5483,17 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 if (context != MEMMAP_EARLY)
>                         goto not_early;
>
> -               if (!early_pfn_valid(pfn))
> +               if (!early_pfn_valid(pfn)) {
> +#if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
> +                       /*
> +                        * Skip to the pfn preceding the next valid one (or
> +                        * end_pfn), such that we hit a valid pfn (or end_pfn)
> +                        * on our next iteration of the loop.
> +                        */
> +                       pfn = memblock_next_valid_pfn(pfn) - 1;
> +#endif
>                         continue;
> +               }
>                 if (!early_pfn_in_nid(pfn, nid))
>                         continue;
>                 if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> --
> 2.7.4
>
