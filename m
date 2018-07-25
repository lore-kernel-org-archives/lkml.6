Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1920882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HTRjsyy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E1920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbeGYBLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:11:11 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:48502 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbeGYBLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:11:11 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 09DF624E0940;
        Tue, 24 Jul 2018 17:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532476935; bh=pg8nDZhYyL2rZG3mGT/4G3NIOioFwibUgvKU5g1EN54=;
        h=From:To:CC:Subject:Date:References:From;
        b=HTRjsyy0fUMXXHIcCKZV2dqJ8Py/foMwMLIQ+w6CcqxvZwbDEG7P6NdGKpETtfWQu
         ovuFID134VcMEFgXQp6xLgRxgqq04aVhu517VjsAUGQbmh1WfIhqM6lmz9E6y7LAiM
         isBa0UidvXWpt0A3TqSXo9CcHiq2Dh2r8jA/LpSarJoqAIDHlorN50l5lGft8aewDf
         lzL8lYetwYofBI+Y25spfgqJ0dRCww6xW6eaK6lGgeaa7cXOqDLoF+DgvWXUzAfFJf
         k2x/abJ1hbm8Pl4Mqfs7pBKVxJ3/jJbT52+XDGtxboKwfWYe3/3kevQltmo6bu3JhB
         JCKzK7wnm3W9g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id E78533D82;
        Tue, 24 Jul 2018 17:02:14 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 24 Jul 2018 17:02:14 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 2/4] arc: fix type warnings in arc/mm/cache.c
Thread-Topic: [PATCH 2/4] arc: fix type warnings in arc/mm/cache.c
Thread-Index: AQHUI49pAsd59NGrBUKprDU844LxcQ==
Date:   Wed, 25 Jul 2018 00:02:13 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0839C0@us01wembx1.internal.synopsys.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
 <20180724204622.2366-3-rd.dunlab@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 01:46 PM, Randy Dunlap wrote:=0A=
> From: Randy Dunlap <rdunlap@infradead.org>=0A=
>=0A=
> ../arch/arc/mm/cache.c: In function 'flush_anon_page':=0A=
> ../arch/arc/mm/cache.c:1062:55: warning: passing argument 2 of '__flush_d=
cache_page' makes integer from pointer without a cast [-Wint-conversion]=0A=
>   __flush_dcache_page((phys_addr_t)page_address(page), page_address(page)=
);=0A=
>                                                        ^~~~~~~~~~~~~~~~~~=
=0A=
> ../arch/arc/mm/cache.c:1013:59: note: expected 'long unsigned int' but ar=
gument is of type 'void *'=0A=
>  void __flush_dcache_page(phys_addr_t paddr, unsigned long vaddr)=0A=
>                                              ~~~~~~~~~~~~~~^~~~~=0A=
>=0A=
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
> Cc: Ofer Levi <oferle@mellanox.com>=0A=
> Cc: linux-snps-arc@lists.infradead.org=0A=
> ---=0A=
>  arch/arc/mm/cache.c |   11 ++++++-----=0A=
>  1 file changed, 6 insertions(+), 5 deletions(-)=0A=
>=0A=
> --- linux-next-20180723.orig/arch/arc/mm/cache.c=0A=
> +++ linux-next-20180723/arch/arc/mm/cache.c=0A=
> @@ -1038,7 +1038,7 @@ void flush_cache_mm(struct mm_struct *mm=0A=
>  void flush_cache_page(struct vm_area_struct *vma, unsigned long u_vaddr,=
=0A=
>  		      unsigned long pfn)=0A=
>  {=0A=
> -	unsigned int paddr =3D pfn << PAGE_SHIFT;=0A=
> +	phys_addr_t paddr =3D pfn << PAGE_SHIFT;=0A=
>  =0A=
>  	u_vaddr &=3D PAGE_MASK;=0A=
>  =0A=
> @@ -1058,8 +1058,9 @@ void flush_anon_page(struct vm_area_stru=0A=
>  		     unsigned long u_vaddr)=0A=
>  {=0A=
>  	/* TBD: do we really need to clear the kernel mapping */=0A=
> -	__flush_dcache_page(page_address(page), u_vaddr);=0A=
> -	__flush_dcache_page(page_address(page), page_address(page));=0A=
> +	__flush_dcache_page((phys_addr_t)page_address(page), u_vaddr);=0A=
> +	__flush_dcache_page((phys_addr_t)page_address(page),=0A=
> +			    (phys_addr_t)page_address(page));=0A=
=0A=
CONFIG_ARC_CACHE_VIPT_ALIASING is a total bitrot and I'm considering removi=
ng it=0A=
as no sane systems should use it. There's none which I know are using it.=
=0A=
But for now this will do.=0A=
=0A=
=0A=
>  =0A=
>  }=0A=
>  =0A=
> @@ -1084,7 +1085,7 @@ void copy_user_highpage(struct page *to,=0A=
>  	 * addr_not_cache_congruent() is 0=0A=
>  	 */=0A=
>  	if (page_mapcount(from) && addr_not_cache_congruent(kfrom, u_vaddr)) {=
=0A=
> -		__flush_dcache_page((unsigned long)kfrom, u_vaddr);=0A=
> +		__flush_dcache_page((phys_addr_t)kfrom, u_vaddr);=0A=
=0A=
Was this needed really ? I can't seem to trigger any warnings here.=0A=
All of this (original code before your change) is technically incorrect due=
 to the=0A=
combination of CONFIG_ARC_CACHE_VIPT_ALIASING and CONFIG_HIGHMEM. @kfrom is=
=0A=
returned by kmap_atomic() and in highmem regime it could be a kernel virtua=
l=0A=
address, so calling the low level cache flush interface with a kvaddr, pret=
ending=0A=
it is paddr (whethe runsigned long or phys_addr_t) is just not right. This=
=0A=
combinations needs to be disallowed from Kconfig !=0A=
=0A=
>  		clean_src_k_mappings =3D 1;=0A=
>  	}=0A=
>  =0A=
> @@ -1105,7 +1106,7 @@ void copy_user_highpage(struct page *to,=0A=
>  	 * sync the kernel mapping back to physical page=0A=
>  	 */=0A=
>  	if (clean_src_k_mappings) {=0A=
> -		__flush_dcache_page((unsigned long)kfrom, (unsigned long)kfrom);=0A=
> +		__flush_dcache_page((phys_addr_t)kfrom, (unsigned long)kfrom);=0A=
>  		set_bit(PG_dc_clean, &from->flags);=0A=
>  	} else {=0A=
>  		clear_bit(PG_dc_clean, &from->flags);=0A=
>=0A=
=0A=
Ditto !=0A=
