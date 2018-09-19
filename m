Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E85C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C20214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C20214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeISQWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:22:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727820AbeISQWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:22:51 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A7F3E7CBC61F;
        Wed, 19 Sep 2018 18:45:28 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 18:45:20 +0800
Date:   Wed, 19 Sep 2018 11:45:07 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 03/29] mm: remove CONFIG_HAVE_MEMBLOCK
Message-ID: <20180919114507.000059f3@huawei.com>
In-Reply-To: <20180919103457.GA20545@rapoport-lnx>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
        <1536163184-26356-4-git-send-email-rppt@linux.vnet.ibm.com>
        <20180919100449.00006df9@huawei.com>
        <20180919103457.GA20545@rapoport-lnx>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 13:34:57 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> Hi Jonathan,
> 
> On Wed, Sep 19, 2018 at 10:04:49AM +0100, Jonathan Cameron wrote:
> > On Wed, 5 Sep 2018 18:59:18 +0300
> > Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >   
> > > All architecures use memblock for early memory management. There is no need
> > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>  
> > 
> > Hi Mike,
> > 
> > A minor editing issue in here that is stopping boot on arm64 platforms with latest
> > version of the mm tree.  
> 
> Can you please try the following patch:
> 
> 
> From 079bd5d24a01df3df9500d0a33d89cb9f7da4588 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Date: Wed, 19 Sep 2018 13:29:27 +0300
> Subject: [PATCH] of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config
>  option
> 
> The removal of HAVE_MEMBLOCK configuration option, mistakenly dropped the
> wrong #endif. This patch restores that #endif and removes the part that
> should have been actually removed, starting from #else and up to the
> correct #endif
> 
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Hi Mike,

That's identical to the local patch I'm carrying to fix this so looks good to me.

For what it's worth given you'll probably fold this into the larger patch.

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for the quick reply.

Jonathan

> ---
>  drivers/of/fdt.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 48314e9..bb532aa 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1119,6 +1119,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  #endif
>  #ifndef MAX_MEMBLOCK_ADDR
>  #define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
> +#endif
>  
>  void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> @@ -1175,26 +1176,6 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
>  	return memblock_reserve(base, size);
>  }
>  
> -#else
> -void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
> -{
> -	WARN_ON(1);
> -}
> -
> -int __init __weak early_init_dt_mark_hotplug_memory_arch(u64 base, u64 size)
> -{
> -	return -ENOSYS;
> -}
> -
> -int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
> -					phys_addr_t size, bool nomap)
> -{
> -	pr_err("Reserved memory not supported, ignoring range %pa - %pa%s\n",
> -		  &base, &size, nomap ? " (nomap)" : "");
> -	return -ENOSYS;
> -}
> -#endif
> -
>  static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
>  {
>  	return memblock_alloc(size, align);


