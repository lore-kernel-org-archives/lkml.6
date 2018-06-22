Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397C248C6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 20:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F397C248C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbeFVU4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 16:56:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754184AbeFVU4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 16:56:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MKo41T108600
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:56:16 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js672mw8t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:56:16 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 16:56:15 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 16:56:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MKuBTe50069628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 20:56:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A413B2068;
        Fri, 22 Jun 2018 16:56:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFD4B2065;
        Fri, 22 Jun 2018 16:56:10 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 16:56:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C51D516C3BD3; Fri, 22 Jun 2018 13:58:13 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:58:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com>
 <20180622181916.GA13628@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622181916.GA13628@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062220-0064-0000-0000-0000031F1ECC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009242; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050834; UDB=6.00538565; IPR=6.00829804;
 MB=3.00021811; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 20:56:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062220-0065-0000-0000-000039AEF5BB
Message-Id: <20180622205813.GV3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 11:19:16AM -0700, Joel Fernandes wrote:
> On Fri, Jun 22, 2018 at 06:28:43AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 21, 2018 at 10:56:59PM -0700, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Wed, Jun 20, 2018 at 09:49:02AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jun 21, 2018 at 01:05:22AM +0900, Byungchul Park wrote:
> > > > > On Wed, Jun 20, 2018 at 11:58 PM, Paul E. McKenney
> > > > > <paulmck@linux.vnet.ibm.com> wrote:
> > > > > > On Wed, Jun 20, 2018 at 05:47:20PM +0900, Byungchul Park wrote:
> > > > > >> Hello folks,
> > > > > >>
> > > > > >> I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
> > > > > >> think it's possible since the only thing we are interested in with
> > > > > >> regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
> > > > > >> idle or not.
> > > > > >
> > > > > > Please keep in mind that NMIs cannot be masked, which means that the
> > > > > > rcu_nmi_enter() and rcu_nmi_exit() pair can be invoked at any point in
> > > > > > the process, between any consecutive pair of instructions.  The saving
> > > > 
> > > > And yes, I should have looked at this patch more closely before replying.
> > > > But please see below.
> > > > 
> > > > > I believe I understand what NMI is and why you introduced
> > > > > ->dynticks_nmi_nesting. Or am I missing something?
> > > > 
> > > > Perhaps the fact that there are architectures that can enter interrupt
> > > > handlers and never leave them when the CPU is non-idle.  One example of
> > > > this is the usermode upcalls in the comment that you removed.
> > > 
> > > I spent some time tonight and last night trying to understand this concept of
> > > never leaving an interrupt, I hope you don't mind me asking this dumb
> > > question... perhaps I will learn something : Could you let me know how is it
> > > possible that an interrupt never exits?
> > > 
> > > Typically an interrupt never exiting sounds like a hard-lockup. This is how
> > > hardlock detector works: Since regular interrupts in linux can't nest, the
> > > hardlockup detector checks if hrtimer interrupts are being handled and if
> > > not, then it throws a splat, panics the kernel etc. So I am a bit troubled by
> > > this interrupt never exiting concept..
> > > 
> > > Further since an interrupt is an atomic context, it cannot sleep or schedule
> > > into usermode so how are these upcalls handled from the interrupt?
> > 
> > It has been some years since I traced the code flow, but what happened
> 
> No problem, thanks for the discussion. :)
> 
> > back then is that it switches itself from an interrupt handler to not
> > without actually returning from the interrupt.  This can only happen when
> > interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> > relies on this restriction.  If I remember correctly, the code ends up
> > executing in the context of the interrupted process, but it has been some
> > years, so please apply appropriate skepticism.
> 
> Sure. So in a later thread you mentioned "usermode helpers". I took a closer
> look at that subsystem, and it seems you can execute usermode helpers from
> atomic sections with help of UMH_NO_WAIT flag.
> 
> Then I checked where this flag is used and it turns out its from the
> mce_work_trigger function in x86/kernel/cpu/mcheck/dev-mcelog.c which can be
> called infact from an interrupt context (mce_notify_irq).
> 
> Is this the usecase you remember causing this weird transitions to userspace?

It was on Power, so it was not this one.

> > Please take a look at the "Interrupts and NMIs" section of the file
> > Documentation/RCU/Design/Requirements/Requirements.html for a bit
> > more information.
> 
> Sure, thanks for the pointer.
> 
> > > Lastly, can you point me to an example how the rcu_nmi_enter/exit() pair can go
> > > out sync? That is they aren't paired and nested properly? In my mind they
> > > always should be but I may be missing the usecase. I'm happy to try and
> > > reproduce and trace this if you can let me know how to so that I can study
> > > it better. 
> > 
> > I have never seen NMIs be unpaired or improperly nested.  However,
> > given that rcu_irq_enter() invokes rcu_nmi_enter() and rcu_irq_exit()
> > invokes rcu_nmi_exit(), it is definitely the case that rcu_nmi_enter()
> > and rcu_nmi_exit() need to deal with unpaired and improperly nested
> > invocations.
> 
> Just wondering how would the fact that rcu_irq_enter calls into rcu_nmi_enter
> cause an improper nesting?
> 
> Just to define what "improper nesting" means, if we can go through an
> example. Do you mean a scenario like?
> 
> rcu_nmi_enter (called because of NMI)
> rcu_nmi_enter (called because of IRQ)
> rcu_nmi_exit (called because of NMI)
> rcu_nmi_exit (called because of IRQ)
> 
> Such scenario seems impossible to me because the IRQ can't be entered after
> the NMI entered.

That is OK.  NMIs really can nest.  Or more accurately, things that
appear to be NMIs from RCU's viewpoint can nest within other things
that appear to be NMIs from RCU's viewpoint.

> On the other hand, if you meant that when IRQ is being handled, an NMI fires
> just before the rcu_irq_enter calls rcu_nmi_enter, then the worst that could
> happen seems to be that the rcu_nmi_enter/exit pairs will not be nested
> within the outer rcu_nmi_enter/exit pair even though the NMI interrupted the
> IRQ. So it'll be something like:
> 
> rcu_nmi_enter (called because of NMI)
> rcu_nmi_exit (called because of NMI)
> rcu_nmi_enter (called because of IRQ)
> rcu_nmi_exit (called because of IRQ)
> 
> Even though what really happened in the real world is:
> 
> IRQ entered
> NMI entered
> NMI exited
> IRQ exited
> 
> This also seems reasonable to me, but is this what you meant by improper
> nesting of the rcu_nmi_enter/exit? If yes, what makes it unreasonable?

Something like this:

	IRQ entered

And never exited.  Ever.  I actually saw this in 2011.

Or something like this:

	IRQ exited

Without a corresponding IRQ enter.

The current code handles both of these situations, at least assuming
that the interrupt entry/exit happens during a non-idle period.

> > So why this function-call structure?  Well, you see, NMI handlers can
> > take what appear to RCU to be normal interrupts...
> > 
> > (And I just added that fun fact to Requirements.html.)
> 
> Yes, I'll definitely go through all the interrupt requirements in the doc and
> thanks for referring me to it.

My concern may well be obsolete.  It would be good if it was!  ;-)

								Thanx, Paul

