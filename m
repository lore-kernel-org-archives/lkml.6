Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2881586-1523466433-2-16415591295617600295
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
    1523466432; b=dl3zVACCy7j60sxxWRPq2Gv4Fpf31c8OHBRVREIfUvenxHC4mh
    6vreqNqkD5SqmNyBx1PXM4GgyWr6q+wOeFw+3CaT6NX9kyWNnZ6AmEMRf6vppSFa
    O/inBS7c6tumeUcJfzgMAFmvkrCZxXgzY6MM5iF18AIaubSaKSVd6JSmvx+K3SFX
    q2e09UvthU8J4eRg+M0qrgclehpjUTAfe7LpHqR85gX4Jwzjk/cF8FzNHvhQL1vw
    U5UM76+R4YWn0Gi2oUWtmg36+ofBF76v3LPoA05igDmSLatR+70kbgOqNIygwmHe
    qMG2KE4z8M2azdwz9UUvchfmQk258S5Ienkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523466432; bh=31NvJK+yWVkHZdyB/CW7ywxdn48WbX
    JXecBqv/a99aw=; b=Cx7Wc2K2lH3Rv5K8XJRoETpS+DCFB7l7DXtmD6SxktrxQJ
    7UVhXoFbD2Pdl3zdmunWxazlk1EU3v2YdqhmDpxlcpNbtOWTZzScmn/16t/e+K4a
    ahrxDHkP2RVlgCNFj9ClX3U02awkWpY849iDkPi8FYQ1bgnYJxzR6808Lr8pwnaO
    iZZLFEIiOGsqCnD1R9V9li5a4Dy96rWjOG9iXeuE4PDGWwKCjBhqxokfOQ+24His
    ZEPxbDUoZq1IQAcPzr7mndl9mOagWKjZFbQMVt39t4koqRNnCceSxNedEiE7E03T
    SOwENoVL4iAVwsoXuQF4WQYdq1GacF8c0AOJG0ag==
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
X-CM-Envelope: MS4wfCJy4D2aDm/uWEcT4zNyr0iQgt/s4A1N/4u8AM5JYmrCuO/lLvXiY1IMSG2IbGdaAUS1KyA+rl6+Ss0MHhQenSRXumwae1gq/wmOcVPl6qoj4uhTNmMr
    YQB8dk9RxLp5eo6J1kHgbSt9p+I3jdhEbgk99hbFDRqw1FdfOlKyQiTlVVF10JFyFuA4SQcCbH+h4FD0z4VyT26C48aGrNJYspBrAHLd/b7UWzTJ6vsX/c4J
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Ikd4Dj_1AAAA:8 a=Sg8HuZxHAAAA:8
    a=lm2F3nKc2I0G537BKJUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeDKRHK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:07:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47131 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbeDKRGm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 13:06:42 -0400
Date: Wed, 11 Apr 2018 19:06:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
Message-ID: <20180411170356.GM23400@dhcp22.suse.cz>
References: <20180411120452.1736-1-mhocko@kernel.org>
 <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
 <20180411163631.GL23400@dhcp22.suse.cz>
 <CAG48ez2wYqxJEHgZCz5g6ZYBY4_qDcYWSGAErC8pUzmrW62rug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2wYqxJEHgZCz5g6ZYBY4_qDcYWSGAErC8pUzmrW62rug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 11-04-18 18:40:09, Jann Horn wrote:
> On Wed, Apr 11, 2018 at 6:36 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Wed 11-04-18 17:37:46, Jann Horn wrote:
> >> On Wed, Apr 11, 2018 at 2:04 PM,  <mhocko@kernel.org> wrote:
> >> > From: Michal Hocko <mhocko@suse.com>
> >> >
> >> > 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
> >> > atomicaly probe for a given address range.
> >> >
> >> > [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
> >> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> >> > ---
> >> > Hi,
> >> > Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
> >> > window. So here we go with the man page update.
> >> >
> >> >  man2/mmap.2 | 27 +++++++++++++++++++++++++++
> >> >  1 file changed, 27 insertions(+)
> >> >
> >> > diff --git a/man2/mmap.2 b/man2/mmap.2
> >> > index ea64eb8f0dcc..f702f3e4eba2 100644
> >> > --- a/man2/mmap.2
> >> > +++ b/man2/mmap.2
> >> > @@ -261,6 +261,27 @@ Examples include
> >> >  and the PAM libraries
> >> >  .UR http://www.linux-pam.org
> >> >  .UE .
> >> > +Newer kernels
> >> > +(Linux 4.17 and later) have a
> >> > +.B MAP_FIXED_NOREPLACE
> >> > +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
> >> > +should be preferred over MAP_FIXED.
> >>
> >> This still looks wrong to me. There are legitimate uses for MAP_FIXED,
> >> and for most users of MAP_FIXED that I'm aware of, MAP_FIXED_NOREPLACE
> >> wouldn't work while MAP_FIXED works perfectly well.
> >>
> >> MAP_FIXED is for when you have already reserved the targeted memory
> >> area using another VMA; MAP_FIXED_NOREPLACE is for when you haven't.
> >> Please don't make it sound as if MAP_FIXED is always wrong.
> >
> > Well, this was suggested by John. I think, nobody is objecting that
> > MAP_FIXED has legitimate usecases. The above text just follows up on
> > the previous section which emphasises the potential memory corruption
> > problems and it suggests that a new flag is safe with that regards.
> >
> > If you have specific wording that would be better I am open for changes.
> 
> I guess I'd probably also want to change the previous text; so I
> should probably send a followup patch once this one has landed.

yeah, that sounds like a better plan.
-- 
Michal Hocko
SUSE Labs
