Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1029091-1521672387-2-4978991401673147334
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521672386; b=AR+qMNKDSb82bRlRtj962zSK9VXLVNpGSS19wqI/6/q2vuj
    Sqxyx2fkVAJ2T5Ld0FQu8Tn7MJ5aCtipniVTpN630sOwXsdW/EW/MXximxEq442O
    9trUJcEY8Ggtw3U3sNTYQ/oBQSlvObMl+IK0jFN9lSmyl23I30GhUGZtPyaRiRak
    ik5Jc6OCrX3qUKGDpVrqSIryViu7qsEV/mLFoFqJHwS+w87muGGqsDgHebPikdHp
    mkk0zBFV6WwATqWRhTYkxxhGXArTR85yZUPg9T6Uf/EdlEMEcomRxECJbWU0tBs7
    wmEwwX6IjT/JiE+HzHuefPRfSlBP6Kq/+aNo0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521672386; bh=lO3xLM/
    LVp3hjUrx4fzXfCmXtE0/91xhSCw5aV2M/6A=; b=FDkikXgw98cKe6/d9k9hn6c
    QeQciamCCQEmlepLXmNmi31didHtkDwBzebuq6Ki230P5jSXvRcjNi2+FJoAOCHx
    seh0ss+XkR0+8yeAJAzlM3GqqumXHyy78UVh7Pi2nV1NCY2DXBTF4BPsk5MpzWvE
    yv4qASNGPIzLFVjShAVZuRBTQGBB/RWxFBGlw7HhmRqAvTy1B4DY5etxIRTv91UF
    Y2gUA2ZqFn/fUWdPiPQQfo//hamjJokf+OwxPQt99y3MgU35vOCGif4G2GHveXOD
    o9ajXGwzhNPJg35FtYDXvurvRqWKpnhmP02px7aQwT7I6ShQT8pq4lFmCenmGFQ=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeCUWqZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 18:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753659AbeCUWqY (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 18:46:24 -0400
Date: Wed, 21 Mar 2018 18:46:21 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 03/15] mm/hmm: HMM should have a callback before MM is
 destroyed v2
Message-ID: <20180321224620.GH3214@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-4-jglisse@redhat.com>
 <d89e417d-c939-4d18-72f5-08b22dc6cff0@nvidia.com>
 <20180321180342.GE3214@redhat.com>
 <788cf786-edbf-ab43-af0d-abbe9d538757@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <788cf786-edbf-ab43-af0d-abbe9d538757@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 03:16:04PM -0700, John Hubbard wrote:
> On 03/21/2018 11:03 AM, Jerome Glisse wrote:
> > On Tue, Mar 20, 2018 at 09:14:34PM -0700, John Hubbard wrote:
> >> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> >>> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> <snip>
> 
> >> Hi Jerome,
> >>
> >> This presents a deadlock problem (details below). As for solution ideas, 
> >> Mark Hairgrove points out that the MMU notifiers had to solve the
> >> same sort of problem, and part of the solution involves "avoid
> >> holding locks when issuing these callbacks". That's not an entire 
> >> solution description, of course, but it seems like a good start.
> >>
> >> Anyway, for the deadlock problem:
> >>
> >> Each of these ->release callbacks potentially has to wait for the 
> >> hmm_invalidate_range() callbacks to finish. That is not shown in any
> >> code directly, but it's because: when a device driver is processing 
> >> the above ->release callback, it has to allow any in-progress operations 
> >> to finish up (as specified clearly in your comment documentation above). 
> >>
> >> Some of those operations will invariably need to do things that result 
> >> in page invalidations, thus triggering the hmm_invalidate_range() callback.
> >> Then, the hmm_invalidate_range() callback tries to acquire the same 
> >> hmm->mirrors_sem lock, thus leading to deadlock:
> >>
> >> hmm_invalidate_range():
> >> // ...
> >> 	down_read(&hmm->mirrors_sem);
> >> 	list_for_each_entry(mirror, &hmm->mirrors, list)
> >> 		mirror->ops->sync_cpu_device_pagetables(mirror, action,
> >> 							start, end);
> >> 	up_read(&hmm->mirrors_sem);
> > 
> > That is just illegal, the release callback is not allowed to trigger
> > invalidation all it does is kill all device's threads and stop device
> > page fault from happening. So there is no deadlock issues. I can re-
> > inforce the comment some more (see [1] for example on what it should
> > be).
> 
> That rule is fine, and it is true that the .release callback will not 
> directly trigger any invalidations. However, the problem is in letting 
> any *existing* outstanding operations finish up. We have to let 
> existing operations "drain", in order to meet the requirement that 
> everything is done when .release returns.
> 
> For example, if a device driver thread is in the middle of working through
> its fault buffer, it will call migrate_vma(), which will in turn unmap
> pages. That will cause an hmm_invalidate_range() callback, which tries
> to take hmm->mirrors_sems, and we deadlock.
> 
> There's no way to "kill" such a thread while it's in the middle of
> migrate_vma(), you have to let it finish up.
>
> > Also it is illegal for the sync callback to trigger any mmu_notifier
> > callback. I thought this was obvious. The sync callback should only
> > update device page table and do _nothing else_. No way to make this
> > re-entrant.
> 
> That is obvious, yes. I am not trying to say there is any problem with
> that rule. It's the "drain outstanding operations during .release", 
> above, that is the real problem.

Maybe just relax the release callback wording, it should stop any
more processing of fault buffer but not wait for it to finish. In
nouveau code i kill thing but i do not wait hence i don't deadlock.

What matter is to stop any further processing. Yes some fault might
be in flight but they will serialize on various lock. So just do not
wait in the release callback, kill thing. I might have a bug where i
still fill in GPU page table in nouveau, i will check nouveau code
for that.

Kill thing should also kill the channel (i don't do that in nouveau
because i am waiting on some channel patchset) but i am not sure if
hardware like it if we kill channel before stoping fault notification.

Cheers,
Jérôme
