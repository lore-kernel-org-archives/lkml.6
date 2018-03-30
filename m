Return-Path: <dvacek@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522400931; cv=none;
        d=google.com; s=arc-20160816;
        b=okr0Cf27qK9hW/sZp4FfJaavYqQWK57Bp+DeNy/94+8RY7RcRPBkhIs1FuG6axDgjO
         F2POj+yL+1/ECm5GxawxDUXSrxRFZu7stA8YQfmvsH++KZuYYEFLi5AKHm9M//IvfiVg
         oEIMZQlcNVO1N0Q1L62Eux2/XdavVVaqUEx+bIrsJNpEeLs4SSSwzh3+baEJaLQ02ABn
         XS3Z/EvBdcKg7rfgbP7RdoYN8o2faE0wb/X3KQ5ascNZwwl6sYUbJ26MI9Vj3K+upTG1
         CWtMqIHCvns+3dBEYe2Tjn3Lj1rU9VV4oRoYxUiYE9YE0+QUxs/BA3GihkhEeKP63KR4
         lSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=BSNdbOth0d35uiPSxtKeMBD6Qmtc5eUOR4pULh9l8iw=;
        b=bgiGjnKmK1GvnITih/N9ggBlDaLotQ30243Nr3ZbgGB/f2/w6m4b1B2cRdfKPgIZUH
         mIwXbhievotHCa1fMYdW9gy9lvnLmejZfF52op6SktDjIRgoV5bvG7ymEJoO0Whq4viO
         KGgkiYu7Bbc0TlLmh9QK+nTlJMN+YmwMiLvKRean/+2g9mQi3ouVS/IU1mdBtgIfaEH9
         Pe0FX3LFfmrtVYYYiLDYEdPGcRTQnno4p+qtdg9JPzFZh6aJcsK0BKjXBmAx9Co2QjiC
         M/GZPSlTyG8o9zRYWZL00CPt+Nlg26ByEkHHxYc2G4Fdb3JQW3viq5U2aNVpzasRanc5
         urVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dvacek@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dvacek@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+KlMUTjmzmxaCwIG7nnCXmF4Zjkfm2ECqfxX9LX5yRg/WqOSlxgkYk3SV+71QnHGRfb/A6j9lJBQjdTnM+cus=
MIME-Version: 1.0
In-Reply-To: <1522397755-33393-2-git-send-email-hejianet@gmail.com>
References: <1522397755-33393-1-git-send-email-hejianet@gmail.com> <1522397755-33393-2-git-send-email-hejianet@gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Fri, 30 Mar 2018 11:08:50 +0200
Message-ID: <CACjP9X_a=w7SrT_di4RXvS5GDTFosiNeX_x6GCTW+uTxTRcWyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm and arm64
To: Jia He <hejianet@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>, Steven Sistare <steven.sistare@oracle.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>, Vlastimil Babka <vbabka@suse.cz>,
	open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	James Morse <james.morse@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steve Capper <steve.capper@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>, Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>, richard.weiyang@gmail.com,
	Jia He <jia.he@hxt-semitech.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596349791646884565?=
X-GMAIL-MSGID: =?utf-8?q?1596353078857666457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 10:15 AM, Jia He <hejianet@gmail.com> wrote:
> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
> where possible") optimized the loop in memmap_init_zone(). But it causes
> possible panic bug. So Daniel Vacek reverted it later.
>
> But as suggested by Daniel Vacek, it is fine to using memblock to skip
> gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.
>
> On arm and arm64, memblock is used by default. But generic version of
> pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
> not always return the next valid one but skips more resulting in some
> valid frames to be skipped (as if they were invalid). And that's why
> kernel was eventually crashing on some !arm machines.
>
> And as verified by Eugeniu Rosca, arm can benifit from commit
> b92df1de5d28. So remain the memblock_next_valid_pfn on arm{,64} and move
> the related codes to arm64 arch directory.
>
> Suggested-by: Daniel Vacek <neelx@redhat.com>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  arch/arm/mm/init.c   | 31 ++++++++++++++++++++++++++++++-
>  arch/arm64/mm/init.c | 31 ++++++++++++++++++++++++++++++-
>  mm/page_alloc.c      | 13 ++++++++++++-
>  3 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index a1f11a7..0fb85ca 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -198,7 +198,36 @@ int pfn_valid(unsigned long pfn)
>         return memblock_is_map_memory(__pfn_to_phys(pfn));
>  }
>  EXPORT_SYMBOL(pfn_valid);
> -#endif
> +
> +/* HAVE_MEMBLOCK is always enabled on arm */
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
> +EXPORT_SYMBOL(memblock_next_valid_pfn);
> +#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>
>  #ifndef CONFIG_SPARSEMEM
>  static void __init arm_memory_present(void)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 00e7b90..13e43ff 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -290,7 +290,36 @@ int pfn_valid(unsigned long pfn)
>         return memblock_is_map_memory(pfn << PAGE_SHIFT);
>  }
>  EXPORT_SYMBOL(pfn_valid);
> -#endif
> +
> +/* HAVE_MEMBLOCK is always enabled on arm64 */
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
> +EXPORT_SYMBOL(memblock_next_valid_pfn);
> +#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
>
>  #ifndef CONFIG_SPARSEMEM
>  static void __init arm64_memory_present(void)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c19f5ac..8a92df7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5452,6 +5452,15 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
>   * up by free_all_bootmem() once the early boot process is
>   * done. Non-atomic initialization, single-pass.
>   */

> +#if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
> +extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
> +#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
> +#endif
> +

This should go to arch/arm{,64}/include/asm/page.h.

> +#ifndef skip_to_last_invalid_pfn
> +#define skip_to_last_invalid_pfn(pfn) (pfn)
> +#endif

And this to include/linux/mmzone.h. Something like this?

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0ec44d6..489875cf3889 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,8 @@ extern void __cpu_copy_user_highpage(struct page
*to, struct page *from,

 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
 #endif

 #include <asm/memory.h>
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 60d02c81a3a2..e57d3f2e2dbd 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -39,6 +39,8 @@ extern void __cpu_copy_user_page(void *to, const void *from,

 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
 #endif

 #include <asm/memory.h>
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 356a814e7c8e..40d51bab6fc0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1222,6 +1222,7 @@ static inline struct mem_section
*__pfn_to_section(unsigned long pfn)
 extern int __highest_present_section_nr;

 #ifndef CONFIG_HAVE_ARCH_PFN_VALID
+#define skip_to_last_invalid_pfn(pfn) (pfn)
 static inline int pfn_valid(unsigned long pfn)
 {
        if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)

--nX

>  void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 unsigned long start_pfn, enum memmap_context context,
>                 struct vmem_altmap *altmap)
> @@ -5483,8 +5492,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                 if (context != MEMMAP_EARLY)
>                         goto not_early;
>
> -               if (!early_pfn_valid(pfn))
> +               if (!early_pfn_valid(pfn)) {
> +                       pfn = skip_to_last_invalid_pfn(pfn);
>                         continue;
> +               }
>                 if (!early_pfn_in_nid(pfn, nid))
>                         continue;
>                 if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
> --
> 2.7.4
>
