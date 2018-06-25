Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED2425CFA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED2425CFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeFYPiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:38:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751686AbeFYPiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:38:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PFYUSw053456
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:38:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju2shs8ur-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:38:00 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 11:37:59 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 11:37:55 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PFbsCU9765258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 15:37:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88ADCB2065;
        Mon, 25 Jun 2018 11:37:49 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A29AB205F;
        Mon, 25 Jun 2018 11:37:49 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 11:37:49 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DF30016C6A76; Mon, 25 Jun 2018 08:39:58 -0700 (PDT)
Date:   Mon, 25 Jun 2018 08:39:58 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Make it stop complaining about docbook
 function-header comment
Reply-To: paulmck@linux.vnet.ibm.com
References: <1529908015-7256-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529908015-7256-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062515-0040-0000-0000-00000444E851
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009253; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052158; UDB=6.00539362; IPR=6.00830083;
 MB=3.00021850; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 15:37:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062515-0041-0000-0000-0000084AFDBD
Message-Id: <20180625153958.GO3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 03:26:55PM +0900, Byungchul Park wrote:
> Running "make htmldocs" complains about the docbook function-header
> comment. It wants the "irq" parameter described which wasn't done by
> a commit 5e5ea52645b197 (rcu: Refactor rcu_{nmi,irq}_{enter,exit}()).
> So add its description of the parameter to the comment.
> 
> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Very good, I will squash this into your previous patch, adding to the
commit log as suggested by Steven Rostedt.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4ed74f1..6c5a7f0 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -774,6 +774,7 @@ void rcu_user_enter(void)
> 
>  /**
>   * rcu_nmi_exit_common - inform RCU of exit from NMI context
> + * @irq: Is this call from rcu_irq_exit?
>   *
>   * If we are returning from the outermost NMI handler that interrupted an
>   * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
> @@ -933,6 +934,7 @@ void rcu_user_exit(void)
> 
>  /**
>   * rcu_nmi_enter_common - inform RCU of entry to NMI context
> + * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
>   * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
> -- 
> 1.9.1
> 

