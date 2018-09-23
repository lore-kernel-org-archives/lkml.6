Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA0C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04971214C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04971214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeIWGdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:33:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbeIWGdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:33:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8N0YuRD069245
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:37:31 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mnsajtgep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 20:37:30 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 22 Sep 2018 20:37:30 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Sep 2018 20:37:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8N0bQcx44499028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Sep 2018 00:37:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD3BBB2065;
        Sat, 22 Sep 2018 20:35:50 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8085B205F;
        Sat, 22 Sep 2018 20:35:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 22 Sep 2018 20:35:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E0A4416C197D; Sat, 22 Sep 2018 17:37:25 -0700 (PDT)
Date:   Sat, 22 Sep 2018 17:37:25 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 3/3] Documentation: RCU: Fix rcu_preempt_state
 reference in stallwarn
Reply-To: paulmck@linux.ibm.com
References: <20180922234127.94970-1-joel@joelfernandes.org>
 <20180922234127.94970-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922234127.94970-3-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092300-0068-0000-0000-000003409F8A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009754; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092246; UDB=6.00564421; IPR=6.00872270;
 MB=3.00023459; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-23 00:37:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092300-0069-0000-0000-000045D38C1A
Message-Id: <20180923003725.GK4222@linux.ibm.com>
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

On Sat, Sep 22, 2018 at 07:41:27PM -0400, Joel Fernandes (Google) wrote:
> rcu_preempt_state doesn't exist anymore. Update stallwarn documentation
> accordingly.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good eyes, queued and pushed with edits, including fixing a grammar
nit in my original.  ;-)

							Thanx, Paul

> ---
>  Documentation/RCU/stallwarn.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
> index 491043fd976f..b6bc7a2a9961 100644
> --- a/Documentation/RCU/stallwarn.txt
> +++ b/Documentation/RCU/stallwarn.txt
> @@ -176,9 +176,8 @@ causing stalls, and that the stall was affecting RCU-sched.  This message
>  will normally be followed by stack dumps for each CPU.  Please note that
>  PREEMPT_RCU builds can be stalled by tasks as well as by CPUs, and that
>  the tasks will be indicated by PID, for example, "P3421".  It is even
> -possible for a rcu_preempt_state stall to be caused by both CPUs -and-
> -tasks, in which case the offending CPUs and tasks will all be called
> -out in the list.
> +possible for a rcu_state stall to be caused by both CPUs -and- tasks,
> +in which case the offending CPUs and tasks will all be called out in the list.
>  
>  CPU 2's "(3 GPs behind)" indicates that this CPU has not interacted with
>  the RCU core for the past three grace periods.  In contrast, CPU 16's "(0
> -- 
> 2.19.0.444.g18242da7ef-goog
> 

