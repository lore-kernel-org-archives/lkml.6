Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeDJIMf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:12:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbeDJIMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:12:33 -0400
Date: Tue, 10 Apr 2018 10:12:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ringbuffer: Don't choose the process with adj equal
 OOM_SCORE_ADJ_MIN
Message-ID: <20180410081231.GV21835@dhcp22.suse.cz>
References: <CAGWkznEQbaw7HMvE1pbVDMriOL8yW74Ka5UEci4YFRdLnVbFzA@mail.gmail.com>
 <20180409094944.6399b211@gandalf.local.home>
 <CAGWkznEhy7Fard=6E3X_qUezXd33RdKV9CVeONWL=6EQ1bokEw@mail.gmail.com>
 <CAGWkznEuGCZq600XjCtp3hzgN2LrCgwSAfoLwQR7jTw5p=qHoQ@mail.gmail.com>
 <20180409231230.1ab99e85@vmware.local.home>
 <CAGWkznG8-zmfE5iqPUVP+sztasa1zLPWE28qBiZ_tq524JznPw@mail.gmail.com>
 <20180410061447.GQ21835@dhcp22.suse.cz>
 <CAGWkznGrugH0VqJyd5ZPiSBMOZ4SbbNpKiHVXM27Q-ep4SYb-Q@mail.gmail.com>
 <20180410074921.GU21835@dhcp22.suse.cz>
 <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHQSZ5jPF2njOp0BritTmKiGOToq5bAz1bhzzmFi_01nA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-04-18 16:04:40, Zhaoyang Huang wrote:
> On Tue, Apr 10, 2018 at 3:49 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 10-04-18 14:39:35, Zhaoyang Huang wrote:
> >> On Tue, Apr 10, 2018 at 2:14 PM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> >> > OOM_SCORE_ADJ_MIN means "hide the process from the OOM killer completely".
> >> > So what exactly do you want to achieve here? Because from the above it
> >> > sounds like opposite things. /me confused...
> >> >
> >> Steve's patch intend to have the process be OOM's victim when it
> >> over-allocating pages for ring buffer. I amend a patch over to protect
> >> process with OOM_SCORE_ADJ_MIN from doing so. Because it will make
> >> such process to be selected by current OOM's way of
> >> selecting.(consider OOM_FLAG_ORIGIN first before the adj)
> >
> > I just wouldn't really care unless there is an existing and reasonable
> > usecase for an application which updates the ring buffer size _and_ it
> > is OOM disabled at the same time.
> There is indeed such kind of test case on my android system, which is
> known as CTS and Monkey etc.

Does the test simulate a real workload? I mean we have two things here

oom disabled task and an updater of the ftrace ring buffer to a
potentially large size. The second can be completely isolated to a
different context, no? So why do they run in the single user process
context?

> Furthermore, I think we should make the
> patch to be as safest as possible. Why do we leave a potential risk
> here? There is no side effect for my patch.

I do not have the full context. Could you point me to your patch?
-- 
Michal Hocko
SUSE Labs
