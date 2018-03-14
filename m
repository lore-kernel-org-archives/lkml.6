Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1800801-1521037053-2-7444610900547127600
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
    t=1521037052; b=rBABQpq61wl7OA9PN/YRnvB/V9kuIHtvl3rifvECecHyjIa
    L/naLZaEXa2lLUX0pO2jzzbxHBQ1eALXXMLb4VxQk2kUfZVBZ0+Vk1LUo9VlEKg0
    tEq5r/q7ZQWYt1guCRGfW67Nc4GJ1pca/ynR7fPPsqBFMu8WWxExrbJU4b+TZEaa
    9cGoxYP44mNfk7YLORKLa+G0BLKGNjm5vIdWH60D9rigOBh983OJ7AIvUmgm8nLr
    IQ9sbXrakeG8a9D04c2KyFGe7m84LD5oahaLf+DrvU/iFsqZIuPym8lrV8L9Aye6
    mL1ru0IoPw1f0QNGI6jz7gVcyDAMfAiFpK6KojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521037052; bh=oL4Q96enz/LoUor/DI2ZtJpoUV
    zxAcPBZu52OJElEeQ=; b=A8Sn5YPBDnzGneVYpAZwGGhJ3uIfPgrB5FsKp9sskH
    yFq4iEuMyrv87OlTKxUONLJMuZgZEDn/hm3IJ6om5FxVHfZ3RJQ2M+4nxIt6LyRG
    n5Qk1OphBeHyiC0XN5cwTojolUpNN5GGH2bJ/L6FGhsY1NMilpvJwO2hRUfVSWcc
    1YgvI1IUrTvIobQZ3WBXh6U6n9gF0cEcCajHE5eBJ6wZePypyVT9i8GAVGMZROat
    jywfoJGSx6Ruinuydcm5pSYY3h1g1RtGQumomY6TsRV7W7Oz8Srx7kT1kElCq1JH
    X/3eVYg1Mevptr6qZHaM5djzZ3Bf/Y2lch5uDItni2UA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750827AbeCNORa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 10:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:33228 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbeCNOR3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 14 Mar 2018 10:17:29 -0400
Date: Wed, 14 Mar 2018 15:17:27 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
Message-ID: <20180314141727.GE23100@dhcp22.suse.cz>
References: <20180313224240.25295-1-neelx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313224240.25295-1-neelx@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 13-03-18 23:42:40, Daniel Vacek wrote:
> On some architectures (reported on arm64) commit 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> causes a boot hang. This patch fixes the hang making sure the alignment
> never steps back.

I am sorry to be complaining again, but the code is so obscure that I
would _really_ appreciate some more information about what is going
on here. memblock_next_valid_pfn will most likely return a pfn within
the same memblock and the alignment will move it before the old pfn
which is not valid - so the block has some holes. Is that correct?
If yes then please put it into the changelog. Maybe reuse data provided
by Arnd http://lkml.kernel.org/r/20180314134431.13241-1-ard.biesheuvel@linaro.org
 
> Link: http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
> Fixes: 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/page_alloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3d974cb2a1a1..e033a6895c6f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5364,9 +5364,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  			 * is not. move_freepages_block() can shift ahead of
>  			 * the valid region but still depends on correct page
>  			 * metadata.
> +			 * Also make sure we never step back.
>  			 */
> -			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> +			unsigned long next_pfn;
> +
> +			next_pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>  					~(pageblock_nr_pages-1)) - 1;
> +			if (next_pfn > pfn)
> +				pfn = next_pfn;
>  #endif
>  			continue;
>  		}
> -- 
> 2.16.2
> 

-- 
Michal Hocko
SUSE Labs
