Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523913080-2-10261061398123917261
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
    1523913080; b=JdnDPIGUBFv0CqPE1xqyPy5vZ/blloV0USadDk3eYo9tlzTnvF
    0EAEKBZV5Ke12EkxYR4adtyf/SqWC77fa3ntetQFxvuctUHJpJMMj7MKGZX6TUM2
    KHjdGSL8CQlD/TLRgpMgy0YtNt2nkWKkoS04HTxdnlFY8BsZmnvMCttU6OQDfv8k
    LObYnGRFk3obXx/BVisFzR2GS68EDZpRzFx1zy4Y107LOAL+1uo2o9jUHMpfzWqE
    XWFJcfAnrPBwPGvxp3HpwTzntE8qxTm6bhX7/79wRa7F1OutraEeDN+qpcLtTOPI
    1LoeQI+P2yN5urVgnEveFOqUh7fZ2o1edPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523913080; bh=PfA/kvmrbv3TnjD6+0fAiLiE6EdYsT
    3NH35pJ0yc3rI=; b=nYt4WhZQY9GGy4uW3gQSJEIGRUC/6e1QZsi2FChW3TrxwD
    MIxZrKwc08vufuyKeynNOK3XRXvdbrwZPm0ufjG+jIjq7ABomUG8jzquPw+4jWuX
    Rx7r/wF4HwceW4X5+fXeotzNReUajFE1ZBsS09+6DA9B45z6DRZSP2Lhxe4uXQsy
    AUA5INI68ptOFWKRtUI6c7WprmuVpLgbpeyiuE8opaZNrqB7ZEGBFUgEgKi6mD7r
    8SpmRO48HSKJTZMV88ARJpXhRjTnMFAbyEbdvKS00tguk8m6g9n38ilp9eYlMiqz
    zdUJN4xS8JRuoJTDCkPBdXbidMxjucycM6IXFu3Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfCpgNHNScxNstlYDM16iTq3GjbNk/gkZP7v5pFRKsOKDtkzmaN1Htm6jwl0ObbHka4AtUws0UzNjzgsGiFhE6ov1ZRQi+GXEBwyP1za288RrSPH42yb9
    71pAt8W2pACU0Wdu5CF9acvwSmzBTZQJdY3MnKHxjmObVG1w1kui5rs0aW6Ruz+H92mkqSI2lsH2cRZBbj0tG1IWCM/O+CMF5aZuiSaPiBBod8ZiNLjfRX94
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vYW5QEwBNTZWlwBkRgcA:9 a=jP4a7MM4HPknIPhy:21
    a=Ghf98AOAEyfbC8r3:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeDPVLT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:11:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751489AbeDPVLS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Apr 2018 17:11:18 -0400
Date: Mon, 16 Apr 2018 23:11:15 +0200
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
Message-ID: <20180416211115.GU17484@dhcp22.suse.cz>
References: <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
 <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz>
 <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz>
 <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
 <20180416195726.GT17484@dhcp22.suse.cz>
 <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 22:17:40, Jann Horn wrote:
> On Mon, Apr 16, 2018 at 9:57 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Mon 16-04-18 21:30:09, Jann Horn wrote:
> >> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > [...]
> >> > Yes, reasonably well written application will not have this problem.
> >> > That, however, requires an external synchronization and that's why
> >> > called it error prone and racy. I guess that was the main motivation for
> >> > that part of the man page.
> >>
> >> What requires external synchronization? I still don't understand at
> >> all what you're talking about.
> >>
> >> The following code:
> >>
> >> void *try_to_alloc_addr(void *hint, size_t len) {
> >>   char *x = mmap(hint, len, ...);
> >>   if (x == MAP_FAILED) return NULL;
> >>   if (x == hint) return x;
> >
> > Any other thread can modify the address space at this moment.
> 
> But not parts of the address space that were returned by this mmap() call.
?
> > Just
> > consider that another thread would does mmap(x, MAP_FIXED) (or any other
> > address overlapping [x, x+len] range)
> 
> If the other thread does that without previously having created a
> mapping covering the area in question, that would be a bug in the
> other thread.

MAP_FIXED is sometimes used without preallocated address ranges.

> MAP_FIXED on an unmapped address is almost always a bug
> (excluding single-threaded cases with no library code, and even then
> it's quite weird) - for example, any malloc() call could also cause
> libc to start using the memory range you're trying to map with
> MAP_FIXED.

Yeah and that's why we there is such a large paragraph in the man page
;)

> > becaus it is seemingly safe as x
> > != hint.
> 
> I don't understand this part. Are you talking about a hypothetical
> scenario in which a programmer attempts to segment the virtual memory
> space into areas that are exclusively used by threads without creating
> memory mappings for those areas?

Yeah, that doesn't sound all that over-exaggerated, right? And yes,
such a code would be subtle and most probably buggy. I am not trying to
argue for those hypothetical cases. All I am saying is that MAP_FIXED is
subtle.

I _do_ agree that using it solely on the preallocated and _properly_
managed address ranges is safe. I still maintain my position on error
prone though. And besides that there are usecases which do not operate
on preallocated address ranges so people really have to be careful.

I do not really care what is the form. I find the current wording quite
informative and showing examples of how things might be broken. I do
agree with your remark that "MAP_FIXED on preallocated ranges is safe"
should be added. But MAP_FIXED is dangerous API and should have few big
fat warnings.
-- 
Michal Hocko
SUSE Labs
