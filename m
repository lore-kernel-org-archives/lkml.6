Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D1C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DBF20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 04:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DBF20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJILUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 07:20:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbeJILUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 07:20:41 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9943pON141741
        for <linux-kernel@vger.kernel.org>; Tue, 9 Oct 2018 00:05:46 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n0m0d1uqt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:05:46 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 9 Oct 2018 00:05:46 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Oct 2018 00:05:43 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9945gLG26869902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Oct 2018 04:05:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE17B2065;
        Tue,  9 Oct 2018 00:03:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FDEBB205F;
        Tue,  9 Oct 2018 00:03:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.183.61])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  9 Oct 2018 00:03:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6E7C016C2663; Mon,  8 Oct 2018 21:05:41 -0700 (PDT)
Date:   Mon, 8 Oct 2018 21:05:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     zhouzhouyi@gmail.com
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU: Adjust the comment of function rcu_is_watching
Reply-To: paulmck@linux.ibm.com
References: <5bbafe54.1c69fb81.954a9.deae@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbafe54.1c69fb81.954a9.deae@mx.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100904-0064-0000-0000-0000035C73E5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009845; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01099963; UDB=6.00569068; IPR=6.00880011;
 MB=3.00023672; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 04:05:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100904-0065-0000-0000-00003AEAC52C
Message-Id: <20181009040541.GI2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=988 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:50:41AM +0000, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> Because RCU avoids interrupting idle CPUs, rcu_is_watching is used to
> test whether or not it is currently legal to run RCU read-side 
> critical sections on this CPU. 
> 
> First sentence and last sentence of current comment for rcu_is_watching
> have opposite meaning of what is expected.  
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good eyes!  Applied and pushed, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0b760c1..adb04ea 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1010,12 +1010,12 @@ void rcu_irq_enter_irqson(void)
>  }
> 
>  /**
> - * rcu_is_watching - see if RCU thinks that the current CPU is idle
> + * rcu_is_watching - see if RCU thinks that the current CPU is not idle
>   *
>   * Return true if RCU is watching the running CPU, which means that this
>   * CPU can safely enter RCU read-side critical sections.  In other words,
> - * if the current CPU is in its idle loop and is neither in an interrupt
> - * or NMI handler, return true.
> + * if the current CPU is not in its idle loop or is in an interrupt or
> + * NMI handler, return true.
>   */
>  bool notrace rcu_is_watching(void)
>  {
> -- 
> 2.1.4
> 

