Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4098E24711
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4098E24711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933967AbeFVSM2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933285AbeFVSM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:12:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MI9NfL104093
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:12:27 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2js4r1k6nt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:12:27 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 14:12:25 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 14:12:21 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MICKM04194654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 18:12:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4E99B2064;
        Fri, 22 Jun 2018 14:12:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A868B205F;
        Fri, 22 Jun 2018 14:12:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 14:12:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0033016C1B67; Fri, 22 Jun 2018 11:14:22 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:14:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
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
 <20180622120149.7d5396d5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622120149.7d5396d5@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062218-0052-0000-0000-00000302C8BE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009241; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050779; UDB=6.00538532; IPR=6.00829750;
 MB=3.00021809; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 18:12:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062218-0053-0000-0000-00005D1B0A4A
Message-Id: <20180622181422.GT3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:01:49PM -0400, Steven Rostedt wrote:
> On Fri, 22 Jun 2018 06:28:43 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > It has been some years since I traced the code flow, but what happened
> > back then is that it switches itself from an interrupt handler to not
> > without actually returning from the interrupt.  This can only happen when
> > interrupting a non-idle process, thankfully, and RCU's dyntick-idle code
> > relies on this restriction.  If I remember correctly, the code ends up
> > executing in the context of the interrupted process, but it has been some
> > years, so please apply appropriate skepticism.
> 
> If irq_enter() is not paired with irq_exit() then major things will
> break. Especially since that's how in_interrupt() and friends rely on to
> work.
> 
> Now, perhaps rcu_irq_enter() is called elsewhere (as a git grep appears
> it may be), and that rcu_irq_enter() may not be paired with
> rcu_irq_exit(). But that's not anything to do with the irq_enter() and
> irq_exit() routines being paired or not.

The non-irq_enter() calls to rcu_irq_enter() and the non-irq_exit()
calls to rcu_irq_exit() do appear to be balanced as of v4.17.

If I recall correctly, the offending piece of functionality was the
usermode helpers, which on some architectures did a syscall exception
from within the kernel to make a system call happen.  This seems to now
be common code using workqueues, kernel threads, and do_execve().
Here is the best reference I could find to the specific problem
I encountered back in the day:

https://groups.google.com/forum/#!msg/linux.kernel/B5hZX1tJRs8/sOVVfhrirL8J

I do recall that there were real failures.  There is no way I would have
written code tolerating half-interrupts without cause, no more than I
would have written code handling what looks to RCU like interrupts from
NMI handlers without cause.  ;-)

One approach would be for me to add a WARN_ON_ONCE() to check for
misnesting.  If this didn't trigger for some time long enough for the
check to propagate to the various distros' users, then this code could
be simplified.  Though it would not be that big a deal, just the removal
of a store or two.

							Thanx, Paul

