Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5673ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5621920BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5621920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeGQEb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:31:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbeGQEb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:31:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6H3wxb9061354
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:01:27 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k93uu1btq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:01:27 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 00:01:25 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 00:01:23 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6H41MBu5177802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 04:01:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C1D1B2072;
        Tue, 17 Jul 2018 00:01:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 267BFB2064;
        Tue, 17 Jul 2018 00:01:15 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.221.157])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 00:01:15 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ABF2516C86C9; Mon, 16 Jul 2018 21:03:46 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:03:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH rcu] rcutorture: err_segs_recorded can be static
Reply-To: paulmck@linux.vnet.ibm.com
References: <201807170920.MbzzhD0j%fengguang.wu@intel.com>
 <20180717014452.GA49087@lkp-g5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717014452.GA49087@lkp-g5>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071704-0060-0000-0000-0000028D41D6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009377; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01061929; UDB=6.00545215; IPR=6.00839833;
 MB=3.00022164; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 04:01:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071704-0061-0000-0000-000045D32A7A
Message-Id: <20180717040346.GE12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:44:52AM +0800, kbuild test robot wrote:
> 
> Fixes: 07809ecaa895 ("rcutorture: Dump reader protection sequence if failures or close calls")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Good catch!  I have folded this in with attribution.

							Thanx, Paul

> ---
>  rcutorture.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index ef85bde..a7a947e 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -209,9 +209,9 @@ struct rt_read_seg {
>  	unsigned long rt_delay_us;
>  	bool rt_preempted;
>  };
> -int err_segs_recorded;
> -struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
> -int rt_read_nsegs;
> +static int err_segs_recorded;
> +static struct rt_read_seg err_segs[RCUTORTURE_RDR_MAX_SEGS];
> +static int rt_read_nsegs;
> 
>  static const char *rcu_torture_writer_state_getname(void)
>  {
> 

