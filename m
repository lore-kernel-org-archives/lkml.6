Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FED0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4D22077C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4D22077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeIBIbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 04:31:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbeIBIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 04:31:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w824EBlo047407
        for <linux-kernel@vger.kernel.org>; Sun, 2 Sep 2018 00:16:43 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m881rh0wx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 00:16:42 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 2 Sep 2018 00:16:42 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 2 Sep 2018 00:16:39 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w824GcTr25100344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 2 Sep 2018 04:16:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66463B2066;
        Sun,  2 Sep 2018 00:15:30 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B143B2065;
        Sun,  2 Sep 2018 00:15:30 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.237.165])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  2 Sep 2018 00:15:30 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AA29216C095C; Sat,  1 Sep 2018 21:16:39 -0700 (PDT)
Date:   Sat, 1 Sep 2018 21:16:39 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901184531.72ffb792@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18090204-2213-0000-0000-000002E6B22F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009654; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01082290; UDB=6.00558426; IPR=6.00862279;
 MB=3.00023065; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-02 04:16:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18090204-2214-0000-0000-00005B692980
Message-Id: <20180902041639.GQ4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809020047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 06:45:31PM -0400, Steven Rostedt wrote:
> On Sat, 1 Sep 2018 10:54:42 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Sat, Sep 01, 2018 at 07:35:59PM +0200, Borislav Petkov wrote:
> > > This is a huge splat! It haz some perf* and sched* in it, I guess for
> > > peterz to stare at. And lemme add Paul for good measure too :)
> > > 
> > > Kernel is -rc1 + 3 microcode loader patches ontop which should not be
> > > related.  
> > 
> > It really is tracing from the idle loop.  But I thought that the event
> > tracing took care of that.  Adding Steve and Joel for their thoughts.
> > 
> > 							Thanx, Paul
> > 
> > > Thx.
> > > 
> > > ---
> > > [   62.409125] =============================
> > > [   62.409129] WARNING: suspicious RCU usage
> > > [   62.409133] 4.19.0-rc1+ #1 Not tainted
> > > [   62.409136] -----------------------------
> > > [   62.409140] ./include/linux/rcupdate.h:631 rcu_read_lock() used illegally while idle!
> > > [   62.409143] 
> > >                other info that might help us debug this:
> > > 
> > > [   62.409147] 
> > >                RCU used illegally from idle CPU!
> > >                rcu_scheduler_active = 2, debug_locks = 1
> > > [   62.409151] RCU used illegally from extended quiescent state!
> > > [   62.409155] 1 lock held by swapper/0/0:
> > > [   62.409158]  #0: 000000004557ee0e (rcu_read_lock){....}, at: perf_event_output_forward+0x0/0x130
> > > [   62.409175] 
> > >                stack backtrace:
> > > [   62.409180] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc1+ #1
> > > [   62.409183] Hardware name: LENOVO 2320CTO/2320CTO, BIOS G2ET86WW (2.06 ) 11/13/2012
> > > [   62.409187] Call Trace:
> > > [   62.409196]  dump_stack+0x85/0xcb
> > > [   62.409203]  perf_event_output_forward+0xf6/0x130
> 
> I think this is because we switched the trace point code to be
> protected by srcu instead of rcu_lock_sched() and a song and dance to
> "make RCU watch again" if it is not, but perf is using normal
> rcu_read_lock() internally even though it is hooked into the
> tracepoint code. Should perf switch to SRCU, or perhaps it can do the
> song and dance to make RCU watch again?

Well, this is a regression, so in theory we could push my three SRCU
patches into the current merge window, which would allow perf going
to SRCU, thus fixing the above splat.  I am OK either way.  What would
you prefer?

							Thanx, Paul

> -- Steve
> 
> 
> > > [   62.409215]  __perf_event_overflow+0x52/0xe0
> > > [   62.409223]  perf_swevent_overflow+0x91/0xb0
> > > [   62.409229]  perf_tp_event+0x11a/0x350
> > > [   62.409235]  ? find_held_lock+0x2d/0x90
> > > [   62.409251]  ? __lock_acquire+0x2ce/0x1350
> > > [   62.409263]  ? __lock_acquire+0x2ce/0x1350
> > > [   62.409270]  ? retint_kernel+0x2d/0x2d
> > > [   62.409278]  ? find_held_lock+0x2d/0x90
> > > [   62.409285]  ? tick_nohz_get_sleep_length+0x83/0xb0
> > > [   62.409299]  ? perf_trace_cpu+0xbb/0xd0
> > > [   62.409306]  ? perf_trace_buf_alloc+0x5a/0xa0
> > > [   62.409311]  perf_trace_cpu+0xbb/0xd0
> > > [   62.409323]  cpuidle_enter_state+0x185/0x340
> > > [   62.409332]  do_idle+0x1eb/0x260
> > > [   62.409340]  cpu_startup_entry+0x5f/0x70
> > > [   62.409347]  start_kernel+0x49b/0x4a6
> > > 
> > > [   62.409357]  secondary_startup_64+0xa4/0xb0
> 

