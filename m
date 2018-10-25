Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7763C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D42920834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D42920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeJZAEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:04:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14987 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727659AbeJZAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:04:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PFTxoH117933
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:31:14 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nbg0fhxbt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:31:14 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 25 Oct 2018 11:31:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 11:31:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PFVAkb18546932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 15:31:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89DADB2065;
        Thu, 25 Oct 2018 15:31:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50501B206A;
        Thu, 25 Oct 2018 15:31:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.210.186])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Oct 2018 15:31:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E60B516C36C3; Thu, 25 Oct 2018 08:31:09 -0700 (PDT)
Date:   Thu, 25 Oct 2018 08:31:09 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 3.18 55/98] rcu: Clear need_qs flag to prevent
 splat
Reply-To: paulmck@linux.ibm.com
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-55-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025141853.214051-55-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102515-0064-0000-0000-000003663BAE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009934; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01107824; UDB=6.00573806; IPR=6.00887907;
 MB=3.00023906; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-25 15:31:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102515-0065-0000-0000-00003B1A65B8
Message-Id: <20181025153109.GU4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:18:10AM -0400, Sasha Levin wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> [ Upstream commit c0135d07b013fa8f7ba9ec91b4369c372e6a28cb ]
> 
> If the scheduling-clock interrupt sets the current tasks need_qs flag,
> but if the current CPU passes through a quiescent state in the meantime,
> then rcu_preempt_qs() will fail to clear the need_qs flag, which can fool
> RCU into thinking that additional rcu_read_unlock_special() processing
> is needed.  This commit therefore clears the need_qs flag before checking
> for additional processing.

Given that this produced a splat that someone (you, in fact) actually
encountered, no objection to it going to -stable.

> For this problem to occur, we need rcu_preempt_data.passed_quiesce equal
> to true and current->rcu_read_unlock_special.b.need_qs also equal to true.
> This condition can occur as follows:
> 
> 1.	CPU 0 is aware of the current preemptible RCU grace period,
> 	but has not yet passed through a quiescent state.  Among other
> 	things, this means that rcu_preempt_data.passed_quiesce is false.
> 
> 2.	Task A running on CPU 0 enters a preemptible RCU read-side
> 	critical section.
> 
> 3.	CPU 0 takes a scheduling-clock interrupt, which notices the
> 	RCU read-side critical section and the need for a quiescent state,
> 	and thus sets current->rcu_read_unlock_special.b.need_qs to true.
> 
> 4.	Task A is preempted, enters the scheduler, eventually invoking
> 	rcu_preempt_note_context_switch() which in turn invokes
> 	rcu_preempt_qs().
> 
> 	Because rcu_preempt_data.passed_quiesce is false,
> 	control enters the body of the "if" statement, which sets
> 	rcu_preempt_data.passed_quiesce to true.
> 
> 5.	At this point, CPU 0 takes an interrupt.  The interrupt
> 	handler contains an RCU read-side critical section, and
> 	the rcu_read_unlock() notes that current->rcu_read_unlock_special
> 	is nonzero, and thus invokes rcu_read_unlock_special().
> 
> 6.	Once in rcu_read_unlock_special(), the fact that
> 	current->rcu_read_unlock_special.b.need_qs is true becomes
> 	apparent, so rcu_read_unlock_special() invokes rcu_preempt_qs().
> 	Recursively, given that we interrupted out of that same
> 	function in the preceding step.
> 
> 7.	Because rcu_preempt_data.passed_quiesce is now true,
> 	rcu_preempt_qs() does nothing, and simply returns.
> 
> 8.	Upon return to rcu_read_unlock_special(), it is noted that
> 	current->rcu_read_unlock_special is still nonzero (because
> 	the interrupted rcu_preempt_qs() had not yet gotten around
> 	to clearing current->rcu_read_unlock_special.b.need_qs).
> 
> 9.	Execution proceeds to the WARN_ON_ONCE(), which notes that
> 	we are in an interrupt handler and thus duly splats.
> 
> The solution, as noted above, is to make rcu_read_unlock_special()
> clear out current->rcu_read_unlock_special.b.need_qs after calling
> rcu_preempt_qs().  The interrupted rcu_preempt_qs() will clear it again,
> but this is harmless.  The worst that happens is that we clobber another
> attempt to set this field, but this is not a problem because we just
> got done reporting a quiescent state.
> 
> Reported-by: Sasha Levin <sasha.levin@oracle.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [ paulmck: Fix embarrassing build bug noted by Sasha Levin. ]
> Tested-by: Sasha Levin <sasha.levin@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/rcu/tree_plugin.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c1d7f27bd38f..c038831bfa57 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -328,6 +328,7 @@ void rcu_read_unlock_special(struct task_struct *t)
>  	special = t->rcu_read_unlock_special;
>  	if (special.b.need_qs) {
>  		rcu_preempt_qs();
> +		t->rcu_read_unlock_special.b.need_qs = false;
>  		if (!t->rcu_read_unlock_special.s) {
>  			local_irq_restore(flags);
>  			return;
> -- 
> 2.17.1
> 

