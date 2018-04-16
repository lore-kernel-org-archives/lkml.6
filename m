Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523913194-2-7224147508327996462
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
    1523913193; b=DVYk5Bnaq1RWdj/QgHJybEcjldgmspAkGRr5wxP2+eJpk/5/qq
    b3+TN1Vl7/ws9rBQrA6vIvlLGX+cJSwsywAG3rMFy1PFzQg2P4exBI9PCqahME3l
    ZzDNdvTR0CVuXfrSZxf3EgaroBGckbEQe6OZgEZs3p5WEIsIpQTxC6xzZgDttzWK
    20DQSNFNxj80mBCYzRVHSbb6R1bvmiR7jlRcdmQdiVTKyWYwhXXCrFN31voAvnUG
    iyx6xHCkOtUA7gu75qT43F7BQrzcketybdkFqgzFvaDS86bR/+OT39ZgOJjj9asN
    WBxv5ku7DzrwKo+tb8pzRlOHPQOaJEgfcXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523913193; bh=5dQ0oDnrjch0iyvbCf3FKTM+NxbkcNEJOZtEYtT6m5
    I=; b=ULtDttJjt7380DPi7VYtakw0HxmEUoBMVCJvAyo16+fwAYzshNikeDzKaU
    FO3aaR6wh1rPP2CKj/RZGO95yPV7PW7W2Ztw1idZnGuZ1Eey24PUbWR03bSBwwzI
    rUtWBq0Xyp0SkXYiI7R920QdRAEuUd+KU4lx+Cyd6fEXm4sit5tEBL3fBf0g39L5
    zAUouoNjAowxFt9U64fiSsbfCHmOliyWJ4aMIccu/GSSWKcFLB6TCsTi98pLpn7g
    R/KdjHlHjLqgfsSP8jWjXj2bwUSYabdW//cFlnMRJvEIkJXGwErGfe0oxE1WjYg7
    o8bGTeaeoCdEMrWDElBEtD4l2Vpw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lospbOj1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uDQU6NCt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=lospbOj1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uDQU6NCt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB3ybYAtkTmnZ3piP3MJAvEveX6m0Teboh1EKWleXdqNGWuIJc0qsKN/s7OTo3nylZip+N3vxBoYIVPn6k7Ah4UDVuoTa4cTKnAzbi9WLzKlHx9dZT6m
    VxtplgxVYr9rcsRGCHZ7Mu5tAY+VT02kKJiBNE/AE6EegTWega1wt5QV16EFHBc6SR7WUTkDmXbdD+h/yTKbL8D8IwsEzFlZlS2zUGT9BnBHJYj9tr0shsow
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=kB60VVGfhrFvc-s97boA:9 a=Unc3CagEBUGAHv00:21
    a=ltOrOqg4KsoJIKyW:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbeDPVNL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:13:11 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:38510 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPVNJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 17:13:09 -0400
X-Google-Smtp-Source: AIpwx4+x6Y27AlC11n6qZwJH9/NLIRpDlPS9C89EAgEnUuDedhdInAeeAwCpNoEGLATmSwC/HKDtugQ7y0fOhsE2kN0=
MIME-Version: 1.0
In-Reply-To: <20180416211115.GU17484@dhcp22.suse.cz>
References: <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz> <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz> <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz> <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
 <20180416195726.GT17484@dhcp22.suse.cz> <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
 <20180416211115.GU17484@dhcp22.suse.cz>
From: Jann Horn <jannh@google.com>
Date: Mon, 16 Apr 2018 23:12:48 +0200
Message-ID: <CAG48ez2fXcQS7sw_aCC6_wBKjYphOxFRN4rrRzSk2+-T_mFaxw@mail.gmail.com>
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

On Mon, Apr 16, 2018 at 11:11 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 16-04-18 22:17:40, Jann Horn wrote:
>> On Mon, Apr 16, 2018 at 9:57 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Mon 16-04-18 21:30:09, Jann Horn wrote:
>> >> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > [...]
>> >> > Yes, reasonably well written application will not have this problem.
>> >> > That, however, requires an external synchronization and that's why
>> >> > called it error prone and racy. I guess that was the main motivation for
>> >> > that part of the man page.
>> >>
>> >> What requires external synchronization? I still don't understand at
>> >> all what you're talking about.
>> >>
>> >> The following code:
>> >>
>> >> void *try_to_alloc_addr(void *hint, size_t len) {
>> >>   char *x = mmap(hint, len, ...);
>> >>   if (x == MAP_FAILED) return NULL;
>> >>   if (x == hint) return x;
>> >
>> > Any other thread can modify the address space at this moment.
>>
>> But not parts of the address space that were returned by this mmap() call.
> ?
>> > Just
>> > consider that another thread would does mmap(x, MAP_FIXED) (or any other
>> > address overlapping [x, x+len] range)
>>
>> If the other thread does that without previously having created a
>> mapping covering the area in question, that would be a bug in the
>> other thread.
>
> MAP_FIXED is sometimes used without preallocated address ranges.

Wow, really? Can you point to an example?

>> MAP_FIXED on an unmapped address is almost always a bug
>> (excluding single-threaded cases with no library code, and even then
>> it's quite weird) - for example, any malloc() call could also cause
>> libc to start using the memory range you're trying to map with
>> MAP_FIXED.
>
> Yeah and that's why we there is such a large paragraph in the man page
> ;)
>
>> > becaus it is seemingly safe as x
>> > != hint.
>>
>> I don't understand this part. Are you talking about a hypothetical
>> scenario in which a programmer attempts to segment the virtual memory
>> space into areas that are exclusively used by threads without creating
>> memory mappings for those areas?
>
> Yeah, that doesn't sound all that over-exaggerated, right? And yes,
> such a code would be subtle and most probably buggy. I am not trying to
> argue for those hypothetical cases. All I am saying is that MAP_FIXED is
> subtle.
>
> I _do_ agree that using it solely on the preallocated and _properly_
> managed address ranges is safe. I still maintain my position on error
> prone though. And besides that there are usecases which do not operate
> on preallocated address ranges so people really have to be careful.
>
> I do not really care what is the form. I find the current wording quite
> informative and showing examples of how things might be broken. I do
> agree with your remark that "MAP_FIXED on preallocated ranges is safe"
> should be added. But MAP_FIXED is dangerous API and should have few big
> fat warnings.
> --
> Michal Hocko
> SUSE Labs
