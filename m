Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeFAPCW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:02:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:46156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751378AbeFAPCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:02:21 -0400
Date: Fri, 1 Jun 2018 17:02:19 +0200
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
Message-ID: <20180601150219.GG15278@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <877enj9uwf.fsf@xmission.com>
 <20180601135725.GE15278@dhcp22.suse.cz>
 <87a7sey3ud.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7sey3ud.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-06-18 09:32:42, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
[...]
> > Group leader exiting early without tearing down the whole thread
> > group should be quite rare as well. No question that somebody might do
> > that on purpose though...
> 
> The group leader exiting early is a completely legitimate and reasonable
> thing to do, even if it is rare.

I am not saying it isn't legitimate. But the most common case is the
main thread waiting for its threads or calling exit which would tear the
whole group down. Is there any easy way to achieve this other than tkill
to group leader? Calling exit(3) from the leader performs group exit
IIRC.

I am not arguing this is non-issue. And it certainly is a problem once
somebody wants to be nasty... I was more interested how often this
really happens for sane workloads.
-- 
Michal Hocko
SUSE Labs
