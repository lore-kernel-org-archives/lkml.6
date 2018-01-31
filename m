Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeAaJuP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:50:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751764AbeAaJuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:50:11 -0500
Date: Tue, 30 Jan 2018 16:52:16 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Sewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] hrtimer: Reset hrtimer cpu base proper on CPU hotplug
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.20.1801261447590.2067@nanos>
 <20180126220917.GI3741@linux.vnet.ibm.com>
 <20180129082047.hash3pnhpztzcg22@linutronix.de>
 <20180129095738.GU3741@linux.vnet.ibm.com>
 <20180129234347.GA26365@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1801302202510.2293@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1801302202510.2293@nanos>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18013109-0036-0000-0000-000002B63CDB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008455; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00982938; UDB=6.00498462; IPR=6.00762221;
 BA=6.00005804; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019302; XFM=3.00000015;
 UTC=2018-01-31 09:50:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013109-0037-0000-0000-0000432D80CA
Message-Id: <20180131005216.GE3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801310130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:03:17PM +0100, Thomas Gleixner wrote:
> On Mon, 29 Jan 2018, Paul E. McKenney wrote:
> 
> > On Mon, Jan 29, 2018 at 01:57:38AM -0800, Paul E. McKenney wrote:
> > > On Mon, Jan 29, 2018 at 09:20:48AM +0100, Sebastian Sewior wrote:
> > > > On 2018-01-26 14:09:17 [-0800], Paul E. McKenney wrote:
> > > > > find this one.  ;-)  But it did pass rcutorture testing for a great many
> > > > > years, didn't it?  :-/
> > > > 
> > > > It started to trigger better (or at all) on our test box with
> > > > 	modprobe kvm_intel preemption_timer=n
> > > > 
> > > > on the host kernel so maybe a completely unrelated change helped to
> > > > trigger this.
> > > 
> > > Good point!
> > > 
> > > And testing continues, currently at 108 hours of TREE01 without any
> > > waylayed timers, so looking good!  ;-)
> > > 
> > > Just kicked off another 70 hours worth.
> > 
> > And those completed without incident for a total of 178 hours.  I believe
> > we can call this one fixed.  Thank you all!!!
> > 
> > One question...  Is the patch shown below needed, or is this just yet
> > another case of me being confused?  (The lack of it is not triggering,
> > but...)
> 
> See commit 26456f87aca7

Got it, thank you!  I will remove my patch from my queue.

							Thanx, Paul
