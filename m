Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBWB6v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 20:58:51 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52225 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBWB6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 20:58:50 -0500
X-Google-Smtp-Source: AG47ELvInoRc/7q3v6TLuoBX3rpJTKHKSaKUbWtPT8eIBRh4NdwPjQfpFA2NKbDXdLhRMMkE+IbBgemIDcDaTGK3GEA=
MIME-Version: 1.0
In-Reply-To: <20180223012057.GO2855@linux.vnet.ibm.com>
References: <1519282357-17983-1-git-send-email-zhouzhouyi@gmail.com>
 <20180222165803.GF2855@linux.vnet.ibm.com> <CAABZP2wt0QLuOFndOFTgRACxZw0jqNNeumE91KpjiFQieg14dA@mail.gmail.com>
 <20180223012057.GO2855@linux.vnet.ibm.com>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Fri, 23 Feb 2018 09:58:49 +0800
Message-ID: <CAABZP2xp6uCCv58PzLcOWyWWZKEx4G0-k29UgjKkdKeJ8K5kjA@mail.gmail.com>
Subject: Re: [PATCH] srcu: remove never used variable
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Paul's encouragement, I will keep studying SRCU code.

On Fri, Feb 23, 2018 at 9:20 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Fri, Feb 23, 2018 at 09:04:05AM +0800, Zhouyi Zhou wrote:
>> Thanks Paul for reviewing
>
> And thank you for your interest in SRCU!  I am pretty sure that other
> bugs still remain.  ;-)
>
>                                                         Thanx, Paul
>
>> Cheers
>> Zhouyi
>>
>> On Friday, February 23, 2018, Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> wrote:
>>
>> > On Thu, Feb 22, 2018 at 06:52:37AM +0000, zhouzhouyi@gmail.com wrote:
>> > > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> > >
>> > > In function srcu_gp_end, the variable idxnext is never used after assign,
>> > > remove it and its assign statement.
>> > >
>> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> >
>> > Good catch, but Byungchul Park beat you to it.  Please see commit
>> > a72da917f186 ("srcu: Remove dead code in srcu_gp_end()") in -rcu.
>> >
>> >                                                         Thanx, Paul
>> >
>> > > ---
>> > >  kernel/rcu/srcutree.c | 2 --
>> > >  1 file changed, 2 deletions(-)
>> > >
>> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> > > index d5cea81..1241715 100644
>> > > --- a/kernel/rcu/srcutree.c
>> > > +++ b/kernel/rcu/srcutree.c
>> > > @@ -531,7 +531,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
>> > >       unsigned long flags;
>> > >       unsigned long gpseq;
>> > >       int idx;
>> > > -     int idxnext;
>> > >       unsigned long mask;
>> > >       struct srcu_data *sdp;
>> > >       struct srcu_node *snp;
>> > > @@ -555,7 +554,6 @@ static void srcu_gp_end(struct srcu_struct *sp)
>> > >
>> > >       /* Initiate callback invocation as needed. */
>> > >       idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
>> > > -     idxnext = (idx + 1) % ARRAY_SIZE(snp->srcu_have_cbs);
>> > >       rcu_for_each_node_breadth_first(sp, snp) {
>> > >               spin_lock_irq_rcu_node(snp);
>> > >               cbs = false;
>> > > --
>> > > 2.1.4
>> > >
>> >
>> >
>
