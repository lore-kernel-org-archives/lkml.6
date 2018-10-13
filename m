Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59205C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E920659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 23:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5E920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeJNG5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 02:57:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbeJNG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 02:57:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9DNEDPZ009412
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 19:19:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n3m63ruq5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 19:19:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 13 Oct 2018 19:19:03 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Oct 2018 19:19:01 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9DNJ0SM36700258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 Oct 2018 23:19:00 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2810DB2064;
        Sat, 13 Oct 2018 19:16:58 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 082A4B205F;
        Sat, 13 Oct 2018 19:16:58 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.131.128])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Oct 2018 19:16:57 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D232016C0F04; Sat, 13 Oct 2018 16:19:02 -0700 (PDT)
Date:   Sat, 13 Oct 2018 16:19:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2018.10.03a 44/73] kernel/rcu/tree.c:2704:5: warning:
 'max_cpu' may be used uninitialized in this function
Reply-To: paulmck@linux.ibm.com
References: <201810081957.GsKmX8Wz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810081957.GsKmX8Wz%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101323-0040-0000-0000-000004802C16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102268; UDB=6.00570450; IPR=6.00882313;
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 23:19:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101323-0041-0000-0000-000008883F63
Message-Id: <20181013231902.GI2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-13_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 07:25:58PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2018.10.03a
> head:   ef44a26c84188888f97e5d7b3f8e4f8c0decd248
> commit: 813f47a94e3b61439bba90340b532f3a6319d4f5 [44/73] rcu: Print per-CPU callback counts for forward-progress failures
> config: x86_64-randconfig-x006-10081527 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 813f47a94e3b61439bba90340b532f3a6319d4f5
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/rcu/tree.c: In function 'rcu_fwd_progress_check':
> >> kernel/rcu/tree.c:2704:5: warning: 'max_cpu' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (max_cpu >= 0)
>         ^
> >> kernel/rcu/tree.c:2699:6: warning: 'max_cbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>       if (cbs <= max_cbs)
>          ^

Good catch!  A fix is on its way.

							Thanx, Paul

> vim +/max_cpu +2704 kernel/rcu/tree.c
> 
>   2670	
>   2671	/*
>   2672	 * Do a forward-progress check for rcutorture.  This is normally invoked
>   2673	 * due to an OOM event.  The argument "j" gives the time period during
>   2674	 * which rcutorture would like progress to have been made.
>   2675	 */
>   2676	void rcu_fwd_progress_check(unsigned long j)
>   2677	{
>   2678		unsigned long cbs;
>   2679		int cpu;
>   2680		unsigned long max_cbs;
>   2681		int max_cpu;
>   2682		struct rcu_data *rdp;
>   2683	
>   2684		if (rcu_gp_in_progress()) {
>   2685			show_rcu_gp_kthreads();
>   2686		} else {
>   2687			preempt_disable();
>   2688			rdp = this_cpu_ptr(&rcu_data);
>   2689			rcu_check_gp_start_stall(rdp->mynode, rdp, j);
>   2690			preempt_enable();
>   2691		}
>   2692		for_each_possible_cpu(cpu) {
>   2693			cbs = rcu_get_n_cbs_cpu(cpu);
>   2694			if (!cbs)
>   2695				continue;
>   2696			if (max_cpu < 0)
>   2697				pr_info("%s: callbacks", __func__);
>   2698			pr_cont(" %d: %lu", cpu, cbs);
> > 2699			if (cbs <= max_cbs)
>   2700				continue;
>   2701			max_cbs = cbs;
>   2702			max_cpu = cpu;
>   2703		}
> > 2704		if (max_cpu >= 0)
>   2705			pr_cont("\n");
>   2706	}
>   2707	EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
>   2708	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


