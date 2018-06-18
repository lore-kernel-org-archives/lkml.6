Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AC8208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AC8208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755235AbeFRP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:28:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752849AbeFRP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:28:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IFSiAx113560
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:28:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpehytfn2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:28:47 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 11:28:31 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 11:28:28 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IFSRL55898702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 15:28:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A67C2B205F;
        Mon, 18 Jun 2018 11:28:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85191B2065;
        Mon, 18 Jun 2018 11:28:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 11:28:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5150316C6A76; Mon, 18 Jun 2018 08:30:27 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:30:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcutorture: use monotonic timestamp for stall detection
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180618144741.339763-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618144741.339763-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061815-2213-0000-0000-000002BBAC07
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009214; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01048811; UDB=6.00537352; IPR=6.00827784;
 MB=3.00021719; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-18 15:28:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061815-2214-0000-0000-00005A8639EC
Message-Id: <20180618153027.GU3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:47:34PM +0200, Arnd Bergmann wrote:
> The get_seconds() call is deprecated because it overflows on 32-bit
> architectures. The algorithm in rcu_torture_stall() can deal with
> the overflow, but another problem here is that using a CLOCK_REALTIME
> stamp can lead to a false-positive stall warning when a settimeofday()
> happens concurrently.
> 
> Using ktime_get_seconds() instead avoids those issues and will never
> overflow. The added cast to 'unsigned long' however is necessary to
> make ULONG_CMP_LT() work correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Queued for testing and review, thank you!  If things go well, I
expect this to be ready for the v4.19 merge window.

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 42fcb7f05fac..f42cf69ef539 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1446,7 +1446,7 @@ static int rcu_torture_stall(void *args)
>  		VERBOSE_TOROUT_STRING("rcu_torture_stall end holdoff");
>  	}
>  	if (!kthread_should_stop()) {
> -		stop_at = get_seconds() + stall_cpu;
> +		stop_at = ktime_get_seconds() + stall_cpu;
>  		/* RCU CPU stall is expected behavior in following code. */
>  		rcu_read_lock();
>  		if (stall_cpu_irqsoff)
> @@ -1455,7 +1455,8 @@ static int rcu_torture_stall(void *args)
>  			preempt_disable();
>  		pr_alert("rcu_torture_stall start on CPU %d.\n",
>  			 smp_processor_id());
> -		while (ULONG_CMP_LT(get_seconds(), stop_at))
> +		while (ULONG_CMP_LT((unsigned long)ktime_get_seconds(),
> +				    stop_at))
>  			continue;  /* Induce RCU CPU stall warning. */
>  		if (stall_cpu_irqsoff)
>  			local_irq_enable();
> -- 
> 2.9.0
> 

