Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeFATQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:16:57 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:45392 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbeFATQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:16:55 -0400
X-Google-Smtp-Source: ADUXVKKD4m0LKjQC/1jbBnUNaYaQ/inVh4GU/b3EDC1Ywp6din4vOPEZtjZ/1m+7J2YY3uiMBU2i6w==
Date: Fri, 1 Jun 2018 12:16:52 -0700
From: Tejun Heo <tj@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in
 the same memory cgroup
Message-ID: <20180601191652.GZ1351649@devbig577.frc2.facebook.com>
References: <87wovu889o.fsf@xmission.com>
 <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
 <20180601165034.GX1351649@devbig577.frc2.facebook.com>
 <87bmcuv0k0.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bmcuv0k0.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 01, 2018 at 01:11:59PM -0500, Eric W. Biederman wrote:
> Widening the definition of a process sounds good.  The memory control
> group code would still need a way to forbid these in cgroup v1 mode,
> when someone uses the task file.

Yeap, you're right.  We'll need memcg's can_attach rejecting for v1.

> Using widening instead of denying should reduce the risk of introducing
> a regression.
> 
> The only reason I support the crazy case in my earlier patch is so that
> we can have this discussion and in case we do cause a regression with
> this change the previous algorithmic cleanup won't have to be reverted
> as well.

Yeah, sure thing.

Thanks a lot.

-- 
tejun
