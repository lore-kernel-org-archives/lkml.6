Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbeA3Jmx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:42:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751391AbeA3Jmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:42:49 -0500
Date: Mon, 29 Jan 2018 21:37:08 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ildar Ismagilov <devix84@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: fix misprint in srcu_funnel_exp_start
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180129182309.3869-1-devix84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129182309.3869-1-devix84@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18013009-0008-0000-0000-000002C91236
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008452; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00982457; UDB=6.00498173; IPR=6.00761739;
 BA=6.00005802; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019285; XFM=3.00000015;
 UTC=2018-01-30 09:42:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013009-0009-0000-0000-00003816C3EF
Message-Id: <20180130053708.GA3741@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 09:23:09PM +0300, Ildar Ismagilov wrote:
> Signed-off-by: Ildar Ismagilov <devix84@gmail.com>

The original does look backwards, now that you mention it, thank you
for sending it.

Did you see any performance differences from this patch?

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 6d5880089ff6..1798d1aa60fa 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -599,7 +599,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *sp, struct srcu_node *snp,
>  		raw_spin_unlock_irqrestore_rcu_node(snp, flags);
>  	}
>  	raw_spin_lock_irqsave_rcu_node(sp, flags);
> -	if (!ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
> +	if (ULONG_CMP_LT(sp->srcu_gp_seq_needed_exp, s))
>  		sp->srcu_gp_seq_needed_exp = s;
>  	raw_spin_unlock_irqrestore_rcu_node(sp, flags);
>  }
> -- 
> 2.11.0
> 
