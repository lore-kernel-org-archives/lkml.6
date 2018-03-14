Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeCNA3A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:29:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37601 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932349AbeCNA27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:28:59 -0400
Date: Wed, 14 Mar 2018 01:28:57 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
cc: Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
        linux-audit@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
In-Reply-To: <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm> <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com> <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm> <CAHC9VhRnM0FKrHvSgf=Pm2BpQSVT2pLWWH8Z7YvG5ExBYb_Ekg@mail.gmail.com>
 <CAHC9VhTipRUv+RB6JPTrHYkVW1vktg5yodD7iZCqgR9Z57Y+zg@mail.gmail.com> <20180310111535.2e3202bc@ivy-bridge> <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2018, Andy Lutomirski wrote:

> > Yes...I wished I was in on the beginning of this discussion. Here's the
> > problem. We need all tasks auditable unless specifically dismissed as
> > uninteresting. This would be a task,never rule.
> >
> > The way we look at it, is if it boots with audit=1, then we know auditd
> > is expected to run at some point. So, we need all tasks to stay
> > auditable. If they weren't and auditd enabled auditing, then we'd need
> > to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
> > process in the system. It was decided that this is too ugly.
> 
> When was that decided?  That's what this patch does.

I'd like to see some more justification as well.

Namely, if I compare "setting TIF_AUDIT_SYSCALL for every process on a 
need-to-be-so basis" to "we always go through the slow path and 
pessimistically assume that audit is enabled and has reasonable ruleset 
loaded", I have my own (different) opinion of what is too ugly.

Thanks,

-- 
Jiri Kosina
SUSE Labs
