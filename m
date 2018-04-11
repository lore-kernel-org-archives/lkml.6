Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeDKIdX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:54707 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbeDKIdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:33:20 -0400
Date: Wed, 11 Apr 2018 10:33:15 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-ID: <20180411083315.GA23400@dhcp22.suse.cz>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-04-18 10:03:36, Laurent Dufour wrote:
> @@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  
>  	if (is_zero_pfn(pfn))
>  		return NULL;
> -check_pfn:
> +
> +check_pfn: __maybe_unused
>  	if (unlikely(pfn > highest_memmap_pfn)) {
>  		print_bad_pte(vma, addr, pte, NULL);
>  		return NULL;
> @@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  	 * NOTE! We still have PageReserved() pages in the page tables.
>  	 * eg. VDSO mappings can cause them to exist.
>  	 */
> -out:
> +out: __maybe_unused
>  	return pfn_to_page(pfn);

Why do we need this ugliness all of the sudden?

-- 
Michal Hocko
SUSE Labs
