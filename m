Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCF6C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D556B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D556B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937199AbeFSChG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:37:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937124AbeFSChF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:37:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5J2Y6EZ127138
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:37:04 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jppb05k48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:37:04 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 22:37:03 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 22:37:00 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5J2axHk16318744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jun 2018 02:36:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95212B2067;
        Mon, 18 Jun 2018 22:36:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73076B2064;
        Mon, 18 Jun 2018 22:36:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.187.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 22:36:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4FA5A16C2AF0; Mon, 18 Jun 2018 19:38:59 -0700 (PDT)
Date:   Mon, 18 Jun 2018 19:38:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        kernel test robot <xiaolong.ye@intel.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180610234544.150933-2-joel@joelfernandes.org>
 <20180613065711.GZ16472@yexl-desktop>
 <20180613072948.GA142000@joelaf.mtv.corp.google.com>
 <20180618165646.GA3593@linux.vnet.ibm.com>
 <20180618222647.GA156172@joelaf.mtv.corp.google.com>
 <20180619010803.GC3593@linux.vnet.ibm.com>
 <2CDE3A5B-1AD3-4185-9E24-24D4075A9EA6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2CDE3A5B-1AD3-4185-9E24-24D4075A9EA6@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061902-0064-0000-0000-0000031D2233
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009217; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049034; UDB=6.00537486; IPR=6.00828007;
 MB=3.00021729; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-19 02:37:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061902-0065-0000-0000-000039A402D0
Message-Id: <20180619023859.GE3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806190028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 06:36:06PM -0700, Joel Fernandes wrote:
> 
> 
> On June 18, 2018 6:08:03 PM PDT, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >On Mon, Jun 18, 2018 at 03:26:47PM -0700, Joel Fernandes wrote:
> >> On Mon, Jun 18, 2018 at 09:56:46AM -0700, Paul E. McKenney wrote:
> >> > > The reason for the rcutorture test failure could be that the
> >default
> >> > > kthread_prio for the system's RCU threads is set to 1 (unless
> >overridden by
> >> > > rcutree.kthread_prio) which is also equal to the priority of the
> >rcutorture's
> >> > > boost threads. Due to this the rcutorture test could starve the
> >RCU threads
> >> > > as well and defeat the boosting mechanism. I was able to solve a
> >similar
> >> > > issue by just passing rcutree.kthread_prio of 50 on the kernel
> >command line.
> >> > > 
> >> > > Paul, would it be ok if we changed the default kthread_prio to
> >something > 1
> >> > > so that rcutorture can test properly without needing to pass any
> >extra
> >> > > rcutree.* parameters?
> >> > > 
> >> > > so something like this in kernel/rcu/tree.c ?
> >> > > 
> >> > > static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;
> >> > 
> >> > Would it be possible to also condition this on rcutorture being
> >built
> >> > in?  Or are they doing modprobes for rcutorture?
> >> 
> >> They seem to be doing built-in rcutorture tests. But I believe the
> >same
> >> problem would occur even if you used modules? I believe the fact that
> >> rcutorture is a module or built-in wouldn't matter to the underlying
> >issue
> >> which is the RCU subsystems's threads are at too low of a priority
> >> (rcutree.kthread_prio = 1).
> >
> >Understood...
> >
> >> If you agree with changing the default priority, I have included a
> >patch
> >> below for rcu/dev.
> >
> >The problem is that without rcutorture, rcutree.kthread_prio=1 is a
> >legitimate choice, and changing the default globally could be breaking
> >someone.  So it would be far better to up the priority only during
> >known
> >rcutorture testing.
> 
> Oh I see what you're saying. I'll work on a patch along these lines
> then. Thanks!

Looking forward to seeing it!

							Thanx, Paul

