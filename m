Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-838514-1520874686-2-13125374987688534309
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520874686; b=loRdvU0qHk3WEGTjbZ266OTGRml70gF5Q4sYH8mFFRyo/MY
    KHdUEZBfmMI2vrcaBc8IC5yqkBVJr7jk6Xn9KW889Ncw4vT0o5F1NxlR9yMyhZ4k
    T0JAZRO/WB2TsT1pSLwGNXwmFOtv5lh+FdBm9O+bOyHJQhfaTkMCsYPRPSSX+GB4
    et4b/I9LfUpV9XZE2NMRL3mqFcNoocx8gfg2W9KpA/0FBNyzk218h3WMHZS3MDSY
    RZW+bdvy4Rsk0Yq7tnlfy/OS2HOn0lwP0VK/ZW82LIszYlU590XstbaNJwcWELN6
    EYRczM1sUqKJ/Mo5b9kNPhmtnekrMRe2NT0lkyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=cc:subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520874686; bh=MGNP4zdwF0fAMdVUpTHGtJLqO27drIwOCYAkf6tB38A=; b=a
    F5M/OwE+vVW/uiwd7jDBebzxe0i1UKHiQuYX1OrtuoahpSNZKFYY9mN2BePSHakm
    pWd4xDyKglc93Sww9PVKfaKbRjhforwB8wQZYUFcwf+nfqExg47XIMLirrqFDcq0
    KfqJtF4aNRwJwiXUtJzde2nloelkdEGqebXG7csyyVf6xGIvbnTFVM4fcj70qv5e
    Vfn73NELbhnWe/bUtYXrt3v7t6V8L/y0oAYf7/38j2GxTPqgDLSRyg2Fw0cxhRDi
    a06BjNxyfCmV7twTedIb6CpNWUUtsZiBoWO5LLQ79owFcuG/NNTYzEc/MfFiH19z
    ddqBirXq3KmPIKWVoHjqQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeCLRLX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 13:11:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56900 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeCLRLX (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 12 Mar 2018 13:11:23 -0400
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock
 alignment
To: Daniel Vacek <neelx@redhat.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com>
 <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
 <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
 <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
 <CA+G9fYvWm5NYX64POULrdGB1c3Ar3WfZAsBTEKw4+NYQ_mmddA@mail.gmail.com>
 <CACjP9X96_Wtj3WOXgkjfijN-ZXB9pS=K547-JerRq4QKkrYkfQ@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <461ae12b-bdff-0987-3b4e-0d7dbc09b2eb@arm.com>
Date: Mon, 12 Mar 2018 17:11:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACjP9X96_Wtj3WOXgkjfijN-ZXB9pS=K547-JerRq4QKkrYkfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/03/18 16:51, Daniel Vacek wrote:
[...]

> 
> Hmm, does it step back perhaps?
> 
> Can you check if below cures the boot hang?
> 

Yes it does fix the boot hang.

> --nX
> 
> ~~~~
> neelx@metal:~/nX/src/linux$ git diff
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3d974cb2a1a1..415571120bbd 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5365,8 +5365,10 @@ void __meminit memmap_init_zone(unsigned long
> size, int nid, unsigned long zone,
>                          * the valid region but still depends on correct page
>                          * metadata.
>                          */
> -                       pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> +                       unsigned long next_pfn;
> +                       next_pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>                                         ~(pageblock_nr_pages-1)) - 1;
> +                       pfn = max(next_pfn, pfn);
>  #endif
>                         continue;
>                 }
> ~~~~
> 

-- 
Regards,
Sudeep
