Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F10C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0656120811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0656120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLMCrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:47:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbeLMCrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:47:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBD2hk9p035706
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:47:09 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pbacvk7xb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:47:09 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 13 Dec 2018 02:47:08 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Dec 2018 02:47:05 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBD2l46t21954750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Dec 2018 02:47:04 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A04D4B2064;
        Thu, 13 Dec 2018 02:47:04 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4FEB205F;
        Thu, 13 Dec 2018 02:47:04 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.223.5])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Dec 2018 02:47:04 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ED08916C5F35; Wed, 12 Dec 2018 18:47:03 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:47:03 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu: add sparse check to rcu_assign_pointer
Reply-To: paulmck@linux.ibm.com
References: <20181212223710.215094-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212223710.215094-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121302-0060-0000-0000-000002E32A0D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010217; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130963; UDB=6.00587721; IPR=6.00911097;
 MB=3.00024674; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-13 02:47:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121302-0061-0000-0000-0000478492F7
Message-Id: <20181213024703.GG4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812130023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:37:10PM -0800, Joel Fernandes (Google) wrote:
> rcu_assign_pointer currently doesn't do any sparse checking on a pointer
> assigned. So its possible that a pointer that is not __rcu annotated is
> assigned with rcu_assign_pointer without sparse complainting.
> rcu_dereference already does such checking so lets also make
> rcu_assign_pointer to do the same. The extra error could be helpful in
> cases where an RCU pointer is assigned with rcu_assign_pointer but not
> annotated with __rcu.
> 
> This doesn't generate any code in the normal case because __CHECKER__ is
> defined only in the context of sparse.
> 
> Also we rename rcu_dereference_sparse to rcu_check_parse since the
> checking now happens not only during derereferencing but also during
> assignment.
> 
> Test: Introduced an rcu_assign_pointer in code and checked the output of
> sparse with and without this change. The change correctly causes sparse
> to throw an error.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied with some commit-log fixes, thank you!

							Thanx, Paul

> ---
>  include/linux/rcupdate.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 4db8bcacc51a..9e6f10da7f26 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -309,16 +309,16 @@ static inline void rcu_preempt_sleep_check(void) { }
>   */
> 
>  #ifdef __CHECKER__
> -#define rcu_dereference_sparse(p, space) \
> +#define rcu_check_sparse(p, space) \
>  	((void)(((typeof(*p) space *)p) == p))
>  #else /* #ifdef __CHECKER__ */
> -#define rcu_dereference_sparse(p, space)
> +#define rcu_check_sparse(p, space)
>  #endif /* #else #ifdef __CHECKER__ */
> 
>  #define __rcu_access_pointer(p, space) \
>  ({ \
>  	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
> -	rcu_dereference_sparse(p, space); \
> +	rcu_check_sparse(p, space); \
>  	((typeof(*p) __force __kernel *)(_________p1)); \
>  })
>  #define __rcu_dereference_check(p, c, space) \
> @@ -326,13 +326,13 @@ static inline void rcu_preempt_sleep_check(void) { }
>  	/* Dependency order vs. p above. */ \
>  	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
> -	rcu_dereference_sparse(p, space); \
> +	rcu_check_sparse(p, space); \
>  	((typeof(*p) __force __kernel *)(________p1)); \
>  })
>  #define __rcu_dereference_protected(p, c, space) \
>  ({ \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
> -	rcu_dereference_sparse(p, space); \
> +	rcu_check_sparse(p, space); \
>  	((typeof(*p) __force __kernel *)(p)); \
>  })
>  #define rcu_dereference_raw(p) \
> @@ -382,6 +382,7 @@ static inline void rcu_preempt_sleep_check(void) { }
>  #define rcu_assign_pointer(p, v)					      \
>  ({									      \
>  	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
> +	rcu_check_sparse(p, __rcu);				      \
>  									      \
>  	if (__builtin_constant_p(v) && (_r_a_p__v) == (uintptr_t)NULL)	      \
>  		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
> @@ -785,7 +786,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>   */
>  #define RCU_INIT_POINTER(p, v) \
>  	do { \
> -		rcu_dereference_sparse(p, __rcu); \
> +		rcu_check_sparse(p, __rcu); \
>  		WRITE_ONCE(p, RCU_INITIALIZER(v)); \
>  	} while (0)
> 
> -- 
> 2.20.0.rc1.387.gf8505762e3-goog
> 

