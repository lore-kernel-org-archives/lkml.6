Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757507AbeD0HIw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:32835 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757367AbeD0HIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:08:50 -0400
Date: Fri, 27 Apr 2018 09:08:48 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
Message-ID: <20180427070848.GA17484@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <87efj2q6sq.fsf@xmission.com>
 <20180426192818.GX17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426192818.GX17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-04-18 21:28:18, Michal Hocko wrote:
> On Thu 26-04-18 11:19:33, Eric W. Biederman wrote:
> > Michal Hocko <mhocko@kernel.org> writes:
> > 
> > > I've had a patch to remove owner few years back. It needed some work
> > > to finish but maybe that would be a better than try to make
> > > non-scalable thing suck less.
> > 
> > I have a question.  Would it be reasonable to just have a mm->memcg?
> > That would appear to be the simplest solution to the problem.
> 
> I do not remember details. Have to re-read the whole thing again. Hope
> to get to this soon but with the current jet lag and backlog from the
> LSFMM I rather not promis anything. Going with mm->memcg would be the
> most simple of course but I have a very vague recollection that it was
> not possible. Maybe I misremember...

Just for the record, the last version where I've tried to remove owner
was posted here: http://lkml.kernel.org/r/1436358472-29137-1-git-send-email-mhocko@kernel.org

I didn't get to remember details yet, but the primary problem was the
task migration between cgroups and the nasty case when different thread
grounds share the mm. At some point I just suggested to not care
about semantic of these weird threads all that much. We can either
migrate all tasks sharing the mm struct or just keep the inconsistency.

Anyway, removing this ugliness would be so cool!
-- 
Michal Hocko
SUSE Labs
