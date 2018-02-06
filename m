Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeBFHnG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:43:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45069 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeBFHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:42:57 -0500
X-Google-Smtp-Source: AH8x224Noplnw0lZ4Q1XNxL6IdceiOmiPxDO5USckhOeZWp2hlev+0P3n6Qlf5hKoaYa9jVAFRBNsA==
Date: Tue, 6 Feb 2018 08:42:53 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        "luca.abeni" <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/7] sched/topology: Adding function
 partition_sched_domains_locked()
Message-ID: <20180206074253.GA19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-2-git-send-email-mathieu.poirier@linaro.org>
 <20180202101951.GS19535@localhost.localdomain>
 <CANLsYkyJb9F14SBSatLHCwThWaO0dcMSddsCB_kHHAeEdunEtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyJb9F14SBSatLHCwThWaO0dcMSddsCB_kHHAeEdunEtw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/18 11:11, Mathieu Poirier wrote:
> On 2 February 2018 at 03:19, Juri Lelli <juri.lelli@redhat.com> wrote:
> > Hi Mathieu,
> >
> > On 01/02/18 09:51, Mathieu Poirier wrote:
> >> Introducing function partition_sched_domains_locked() by taking
> >> the mutex locking code out of the original function.  That way
> >> the work done by partition_sched_domains_locked() can be reused
> >> without dropping the mutex lock.
> >>
> >> This patch doesn't change the functionality provided by the
> >> original code.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >
> > [...]
> >
> >> +/*
> >> + * Call with hotplug lock held
> >
> > Is this the one that we can actually check if it's locked with
> >
> > lockdep_assert_cpus_held()
> >
> > ?
> 
> Hi Juri,
> 
> You are correct - we could call lockdep_assert_cpus_held() but in my
> opinion it would be in a separate patch and probably outside the scope
> of this work.  The sole purpose of this patch is to get the
> locking/unlocking operations of mutex sched_domains_mutex out of
> function partition_sched_domains_locked().

Fair enough. I just thought though that, since you are adding the comment
above, we could as well add an explicit check for hotplug lock.

Best,

- Juri
