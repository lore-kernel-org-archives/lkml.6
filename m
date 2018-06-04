Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeFDGy3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:54:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:54022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeFDGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:54:28 -0400
Date: Mon, 4 Jun 2018 08:54:25 +0200
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
Message-ID: <20180604065425.GF19202@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <877enj9uwf.fsf@xmission.com>
 <20180601135725.GE15278@dhcp22.suse.cz>
 <87a7sey3ud.fsf@xmission.com>
 <20180601150219.GG15278@dhcp22.suse.cz>
 <87y3fyv88o.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3fyv88o.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 10:25:59, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Fri 01-06-18 09:32:42, Eric W. Biederman wrote:
> >> Michal Hocko <mhocko@kernel.org> writes:
> > [...]
> >> > Group leader exiting early without tearing down the whole thread
> >> > group should be quite rare as well. No question that somebody might do
> >> > that on purpose though...
> >> 
> >> The group leader exiting early is a completely legitimate and reasonable
> >> thing to do, even if it is rare.
> >
> > I am not saying it isn't legitimate. But the most common case is the
> > main thread waiting for its threads or calling exit which would tear the
> > whole group down. Is there any easy way to achieve this other than tkill
> > to group leader? Calling exit(3) from the leader performs group exit
> > IIRC.
> 
> pthread_exit from the group leader.

Right, forgot to mention this one but this would be quite exotic, right?


> > I am not arguing this is non-issue. And it certainly is a problem once
> > somebody wants to be nasty... I was more interested how often this
> > really happens for sane workloads.
> 
> That is a fair question.  All I know for certain is that whatever Kirill
> Tkhai's workload was it was triggering this the slow path.

Yeah, that was exactly why I've asked that originally. It must be
something pretty special ;)
-- 
Michal Hocko
SUSE Labs
