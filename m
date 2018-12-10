Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC9FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA0120851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA0120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeLJSDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:03:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727190AbeLJSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:03:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBAHxM5E039330
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:03:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p9uhcd29m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:03:21 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 10 Dec 2018 18:03:20 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Dec 2018 18:03:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBAI3GXS19071070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 18:03:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1FB1B2066;
        Mon, 10 Dec 2018 18:03:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838F0B2064;
        Mon, 10 Dec 2018 18:03:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Dec 2018 18:03:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 667E416C2F64; Mon, 10 Dec 2018 10:03:19 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:03:19 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Liu Song <fishland@aliyun.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [PATCH] rcu: Print correct in print_one_rcu_pending
Reply-To: paulmck@linux.ibm.com
References: <20181210153557.3110-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210153557.3110-1-fishland@aliyun.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18121018-0052-0000-0000-00000364EA2F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010209; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129828; UDB=6.00587043; IPR=6.00909962;
 MB=3.00024644; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 18:03:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121018-0053-0000-0000-00005F0E794F
Message-Id: <20181210180319.GU4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:35:56PM +0800, Liu Song wrote:
> My kernel version is 4.4.166 and I found incorrect print info
> from print_one_rcu_pending. Adjust the description to make the
> information correct.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

This does not apply to mainline because debugfs tracing has been removed.

Please do feel free to send it to -stable, though I have no idea what the
-stable folks do about fixes to things that are no longer in mainline.
In that case, it is clear that the rule about waiting until it gets to
mainline isn't appropriate.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree_trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_trace.c b/kernel/rcu/tree_trace.c
> index ef7093cc9b5c..5d0eddc9dc63 100644
> --- a/kernel/rcu/tree_trace.c
> +++ b/kernel/rcu/tree_trace.c
> @@ -365,7 +365,7 @@ static void print_one_rcu_pending(struct seq_file *m, struct rcu_data *rdp)
>  		   rdp->n_rp_report_qs,
>  		   rdp->n_rp_cb_ready,
>  		   rdp->n_rp_cpu_needs_gp);
> -	seq_printf(m, "gpc=%ld gps=%ld nn=%ld ndw%ld\n",
> +	seq_printf(m, "gpc=%ld gps=%ld ndw=%ld nn=%ld\n",
>  		   rdp->n_rp_gp_completed,
>  		   rdp->n_rp_gp_started,
>  		   rdp->n_rp_nocb_defer_wakeup,
> -- 
> 2.19.1
> 

