Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109416-1523909884-2-14031220268722738277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523909884; b=mDQFwI6g5eQhw32XH+vOKMnGn8/FAeSIaUuhjaCkumQPdP1pKc
    DmVWzMeYuDSSq1mFBvYHmJKE02Jm/CVUH+Lzqw6RUnsnRrQ7kwe4zUSBwMO50Wgp
    0WJFNfU42ZCCZHzHZs6h+us8l/8jgqN7ODH2vHGRF0KHqFILngqBCFxvcR0KtEOn
    1bIn1fO97fDC5Wqli1UIfe61SjJbjJJKmx6Y0lmpS9/6xymweWesA7ifGSma1ZD3
    nNWtFHZQw3JwOdsFfU9BHuDt0z/ase89OkB74fZjUr5u3/fZq0d2Qr6W0WhPE7kL
    Kpgb9dp4e0WoTVRFcDDKRN6QAVbZ5PCadvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523909884; bh=XG3ffrK9vRogyc0FBYrpjgtJqXVKZ2kPKjGYOKonjl
    k=; b=coGNxYqRgFe2Z+1YwQn/r57L4g3uJDudjNSUf26uG9usmT+SS+U0Nle5y4
    cxJcUFiuGA+h1iXKrXl9OMi76YwQPEKICTnoJB2TUEalqf/v+YLX5B6GPT7xoAya
    7grZ6ZNc9keVKbmDKsx6MWauu3CYVaQLX6gZIQkRi8RZ3IYOyFX2w25I/0bazKra
    clV6b+XCKf6FPGhgPyJKpXvJfe7O9vqCfGyXn1QOoW+Pl9eK0pBwU5KBJezZ7xPq
    LvkOmp+ETaYsXicCl4Bag3TE66KgAyd9teB2OKtGf/1ShRC8cKVQv6cDO8XPtW70
    t+DB3EqnUP2xl4dgonf46vIkA9mA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=InZ1d0BM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPYKoZan;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=InZ1d0BM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPYKoZan;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHClWlh0IMXzCatV5N4tBUhHNQb9gzAECXcBpCPcphTKedg0wP0SmNCiq62g+JMqHnlusJEkIetEQjH7DaLyGeXOssU4D1aJn8avmTyUDGpJ/fa4woRK
    iM6Nh2xHTCIIIIGLc7+OX69M4PPYbE3Js5ICUdBNNdCnzecFQ7/LGkjM92LG2dqYlARGnLGL9z0dhn9sZMBbm1ouUBUZGlvtumJs8w6ChIvJXBszdK+NcaiN
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=_CWdEPY_mdm_l_k2fJoA:9 a=LPWRucdLaZtYYgqR:21
    a=uQcWg0DCWBY7-fk9:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDPUSC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:18:02 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34086 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPUSB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 16:18:01 -0400
X-Google-Smtp-Source: AIpwx481/TairjVSeMRtLd+SZRE+14r1A0qfJ4QbYq1Lf2b4J2uti4CDXTWbstvXb6aUqUWperMl03QFyJi67kZtZJI=
MIME-Version: 1.0
In-Reply-To: <20180416195726.GT17484@dhcp22.suse.cz>
References: <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz> <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz> <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz> <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz> <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
 <20180416195726.GT17484@dhcp22.suse.cz>
From: Jann Horn <jannh@google.com>
Date: Mon, 16 Apr 2018 22:17:40 +0200
Message-ID: <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been reserved
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 9:57 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 16-04-18 21:30:09, Jann Horn wrote:
>> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
> [...]
>> > Yes, reasonably well written application will not have this problem.
>> > That, however, requires an external synchronization and that's why
>> > called it error prone and racy. I guess that was the main motivation for
>> > that part of the man page.
>>
>> What requires external synchronization? I still don't understand at
>> all what you're talking about.
>>
>> The following code:
>>
>> void *try_to_alloc_addr(void *hint, size_t len) {
>>   char *x = mmap(hint, len, ...);
>>   if (x == MAP_FAILED) return NULL;
>>   if (x == hint) return x;
>
> Any other thread can modify the address space at this moment.

But not parts of the address space that were returned by this mmap() call.

> Just
> consider that another thread would does mmap(x, MAP_FIXED) (or any other
> address overlapping [x, x+len] range)

If the other thread does that without previously having created a
mapping covering the area in question, that would be a bug in the
other thread. MAP_FIXED on an unmapped address is almost always a bug
(excluding single-threaded cases with no library code, and even then
it's quite weird) - for example, any malloc() call could also cause
libc to start using the memory range you're trying to map with
MAP_FIXED.

> becaus it is seemingly safe as x
> != hint.

I don't understand this part. Are you talking about a hypothetical
scenario in which a programmer attempts to segment the virtual memory
space into areas that are exclusively used by threads without creating
memory mappings for those areas?

> This will succeed and ...
>>   munmap(x, len);
> ... now you are munmaping somebody's else memory range
>
>>   return NULL;
>
> Do code _is_ buggy but it is not obvious at all.
>
>> }
>>
>> has no need for any form of external synchronization.
>
> If the above mmap/munmap section was protected by a lock and _all_ other
> mmaps (direct or indirect) would use the same lock then you are safe
> against that.
