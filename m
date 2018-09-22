Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6CCC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCE821522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 21:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCE821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIWDVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 23:21:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727299AbeIWDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 23:21:37 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8MLNrts096854
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 17:26:35 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mnkva7es4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 17:26:35 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 22 Sep 2018 17:26:35 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Sep 2018 17:26:31 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8MLQUMS37945450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 22 Sep 2018 21:26:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51436B206B;
        Sat, 22 Sep 2018 17:24:55 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32021B2065;
        Sat, 22 Sep 2018 17:24:55 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 22 Sep 2018 17:24:55 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A6C116C1D80; Sat, 22 Sep 2018 14:26:30 -0700 (PDT)
Date:   Sat, 22 Sep 2018 14:26:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Pierce Griffiths <pierceagriffiths@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] torture-test modules: Remove unnecessary "ret" variables
Reply-To: paulmck@linux.ibm.com
References: <20180922012132.23373-1-pierceagriffiths@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180922012132.23373-1-pierceagriffiths@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092221-0068-0000-0000-000003408E31
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009754; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01092182; UDB=6.00564383; IPR=6.00872206;
 MB=3.00023458; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-22 21:26:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092221-0069-0000-0000-000045D33344
Message-Id: <20180922212630.GF4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809220226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 08:21:31PM -0500, Pierce Griffiths wrote:
> Remove return variables (declared as "ret") in cases where,
> depending on whether a condition evaluates as true, the result of a
> function call can be immediately returned instead of storing the result in
> the return variable. When the condition evaluates as false, the constant
> initially stored in the return variable at declaration is returned instead.
> 
> Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>

Not bad, as it does safe a couple of lines.  Is it possible to save
a few more by using "if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))" instead
of the #ifdef?  Or does that end up breaking the build for either
CONFIG_HOTPLUG_CPU=y or CONFIG_HOTPLUG_CPU=n builds?

							Thanx, Paul

> ---
>  kernel/torture.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 1ac24a826589..f4cec6db7f3c 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -233,16 +233,15 @@ torture_onoff(void *arg)
>   */
>  int torture_onoff_init(long ooholdoff, long oointerval)
>  {
> -	int ret = 0;
> -
>  #ifdef CONFIG_HOTPLUG_CPU
>  	onoff_holdoff = ooholdoff;
>  	onoff_interval = oointerval;
>  	if (onoff_interval <= 0)
>  		return 0;
> -	ret = torture_create_kthread(torture_onoff, NULL, onoff_task);
> -#endif /* #ifdef CONFIG_HOTPLUG_CPU */
> -	return ret;
> +	return torture_create_kthread(torture_onoff, NULL, onoff_task);
> +#else /* #ifdef CONFIG_HOTPLUG_CPU */
> +	return 0;
> +#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
>  }
>  EXPORT_SYMBOL_GPL(torture_onoff_init);
> 
> @@ -513,15 +512,13 @@ static int torture_shutdown(void *arg)
>   */
>  int torture_shutdown_init(int ssecs, void (*cleanup)(void))
>  {
> -	int ret = 0;
> -
>  	torture_shutdown_hook = cleanup;
>  	if (ssecs > 0) {
>  		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
> -		ret = torture_create_kthread(torture_shutdown, NULL,
> +		return torture_create_kthread(torture_shutdown, NULL,
>  					     shutdown_task);
>  	}
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(torture_shutdown_init);
> 
> @@ -619,13 +616,10 @@ static int torture_stutter(void *arg)
>  /*
>   * Initialize and kick off the torture_stutter kthread.
>   */
> -int torture_stutter_init(int s)
> +int torture_stutter_init(const int s)
>  {
> -	int ret;
> -
>  	stutter = s;
> -	ret = torture_create_kthread(torture_stutter, NULL, stutter_task);
> -	return ret;
> +	return torture_create_kthread(torture_stutter, NULL, stutter_task);
>  }
>  EXPORT_SYMBOL_GPL(torture_stutter_init);
> 
> -- 
> 2.19.0
> 

