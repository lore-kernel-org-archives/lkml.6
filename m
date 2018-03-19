Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967656AbeCSREo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:04:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967697AbeCSREj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:04:39 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Paul Moore <paul@paul-moore.com>,
        linux-audit@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has been populated
Date: Mon, 19 Mar 2018 13:04:38 -0400
Message-ID: <1768479.at3cVp0HA2@x2>
Organization: Red Hat
In-Reply-To: <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm> <CALCETrUV9Q8o2TkydO7NNjHAQNsZM-m9nEV8n_XnoaE+RmGoXw@mail.gmail.com> <nycvar.YFH.7.76.1803140124210.15778@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 13, 2018 8:28:57 PM EDT Jiri Kosina wrote:
> On Wed, 14 Mar 2018, Andy Lutomirski wrote:
> > > Yes...I wished I was in on the beginning of this discussion. Here's the
> > > problem. We need all tasks auditable unless specifically dismissed as
> > > uninteresting. This would be a task,never rule.
> > > 
> > > The way we look at it, is if it boots with audit=1, then we know auditd
> > > is expected to run at some point. So, we need all tasks to stay
> > > auditable. If they weren't and auditd enabled auditing, then we'd need
> > > to walk the whole proctable and stab TIF_AUDIT_SYSCALL into every
> > > process in the system. It was decided that this is too ugly.
> > 
> > When was that decided?  That's what this patch does.
> 
> I'd like to see some more justification as well.

There was some discussion about removing the flag here:
https://www.redhat.com/archives/linux-audit/2007-October/msg00053.html

-Steve

> Namely, if I compare "setting TIF_AUDIT_SYSCALL for every process on a
> need-to-be-so basis" to "we always go through the slow path and
> pessimistically assume that audit is enabled and has reasonable ruleset
> loaded", I have my own (different) opinion of what is too ugly.
