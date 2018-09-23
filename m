Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0312ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54296214C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54296214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeIWGcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:32:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbeIWGcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:32:18 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8N0ZYGl040513
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:36:48 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mnn69sbuk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:36:48 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 22 Sep 2018 20:36:47 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Sep 2018 20:36:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8N0aitW22216856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 00:36:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5FC1B2065;
        Sat, 22 Sep 2018 20:35:08 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4F5CB205F;
        Sat, 22 Sep 2018 20:35:08 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 22 Sep 2018 20:35:08 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD50D16C197D; Sat, 22 Sep 2018 17:36:43 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:36:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 2/3] rcu: tree: Fix comment about gp_seq_needed
Reply-To: paulmck@linux.ibm.com
References: <20180922234127.94970-1-joel@joelfernandes.org>
 <20180922234127.94970-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922234127.94970-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092300-0064-0000-0000-00000352985C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009754; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092245; UDB=6.00564421; IPR=6.00872270;
 MB=3.00023459; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-23 00:36:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092300-0065-0000-0000-00003ABC7BDF
Message-Id: <20180923003643.GJ4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809230005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 07:41:26PM -0400, Joel Fernandes (Google) wrote:
> rcu_state does not have a gp_seq_needed field. This comment therefore is
> confusing or incorrect. Fix it.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good eyes, queued and pushed with edits, thank you!

(Yes, I do have a great deal of experience with punched cards.  Why do
you ask?)

							Thanx, Paul

> ---
>  kernel/rcu/tree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 57a937ac51c2..fd2ba3f9eee9 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -57,7 +57,7 @@ struct rcu_node {
>  					/*  some rcu_state fields as well as */
>  					/*  following. */
>  	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
> -	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
> +	unsigned long gp_seq_needed; /* Track the furthest future gp request seen */
>  	unsigned long completedqs; /* All QSes done for this node. */
>  	unsigned long qsmask;	/* CPUs or groups that need to switch in */
>  				/*  order for current grace period to proceed.*/
> @@ -163,7 +163,7 @@ union rcu_noqs {
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
>  	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
> -	unsigned long	gp_seq_needed;	/* Track rsp->rcu_gp_seq_needed ctr. */
> +	unsigned long	gp_seq_needed;	/* Track the furthest future gp request seen */
>  	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
>  	bool		core_needs_qs;	/* Core waits for quiesc state. */
>  	bool		beenonline;	/* CPU online at least once. */
> -- 
> 2.19.0.444.g18242da7ef-goog
> 

