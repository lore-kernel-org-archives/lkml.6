Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sZdSAiFOGlvsdwAAmS7hNA
	; Fri, 08 Jun 2018 09:36:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 87B00607E4; Fri,  8 Jun 2018 09:36:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6DFF2602FC;
	Fri,  8 Jun 2018 09:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DFF2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeFHJgn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:36:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752061AbeFHJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:36:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w589TV7A137599
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 05:36:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jfp4aawjc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:36:40 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 8 Jun 2018 05:36:40 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 05:36:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w589abgV7012720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 09:36:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D32FB205F;
        Fri,  8 Jun 2018 06:38:06 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35DBAB2064;
        Fri,  8 Jun 2018 06:38:06 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.209.72])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 06:38:06 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A283A16C62F9; Fri,  8 Jun 2018 02:38:26 -0700 (PDT)
Date: Fri, 8 Jun 2018 02:38:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] doc: Update synchronize_rcu() definition in whatisRCU.txt
Reply-To: paulmck@linux.vnet.ibm.com
References: <1528365717-7213-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528365717-7213-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060809-0072-0000-0000-0000036A55EB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009150; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043909; UDB=6.00534503; IPR=6.00822964;
 MB=3.00021528; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-08 09:36:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060809-0073-0000-0000-000048499427
Message-Id: <20180608093826.GT3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:01:57PM +0200, Andrea Parri wrote:
> The synchronize_rcu() definition based on RW-locks in whatisRCU.txt
> does not meet the "Memory-Barrier Guarantees" in Requirements.html;
> for example, the following SB-like test:
> 
>     P0:                      P1:
> 
>     WRITE_ONCE(x, 1);        WRITE_ONCE(y, 1);
>     synchronize_rcu();       smp_mb();
>     r0 = READ_ONCE(y);       r1 = READ_ONCE(x);
> 
> should not be allowed to reach the state "r0 = 0 AND r1 = 0", but
> the current write_lock()+write_unlock() definition can not ensure
> this. Remedies this by inserting an smp_mb__after_spinlock().
> 
> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Queued for review, thank you!

							Thanx, Paul

> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/RCU/whatisRCU.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
> index a27fbfb0efb82..86a54ff911fc2 100644
> --- a/Documentation/RCU/whatisRCU.txt
> +++ b/Documentation/RCU/whatisRCU.txt
> @@ -586,6 +586,7 @@ It is extremely simple:
>  	void synchronize_rcu(void)
>  	{
>  		write_lock(&rcu_gp_mutex);
> +		smp_mb__after_spinlock();
>  		write_unlock(&rcu_gp_mutex);
>  	}
> 
> @@ -607,12 +608,15 @@ don't forget about them when submitting patches making use of RCU!]
> 
>  The rcu_read_lock() and rcu_read_unlock() primitive read-acquire
>  and release a global reader-writer lock.  The synchronize_rcu()
> -primitive write-acquires this same lock, then immediately releases
> -it.  This means that once synchronize_rcu() exits, all RCU read-side
> -critical sections that were in progress before synchronize_rcu() was
> -called are guaranteed to have completed -- there is no way that
> -synchronize_rcu() would have been able to write-acquire the lock
> -otherwise.
> +primitive write-acquires this same lock, then releases it.  This means
> +that once synchronize_rcu() exits, all RCU read-side critical sections
> +that were in progress before synchronize_rcu() was called are guaranteed
> +to have completed -- there is no way that synchronize_rcu() would have
> +been able to write-acquire the lock otherwise.  The smp_mb__after_spinlock()
> +promotes synchronize_rcu() to a full memory barrier in compliance with
> +the "Memory-Barrier Guarantees" listed in:
> +
> +	Documentation/RCU/Design/Requirements/Requirements.html.
> 
>  It is possible to nest rcu_read_lock(), since reader-writer locks may
>  be recursively acquired.  Note also that rcu_read_lock() is immune
> -- 
> 2.7.4
> 
