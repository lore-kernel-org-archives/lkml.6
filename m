Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7BEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905E72087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905E72087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeJTCSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:18:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbeJTCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:18:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JI9UXO010692
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:11:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n7kfk28br-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:11:39 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Oct 2018 14:11:38 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 14:11:35 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JIBYbJ42991798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 18:11:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 603B5B2067;
        Fri, 19 Oct 2018 18:11:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EC8BB2066;
        Fri, 19 Oct 2018 18:11:34 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 18:11:34 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1D84316C300B; Fri, 19 Oct 2018 11:11:34 -0700 (PDT)
Date:   Fri, 19 Oct 2018 11:11:34 -0700
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
References: <20181018144637.GD2674@linux.ibm.com>
 <20181019000350.GB89903@joelaf.mtv.corp.google.com>
 <20181019001932.GR2674@linux.ibm.com>
 <20181019012645.GC89903@joelaf.mtv.corp.google.com>
 <20181018215035.5e8ff553@vmware.local.home>
 <20181019022529.GA155753@joelaf.mtv.corp.google.com>
 <20181018225223.42641c73@vmware.local.home>
 <20181019035844.GA141835@joelaf.mtv.corp.google.com>
 <20181019120758.GV2674@linux.ibm.com>
 <20181019172425.GA197351@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019172425.GA197351@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101918-0068-0000-0000-00000350356B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009902; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105037; UDB=6.00572114; IPR=6.00885087;
 MB=3.00023826; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 18:11:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101918-0069-0000-0000-000046215C95
Message-Id: <20181019181134.GK2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:24:25AM -0700, Joel Fernandes wrote:
> On Fri, Oct 19, 2018 at 05:07:58AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 18, 2018 at 08:58:44PM -0700, Joel Fernandes wrote:
> > > On Thu, Oct 18, 2018 at 10:52:23PM -0400, Steven Rostedt wrote:
> > > > On Thu, 18 Oct 2018 19:25:29 -0700
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > > On Thu, Oct 18, 2018 at 09:50:35PM -0400, Steven Rostedt wrote:
> > > > > > On Thu, 18 Oct 2018 18:26:45 -0700
> > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >   
> > > > > > > Yes, local_irq_restore is light weight, and does not check for reschedules.
> > > > > > > 
> > > > > > > I was thinking of case where ksoftirqd is woken up, but does not run unless
> > > > > > > we set the NEED_RESCHED flag. But that should get set anyway since probably
> > > > > > > ksoftirqd is of high enough priority than the currently running task..
> > > > > > > 
> > > > > > > Roughly speaking the scenario could be something like:
> > > > > > > 
> > > > > > > rcu_read_lock();
> > > > > > >                  <-- IPI comes in for the expedited GP, sets exp_hint
> > > > > > > local_irq_disable();
> > > > > > > // do a bunch of stuff
> > > > > > > rcu_read_unlock();   <-- This calls the rcu_read_unlock_special which raises
> > > > > > >                          the soft irq, and wakesup softirqd.  
> > > > > > 
> > > > > > If softirqd is of higher priority than the current running task, then
> > > > > > the try_to_wake_up() will set NEED_RESCHED of the current task here.
> > > > > >   
> > > > > 
> > > > > Yes, only *if*. On my system, ksoftirqd is CFS nice 0. I thought expedited
> > > > > grace periods are quite important and they should complete quickly which is
> > > > > the whole reason for interrupting rcu read sections with an IPI and stuff.
> > > > > IMO there should be no harm in setting NEED_RESCHED unconditionally anyway
> > > > > for possible benefit of systems where the ksoftirqd is not of higher priority
> > > > > than the currently running task, and we need to run it soon on the CPU. But
> > > > > I'm Ok with whatever Paul and you want to do here.
> > > > 
> > > > 
> > > > Setting NEED_RESCHED unconditionally wont help. Because even if we call
> > > > schedule() ksoftirqd will not be scheduled! If it's CFS nice 0, and the
> > > > current task still has quota to run, if you call schedule, you'll just
> > > > waste time calculating that the current task should still be running.
> > > > It's equivalent to calling yield() (which is why we removed all yield()
> > > > users in the kernel, because *all* of them were buggy!). This is *why*
> > > > it only calls schedule *if* softirqd is of higher priority.
> > > 
> > > Yes, ok. you are right the TTWU path should handle setting the NEED_RESCHED
> > > flag or not and unconditionally setting it does not get us anything. I had to
> > > go through the code a bit since it has been a while since I explored it.
> > > 
> > > So Paul, I'm Ok with your latest patch for the issue we discussed and don't
> > > think much more can be done barring raising of ksofitrqd priorities :-) So I
> > > guess the synchronize_rcu_expedited will just cope with the deal between
> > > local_irq_enable and the next scheduling point.. :-)
> > 
> > Thank you both!
> > 
> > Indeed, real-time systems need to be configured carefully, especially if
> > you are crazy enough to run them under high load.  I interpreted "Ok with
> > your latest patch" as an Acked-by, but please let me know if that is a
> > misinterpretation.
> 
> Yes,
> 
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Very good, pre-applied, thank you!  ;-)

							Thanx, Paul

