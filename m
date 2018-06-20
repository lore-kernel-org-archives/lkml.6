Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6072C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8849420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8849420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeFTRio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:38:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754238AbeFTRin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:38:43 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KHXsl8046435
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:38:42 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqsmnw3h0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:38:42 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 13:38:42 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 13:38:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5KHcaHj9437642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 17:38:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39291B205F;
        Wed, 20 Jun 2018 13:38:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 087CEB2064;
        Wed, 20 Jun 2018 13:38:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 13:38:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4059516C6A76; Wed, 20 Jun 2018 10:40:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:40:37 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <max.byungchul.park@gmail.com>
Cc:     Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062017-0040-0000-0000-00000442EFAF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009228; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049808; UDB=6.00537949; IPR=6.00828781;
 MB=3.00021762; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 17:38:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062017-0041-0000-0000-00000848FFD6
Message-Id: <20180620174037.GZ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 02:15:07AM +0900, Byungchul Park wrote:
> On Thu, Jun 21, 2018 at 1:49 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> 
> [...]
> 
> > Perhaps the fact that there are architectures that can enter interrupt
> > handlers and never leave them when the CPU is non-idle.  One example of
> > this is the usermode upcalls in the comment that you removed.
> >
> > Or have all the architectures been modified so that each and every call to
> > rcu_irq_enter() and to rcu_irq_exit() are now properly paired and nested?
> >
> > Proper nesting and pairing was -not- present in the past, hence the
> > special updates (AKA "crowbar") to the counters when transitioning to
> > and from idle.
> 
> Thank you very much for explaining it in detail.
> 
> > If proper nesting and pairing of rcu_irq_enter() and rcu_irq_exit()
> > is now fully in force across all architectures and configurations, the
> > commit log needs to say this, preferably pointing to the corresponding
> > commits that made this change.
> 
> Right.
> 
> > There is a call to rcu_irq_enter() without a corresponding call to
> > rcu_irq_exit(), so that the ->dynticks_nesting counter never goes back to
> > zero so that the next time this CPU goes idle, RCU thinks that the CPU
> > is still non-idle.  This can result in excessively long grace periods
> > and needless IPIs to idle CPUs.
> 
> No doubt.
> 
> > But only if calls to rcu_irq_enter() and rcu_irq_exit() are now always
> > properly paired and nested, which was definitely -not- the case last
> > I looked.
> 
> I missed it. Right. It's worth only in the case that calls to rcu_irq_enter()
> and rcu_irq_exit() are always properly paired and nested.
> 
> > OK, so I can further consider this pair of patches only if
> > all architectures now properly pair and nest rcu_irq_enter() and
> > rcu_irq_exit().  It would be very good if they did, but actually testing
> > back in the day showed that they did not.  If that has changed, that
> > would be a very good thing, but if not, this patch injects bugs.
> 
> Totally agree with you. Sorry bothering you.

Absolutely not a problem, absolutely no need to apologize!  I am
actually very happy that you are taking RCU seriously and looking at it
in such depth.

My problem is that when I see a patch like this, something in the back of
my head screams "WRONG!!!", and I sometimes get confused about exactly
what the back of my head is screaming about, which was the case here.
Hence my misguided initial complaint about NMI nesting instead of about
the possibility of unpaired rcu_irq_enter() calls.

So apologies for that, but I unfortunately cannot promise that this
won't happen again.  I have learned the hard way to trust the back of
my head.  It sometimes makes mistakes, but less often than the rest of
my head does.  ;-)

In the meantime, is it possible to rearrange rcu_irq_enter() and
rcu_nmi_enter() (and similarly rcu_irq_exit() and rcu_nmi_exit())
to avoid the conditionals (via compiler inlining) while still keeping
function calls ordered properly?  I bet that you could do it by splitting
rcu_nmi_enter() and rcu_nmi_exit() sort of like this:

	static void rcu_nmi_enter_common(bool irq)
	{
		/*
		 * You fill this in.  Maybe __always_inline above.  The
		 * rcu_dynticks_task_exit() and rcu_cleanup_after_idle()
		 * calls need to be on opposite sides of the
		 * rcu_dynticks_eqs_exit() call, just like they are now.
		 */
	}

	void rcu_nmi_enter(void)
	{
		rcu_nmi_enter_common(false);
	}

	void rcu_irq_enter(void)
	{
		lockdep_assert_irqs_disabled();
		rcu_nmi_enter(true);
	}

Saving a couple of branches on the irq enter/exit paths seems like it
just might be worth something.  ;-)

							Thanx, Paul

