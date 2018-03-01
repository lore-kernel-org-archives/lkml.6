Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2993705-1519909843-2-6088137735392559528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909842; b=d0X3uLETDjNg6JlvbZViglu9Z46EpGSgjSVonGsqzZzrbbo
    pb991bjELjJnFmTcigYZoRWCHpBIvZO58y4eQeLzzzadeiq1Rv7brxWrZTKtE+qd
    LPLLL7D1Aih7eHCARppBQCgQlD4WPKkDm86iwlvHPU3CYiFinhbFsc7YjSYyMP8w
    DWXTLCITpYlc3/O4CRtEvZhlzXhT6+4GzImi7MZkTLmy+SgxRGkKCkbNRI1bB9mw
    2ds241oKdmbn1vpTWCvNe0JzcUl9BC8RoNxnQGxhJXZA5Vm9v1r4lyCAtdLFayk+
    MnjpmAvndF5BhLdgratQb58aEmodCP/qTf2jmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519909842; bh=XQCubfdYrK/ST6FDmyzUsJk77u
    K9egw4DaIoUhSLWIQ=; b=uBap19v6osTzSwJl0ihF4FnUbVTbpxPSRWQtYpesME
    7tuihMODLI7wqeh5fp4MoNuLEEotekdZMlV8pSYgTjhVMeqDwijjMNTE+Kp7gNH4
    khZoiIjdIZE2c7P7F9ZpEo7TWGw3Cf9xRpWOVcROESt4YIjN2pM7JdKQLRrooiws
    oAHtvNWKeWrSVUseihc64Vh/TXI8pnH8k552LYnC8svXes5j6/jpeT7DYSD+Q4lS
    KkJZx1oNySVOjdB03zPQ6CFJ3qWlSCd2+o74cf5x/ZR2KFCQtSJlf1EB+1swgPJO
    msvK231jTWSwXnei2EvmOgor3fisuRli18F1EBH4aVdA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030519AbeCANKh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:10:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:56265 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030517AbeCANKg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 08:10:36 -0500
Date: Thu, 1 Mar 2018 14:10:33 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
Message-ID: <20180301131033.GH15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519908465-12328-1-git-send-email-neelx@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 01-03-18 13:47:45, Daniel Vacek wrote:
> In move_freepages() a BUG_ON() can be triggered on uninitialized page structures
> due to pageblock alignment. Aligning the skipped pfns in memmap_init_zone() the
> same way as in move_freepages_block() simply fixes those crashes.

This changelog doesn't describe how the fix works. Why doesn't
memblock_next_valid_pfn return the first valid pfn as one would expect?

It would be also good put the panic info in the changelog.

> Fixes: b92df1de5d28 ("[mm] page_alloc: skip over regions of invalid pfns where possible")
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/page_alloc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cb416723538f..9edee36e6a74 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5359,9 +5359,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			/*
>  			 * Skip to the pfn preceding the next valid one (or
>  			 * end_pfn), such that we hit a valid pfn (or end_pfn)
> -			 * on our next iteration of the loop.
> +			 * on our next iteration of the loop. Note that it needs
> +			 * to be pageblock aligned even when the region itself
> +			 * is not as move_freepages_block() can shift ahead of
> +			 * the valid region but still depends on correct page
> +			 * metadata.
>  			 */
> -			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
> +			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> +						~(pageblock_nr_pages-1)) - 1;
>  #endif
>  			continue;
>  		}
> -- 
> 2.16.2
> 

-- 
Michal Hocko
SUSE Labs
