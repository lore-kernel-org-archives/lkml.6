Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeFDSrn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:47:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33450 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeFDSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:47:42 -0400
X-Google-Smtp-Source: ADUXVKK8CzLLCFidYDD+ejeYjc0kUeP3Uf9XFzZVz09fDhyLP6VSxZ/MbK4ggYpMPGeGcC/hrt28ig==
Date: Mon, 4 Jun 2018 11:47:38 -0700
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20180604184738.GB1351649@devbig577.frc2.facebook.com>
References: <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
 <20180601165034.GX1351649@devbig577.frc2.facebook.com>
 <87bmcuv0k0.fsf@xmission.com>
 <20180601191652.GZ1351649@devbig577.frc2.facebook.com>
 <20180604125934.GR19202@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604125934.GR19202@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michal.

On Mon, Jun 04, 2018 at 03:01:19PM +0200, Michal Hocko wrote:
> > On Fri, Jun 01, 2018 at 01:11:59PM -0500, Eric W. Biederman wrote:
> > > Widening the definition of a process sounds good.  The memory control
> > > group code would still need a way to forbid these in cgroup v1 mode,
> > > when someone uses the task file.
> > 
> > Yeap, you're right.  We'll need memcg's can_attach rejecting for v1.
> 
> Do we really need? I mean, do we know about any existing usecase that
> would need this weird threading concept and depend on memory migration
> which doesn't really work?

I thought the requirement is from the ->owner change so that the
association doesn't become 1:N, right?

Thanks.

-- 
tejun
