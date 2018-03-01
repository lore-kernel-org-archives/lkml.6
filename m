Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3314020-1519921242-2-1889045151920963990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921242; b=gqTqvEqV2tjGxe5eYF9qZBlFtSFQQXflBjUVeDO7feZ1Ev5
    s77Hvg43Q2PLefzv2osJfnsGdLqurHObVNzT4/65bOemSxRculiPq8HJU5SVWYyV
    nsPS1AuOw70XUIQk6X+PZbDWALQPjn32tlnM0OPZzwRnp1jzdm/3C5GaEScjpwnw
    GQYI6P+7nQByuVaMURwjeGHuTBm0iCP0HXNx0oCB94ujcdawc7QMXKNY1Ny8D/QN
    CUhvv5pDDSFcdwxSjKLiB0Tx5MEds3MCO2Xzo5+rMCSoRqCuwEIFyPeLdv2ANmYf
    u3aZULZZx+zlntH4514kjvoJ0M6RURfadTQZWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519921242; bh=AT/1u9/miHB82rFJb3gq79g0Vx20UtJ1g7F1pI
    3tvBk=; b=SL1dLQkinX/Cxgur2WbRoUtfYdWRrntEUiBfKZ723+6fTFpxg9sK4v
    w3NINZzX2Z6QeuNW/oqUJYOGWbhPZElf6IbsGU3vhbC9P4Y0V+wXiSQrhxdS8zUT
    xQ+RwR1zvytRk+8wq3+agOGlLpdKGvPQBo5BPH9NXYpVxvPa+cuShjARG6QCtDpk
    OTtv2R/QOxObNq4lrvqPnmL2vXcNfJ7X5HJQ33xFMFZcor7r+eVefOKJm8ZaaWw8
    477F2EMeYnsywcwCan2W5WYnD+1aKSh6I5gEldJGw6L0BQQiZv3oYklT1lZdU4BJ
    rNaGtI2iLOKHjVDfp9VJ4HNN+DilsrVw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QPUngHWU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QPUngHWU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032866AbeCAQUH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 11:20:07 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44658 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032539AbeCAQUG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 11:20:06 -0500
X-Google-Smtp-Source: AG47ELvFsabEzAs2OFueDZxz8psCKpTEs8BHd6R//ShtLlwQrFhj6iATqneKQaTMMzEuRTEYfVmzxkHajFaUoXezBP0=
MIME-Version: 1.0
In-Reply-To: <20180301152729.GM15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz> <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
 <20180301152729.GM15057@dhcp22.suse.cz>
From: Daniel Vacek <neelx@redhat.com>
Date: Thu, 1 Mar 2018 17:20:04 +0100
Message-ID: <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 4:27 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-03-18 16:09:35, Daniel Vacek wrote:
> [...]
>> $ grep 7b7ff000 /proc/iomem
>> 7b7ff000-7b7fffff : System RAM
> [...]
>> After commit b92df1de5d28 machine eventually crashes with:
>>
>> BUG at mm/page_alloc.c:1913
>>
>> >         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
>
> This is an important information that should be in the changelog.

And that's exactly what my seven very first words tried to express in
human readable form instead of mechanically pasting the source code. I
guess that's a matter of preference. Though I see grepping later can
be an issue here.

>> >From registers and stack I digged start_page points to
>> ffffe31d01ed8000 (note that this is
>> page ffffe31d01edffc0 aligned to pageblock) and I can see this in memory dump:
>>
>> crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
>> 7b800000 7ffff000 80000000
>>       PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>> ffffe31d01e00000  78000000                0        0  0 0
>> ffffe31d01ed7fc0  7b5ff000                0        0  0 0
>> ffffe31d01ed8000  7b600000                0        0  0 0    <<<< note
>
> Are those ranges covered by the System RAM as well?
>
>> that nodeid and zonenr are encoded in top bits of page flags which are
>> not initialized here, hence the crash :-(
>> ffffe31d01edff80  7b7fe000                0        0  0 0
>> ffffe31d01edffc0  7b7ff000                0        0  1 1fffff00000000
>> ffffe31d01ee0000  7b800000                0        0  1 1fffff00000000
>> ffffe31d01ffffc0  7ffff000                0        0  1 1fffff00000000
>
> It is still not clear why not to do the alignment in
> memblock_next_valid_pfn rather than its caller.

As it's the mem init which needs it to be aligned. Other callers may
not, possibly?
Not that there are any other callers at the moment so it really does
not matter where it is placed. The only difference would be the end of
the loop with end_pfn vs aligned end_pfn. And it looks like the pure
(unaligned) end_pfn would be preferred here. Wanna me send a v2?

> --
> Michal Hocko
> SUSE Labs
