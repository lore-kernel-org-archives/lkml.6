Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891931-1523946198-2-6833290422107698212
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
    1523946197; b=O9X8ydtknOLaUDFN3fnd04s70yNtrtDRXusbrifrVFrCkgj2aP
    H1zt0ePUeRk2uOmqHiDloe4tq0Z74XycWuX7TD5T9fsu+JBvKwrmhzn1WywKZOzC
    Hqes62SCPdkw++rODOkK8dDUbRiaYFA5XEVXSPF62rsEUxI+TGk2mcxkmvSJnCU8
    Y6RT9M8mDu1wb9FCBVCTpGGDxj9QGRKfQ+Bn5Ijw/ek+5R5im3lRBtUg4A+5YsaG
    5QUnmFRMvAL+kNz44NdXtMi9DUuci43RTsrRkPXgwYsvt3kD8P/aP6FAsNVVEvt5
    4kvB3lqZM4f7EGR6smm/foQnMcZlthW42Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523946197; bh=mtnNg27hXt5NUoEPvbLzqKttLuW/rW
    JJ2J1hX3tgv+Q=; b=RtRK+pRgGeKFjIB7Px7bg8v13EmGzuEVb6xB1/5DhE1+ha
    RNMgIwZo0G0YDGFyp3VLChDaM+pKty/Q//AjCzs0pXxdmTH3SPPbogMedO8OIhgJ
    igetvo+IpHEosrzOS0cZXZTCfrgSNv5CUepoU6ZN7nWAPcyoRro625OVu7MG4CQA
    DuGjXeu+fK1a+crBcoW7cqUE5peelYCGMboGshVKHrIeC26OQvUCEadxEnJlgeIS
    S41yxfhdDeNb4yPhWC7NuA/L93gWGIhgeJLW/YCJW+YlaCCITbt3b2apjg1xZefU
    dOH4YEPWKNx+HhVpMmzReMbCP2FV93GRdh3J2XfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfMkTvevUEPNatKnZ5YD96zQcA2HzkX3kusIeQQ63ZUdc7o0WeJ+blfGe7EMHFUloBPRKpIagX8xQnaPCcfFHG9lvvf+YOauhKUinaIKQUzF6QeMiRIpR
    u3JTmr/cqAni1J0xqVAP5ceJpBBaFOyj3B/tEeYg2UWWjlVN75vtib+BkEwQn8vvPszM8vKpx5ICjZt274R6oHQrT2Q3UAA85oZr9w+FEWPClKeWWY986OtV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=WTNleGlrAjYN4qDeeRgA:9 a=mKWq3M7MdLggV_PW:21
    a=Xwkrn7m-LCcaa3yX:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeDQGXQ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 02:23:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35875 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeDQGXP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 17 Apr 2018 02:23:15 -0400
Date: Tue, 17 Apr 2018 08:23:10 +0200
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
Message-ID: <20180417062310.GW17484@dhcp22.suse.cz>
References: <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz>
 <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz>
 <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
 <20180416195726.GT17484@dhcp22.suse.cz>
 <CAG48ez1bV_zZP3Y2ioDndP+H8mLCcxOtU1vCbWe7Q8myEGfXQQ@mail.gmail.com>
 <20180416211115.GU17484@dhcp22.suse.cz>
 <CAG48ez2fXcQS7sw_aCC6_wBKjYphOxFRN4rrRzSk2+-T_mFaxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2fXcQS7sw_aCC6_wBKjYphOxFRN4rrRzSk2+-T_mFaxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 23:12:48, Jann Horn wrote:
> On Mon, Apr 16, 2018 at 11:11 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Mon 16-04-18 22:17:40, Jann Horn wrote:
> >> On Mon, Apr 16, 2018 at 9:57 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> > On Mon 16-04-18 21:30:09, Jann Horn wrote:
> >> >> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> > [...]
> >> >> > Yes, reasonably well written application will not have this problem.
> >> >> > That, however, requires an external synchronization and that's why
> >> >> > called it error prone and racy. I guess that was the main motivation for
> >> >> > that part of the man page.
> >> >>
> >> >> What requires external synchronization? I still don't understand at
> >> >> all what you're talking about.
> >> >>
> >> >> The following code:
> >> >>
> >> >> void *try_to_alloc_addr(void *hint, size_t len) {
> >> >>   char *x = mmap(hint, len, ...);
> >> >>   if (x == MAP_FAILED) return NULL;
> >> >>   if (x == hint) return x;
> >> >
> >> > Any other thread can modify the address space at this moment.
> >>
> >> But not parts of the address space that were returned by this mmap() call.
> > ?
> >> > Just
> >> > consider that another thread would does mmap(x, MAP_FIXED) (or any other
> >> > address overlapping [x, x+len] range)
> >>
> >> If the other thread does that without previously having created a
> >> mapping covering the area in question, that would be a bug in the
> >> other thread.
> >
> > MAP_FIXED is sometimes used without preallocated address ranges.
> 
> Wow, really? Can you point to an example?

Just from top of my head.

Some of that is for historical reasons because the hint address used to
be ignored on some operating systems so MAP_FIXED had to be used.

Currently not user I guess but MAP_FIXED for addresses above 47b address
space AFAIR.

And I am pretty sure there would be much more if you actually browsed
code search.
-- 
Michal Hocko
SUSE Labs
