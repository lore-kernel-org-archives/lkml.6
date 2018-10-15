Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7773EC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02FA20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02FA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJPDlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:41:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbeJPDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:41:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9FJs6mx098507
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:54:27 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4wv4978c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:54:27 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 15 Oct 2018 15:54:26 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 15:54:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9FJsMbN28967020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 19:54:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24BD7B2064;
        Mon, 15 Oct 2018 15:52:17 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3813B205F;
        Mon, 15 Oct 2018 15:52:16 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Oct 2018 15:52:16 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 59F2816C2B10; Mon, 15 Oct 2018 12:54:26 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:54:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Reply-To: paulmck@linux.ibm.com
References: <20181014212955.95267-1-joel@joelfernandes.org>
 <20181014231731.GN2674@linux.ibm.com>
 <20181015020827.GA217384@joelaf.mtv.corp.google.com>
 <20181015021349.GB217384@joelaf.mtv.corp.google.com>
 <20181015023328.GP2674@linux.ibm.com>
 <20181015024758.GA227989@joelaf.mtv.corp.google.com>
 <5151da01-343b-bb37-353e-b6652ae530f5@suse.com>
 <20181015112112.GT2674@linux.ibm.com>
 <20181015193951.GA33528@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015193951.GA33528@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101519-0060-0000-0000-000002C1177F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009881; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103154; UDB=6.00570984; IPR=6.00883204;
 MB=3.00023767; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 19:54:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101519-0061-0000-0000-000046DB7B00
