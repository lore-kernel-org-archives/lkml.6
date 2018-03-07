Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934044AbeCGQtF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:49:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:60776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933386AbeCGQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:49:01 -0500
Date: Wed, 7 Mar 2018 17:48:59 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
cc: Oleg Nesterov <oleg@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: set TIF_AUDIT_SYSCALL only if audit filter has
 been populated
In-Reply-To: <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1803071745180.15778@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1803071120410.15778@cbobk.fhfr.pm> <CALCETrWhZ5ermtpfMt6UdLAC0M9mv7L_TsTfErGStPxznz-AWg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Andy Lutomirski wrote:

> Wow, this was a long time ago.  

Oh yeah; but it now resurfaced on our side, as we are of course receiving 
a lot of requests with respect to making syscall performance great again 
:)

> From memory and a bit of email diving, there are two reasons.
> 
> 1. The probably was partially solved (by Oleg, IIRC) by making auditctl 
>    -a task,never cause newly spawned tasks to not suck.  Yes, it's a 
>    very partial solution.  After considerable nagging, I got Fedora to 
>    default to -a task,never.

Hm, right; that's a bit inconvenient, because it takes each and every 
vendor having to realize this option, and put it in. Making kernel do the 
right thing automatically sounds like a better option to me.

> 2. This patch, as is, may be a bit problematic.  In particular, if one 
>    task changes the audit rules while another task is in the middle of 
>    the syscall, then it's too late to audit that syscall correctly.  
>    This could be seen as a bug or it could be seen as being just fine.

I don't think this should be a problem, given the fact that the whole 
timing/ordering is not predictable anyway due to scheduling.

Paul, what do you think?

Thanks,

-- 
Jiri Kosina
SUSE Labs
