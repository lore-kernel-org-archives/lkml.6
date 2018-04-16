Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523906294-2-12450944329154141638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523906293; b=OB4bNzw+tRzs/GMvBcPVLdiQkYxRR2MF10GVsSRp7ZJ6BfLsZy
    SjrRSK5yyNj+ETaMRPX3VhIWnIHepglIRU+oj5dyYDOypsW3LL5VQdRjyWIrt2yg
    Doxs4eAOYpwoe+872c6/JRcwK+1Fx5r+NrtToQjImLI53o6+hM5moyH9SFECV3HW
    UHC/r87odZfaVyuDbS+MKElvWJgfTlsgOm7CxM6q/wDlW6xn1JAoG8yclBsBhlLA
    T2ctAiF1WkTI4QIIoLQqb7FzcbYcW60hMz0gzYk2BBxVkD9uRRNAMG2v+p2ZgHxS
    /eHxb6svpPJtBnAdTiccgyEHFxoHbByewZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523906293; bh=GLtmFH6w1e3QnF5HepnA06e0Ls+3Xb
    SAwxaS9hkhUuk=; b=Z1e8KV1uhJcTD5V2NLU/o3Zlu2Qz4Uq9r2Xh4Vo80Opg5u
    OCcN86HqM58WwpWyrCOfhsFJF5+BDoe7x/skvFMVdRtAIa9xPaBf15O/nkUy6hmo
    as76kAFQWtYFe0+WSv9JPVVPyia0oRIi4qZjufzwMP0r1qtg+7NWaxTRGzfH7pbr
    hqeAI7Fi0bk8MPDoTqUoQ5Hh2/ZiIrPjWj1+R3kAo2yZYP2AoAWMDdeo+dpy2e34
    bax/3sWw0F3+/f7Pvh/pBDRefHZaStZSkLWS5aBCjc/VmCeR5H2AYQ0MAFvyyxfN
    kkcBrGAEuXzXswBin1R+3BGDaqfZ9tLX9Lvm+7Lg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOHYps4lDP3vr/IqvDz2uilemQoxKEYlw4XGnaAxqf52/YXxlHkE+DWleEcWFrpKnAw4Z9L8FVbxL8+ut0El+VbM5LQwjvoEzz/rPSQEXhvRNDcFNm0
    LKpNaa3HBcTjcxTuK0132RNmpSzJPZlEwUUrMVY6pa/IsFxRnGL0Gf3jBvjH2XDvnujw4eh5Pbyd+yJ6m6bveWH2mPLc8aRxuVqp8SFv9p5aZgWxN7WeqmmT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=1ivHrgPY8eDoDwpt3OAA:9
    a=0mWpPuoMEuSqow-X:21 a=QpNy5H4tHK_7QrMc:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeDPTSK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:18:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753182AbeDPTSI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Apr 2018 15:18:08 -0400
Date: Mon, 16 Apr 2018 21:18:05 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-man <linux-man@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
Message-ID: <20180416191805.GS17484@dhcp22.suse.cz>
References: <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
 <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz>
 <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
 <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz>
 <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 15:55:36, Jann Horn wrote:
> On Mon, Apr 16, 2018 at 12:07 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Fri 13-04-18 18:17:36, Jann Horn wrote:
> >> On Fri, Apr 13, 2018 at 6:05 PM, Jann Horn <jannh@google.com> wrote:
> >> > On Fri, Apr 13, 2018 at 6:04 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> >> On Fri 13-04-18 17:04:09, Jann Horn wrote:
> >> >>> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >> >>> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
> >> >>> > [...]
> >> >>> >> So, you mean remove this entire paragraph:
> >> >>> >>
> >> >>> >>               For cases in which the specified memory region has not been
> >> >>> >>               reserved using an existing mapping,  newer  kernels  (Linux
> >> >>> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
> >> >>> >>               should be used instead; older kernels require the caller to
> >> >>> >>               use addr as a hint (without MAP_FIXED) and take appropriate
> >> >>> >>               action if the kernel places the new mapping at a  different
> >> >>> >>               address.
> >> >>> >>
> >> >>> >> It seems like some version of the first half of the paragraph is worth
> >> >>> >> keeping, though, so as to point the reader in the direction of a remedy.
> >> >>> >> How about replacing that text with the following:
> >> >>> >>
> >> >>> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
> >> >>> >>               in a multithreaded program to avoid  the  hazard  described
> >> >>> >>               above.
> >> >>> >
> >> >>> > Yes, that sounds reasonable to me.
> >> >>>
> >> >>> But that kind of sounds as if you can't avoid it before Linux 4.17,
> >> >>> when actually, you just have to call mmap() with the address as hint,
> >> >>> and if mmap() returns a different address, munmap() it and go on your
> >> >>> normal error path.
> >> >>
> >> >> This is still racy in multithreaded application which is the main point
> >> >> of the whole section, no?
> >> >
> >> > No, it isn't.
> >
> > I could have been more specific, sorry.
> >
> >> mmap() with a hint (without MAP_FIXED) will always non-racily allocate
> >> a memory region for you or return an error code. If it does allocate a
> >> memory region, it belongs to you until you deallocate it. It might be
> >> at a different address than you requested -
> >
> > Yes, this all is true. Except the atomicity is guaranteed only for the
> > syscall. Once you return to the userspace any error handling is error
> > prone and racy because your mapping might change under you feet. So...
> 
> Can you please elaborate on why you think anything could change the
> mapping returned by mmap() under the caller's feet?

Because as soon as the mmap_sem is dropped then any other thread can
modify the shared address space.

> When mmap() returns a memory area to the caller, that memory area
> belongs to the caller. No unrelated code will touch it, unless that
> code is buggy.

Yes, reasonably well written application will not have this problem.
That, however, requires an external synchronization and that's why
called it error prone and racy. I guess that was the main motivation for
that part of the man page.
-- 
Michal Hocko
SUSE Labs
