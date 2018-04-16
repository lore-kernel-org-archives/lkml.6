Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523908652-2-9143946298807739000
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
    1523908652; b=f0q67YAhMLzaSdClTWz+kukVYVWxvUt9QtXtSFsMrDMgmCrzX1
    C4BrEDsHOtTZjDShDc2gxXR4EdaGeTqpT4W31SHtvJxaCr2q79GBAc0bSjbXlU6/
    aDLa63Wk079FEjjmdubRrggwoD3tqWIVxUFwdQx568br2za0iAb8YOYihCXO8L7H
    6UXqX8GY5wpHLt8LSeJDKstQYUJOVR7JDUadLg4rbqdKUle08kpaiwp/+IDLtU9R
    Yk8HRHXB8oJIOMgAEnbD3otzd/C91UbzjUAIqFDG82YiqHxRN58FZrleYv1mCPSt
    876a/FB6VS4r9iZLCr+QGTyyubWphO6xitHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523908652; bh=tNEwq6327gyLXShpYB6tesBJbBdkjC
    H68Yu3XIPvu4w=; b=RKO0lwH7Tm8bthDCaYzOZTjHTTC337rjMKtFTrP3U2F3SL
    vY+Eh6RFNWSykq/RydYAp0rZT/OpMveAHZZ8EsUvN5rv/fHbWngLsdd+Uu6MTYz6
    oFmkpajZu+MRGQcqV1fbIHrBJTs3c0agpsTS6ji2ZgJmFkTxLVnXtPU8cDOAly7C
    IKSpW2RfK2qvJ/xIQO+66d38nd+msebAoEkwfg/ZAN7bjytpD+ophcxQsDZo+4aA
    K29Hz3qQEytuTTJO6DySKGmZlQIfnEwG9/x/2eXovzrRIwXSXYR6SR68RUIvWRmS
    DtkvNeUmxYoPWebGS8adXFY1SPgngMCH0AoNu3Ww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfKtCgoZGfTBFbo01A8Pep10f6/SEQsnX1cA7RVqu8lPZau3Xd7NzB3P71Ev4nu7Nk8YPLhphQtF4VQ87UGvAeVOjw7qxTCUPlXDvSIJOpjycBI6w6q+V
    ypt7r/WFZvU7x2ZLsowoQrs+HNWYHlJE0pQtG9A/q2qVoZMM8N/C2TX1cudYmKknQ1kBPQ5GPpSmupiD9AewHvySiKuyrtKwwcsC4jS1xQtRCnEJkUCY30Gf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=hrEkC72pg9wi3ZIOr6oA:9 a=nbYHl0Xs11KIf7e8:21
    a=t4Q8KeQMFjQ-3ct9:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDPT53 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54871 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752934AbeDPT53 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Apr 2018 15:57:29 -0400
Date: Mon, 16 Apr 2018 21:57:26 +0200
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
Message-ID: <20180416195726.GT17484@dhcp22.suse.cz>
References: <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz>
 <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
 <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
 <20180416100736.GG17484@dhcp22.suse.cz>
 <CAG48ez3DwRXMtiinUWKnan6hAppLYLdx-w+VzXG6ubioZUacQg@mail.gmail.com>
 <20180416191805.GS17484@dhcp22.suse.cz>
 <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1nf96nHj8a+aZy22RwqYTUZBGrsGFcz=ZhZBUWzaEZ9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 16-04-18 21:30:09, Jann Horn wrote:
> On Mon, Apr 16, 2018 at 9:18 PM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > Yes, reasonably well written application will not have this problem.
> > That, however, requires an external synchronization and that's why
> > called it error prone and racy. I guess that was the main motivation for
> > that part of the man page.
> 
> What requires external synchronization? I still don't understand at
> all what you're talking about.
> 
> The following code:
> 
> void *try_to_alloc_addr(void *hint, size_t len) {
>   char *x = mmap(hint, len, ...);
>   if (x == MAP_FAILED) return NULL;
>   if (x == hint) return x;

Any other thread can modify the address space at this moment. Just
consider that another thread would does mmap(x, MAP_FIXED) (or any other
address overlapping [x, x+len] range) becaus it is seemingly safe as x
!= hint. This will succeed and ...
>   munmap(x, len);
... now you are munmaping somebody's else memory range

>   return NULL;

Do code _is_ buggy but it is not obvious at all.

> }
> 
> has no need for any form of external synchronization.

If the above mmap/munmap section was protected by a lock and _all_ other
mmaps (direct or indirect) would use the same lock then you are safe
against that.
-- 
Michal Hocko
SUSE Labs
