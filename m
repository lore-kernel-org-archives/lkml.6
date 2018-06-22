Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE97242C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE97242C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeFVNej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:34:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750853AbeFVNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:34:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MDYUhI063620
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:34:37 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrxynyhae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:34:36 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 09:34:33 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 09:34:30 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MDYTGf2032168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 13:34:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1189CB2068;
        Fri, 22 Jun 2018 09:34:29 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEF16B2066;
        Fri, 22 Jun 2018 09:34:28 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.197.125])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 09:34:28 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ACDFD16C9E49; Fri, 22 Jun 2018 06:36:31 -0700 (PDT)
Date:   Fri, 22 Jun 2018 06:36:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
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
 <20180620174037.GZ3593@linux.vnet.ibm.com>
 <20180621063949.GA28024@X58A-UD3R>
 <20180621150407.GE3593@linux.vnet.ibm.com>
 <20180622030032.GB17010@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622030032.GB17010@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062213-0052-0000-0000-00000302AF60
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009238; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050687; UDB=6.00538476; IPR=6.00829657;
 MB=3.00021805; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 13:34:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062213-0053-0000-0000-00005D1A7611
Message-Id: <20180622133631.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:00:32PM +0900, Byungchul Park wrote:
> On Thu, Jun 21, 2018 at 08:04:07AM -0700, Paul E. McKenney wrote:
> 
> > Nothing quite like concurrent programming to help one see one's own
> > mistakes.  ;-)
> 
> Haha.
> 
> > Your reasoning has merit, but the nice thing about keeping "nmi" is
> > that it helps casual readers see that NMIs must be handled.  If we
> > rename this to "irq", we lose that hint and probably leave some
> > readers wondering why the strange increment-by-2 code is there.
> > So let's please keep the current names.
> 
> Got it. I will.
> 
> > >  /**
> > > - * rcu_nmi_exit - inform RCU of exit from NMI context
> > > + * rcu_irq_exit_common - inform RCU of exit from interrupt context
> > >   *
> > > - * If we are returning from the outermost NMI handler that interrupted an
> > > - * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
> > > - * to let the RCU grace-period handling know that the CPU is back to
> > > - * being RCU-idle.
> > > + * If we are returning from the outermost interrupt handler that
> > > + * interrupted an RCU-idle period, update rdtp->dynticks and
> > > + * rdtp->dynticks_irq_nesting to let the RCU grace-period handling
> > > + * know that the CPU is back to being RCU-idle.
> > >   *
> > > - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > > - * with CONFIG_RCU_EQS_DEBUG=y.
> > > + * If you add or remove a call to rcu_irq_exit_common(), be sure to
> > > + * test with CONFIG_RCU_EQS_DEBUG=y.
> > >   */
> > > -void rcu_nmi_exit(void)
> > > +static __always_inline void rcu_irq_exit_common(bool nmi)
> > 
> > However, I suggest making this function's parameter "irq" because ...
> 
> I will.
> 
> > Does the generated code really get rid of the conditional branches?
> > I would hope that it wouild, but it is always good to check.  This
> > should be easy to find in the assembly-language output because of the
> > calls to rcu_prepare_for_idle() and rcu_dynticks_task_enter().
> 
> Good! It works as we expect, I did it only with x86_64 tho.

I suspect that it would be similar for most other architectures running
the same compiler version.  Might be worth firing up a cross-compiler
to check one or two more, though.

>                                                             Let me show
> you the part we are interested in. The rest are almost same.
> 
> <rcu_nmi_exit>:
> 	5b                   	pop    %rbx
> 	5d                   	pop    %rbp
> 	41 5c                	pop    %r12
> 	41 5d                	pop    %r13
> 	41 5e                	pop    %r14
> 	41 5f                	pop    %r15
> 	e9 0f 75 ff ff       	jmpq   ffffffff810bb440 <rcu_dynticks_eqs_enter>
> 
> <rcu_irq_exit>:
> 	e8 e6 e5 ff ff       	callq  ffffffff810c26a0 <rcu_prepare_for_idle>
> 	e8 81 73 ff ff       	callq  ffffffff810bb440 <rcu_dynticks_eqs_enter>
> 	e8 ec 3a 2b 00       	callq  ffffffff81377bb0 <debug_smp_processor_id>
> 	65 48 8b 14 25 00 4d 	mov    %gs:0x14d00,%rdx
> 	01 00 
> 	89 82 94 03 00 00    	mov    %eax,0x394(%rdx)
> 	5b                   	pop    %rbx
> 	5d                   	pop    %rbp
> 	41 5c                	pop    %r12
> 	41 5d                	pop    %r13
> 	41 5e                	pop    %r14
> 	41 5f                	pop    %r15
> 	c3                   	retq

This is a summary view focusing on the function calls, correct?
(I am guessing this based on your "the part we are interested in".)

> Even though they return in a little bit different way, anyway I can see
> all the branchs we are interested in were removed by compiler!

Yes, very nice!

The reason for the difference is that the compiler applied tail
recursion to rcu_nmi_exit()'s call to rcu_dynticks_eqs_enter(), and
inlined rcu_irq_exit()'s call to rcu_dynticks_task_enter().

> > >  {
> > >  	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
> > >  	long incby = 2;
> > > 
> > >  	/* Complain about underflow. */
> > > -	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
> > > +	WARN_ON_ONCE(rdtp->dynticks_irq_nesting < 0);
> > > 
> > >  	/*
> > >  	 * If idle from RCU viewpoint, atomically increment ->dynticks
> > > -	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
> > > -	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
> > > -	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
> > > +	 * to mark non-idle and increment ->dynticks_irq_nesting by one.
> > > +	 * Otherwise, increment ->dynticks_irq_nesting by two.  This means
> > > +	 * if ->dynticks_irq_nesting is equal to one, we are guaranteed
> > >  	 * to be in the outermost NMI handler that interrupted an RCU-idle
> > >  	 * period (observation due to Andy Lutomirski).
> > >  	 */
> > >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > +
> > > +		if (!nmi)
> > > +			rcu_dynticks_task_exit();
> > > +
> > >  		rcu_dynticks_eqs_exit();
> > > +
> > > +		if (!nmi)
> > 
> > ... and checking for branches here.
> 
> Also good! The following is the only different part.
> 
> <rcu_nmi_enter>:
> 	e8 dc 81 ff ff       	callq  ffffffff810bc450 <rcu_dynticks_eqs_exit>
> 
> <rcu_irq_enter>:
> 	65 48 8b 04 25 00 4d 	mov    %gs:0x14d00,%rax
> 	01 00 
> 	c7 80 94 03 00 00 ff 	movl   $0xffffffff,0x394(%rax)
> 	ff ff ff 
> 	e8 b9 80 ff ff       	callq  ffffffff810bc450 <rcu_dynticks_eqs_exit>
> 	e8 d4 b9 ff ff       	callq  ffffffff810bfd70 <rcu_cleanup_after_idle>

Also looks good, so please do send the patches!

							Thanx, Paul

