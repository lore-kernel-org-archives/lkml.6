Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4073160-1523635550-2-10591126586708583973
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
    1523635549; b=Gb6KPgtegsUJf+OyItVeEyJg1Ag8nzBbdQpyk78Wo+R/geBa9Q
    luAaAHI3kT3oocJMpRqozIRVqIoM3nQexDq6OjjE88d4tX9skYARmn84NO9lMf1V
    cwARrZxYUt+f+QTCmdc8DUHhL58lhpwZO8IsAM2V/O1FHq43jZbO+Lf5zGUciGro
    sRG1AIyWa2QtwC/l44rVez1NIJhLLMKe5tQ8S2n4VfR0hS6l16SvLsFPNW+EOFi2
    iyxEsjt45aJFueFjtMgsi3kKExO04G1ZOggkZt7ga8yobdQSyPOE4YLqiExgsw+D
    YSFhXAO3UNVJTRGy8bjzp0kfJ8VLlnszsblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523635549; bh=U/ifQAl3ugLE8Kg3NEsD8krHC0eqCKLMpEoEyOjyCy
    k=; b=nbKTJiXTzwUOrZIMhzrxd1LqixxFxibKM+qt46Da/LbEdQt+cH1o6+pWS4
    P9xR2H1/mRhUVFwNQnEAdRUHnCorxf9JwwXcn5Qc/wCdFcpZztMfS8bkakl1C7bf
    YIL5Ro4kfKy1jhE4zkuOwF6VXPsUvK7DmuRrZThsS2fxBRfwNGqAeja69vpraj53
    5qvn06mL/kQnLDxaEM1bya2fiWzU61FbfEdVTuFOg6/S5khkkpoz/PIuDrogH33W
    pv13TXqtxU8VTyTdBpJbuJX0oL53y3me+OZXpFpmdmvQMaFowwdiC7PUi6ihA40f
    uUW3OESPu4x0EVoCfVaTzKD9b3Xg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=gBLc2iW8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lpLy0z7A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=gBLc2iW8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lpLy0z7A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsYmhKpp6Ysh6ZUW18Q4PCTwUwA6t/6+lNjwywNAZLr2mxf/5qu4L/uYqMHAIOuWsGoVs8OL1xQgi0jEFKnr0kpm7wkY2Jnbh1X6TGP/M+SvIcFjK8s
    YH71hcoaU6q3bv6HmrEE+2prBH1069w7V+pT8XPt9vlp2L56YQTCXMIJRMcGxpvpC/kS+/40ldsEf/6tdjqAe/SBnrapva/rglCkxlmi9M33pcAy0zZTsazD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1Db3cBMgkLxaztUHKHgA:9 a=WzAGw90G5pFzFbU7:21
    a=_8VGiddLuAYC4ErE:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDMQFs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 12:05:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36010 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDMQFq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Apr 2018 12:05:46 -0400
X-Google-Smtp-Source: AIpwx48ZTQ049S7jYzmfC9Sn7pfHORUJaLOMMnOOiKiaKGsCnIPC1zHwV9jVDtwvmm2tGUulXaiqNppKSSsZtEU+ieY=
MIME-Version: 1.0
In-Reply-To: <20180413160435.GA17484@dhcp22.suse.cz>
References: <20180412153941.170849-1-jannh@google.com> <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
 <CAKgNAkgcJ2kCTff0=7=D3zPFwpJt-9EM8yis6-4qDjfvvb8ukw@mail.gmail.com>
 <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com> <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com> <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz> <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 13 Apr 2018 18:05:24 +0200
Message-ID: <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
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

On Fri, Apr 13, 2018 at 6:04 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 13-04-18 17:04:09, Jann Horn wrote:
>> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
>> > [...]
>> >> So, you mean remove this entire paragraph:
>> >>
>> >>               For cases in which the specified memory region has not been
>> >>               reserved using an existing mapping,  newer  kernels  (Linux
>> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
>> >>               should be used instead; older kernels require the caller to
>> >>               use addr as a hint (without MAP_FIXED) and take appropriate
>> >>               action if the kernel places the new mapping at a  different
>> >>               address.
>> >>
>> >> It seems like some version of the first half of the paragraph is worth
>> >> keeping, though, so as to point the reader in the direction of a remedy.
>> >> How about replacing that text with the following:
>> >>
>> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
>> >>               in a multithreaded program to avoid  the  hazard  described
>> >>               above.
>> >
>> > Yes, that sounds reasonable to me.
>>
>> But that kind of sounds as if you can't avoid it before Linux 4.17,
>> when actually, you just have to call mmap() with the address as hint,
>> and if mmap() returns a different address, munmap() it and go on your
>> normal error path.
>
> This is still racy in multithreaded application which is the main point
> of the whole section, no?

No, it isn't.
