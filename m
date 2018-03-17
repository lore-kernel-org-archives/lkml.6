Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-246096-1521252255-2-5010618522420127703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521252255; b=av3/3HgiMaKh36oB58iBp+4JvkLaZcuFU/fvvfCTBWlXjb8
    Ql8wurNh3cdRpvd/EKDYFhdZueNa6zzUOg3NVLw5XdkPrb5yB9g5quMRFQiV4yy+
    w5Ki+BB7s6jtTR+CA5Q+NwD1i4Mulg6cxObKAz1eRLYtDg801urgWi1T8dQ3eBTf
    UGaBVBtdk9xAv8RBbBIC/RmFNBYfiadAOa8YX+CeG6Bc8SEDsexv5SFtsRbENqB8
    ciYNdcQvn6njL3QCCgkz3Bf5MZwMGfoAIO0wrTF0KZbNfKf6FpspcudjM08EcwD1
    KkPZHRHF3w2O6RbJdIN12JGsEOSHC1qSzUGSZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521252255; bh=WvZPZkfnhsz0U1sP6JjFRby7X4F75/eJ/Ok1MUrct0c=; b=n
    T5Q3x6PNkvrCDA7h0vBnPfoKVdNVatMhp5WshVLCDwM6bavublHyOguH7BXuEjXi
    j91URPHhBgFHCqyWXkzhj+xjTdIt4UfCXH2260MShHDdwTzkRBN7Gq8ki5TCsZoY
    t4ksVbmWIb0jCn910kGNuTOe/Vj57zKP9/XpxbKDhsXEga4uJih0nGaCezoyqcQF
    ff0lHvJru0DjsucC+nQWPi5OKGLotC7V0/ureIm4sAH31ikbfwvsze9y9yGs7wtL
    z3Mc3yMb1qS1JxvYb5gNwT+gSCsdpSaLZ0GvtuthMzv/NLaSsUuV+9pQJU3/b3Gj
    kSd2Hc4yDgzGHIvSnvZ2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeCQCEL convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Mar 2018 22:04:11 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17074 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeCQCEK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 22:04:10 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 16 Mar 2018 19:04:09 -0700
Subject: Re: [PATCH 04/14] mm/hmm: hmm_pfns_bad() was accessing wrong struct
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-5-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <88cd1c14-f4eb-cfc3-4f6a-ba669832dad7@nvidia.com>
Date: Fri, 16 Mar 2018 19:04:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-5-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> The private field of mm_walk struct point to an hmm_vma_walk struct and
> not to the hmm_range struct desired. Fix to get proper struct pointer.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hmm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6088fa6ed137..64d9e7dae712 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -293,7 +293,8 @@ static int hmm_pfns_bad(unsigned long addr,
>  			unsigned long end,
>  			struct mm_walk *walk)
>  {
> -	struct hmm_range *range = walk->private;
> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> +	struct hmm_range *range = hmm_vma_walk->range;
>  	hmm_pfn_t *pfns = range->pfns;
>  	unsigned long i;
>  

This fix looks good. I also checked the other uses of walk->private, of course, 
but it was only this one that was wrong.

I think this patch also belongs in -stable, because it is a simple bug fix.

For the description, well...actually, because ->range is the first element in
struct hmm_vma_walk, you probably end up with the same pointer value, both
before and after this fix. So maybe there are no symptoms to see. Maybe that's
an argument for *not* putting it in -stable, too. I'll leave that question
to more experienced people.

Either way, you can add: 

Reviewed by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
 
