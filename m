Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2946384-1523873263-2-2733998304145232731
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
    1523873262; b=JspLpj/QSMEh4guPSniK7tFPsiLbbFYOaQ77pgPd6PpI4khmGE
    Rwsz1zaW3XEtHWNKM+83pltWzr+IgX9ZusEnR59p1GeRbp0ojAhh5R9YcbUOnUaA
    5+TI3uTwPLEh00EulxHyFSq99vOxMuf800+TKMdtbTVfVwbx+w6mT0NQsH9HA809
    SuQNudpdT07+pdfwxQ+xYJ/QQeS8ock2JvAlUAI8v81qY/0Rv66PM01cA3TmwFAU
    LWLwwphfAzPL1A8eaLcI/+hW+D6lsRadcEJGLOHlqsqsJA0X6bZYJ9iSt/u6aOe/
    hmUz+qcsp0NX6tFU+RiVv59Nvj4nU0zqXtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523873262; bh=QXkPdLqyRscPWA6yGV/OCCuQUsR5ng
    6nhOo8KF58HKg=; b=kV+4t2ozDf3baclDd4IVIjI6FWkoWleQwxSietk3/o9wEW
    xLrTtHGHJNilF54FKUvTZs2+Z2v64k4Z4Wujcicb2EFJtOol6NSsPiZLCw3bvVDw
    l1oeSfLrxeuoa+GMTfDViJDD+zSs+TTxfLVy9Lo4aljN8S1w2qVL0OAlqKkfT2Is
    qnEGCmUJ1LBPQXlmoVFRwdOeG+jjF5QOKGpDzulFfcu27MUkaRVUGt/wDiWno5xt
    uOWaoN/ZNntic77cXuPZbGKVR8qeyzcqQlYuk5pVPQgzOdkhY7oKkIs/8WDUDvia
    MiZlpfCOxiXnzxdQuL+4v0mrpwHNULlWtuOcEjsw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPO3tNkcZfyt4lN3NNOf0t/3c0J6v4ayXmbKqu23gI80HTN5xRuRxLL14JLa37Ks1hgChEGod3RUaQgxD6MN+KbLI4fds6zK5OtKpZsnjvVtmMHrwx2a
    lBAXjYjJbWc09sVH7SFuCuVH4fz/b/k04BR0qbutcsgiX8r6Xu/uB7kFZkjp/s+/ZmtkbuJwbQ0Rrk0kp8wVAKzHXzmrRCmsThNZri3WSxL1/UVLuZO0RCsg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ciVnlZARnaeVhsrhbKAA:9
    a=3EoKyvY2xKaBr0W2:21 a=dB1eRdsVRaIMLjWs:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeDPKHj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 06:07:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeDPKHj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 16 Apr 2018 06:07:39 -0400
Date: Mon, 16 Apr 2018 12:07:36 +0200
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
Message-ID: <20180416100736.GG17484@dhcp22.suse.cz>
References: <CAG48ez2NtCr8+HqnKJTFBcLW+kCKUa=2pz=7HD9p9u1p-MfJqw@mail.gmail.com>
 <13801e2a-c44d-e940-f872-890a0612a483@nvidia.com>
 <CAG48ez085cASur3kZTRkdJY20dFZ4Yqc1KVOHxnCAn58_NtW8w@mail.gmail.com>
 <cfbbbe06-5e63-e43c-fb28-c5afef9e1e1d@nvidia.com>
 <9c714917-fc29-4d12-b5e8-cff28761a2c1@gmail.com>
 <20180413064917.GC17484@dhcp22.suse.cz>
 <CAG48ez2w+3FDh9LM3+P2EHowicjM2Xw6giR6uq=26JfWHYsTAQ@mail.gmail.com>
 <20180413160435.GA17484@dhcp22.suse.cz>
 <CAG48ez3-xtmAt2EpRFR8GNKKPcsDsyg7XdwQ=D5w3Ym6w4Krjw@mail.gmail.com>
 <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1PdzMs8hkatbzSLBWYucjTc75o8ovSmeC66+e9mLvSfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 13-04-18 18:17:36, Jann Horn wrote:
> On Fri, Apr 13, 2018 at 6:05 PM, Jann Horn <jannh@google.com> wrote:
> > On Fri, Apr 13, 2018 at 6:04 PM, Michal Hocko <mhocko@kernel.org> wrote:
> >> On Fri 13-04-18 17:04:09, Jann Horn wrote:
> >>> On Fri, Apr 13, 2018 at 8:49 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >>> > On Fri 13-04-18 08:43:27, Michael Kerrisk wrote:
> >>> > [...]
> >>> >> So, you mean remove this entire paragraph:
> >>> >>
> >>> >>               For cases in which the specified memory region has not been
> >>> >>               reserved using an existing mapping,  newer  kernels  (Linux
> >>> >>               4.17  and later) provide an option MAP_FIXED_NOREPLACE that
> >>> >>               should be used instead; older kernels require the caller to
> >>> >>               use addr as a hint (without MAP_FIXED) and take appropriate
> >>> >>               action if the kernel places the new mapping at a  different
> >>> >>               address.
> >>> >>
> >>> >> It seems like some version of the first half of the paragraph is worth
> >>> >> keeping, though, so as to point the reader in the direction of a remedy.
> >>> >> How about replacing that text with the following:
> >>> >>
> >>> >>               Since  Linux 4.17, the MAP_FIXED_NOREPLACE flag can be used
> >>> >>               in a multithreaded program to avoid  the  hazard  described
> >>> >>               above.
> >>> >
> >>> > Yes, that sounds reasonable to me.
> >>>
> >>> But that kind of sounds as if you can't avoid it before Linux 4.17,
> >>> when actually, you just have to call mmap() with the address as hint,
> >>> and if mmap() returns a different address, munmap() it and go on your
> >>> normal error path.
> >>
> >> This is still racy in multithreaded application which is the main point
> >> of the whole section, no?
> >
> > No, it isn't.

I could have been more specific, sorry.

> mmap() with a hint (without MAP_FIXED) will always non-racily allocate
> a memory region for you or return an error code. If it does allocate a
> memory region, it belongs to you until you deallocate it. It might be
> at a different address than you requested -

Yes, this all is true. Except the atomicity is guaranteed only for the
syscall. Once you return to the userspace any error handling is error
prone and racy because your mapping might change under you feet. So...

> in that case you can
> emulate MAP_FIXED_NOREPLACE by calling munmap() and treating it as an
> error; or you can do something else with it.
> 
> MAP_FIXED_NOREPLACE is just a performance optimization.

This is not quite true because you get _your_ area or _an error_
atomically which is not possible with 2 syscalls.

-- 
Michal Hocko
SUSE Labs
