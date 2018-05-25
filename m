Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936182AbeEYOSL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:18:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935791AbeEYOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:18:09 -0400
Date: Fri, 25 May 2018 07:19:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, ebiederm@xmission.com
Subject: Re: [PATCH v2 1/2] rcu: Update documentation of rcu_read_unlock()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525090507.22248-1-anna-maria@linutronix.de>
 <20180525090507.22248-2-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525090507.22248-2-anna-maria@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052514-0044-0000-0000-0000041B80CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-25 14:18:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052514-0045-0000-0000-0000084D9F18
Message-Id: <20180525141942.GB3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 11:05:06AM +0200, Anna-Maria Gleixner wrote:
> Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the
> explanation in rcu_read_unlock() documentation about irq unsafe rtmutex
> wait_lock is no longer valid.
> 
> Remove it to prevent kernel developers reading the documentation to rely on
> it.
> 
> Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Or let me know if you would like me to carry this patch.  Either way,
just let me know!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 36360d07f25b..64644fda3b22 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -653,9 +653,7 @@ static inline void rcu_read_lock(void)
>   * Unfortunately, this function acquires the scheduler's runqueue and
>   * priority-inheritance spinlocks.  This means that deadlock could result
>   * if the caller of rcu_read_unlock() already holds one of these locks or
> - * any lock that is ever acquired while holding them; or any lock which
> - * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
> - * does not disable irqs while taking ->wait_lock.
> + * any lock that is ever acquired while holding them.
>   *
>   * That said, RCU readers are never priority boosted unless they were
>   * preempted.  Therefore, one way to avoid deadlock is to make sure
> -- 
> 2.15.1
> 
