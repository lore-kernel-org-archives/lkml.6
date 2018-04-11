Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464597-2-18167696328632366137
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
    1523464596; b=E5usbY7O+vN6OGs0Qni5rjfrUMuRYrggMMjODjCrnPbUamJpGv
    5TNi53X+HDum1P7X5gvwIv4xoJc/SSa/AqPF4qVKdoQ6/kixDay8ZxpRF3t/BL4q
    rIXcVK4F/+EooRV4LkntitTj8cNYa6u39+Nw97bzrSsaevsH1a/ewBfW9Uq3aGLX
    Gy58n+RLXiXhTNLN8WOU5LMCIVPnvuZwI18dwxfO9DOWuI9KFCp/iOuaeg1AfBPD
    FbSi35VgXEgzG76yiH8fo6LXguXmmKUSa7/kgJuTwNLCDIOmQVd2sQQN/Lz7U/NP
    8BRkFzIwWfJYU/em3hUqgE19gqgUkgdstVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523464596; bh=LO4eOa5EhLAKRIq+tUnDjPmyiU3RAk
    UcldjXXKdD51g=; b=mUKnDEF0V5i+gJ+XGYvx2qtgy9f4+DOy5obAElsN5k9q+v
    lXMB1X/LGHduEcYJQX+vb9ynTyNbHL6lgfP288p60wxj0Ve2JBKT872RXvWh+8SN
    bPWuCv64MAxgo3IRDHZGhOQt4Cqcmw6buOePUoOJl56PcNs7v87o4zpMnSDTsuVR
    Cu16E0e0EheDRgZAwHW/umQ7IAvlHUFjOfwpXugNIFiW/oLEtgjSnUvnOgpOiuPa
    fnc3ZNTvng/Kn48vr3GMXg2OH6TsE9o+9NEW58XWRaxYlIWxxiGXwBuEddCdrsrU
    UqagC7LRhZwGPpyCyVy+Ost0k6n+j0ga3Z3CSEEg==
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
X-CM-Envelope: MS4wfKFYj07Tdiy6gCOkdS0fTuwyD9jd2GgJFVLqM2dvJsmZjxlQlpmcPTmPt113yMuDMn205D/zpaW2+G9Lw1Gmx5Eyo8xZ5aO4HTlQe3nL7ZypjTcSfITb
    fuaxSQ0dxzZKZgMtxB9FHhCBFBxCjm1l3V2NnMDNiqFV3apAV83YEeSyBqNPvDLuEAktJxdIhh/e+6mss2JP9Vy9WruZSmeikxnW5U2eyy4nmUylFPZjBzwD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8
    a=4LLCPHEH1acVqOnI_ssA:9 a=d1w1Taw8AuMoDPry:21 a=8wOxZW-QHMVwjyD8:21
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeDKQgf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:36:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44953 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbeDKQge (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:36:34 -0400
Date: Wed, 11 Apr 2018 18:36:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
Message-ID: <20180411163631.GL23400@dhcp22.suse.cz>
References: <20180411120452.1736-1-mhocko@kernel.org>
 <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 11-04-18 17:37:46, Jann Horn wrote:
> On Wed, Apr 11, 2018 at 2:04 PM,  <mhocko@kernel.org> wrote:
> > From: Michal Hocko <mhocko@suse.com>
> >
> > 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
> > atomicaly probe for a given address range.
> >
> > [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> > Hi,
> > Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
> > window. So here we go with the man page update.
> >
> >  man2/mmap.2 | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/man2/mmap.2 b/man2/mmap.2
> > index ea64eb8f0dcc..f702f3e4eba2 100644
> > --- a/man2/mmap.2
> > +++ b/man2/mmap.2
> > @@ -261,6 +261,27 @@ Examples include
> >  and the PAM libraries
> >  .UR http://www.linux-pam.org
> >  .UE .
> > +Newer kernels
> > +(Linux 4.17 and later) have a
> > +.B MAP_FIXED_NOREPLACE
> > +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
> > +should be preferred over MAP_FIXED.
> 
> This still looks wrong to me. There are legitimate uses for MAP_FIXED,
> and for most users of MAP_FIXED that I'm aware of, MAP_FIXED_NOREPLACE
> wouldn't work while MAP_FIXED works perfectly well.
> 
> MAP_FIXED is for when you have already reserved the targeted memory
> area using another VMA; MAP_FIXED_NOREPLACE is for when you haven't.
> Please don't make it sound as if MAP_FIXED is always wrong.

Well, this was suggested by John. I think, nobody is objecting that
MAP_FIXED has legitimate usecases. The above text just follows up on
the previous section which emphasises the potential memory corruption
problems and it suggests that a new flag is safe with that regards.

If you have specific wording that would be better I am open for changes.

> > +.TP
> > +.BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
> > +Similar to MAP_FIXED with respect to the
> > +.I
> > +addr
> > +enforcement, but different in that MAP_FIXED_NOREPLACE never clobbers a pre-existing
> > +mapped range. If the requested range would collide with an existing
> > +mapping, then this call fails with
> > +.B EEXIST.
> > +This flag can therefore be used as a way to atomically (with respect to other
> > +threads) attempt to map an address range: one thread will succeed; all others
> > +will report failure. Please note that older kernels which do not recognize this
> > +flag will typically (upon detecting a collision with a pre-existing mapping)
> > +fall back to a "non-MAP_FIXED" type of behavior: they will return an address that
> > +is different than the requested one. Therefore, backward-compatible software
> > +should check the returned address against the requested address.
> >  .TP
> >  .B MAP_GROWSDOWN
> >  This flag is used for stacks.
> > @@ -487,6 +508,12 @@ is not a valid file descriptor (and
> >  .B MAP_ANONYMOUS
> >  was not set).
> >  .TP
> > +.B EEXIST
> > +range covered by
> > +.IR addr ,
> > +.IR length
> > +is clashing with an existing mapping.
> 
> Maybe add something like ", and MAP_FIXED_NOREPLACE was specified"? I
> think most manpages explicitly document which error conditions can be
> triggered by which flags.

sure, no objection from me.

-- 
Michal Hocko
SUSE Labs
