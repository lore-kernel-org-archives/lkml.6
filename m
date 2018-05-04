Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeEDLH4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDLHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:07:55 -0400
Date: Fri, 4 May 2018 13:07:51 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] memcg: Replace mm->owner with mm->memcg
Message-ID: <20180504110751.GM4535@dhcp22.suse.cz>
References: <20180426130700.GP17484@dhcp22.suse.cz>
 <87efj2q6sq.fsf@xmission.com>
 <20180426192818.GX17484@dhcp22.suse.cz>
 <20180427070848.GA17484@dhcp22.suse.cz>
 <87r2n01q58.fsf@xmission.com>
 <87o9hz2sw3.fsf@xmission.com>
 <87h8nr2sa3.fsf_-_@xmission.com>
 <20180502084708.GC26305@dhcp22.suse.cz>
 <20180502132026.GB16060@cmpxchg.org>
 <87lgd1zww0.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgd1zww0.fsf_-_@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following for nommu with MEMCG=y randconfig:
kernel/fork.o: In function `mm_init':
fork.c:(.text+0x948): undefined reference to `mm_update_memcg'
kernel/fork.o: In function `mmput':
fork.c:(.text+0x119c): undefined reference to `mm_update_memcg'
make: *** [vmlinux] Error 1

I am sorry but I didn't get to look at it much more but I suspect you
just have to move mm_update_memcg up before mem_cgroup_do_precharge.
-- 
Michal Hocko
SUSE Labs
