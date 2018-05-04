Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbeEDRvY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:51:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751307AbeEDRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:51:23 -0400
Date: Fri, 4 May 2018 10:52:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH] kernel/signal: Remove no longer required irqsave/restore
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180504144014.5378-1-bigeasy@linutronix.de>
 <87fu37e4rn.fsf@xmission.com>
 <20180504170459.624e7vkro5fn2bgw@linutronix.de>
 <876043e3xb.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <876043e3xb.fsf@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050417-0044-0000-0000-0000040FBC50
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008970; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027471; UDB=6.00524848; IPR=6.00806605;
 MB=3.00020930; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 17:51:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050417-0045-0000-0000-00000841C609
Message-Id: <20180504175241.GT26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 12:17:20PM -0500, Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2018-05-04 11:59:08 [-0500], Eric W. Biederman wrote:
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> >> > From: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > …
> >> > This long-term fix has been made in commit 4abf91047cf ("rtmutex: Make >
> >> > wait_lock irq safe") for different reason.
> >> 
> >> Which tree has this change been made in?  I am not finding the commit
> >> you mention above in Linus's tree.
> >
> > I'm sorry, it should have been commit b4abf91047cf ("rtmutex: Make
> > wait_lock irq safe").
> 
> Can you fix that in your patch description and can you also up the
> description of rcu_read_unlock?
> 
> If we don't need to jump through hoops it looks very reasonable to
> remove this unnecessary logic.  But we should fix the description
> in rcu_read_unlock that still says we need these hoops.

The hoops are still required for rcu_read_lock(), otherwise you
get deadlocks between the scheduler and RCU in PREEMPT=y kernels.
What happens with this patch (if I understand it correctly) is that the
signal code now uses a different way of jumping through the hoops.
But the hoops are still jumped through.

							Thanx, Paul
