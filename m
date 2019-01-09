Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499EFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23288206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfAINxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:53:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731135AbfAINwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:52:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09Dnm7W081040
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 08:52:53 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwfr0qemv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:52:53 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 13:52:51 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 13:52:48 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09Dqmmi15859760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 13:52:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 038ADB2067;
        Wed,  9 Jan 2019 13:52:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7269B205F;
        Wed,  9 Jan 2019 13:52:47 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.82])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 13:52:47 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 06C5816C63D1; Wed,  9 Jan 2019 05:52:48 -0800 (PST)
Date:   Wed, 9 Jan 2019 05:52:48 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  rcu: Remove rcu_*_state declaration
Reply-To: paulmck@linux.ibm.com
References: <1547043208-11941-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547043208-11941-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19010913-0052-0000-0000-000003758350
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010373; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01143993; UDB=6.00595617; IPR=6.00924255;
 MB=3.00025049; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 13:52:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010913-0053-0000-0000-00005F66803F
Message-Id: <20190109135247.GX1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:13:28PM +0800, Peng Hao wrote:
> Because of just only one set of rcu_state, the declaration of
> rcu_sched_state/rcu_bh_state/rcu_preempt_state is unnecessary.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

This does not apply to my current -rcu tree.  Please see branch "dev"
of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git.

							Thanx, Paul

> ---
>  kernel/rcu/tree.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 703e19f..9ea704c 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -401,13 +401,6 @@ struct rcu_state {
>  /*
>   * RCU implementation internal declarations:
>   */
> -extern struct rcu_state rcu_sched_state;
> -
> -extern struct rcu_state rcu_bh_state;
> -
> -#ifdef CONFIG_PREEMPT_RCU
> -extern struct rcu_state rcu_preempt_state;
> -#endif /* #ifdef CONFIG_PREEMPT_RCU */
> 
>  int rcu_dynticks_snap(struct rcu_data *rdp);
> 
> -- 
> 1.8.3.1
> 

