Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2201478-1520922891-2-8984694987978942139
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520922891; b=oYrNvmhNhFwqhkRJBuDAc7GcXWgyG/x7n8RrCOZPt8YVek0
    qb5lAZBtKY21Rj2TXJ4P3gA1bVqAkO36ND1DroLdLPwR58NfdYKEIbSBt8KrWCRn
    ODPh3fdbUPuVOyhiOHCgOs+WNbMxGBtInYS3dpWd51bk7XDj/p8LowhuzLrWL/Fp
    xnCZvx4yUnlQdOCg6YISbr8HNI/qJHruN6LwOPh2j3X8D4Nlm44LYESxJVJFrIcO
    HseUsndBY35Pw2F4bDAo2sTAwXgPa49VxoFV+KxKjgXc374iXt9/gIKbeIv8X3Nk
    dD8K1joquVU5KkVEbrAHzsip1UQseuRtBgFQpJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520922891; bh=PfS6zrkg9i87fR8dKLgXz6vGVg4mvcb4G0tJLd
    KJ04c=; b=k4emRYTgH6xW1+MSQFkJK7EpkgromuMi8TbJw1xTLdws537bK2KyKq
    /xOs3kJ3HwT2FYgBm0zqSiet5qOdEx9Hb9Q8X55d867+L6P510HzfxrPMEv7X/wT
    67KDEojSi4gGGHLdmYeXvE1Kg71essDU1xKICxm58Lfmwl74EBVd3VGKfN28RXjK
    lnSw+OQWI8YbH/ZrZB4LSFP/MNU7wQPjFyPuKRKugJLhXvYJBLCIXKtCGXSDaZ8N
    7kkO1J2Ur8ceHGtbGYjpJKbUcQHJyV1akq+CAopYfWLOguNQZ0heiAjAjWYbNyBm
    bYqAkEfNYU7PW7PmZReHkcC7qTnk0uCw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QUGrSX0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qx1KLjNB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=QUGrSX0l x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qx1KLjNB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeCMGes (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 02:34:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41159 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCMGer (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 02:34:47 -0400
X-Google-Smtp-Source: AG47ELt3hyEKjxGLaBZddo4F0mMgJ17OTD/8hZ9x0oOnMyQ/LF9xezLpubgTsQeUm+lqirC85Df7nyaDbjk4aqLfOV8=
MIME-Version: 1.0
In-Reply-To: <CACjP9X96_Wtj3WOXgkjfijN-ZXB9pS=K547-JerRq4QKkrYkfQ@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com> <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
 <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com>
 <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
 <CA+G9fYvWm5NYX64POULrdGB1c3Ar3WfZAsBTEKw4+NYQ_mmddA@mail.gmail.com> <CACjP9X96_Wtj3WOXgkjfijN-ZXB9pS=K547-JerRq4QKkrYkfQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Mar 2018 12:04:45 +0530
Message-ID: <CA+G9fYth0DVemSK3Sp8aRc9mzDAq0==WW08Gq1L5JjxWg-a+Gw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Daniel Vacek <neelx@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 March 2018 at 22:21, Daniel Vacek <neelx@redhat.com> wrote:
> On Mon, Mar 12, 2018 at 3:49 PM, Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
>> On 12 March 2018 at 17:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> Hi,
>>>
>>> I couldn't find the exact mail corresponding to the patch merged in v4.16-rc5
>>> but commit 864b75f9d6b01 "mm/page_alloc: fix memmap_init_zone
>>> pageblock alignment"
>>> cause boot hang on my ARM64 platform.
>>
>> I have also noticed this problem on hi6220 Hikey - arm64.
>>
>> LKFT: linux-next: Hikey boot failed linux-next-20180308
>> https://bugs.linaro.org/show_bug.cgi?id=3676
>>
>> - Naresh
>>
>>>
>>> Log:
>>> [    0.000000] NUMA: No NUMA configuration found
>>> [    0.000000] NUMA: Faking a node at [mem
>>> 0x0000000000000000-0x00000009ffffffff]
>>> [    0.000000] NUMA: NODE_DATA [mem 0x9fffcb480-0x9fffccf7f]
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000f8f9afff]
>>> [    0.000000]   node   0: [mem 0x00000000f8f9b000-0x00000000f908ffff]
>>> [    0.000000]   node   0: [mem 0x00000000f9090000-0x00000000f914ffff]
>>> [    0.000000]   node   0: [mem 0x00000000f9150000-0x00000000f920ffff]
>>> [    0.000000]   node   0: [mem 0x00000000f9210000-0x00000000f922ffff]
>>> [    0.000000]   node   0: [mem 0x00000000f9230000-0x00000000f95bffff]
>>> [    0.000000]   node   0: [mem 0x00000000f95c0000-0x00000000fe58ffff]
>>> [    0.000000]   node   0: [mem 0x00000000fe590000-0x00000000fe5cffff]
>>> [    0.000000]   node   0: [mem 0x00000000fe5d0000-0x00000000fe5dffff]
>>> [    0.000000]   node   0: [mem 0x00000000fe5e0000-0x00000000fe62ffff]
>>> [    0.000000]   node   0: [mem 0x00000000fe630000-0x00000000feffffff]
>>> [    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
>>> [    0.000000]  Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
>>>
>>> On Sat, Mar 3, 2018 at 1:08 AM, Daniel Vacek <neelx@redhat.com> wrote:
>>>> On Sat, Mar 3, 2018 at 1:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>>>>>
>>>>> This makes me wonder whether a -stable backport is really needed...
>>>>
>>>> For some machines it definitely is. Won't hurt either, IMHO.
>>>>
>>>> --nX
>
> Hmm, does it step back perhaps?
>
> Can you check if below cures the boot hang?
>
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

After applying this patch on linux-next the boot hang problem resolved.
Now the hi6220-hikey is booting successfully.
Thank you.

- Naresh

> ~~~~
