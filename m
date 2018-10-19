Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72BAECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFB021486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFB021486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJSUNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:13:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727170AbeJSUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:13:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JC4SAm095712
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:08:04 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7dbvw4sa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:08:03 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Oct 2018 08:08:02 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 08:07:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JC7w5F44302520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 12:07:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DA2B2065;
        Fri, 19 Oct 2018 12:07:58 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76B51B2066;
        Fri, 19 Oct 2018 12:07:58 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 12:07:58 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 26E7216C39BB; Fri, 19 Oct 2018 05:07:58 -0700 (PDT)
Date:   Fri, 19 Oct 2018 05:07:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH RFC] doc: rcu: remove obsolete (non-)requirement about
 disabling preemption
Reply-To: paulmck@linux.ibm.com
References: <20181017203324.GS2674@linux.ibm.com>
 <20181018020751.GB99677@joelaf.mtv.corp.google.com>
 <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
 <20181019001932.GR2674@linux.ibm.com>
 <20181019012645.GC89903@joelaf.mtv.corp.google.com>
 <20181018215035.5e8ff553@vmware.local.home>
 <20181019022529.GA155753@joelaf.mtv.corp.google.com>
 <20181018225223.42641c73@vmware.local.home>
 <20181019035844.GA141835@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019035844.GA141835@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101912-0060-0000-0000-000002C36E1F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009899; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104916; UDB=6.00572041; IPR=6.00884966;
 MB=3.00023821; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 12:08:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101912-0061-0000-0000-000046E6ABAF
Message-Id: <20181019120758.GV2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:58:44PM -0700, Joel Fernandes wrote:
> On Thu, Oct 18, 2018 at 10:52:23PM -0400, Steven Rostedt wrote:
> > On Thu, 18 Oct 2018 19:25:29 -0700
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Thu, Oct 18, 2018 at 09:50:35PM -0400, Steven Rostedt wrote:
> > > > On Thu, 18 Oct 2018 18:26:45 -0700
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >   
> > > > > Yes, local_irq_restore is light weight, and does not check for reschedules.
> > > > > 
> > > > > I was thinking of case where ksoftirqd is woken up, but does not run unless
> > > > > we set the NEED_RESCHED flag. But that should get set anyway since probably
> > > > > ksoftirqd is of high enough priority than the currently running task..
> > > > > 
> > > > > Roughly speaking the scenario could be something like:
> > > > > 
> > > > > rcu_read_lock();
> > > > >                  <-- IPI comes in for the expedited GP, sets exp_hint
> > > > > local_irq_disable();
> > > > > // do a bunch of stuff
> > > > > rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
> > > > >                          the soft irq, and wakesup softirqd.  
> > > > 
> > > > If softirqd is of higher priority than the current running task, then
> > > > the try_to_wake_up() will set NEED_RESCHED of the current task here.
> > > >   
> > > 
> > > Yes, only *if*. On my system, ksoftirqd is CFS nice 0. I thought expedited
> > > grace periods are quite important and they should complete quickly which is
> > > the whole reason for interrupting rcu read sections with an IPI and stuff.
> > > IMO there should be no harm in setting NEED_RESCHED unconditionally anyway
> > > for possible benefit of systems where the ksoftirqd is not of higher priority
> > > than the currently running task, and we need to run it soon on the CPU. But
> > > I'm Ok with whatever Paul and you want to do here.
> > 
> > 
> > Setting NEED_RESCHED unconditionally wont help. Because even if we call
> > schedule() ksoftirqd will not be scheduled! If it's CFS nice 0, and the
> > current task still has quota to run, if you call schedule, you'll just
> > waste time calculating that the current task should still be running.
> > It's equivalent to calling yield() (which is why we removed all yield()
> > users in the kernel, because *all* of them were buggy!). This is *why*
> > it only calls schedule *if* softirqd is of higher priority.
> 
> Yes, ok. you are right the TTWU path should handle setting the NEED_RESCHED
> flag or not and unconditionally setting it does not get us anything. I had to
> go through the code a bit since it has been a while since I explored it.
> 
> So Paul, I'm Ok with your latest patch for the issue we discussed and don't
> think much more can be done barring raising of ksofitrqd priorities :-) So I
> guess the synchronize_rcu_expedited will just cope with the deal between
> local_irq_enable and the next scheduling point.. :-)

Thank you both!

Indeed, real-time systems need to be configured carefully, especially if
you are crazy enough to run them under high load.  I interpreted "Ok with
your latest patch" as an Acked-by, but please let me know if that is a
misinterpretation.

							Thanx, Paul