Message-Id: <20181015195426.GD2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:39:51PM -0700, Joel Fernandes wrote:
> On Mon, Oct 15, 2018 at 04:21:12AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 15, 2018 at 09:05:22AM +0300, Nikolay Borisov wrote:
> > > On 15.10.2018 05:47, Joel Fernandes wrote:
> > > > On Sun, Oct 14, 2018 at 07:33:28PM -0700, Paul E. McKenney wrote:
> > > >> On Sun, Oct 14, 2018 at 07:13:49PM -0700, Joel Fernandes wrote:
> > > >>> On Sun, Oct 14, 2018 at 07:08:27PM -0700, Joel Fernandes wrote:
> > > >>>> On Sun, Oct 14, 2018 at 04:17:31PM -0700, Paul E. McKenney wrote:
> > > >>>>> On Sun, Oct 14, 2018 at 02:29:55PM -0700, Joel Fernandes (Google) wrote:
> > > >>>>>> The Requirements.html document says "Disabling Preemption Does Not Block
> > > >>>>>> Grace Periods". However this is no longer true with the RCU
> > > >>>>>> consolidation. Lets remove the obsolete (non-)requirement entirely.
> > > >>>>>>
> > > >>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >>>>>
> > > >>>>> Good catch, queued, thank you!
> > > >>>>
> > > >>>> Thanks! By the way after I sent the patch, I also tried Oleg's experiment to
> > > >>>> confirm that this is indeed obsolete.  :)
> > > >>>>
> > > >>>> One thing interesting came up when I tried synchronize_rcu_expedited()
> > > >>>> instead of synchronize_rcu() in Oleg's experiment, I still saw a multiple
> > > >>>> millisecond delay between when the rcu read section completely and the
> > > >>>> synchronize_rcu_expedited returns:
> > > >>>>
> > > >>>> For example, with synchronize_rcu_expedited, the 'SPIN done' and the 'SYNC
> > > >>>> done' are about 3 millisecond apart:
> > > >>>> [   77.599142] SPIN start
> > > >>>> [   77.601595] SYNC start
> > > >>>> [   82.604950] SPIN done!
> > > >>>> [   82.607836] SYNC done!
> > > >>>>  I saw anywhere from 2-6 milliseconds.
> > > >>>>
> > > >>>> The reason I bring this up is according to Requirements.html: In some cases,
> > > >>>> the multi-millisecond synchronize_rcu() latencies are unacceptable. In these
> > > >>>> cases, synchronize_rcu_expedited() may be used instead,.. so either I messed
> > > >>>> something up in the experiment, or I need to update this part of the document ;-)
> > > >>
> > > >> In normal testing, 2-6 milliseconds is indeed excessive.  Could you please
> > > >> point me at Oleg's experiment?  Also, what CONFIG_PREEMPT setting were
> > > >> you using?  (My guess is CONFIG_PREEMPT=y.)
> > > > 
> > > > The CONFIG_PREEMPT config I am using is CONFIG_PREEMPT=y.
> > > > 
> > > >>> So I realized I'm running in Qemu so it could also be a scheduling delay of
> > > >>> the vcpu thread. So apologies about the noise if the experiment works fine
> > > >>> for you.
> > > >>
> > > >> I used rcuperf, which might not be doing the same thing as Oleg's
> > > >> experiment.
> > > > 
> > > > The experiment is mentioned at:
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg912055.html
> > > > 
> > > > If you apply the below diff, it applies cleanly on rcu/dev. And then run:
> > > > taskset 2 perl -e 'syscall 157, 666, 5000' &
> > > > taskset 1 perl -e 'syscall 157, 777'
> > > > 
> > > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > > index cf5c67533ff1..b654b7566ca3 100644
> > > > --- a/kernel/sys.c
> > > > +++ b/kernel/sys.c
> > > > @@ -2261,6 +2261,9 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > +#include <linux/delay.h>
> > > > +
> > > > +
> > > >  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > > >  		unsigned long, arg4, unsigned long, arg5)
> > > >  {
> > > > @@ -2274,6 +2277,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> > > >  
> > > >  	error = 0;
> > > >  	switch (option) {
> > > > +	case 666:
> > > > +		preempt_disable();
> > > > +		pr_crit("SPIN start\n");
> > > > +		while (arg2--)
> > > > +			mdelay(1);
> > 
> > OK, this is the problem.  When you spin in the kernel for several
> > milliseconds with preemption disabled, the consolidated grace period
> > is -required- to wait for this preemption-disabled reader to complete,
> > whether expedited or not.
> > 
> > So, expected behavior.  ;-)
> 
> Cool. Thanks for confirming. I ran some tests too and if I reduce the
> preempt_disabled section's duration, then the delay for
> synchronize_rcu_expedited is much lesser indeed.

Good to hear!

> > In any case, please don't spin for milliseconds with preemption disabled.
> > The real-time guys are unlikely to be happy with you if you do this!
> 
> Well just to clarify, I was just running Oleg's test which did this. This
> test was mentioned in the original documentation that I deleted. Ofcourse I
> would not dare do such a thing in production code :-D. I guess to Oleg's
> defense, he did it to very that synchronize_rcu() was not blocked on
> preempt-disable sections which was a different test.

Understood!  Just pointing out that RCU's tolerating a given action does
not necessarily mean that it is a good idea to take that action.  ;-)

> > > > +		pr_crit("SPIN done!\n");
> > > > +		preempt_enable();
> > > > +		break;
> > > > +	case 777:
> > > > +		pr_crit("SYNC start\n");
> > > > +		synchronize_rcu();
> > > > +		pr_crit("SYNC done!\n");
> > > 
> > > But you are using the console printing infrastructure which is rather
> > > heavyweight. Try replacing pr_* calls with trace_printk so that you
> > > write to the lock-free ring buffer, this will reduce the noise from the
> > > heavy console printing infrastructure.
> > 
> > And this might be a problem as well.
> 
> This was not the issue (or atleast not fully the issue) since I saw the same
> thing with trace_printk. It was exactly what you said - which is the
> excessively long preempt disabled times.

One approach would be to apply this patch against (say) v4.18, which
does not have consolidated grace periods.  You might then be able to
tell if the pr_crit() calls make any difference.

							Thanx, Paul

