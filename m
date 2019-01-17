Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429CFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DD320866
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547708783;
	bh=YQg5kK0CK1gygp8V+fUKHMM30p/aVFKoBFNquIpl8z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nms4rVSYDFjTDWkuq5DPC9vwG/4fTBXEigN2rsk+9TycFNpihZPwCw/u3SgTM3q50
	 I7pvzFS/gqe/OJLRg8vsHyaiHaSoIH33z+c2OaIwNNskyTxtSmynaqjf+hYgaeMr4g
	 CHiNJ9TBU9YYay/PFIYbiKlZ9bTHsKky/TecTR1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfAQHGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbfAQHGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:06:19 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353B920856;
        Thu, 17 Jan 2019 07:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547708777;
        bh=YQg5kK0CK1gygp8V+fUKHMM30p/aVFKoBFNquIpl8z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0pw3ulKi3jq4oKmvxSJxzzJsSdMcohB7IigecglkQT5Rx7a1QVi6VMiKG+7/EaK5C
         /1jqt2buqhHUph/IaPf93BCvJIFaI+XBcHutXpZ8WKrpTTySrlp18ZPjm07/tBc6Eg
         nedbQORGuNF/Dh36ZedpPIbDbRoH11rc3m/ItgOI=
Date:   Thu, 17 Jan 2019 15:06:03 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 19/21] treewide: add checks for the return value of
 memblock_alloc*()
Message-ID: <20190117070602.GA31839@guoren-Inspiron-7460>
References: <1547646261-32535-1-git-send-email-rppt@linux.ibm.com>
 <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547646261-32535-20-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 03:44:19PM +0200, Mike Rapoport wrote:
>  arch/csky/mm/highmem.c                    |  5 +++++
...
> diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
> index 53b1bfa..3317b774 100644
> --- a/arch/csky/mm/highmem.c
> +++ b/arch/csky/mm/highmem.c
> @@ -141,6 +141,11 @@ static void __init fixrange_init(unsigned long start, unsigned long end,
>  			for (; (k < PTRS_PER_PMD) && (vaddr != end); pmd++, k++) {
>  				if (pmd_none(*pmd)) {
>  					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
> +					if (!pte)
> +						panic("%s: Failed to allocate %lu bytes align=%lx\n",
> +						      __func__, PAGE_SIZE,
> +						      PAGE_SIZE);
> +
>  					set_pmd(pmd, __pmd(__pa(pte)));
>  					BUG_ON(pte != pte_offset_kernel(pmd, 0));
>  				}

Looks good for me and panic is ok.

Reviewed-by: Guo Ren <ren_guo@c-sky.com>
