Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeEVXa7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:30:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753100AbeEVXa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:30:58 -0400
Date: Tue, 22 May 2018 16:21:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH rcu] rcutorture: __pcpu_scope_rcu_torture_timer_rand
 can be static
Reply-To: paulmck@linux.vnet.ibm.com
References: <201805230516.7z5kOC3u%fengguang.wu@intel.com>
 <20180522213034.GA87654@lkp-sb04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522213034.GA87654@lkp-sb04>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052223-0016-0000-0000-000008C7E1F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036223; UDB=6.00530082; IPR=6.00815351;
 MB=3.00021247; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 23:30:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052223-0017-0000-0000-00003EDAAD9B
Message-Id: <20180522232116.GG3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220232
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 05:30:35AM +0800, kbuild test robot wrote:
> 
> Fixes: 816e0790625a ("rcutorture: Use per-CPU random state for rcu_torture_timer()")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

I folded this into the offending patch with attribution, thank you!

							Thanx, Paul

> ---
>  rcutorture.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 5683bfb..a03313e 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1142,7 +1142,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
>  	return true;
>  }
> 
> -DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
> +static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
> 
>  /*
>   * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
> 
