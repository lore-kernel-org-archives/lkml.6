Return-Path: <richard.weiyang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522229920; cv=none;
        d=google.com; s=arc-20160816;
        b=ZBvA7Pcxe7XsLCGTJqoJxHH0opzawmbzanCRCa+fzCXgXjHYwFAYHSR8El50jgYzRo
         BDAPbfWqZukqUN6CbJZDKDaI1iVGpKnvD8px4biaQZq9r/7+ExjNDSBOuEz0TUJKi9SN
         qQJk3bzW9VXwwgdCUJLFfcb0exRemyI4dhRB3Z8HYDr2pYHIyjTB53HSeZAJh55PKlwP
         Bein87w9GnoQXf9gRuWJYhVBMfi1NaJfWIlPuTEfrCuaSmTF1EWoenRwUzO69s1kIIT2
         IUcmFy0USwmVCi52BtfxtJ5VFwBAVlOvYGB/vcagy7nrXuKNuRkmJ4WDGgz+8Wzaj2ME
         +ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=M2JL+c9OK7o1jHuSKB0PwYzqIny3+aceEa1enEyF1OQ=;
        b=jxdVVBLnPPqOpg8iIvoFpfAh0J+FIhpT8h407P511YMOj+It/XHqpwFQoi05j29wvu
         PtfOJcPtmjP8Le0O67Ahbvtd4pb/bvJ2QpCsDXmkJ+0CgTKXrLzB9FFibG1ycA1fmUBA
         gf5yeK9wkWrVu45Wmi6U2inOW+NARQb2WyxC0EZJeHMWcQ/Fl/KFAcDICTbD4Ye8n9GA
         9WtxUNm1dCIqaSGhAk60g08DIschyDxLv3Gw9r0Ol0LjKCmx2wez5C7sYHpTxLNT6i35
         Df2R9lD27hegk4JT5nQuYzNBjUArV9+JfFDLrY9G4vqPIo/OGMpr1bT8gAvRfpARdIaQ
         dK3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o/ER86bo;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o/ER86bo;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48R+5Pr3UaXweVcejFRiQxpuYCAoznlpMrymNFY0hAB8mSC0+SQGZk7bP9O4A3sS+p1kDTNdQ==
Date: Wed, 28 Mar 2018 17:38:30 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Jia He <hejianet@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Vacek <neelx@redhat.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, James Morse <james.morse@arm.com>,
	Steve Capper <steve.capper@arm.com>, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>, Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: Re: [PATCH v3 4/5] arm64: introduce pfn_valid_region()
Message-ID: <20180328093830.GB98648@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
 <1522033340-6575-5-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522033340-6575-5-git-send-email-hejianet@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967713881202535?=
X-GMAIL-MSGID: =?utf-8?q?1596173761299844529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 25, 2018 at 08:02:18PM -0700, Jia He wrote:
>This is the preparation for further optimizing in early_pfn_valid
>on arm64.
>
>Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>---
> arch/arm64/include/asm/page.h |  3 ++-
> arch/arm64/mm/init.c          | 25 ++++++++++++++++++++++++-
> 2 files changed, 26 insertions(+), 2 deletions(-)
>
>diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
>index 60d02c8..da2cba3 100644
>--- a/arch/arm64/include/asm/page.h
>+++ b/arch/arm64/include/asm/page.h
>@@ -38,7 +38,8 @@ extern void clear_page(void *to);
> typedef struct page *pgtable_t;
> 
> #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>-extern int pfn_valid(unsigned long);
>+extern int pfn_valid(unsigned long pfn);
>+extern int pfn_valid_region(unsigned long pfn, int *last_idx);
> #endif
> 
> #include <asm/memory.h>
>diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>index 00e7b90..06433d5 100644
>--- a/arch/arm64/mm/init.c
>+++ b/arch/arm64/mm/init.c
>@@ -290,7 +290,30 @@ int pfn_valid(unsigned long pfn)
> 	return memblock_is_map_memory(pfn << PAGE_SHIFT);
> }
> EXPORT_SYMBOL(pfn_valid);
>-#endif
>+
>+int pfn_valid_region(unsigned long pfn, int *last_idx)
>+{
>+	unsigned long start_pfn, end_pfn;
>+	struct memblock_type *type = &memblock.memory;
>+
>+	if (*last_idx != -1) {
>+		start_pfn = PFN_DOWN(type->regions[*last_idx].base);

PFN_UP() should be used.

>+		end_pfn= PFN_DOWN(type->regions[*last_idx].base +
>+					type->regions[*last_idx].size);
>+
>+		if (pfn >= start_pfn && pfn < end_pfn)
>+			return !memblock_is_nomap(
>+				&memblock.memory.regions[*last_idx]);

Could use type->regions directly.

>+	}
>+
>+	*last_idx = memblock_search_pfn_regions(pfn);
>+	if (*last_idx == -1)
>+		return false;
>+
>+	return !memblock_is_nomap(&memblock.memory.regions[*last_idx]);

Could use type->regions directly.

Well, since your check memblock.memory.regions, how about use a variable
equals memblock.memory.regions directly instead of type->regions?

For example:

struct memblock_region *regions = memblock.memory.regions;

>+}
>+EXPORT_SYMBOL(pfn_valid_region);
>+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
> 
> #ifndef CONFIG_SPARSEMEM
> static void __init arm64_memory_present(void)
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
