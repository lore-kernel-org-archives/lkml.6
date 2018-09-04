Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A9AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC2A20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeIEBUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:20:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbeIEBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:20:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w84Kn4f1102528
        for <linux-kernel@vger.kernel.org>; Tue, 4 Sep 2018 16:53:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m9xsvxy8t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 16:53:21 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 4 Sep 2018 16:53:20 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Sep 2018 16:53:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w84KrH7C26542294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Sep 2018 20:53:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE868B205F;
        Tue,  4 Sep 2018 16:52:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6D1B2064;
        Tue,  4 Sep 2018 16:52:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Sep 2018 16:52:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 30CDB16C2997; Tue,  4 Sep 2018 13:53:21 -0700 (PDT)
Date:   Tue, 4 Sep 2018 13:53:21 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, joel@joelfernandes.org
Subject: Re: 4.19-rc1: ./include/linux/rcupdate.h:631 rcu_read_lock() used
 illegally while idle!
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180901173559.GC26871@zn.tnic>
 <20180901175442.GO4225@linux.vnet.ibm.com>
 <20180901184531.72ffb792@vmware.local.home>
 <20180902041639.GQ4225@linux.vnet.ibm.com>
 <20180904162611.6a120068@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904162611.6a120068@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090420-0068-0000-0000-00000334B3B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009672; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01083572; UDB=6.00559201; IPR=6.00863571;
 MB=3.00023112; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-04 20:53:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090420-0069-0000-0000-0000459F4B55
Message-Id: <20180904205321.GQ4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809040209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 04:26:11PM -0400, Steven Rostedt wrote:
> On Sat, 1 Sep 2018 21:16:39 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sat, Sep 01, 2018 at 06:45:31PM -0400, Steven Rostedt wrote:
> > > On Sat, 1 Sep 2018 10:54:42 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > >   
> > > > On Sat, Sep 01, 2018 at 07:35:59PM +0200, Borislav Petkov wrote:  
> > > > > This is a huge splat! It haz some perf* and sched* in it, I guess for
> > > > > peterz to stare at. And lemme add Paul for good measure too :)
> > > > > 
> > > > > Kernel is -rc1 + 3 microcode loader patches ontop which should not be
> > > > > related.    
> > > > 
> > > > It really is tracing from the idle loop.  But I thought that the event
> > > > tracing took care of that.  Adding Steve and Joel for their thoughts.
> > > > 
> > > > 							Thanx, Paul
> > > >   
> > > > > Thx.
> > > > > 
> > > > > ---
> > > > > [   62.409125] =============================
> > > > > [   62.409129] WARNING: suspicious RCU usage
> > > > > [   62.409133] 4.19.0-rc1+ #1 Not tainted
> > > > > [   62.409136] -----------------------------
> > > > > [   62.409140] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
> > > > > [   62.409143] 
> > > > >                other info that might help us debug this:
> > > > > 
> > > > > [   62.409147] 
> > > > >                RCU used illegally from idle CPU!
> > > > >                rcu_scheduler_active = 2, debug_locks = 1
> > > > > [   62.409151] RCU used illegally from extended quiescent state!
> > > > > [   62.409155] 1 lock held by swapper/0/0:
> > > > > [   62.409158]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
> > > > > [   62.409175] 
> > > > >                stack backtrace:
> > > > > [   62.409180] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
> > > > > [   62.409183] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
> > > > > [   62.409187] Call Trace:
> > > > > [   62.409196]  dump_stack+0x85/0xcb
> > > > > [   62.409203]  perf_event_output_forward+0xf6/0x130  
> > > 
> > > I think this is because we switched the trace point code to be
> > > protected by srcu instead of rcu_lock_sched() and a song and dance to
> > > "make RCU watch again" if it is not, but perf is using normal
> > > rcu_read_lock() internally even though it is hooked into the
> > > tracepoint code. Should perf switch to SRCU, or perhaps it can do the
> > > song and dance to make RCU watch again?  
> > 
> > Well, this is a regression, so in theory we could push my three SRCU
> > patches into the current merge window, which would allow perf going
> > to SRCU, thus fixing the above splat.  I am OK either way.  What would
> > you prefer?
> 
> I wonder if this partial revert will fix things?

I must defer to Borislav on this one.  Assuming it has the desired
effect, I am good with it.  Nicer and more contained fix than three
SRCU patches!  ;-)

							Thanx, Paul

> -- Steve
> 
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 7f2e16e76ac4..041f7e56a289 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -158,8 +158,10 @@ extern void syscall_unregfunc(void);
>  		 * For rcuidle callers, use srcu since sched-rcu	\
>  		 * doesn't work from the idle path.			\
>  		 */							\
> -		if (rcuidle)						\
> +		if (rcuidle) {						\
>  			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +			rcu_irq_enter_irqson();				\
> +		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -171,8 +173,10 @@ extern void syscall_unregfunc(void);
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle)						\
> +		if (rcuidle) {						\
> +			rcu_irq_exit_irqson();				\
>  			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		}							\
>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> 

