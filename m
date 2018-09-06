Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E4EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791FF2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791FF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIFMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:15:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbeIFMPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03057AD98;
        Thu,  6 Sep 2018 07:41:15 +0000 (UTC)
Date:   Thu, 6 Sep 2018 09:41:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/29] memblock: replace alloc_bootmem_low with
 memblock_alloc_low
Message-ID: <20180906074114.GR14951@dhcp22.suse.cz>
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536163184-26356-10-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536163184-26356-10-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 18:59:24, Mike Rapoport wrote:
> The functions are equivalent, just the later does not require nobootmem
> translation layer.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

modulo @memblock_alloc_low@@memblock_virt_alloc_low@
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/kernel/tce_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tce_64.c b/arch/x86/kernel/tce_64.c
> index f386bad..54c9b5a 100644
> --- a/arch/x86/kernel/tce_64.c
> +++ b/arch/x86/kernel/tce_64.c
> @@ -173,7 +173,7 @@ void * __init alloc_tce_table(void)
>  	size = table_size_to_number_of_entries(specified_table_size);
>  	size *= TCE_ENTRY_SIZE;
>  
> -	return __alloc_bootmem_low(size, size, 0);
> +	return memblock_alloc_low(size, size);
>  }
>  
>  void __init free_tce_table(void *tbl)
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
