Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38777C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01AA20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01AA20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeIZPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:43:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeIZPni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A918EB04E;
        Wed, 26 Sep 2018 09:31:31 +0000 (UTC)
Date:   Wed, 26 Sep 2018 11:31:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <lftan@altera.com>,
        Mark Salter <msalter@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: Re: [PATCH 14/30] memblock: add align parameter to
 memblock_alloc_node()
Message-ID: <20180926093127.GO6278@dhcp22.suse.cz>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-15-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536927045-23536-15-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-09-18 15:10:29, Mike Rapoport wrote:
> With the align parameter memblock_alloc_node() can be used as drop in
> replacement for alloc_bootmem_pages_node() and __alloc_bootmem_node(),
> which is done in the following patches.

/me confused. Why do we need this patch at all? Maybe it should be
folded into the later patch you are refereing here?

> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  include/linux/bootmem.h | 4 ++--
>  mm/sparse.c             | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
> index 7d91f0f..3896af2 100644
> --- a/include/linux/bootmem.h
> +++ b/include/linux/bootmem.h
> @@ -157,9 +157,9 @@ static inline void * __init memblock_alloc_from_nopanic(
>  }
>  
>  static inline void * __init memblock_alloc_node(
> -						phys_addr_t size, int nid)
> +		phys_addr_t size, phys_addr_t align, int nid)
>  {
> -	return memblock_alloc_try_nid(size, 0, BOOTMEM_LOW_LIMIT,
> +	return memblock_alloc_try_nid(size, align, BOOTMEM_LOW_LIMIT,
>  					    BOOTMEM_ALLOC_ACCESSIBLE, nid);
>  }
>  
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 04e97af..509828f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -68,7 +68,7 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
>  	if (slab_is_available())
>  		section = kzalloc_node(array_size, GFP_KERNEL, nid);
>  	else
> -		section = memblock_alloc_node(array_size, nid);
> +		section = memblock_alloc_node(array_size, 0, nid);
>  
>  	return section;
>  }
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
