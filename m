Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeFDNBX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:01:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57255 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbeFDNBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:01:22 -0400
Date: Mon, 4 Jun 2018 15:01:19 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in
 the same memory cgroup
Message-ID: <20180604125934.GR19202@dhcp22.suse.cz>
References: <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
 <20180601165034.GX1351649@devbig577.frc2.facebook.com>
 <87bmcuv0k0.fsf@xmission.com>
 <20180601191652.GZ1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601191652.GZ1351649@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropping Kirill Tkhai from the CC because I get rejection from the mail
 server]

On Fri 01-06-18 12:16:52, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jun 01, 2018 at 01:11:59PM -0500, Eric W. Biederman wrote:
> > Widening the definition of a process sounds good.  The memory control
> > group code would still need a way to forbid these in cgroup v1 mode,
> > when someone uses the task file.
> 
> Yeap, you're right.  We'll need memcg's can_attach rejecting for v1.

Do we really need? I mean, do we know about any existing usecase that
would need this weird threading concept and depend on memory migration
which doesn't really work?
-- 
Michal Hocko
SUSE Labs
