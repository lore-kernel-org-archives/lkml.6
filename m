Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523907034-2-2212791344475867267
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
    1523907033; b=c37bwcLg8rhpc9KaK83bKZlk5sEhwdYF4JQzDTRp7za/1hWnAZ
    wyyeqZkVp7XqSADesRsHcWGRbKNQ3VINho8qH5ETxmd4zKDLvzwf95Ld3uKvXi5S
    dzgzhWoFV05IWQmC60xhAOm1rNUruYIS+2YRkPZW4fYIzWJ21SjHDfdGBOZIGoMF
    FYu4XJTnIU/X1/2sxDOqYxIRVr4sRqAeIlH3+Tbov4mWcAlkswn+cnG4Gv8h7cFW
    s/Pb1MXKpUjmLLhDsRfCDFTVUuL2b/qBuDykz0BpPoY0oXD4IOzB5TSAlaMS2g/W
    ykbf7nzhzzPSGmtFB2NXF5T+JBGloEzUYugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523907033; bh=lVWTyrzl1PrQs3NVGDdb+XJOS5C004KXCL//UpK2gU
    s=; b=DQYC7atCy9oX0CHcn37m4TAdrxiKxtbTLDNIWwmR7WDPwvU71ZSyMbQv7s
    rb28YVjQjYmckrIFXcl0epeeAYO++RQjLecjQjnoJAEXCF2oZixWkOeb5k/daZOm
    7aCV6ITQ+D7Gaz+AAxhW70adlwor4RzOPMtt3hqn9y03fWTZzWIItRvwZJcnkGjd
    B7NwhgeAHwlsnIha7gCxIQov+cdTxngr1Ir/HnrnN78hj9i3oCjzo3Q2ZRFLYXvw
    fqxfplmmTjicFNTzVlI/LKy9PGyfPel2HQ/Un4jAcxLYsl2LCUCfcAXzWNivGmM0
    QzIsZ/RDFwFnAgWtgEOHynl100WA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=I+SRcEpp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XSpXsMwl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=I+SRcEpp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XSpXsMwl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYja3pefKmw5bltFKK/vrXvV/z4VsxeKjdEmKYNhn9L0RGoI3FKwCclYJYOevY0oHenJqp3iq4B0uVvSGsjhMrRPjwDRWWmQJFNqepeDM3PpDHfDDB/
    YXooekTkurHynDRAEftblyt9hQMhKRXB5mjIN9JJMoLYva6YUX013Vpf9j05OzZzsoOqyF64AO/BYtxqeaMaUXilEGOKcXJ0Uq9QUtiGEh+gin8NSZ9v0yjr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=idy-k7s51AI2bQaQLbkA:9
    a=J5fKinUS0XuUj9xt:21 a=4j75bSvzjx7oiINc:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDPTac (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:30:32 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33873 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeDPTaa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Apr 2018 15:30:30 -0400
X-Google-Smtp-Source: AIpwx492xdV43C5g9Wgjf79OBMr469w0ESVfrFR9DieoLfXf0mQ8+PpijpDQl4MFeafSK6E58vK4uEFaABALYAbMc6E=
MIME-Version: 1.0
In-Reply-To: <20180416191805.GS17484@dhcp22.suse.cz>
References: <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com> <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz> <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz> <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz> <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz>
From: Jann Horn <jannh@google.com>
Date: Mon, 16 Apr 2018 21:30:09 +0200
Message-ID: <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
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

On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 16-04-18 15:55:36, Jann Horn wrote:
>> On Mon, Apr 16, 2018 at 12:07 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Fri 13-04-18 18:17:36, Jann Horn wrote:
>> >> On Fri, Apr 13, 2018 at 6:05 PM, Jann Horn <jannh@google.com> wrote:
>> >> > On Fri, Apr 13, 2018 at 6:04 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> >> >> On Fri 13-04-18 17:04:09, Jann Horn wrote:
>> >> >>> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
>> >> >>> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
>> >> >>> > [...]
>> >> >>> >> So, you mean remove this entire paragraph:
>> >> >>> >>
>> >> >>> >>               For cases in which the specified memory region has not been
>> >> >>> >>               reserved using an existing mapping,  newer  kernels  (Linux
>> >> >>> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
>> >> >>> >>               should be used instead; older kernels require the caller to
>> >> >>> >>               use addr as a hint (without MAP_FIXED) and take appropriate
>> >> >>> >>               action if the kernel places the new mapping at a  different
>> >> >>> >>               address.
>> >> >>> >>
>> >> >>> >> It seems like some version of the first half of the paragraph is worth
>> >> >>> >> keeping, though, so as to point the reader in the direction of a remedy.
>> >> >>> >> How about replacing that text with the following:
>> >> >>> >>
>> >> >>> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
>> >> >>> >>               in a multithreaded program to avoid  the  hazard  described
>> >> >>> >>               above.
>> >> >>> >
>> >> >>> > Yes, that sounds reasonable to me.
>> >> >>>
>> >> >>> But that kind of sounds as if you can't avoid it before Linux 4.17,
>> >> >>> when actually, you just have to call mmap() with the address as hint,
>> >> >>> and if mmap() returns a different address, munmap() it and go on your
>> >> >>> normal error path.
>> >> >>
>> >> >> This is still racy in multithreaded application which is the main point
>> >> >> of the whole section, no?
>> >> >
>> >> > No, it isn't.
>> >
>> > I could have been more specific, sorry.
>> >
>> >> mmap() with a hint (without MAP_FIXED) will always non-racily allocate
>> >> a memory region for you or return an error code. If it does allocate a
>> >> memory region, it belongs to you until you deallocate it. It might be
>> >> at a different address than you requested -
>> >
>> > Yes, this all is true. Except the atomicity is guaranteed only for the
>> > syscall. Once you return to the userspace any error handling is error
>> > prone and racy because your mapping might change under you feet. So...
>>
>> Can you please elaborate on why you think anything could change the
>> mapping returned by mmap() under the caller's feet?
>
> Because as soon as the mmap_sem is dropped then any other thread can
> modify the shared address space.
>
>> When mmap() returns a memory area to the caller, that memory area
>> belongs to the caller. No unrelated code will touch it, unless that
>> code is buggy.
>
> Yes, reasonably well written application will not have this problem.
> That, however, requires an external synchronization and that's why
> called it error prone and racy. I guess that was the main motivation for
> that part of the man page.

What requires external synchronization? I still don't understand at
all what you're talking about.

The following code:

void *try_to_alloc_addr(void *hint, size_t len) {
  char *x = mmap(hint, len, ...);
  if (x == MAP_FAILED) return NULL;
  if (x == hint) return x;
  munmap(x, len);
  return NULL;
}

has no need for any form of external synchronization. You can call it
in library code, you can call it in a multithreaded process, you can
call it wherever and it should be safe.

mmap() atomically reserves previously unallocated memory, and nothing
else should be touching that memory until it is released again using
munmap(). (Just like malloc(): When you call malloc(), you get a chunk
of memory that is reserved just for you, and nobody else will scribble
over it until you call free().)
