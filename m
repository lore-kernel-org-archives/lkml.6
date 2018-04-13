Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4073160-1523636282-5-15976401924795397988
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
    1523636281; b=F6Q586s/SZvvXmT4ol44L5V2pMAsuvy4N4Dz1mSSITXtqO1pM9
    QNJ4gtHn+U4hwjKJ+7HN8Fxe0ip6vlEDAxNDtCjZh0A1D9GIjd7NblkJKD4K7pN6
    M5LFOecXq7mXLmXCXq0IpAu3JcSNZHETBLmdFykKEudFH6hbVTj87ZfzVjPeBjVv
    zYffloGs1Rw2Ls8dJWR+h6xH/dwqIv/LqfCTEFWUUDF97+FzMbnerHVON9fBFqe0
    OtVlgDvtS/YzZVvi6ZldX9d7lmn1T54FMm1CjcGAQxkT/WHzWRSYn7oa2k6LNBVC
    2YJ1kUY3zsujWIpmkZ7WTnXvD3TX+GiYY4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523636281; bh=zlLq/V0rvw3n0WV/gOkqxnfvCMRQx9A59G6R9vKfxf
    E=; b=CdyPBmObDM5/00QxKw/3seXlVFytgpBqlXMg8lm7KNlLJGxN5erKfGobhF
    zpMyVZKqCo6ismd/fNV1OpMQpeUZ2mY4SlQOYrhou5k+MRi/rRLHpDjO3Odk2p2p
    PSWcClD9kHq338O/ndNwBsFVaeR0pZovG7Lu1Re+ekuTGrcv08Ml3O1hZ5rZ3Ruv
    5RdCj2vGEeFMrZ2eMaNG6dz+T1G5qghixGtp9UAoi2NGjq2XhUKQW9+k/50LOVf/
    UsVYaqPJLXUORNqQ2jQHVRgzgp+cYYfSK4PvbYrmcEO7SsKgQwFZPx/C65g/Bgh9
    nWbogkhEg5q40jZrS+K3F0KBszEA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZJRMKLcr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufo16AnB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ZJRMKLcr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufo16AnB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAh5DdGDPA7kJ5rGDaPJUMl0dZU2HyDIEqS61NGXt+aepOn0J7JR1jtdCcVslCBOXeR4TBppzMKvDuZVSurUwMQ6cJz/pYrUwXtU7GgI8dY2MZiPeXa2
    SPLcHf+xqDGXYuyxNrwKihb6UKDW+eP4SKE5ZFoJGciPvIx91ozjVGIfrvvgWi7eW2BwbQnecUx4iRZ3leReB/FsRZnPBc1yYED6zHmIqQxjFeMGCPvEmb3L
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=a3kDleBxXQSkNk-Bq6UA:9
    a=qmvaqIFPaloTHcm4:21 a=kIsR0GuXJ0ictSkD:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeDMQR7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:17:59 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34082 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeDMQR6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 12:17:58 -0400
X-Google-Smtp-Source: AIpwx4/KdEaHEp38gWuF5027bH7Jbqq2szJ7n3lj/kIZKnzc+lBi9obikUeRDfBADuPHZQoOua9pAHKIB200/8jk7SY=
MIME-Version: 1.0
In-Reply-To: <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com> <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com> <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz> <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz> <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 13 Apr 2018 18:17:36 +0200
Message-ID: <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
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

On Fri, Apr 13, 2018 at 6:05 PM, Jann Horn <jannh@google.com> wrote:
> On Fri, Apr 13, 2018 at 6:04 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> On Fri 13-04-18 17:04:09, Jann Horn wrote:
>>> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
>>> > [...]
>>> >> So, you mean remove this entire paragraph:
>>> >>
>>> >>               For cases in which the specified memory region has not been
>>> >>               reserved using an existing mapping,  newer  kernels  (Linux
>>> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
>>> >>               should be used instead; older kernels require the caller to
>>> >>               use addr as a hint (without MAP_FIXED) and take appropriate
>>> >>               action if the kernel places the new mapping at a  different
>>> >>               address.
>>> >>
>>> >> It seems like some version of the first half of the paragraph is worth
>>> >> keeping, though, so as to point the reader in the direction of a remedy.
>>> >> How about replacing that text with the following:
>>> >>
>>> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
>>> >>               in a multithreaded program to avoid  the  hazard  described
>>> >>               above.
>>> >
>>> > Yes, that sounds reasonable to me.
>>>
>>> But that kind of sounds as if you can't avoid it before Linux 4.17,
>>> when actually, you just have to call mmap() with the address as hint,
>>> and if mmap() returns a different address, munmap() it and go on your
>>> normal error path.
>>
>> This is still racy in multithreaded application which is the main point
>> of the whole section, no?
>
> No, it isn't.

mmap() with a hint (without MAP_FIXED) will always non-racily allocate
a memory region for you or return an error code. If it does allocate a
memory region, it belongs to you until you deallocate it. It might be
at a different address than you requested - in that case you can
emulate MAP_FIXED_NOREPLACE by calling munmap() and treating it as an
error; or you can do something else with it.

MAP_FIXED_NOREPLACE is just a performance optimization.
