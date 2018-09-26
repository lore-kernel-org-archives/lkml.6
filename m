Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D21C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD0321566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 04:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD0321566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeI0Kod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 06:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbeI0Koc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 06:44:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8R4OjOg029821
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:28:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrpsu2tmp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:28:18 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 27 Sep 2018 00:28:16 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Sep 2018 00:28:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8R4SDvT43319498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Sep 2018 04:28:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3066B2064;
        Thu, 27 Sep 2018 00:26:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B64B2067;
        Thu, 27 Sep 2018 00:26:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Sep 2018 00:26:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9BED316C3A6B; Wed, 26 Sep 2018 15:09:26 -0700 (PDT)
Date:   Wed, 26 Sep 2018 15:09:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Pierce Griffiths <pierceagriffiths@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] torture-test modules: Remove unnecessary "ret" variables
Reply-To: paulmck@linux.ibm.com
References: <20180922012132.23373-1-pierceagriffiths@gmail.com>
 <20180922212630.GF4222@linux.ibm.com>
 <20180925194706.GA27944@GANOO-Loonix.attlocal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925194706.GA27944@GANOO-Loonix.attlocal.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18092704-0040-0000-0000-000004770947
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009778; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01094226; UDB=6.00565617; IPR=6.00874261;
 MB=3.00023523; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-27 04:28:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092704-0041-0000-0000-0000087F0EBD
Message-Id: <20180926220926.GM4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809270046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:47:08PM -0500, Pierce Griffiths wrote:
> Paul,
> The #ifdef cannot be replaced, as this would break the build for
> CONFIG_HOTPLUG_CPU=n builds. There are assignments and references to two
> global variables, a struct, and a function that are declared/defined in
> a large "#ifdef CONFIG_HOTPLUG_CPU" block which ends directly above
> torture_onoff_init(). IS_ENABLED() would cause these references to be
> present at compile time, but not their declarations or definitions,
> which would certainly cause a compilation error.

Good point, and thank you!  I have queued the original patch with a
minor edit to the Subject line.  It will make it to my -rcu tree once
I find a decent internet connection.

							Thanx, Paul

> On Sat, Sep 22, 2018 at 02:26:30PM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 21, 2018 at 08:21:31PM -0500, Pierce Griffiths wrote:
> > > Remove return variables (declared as "ret") in cases where,
> > > depending on whether a condition evaluates as true, the result of a
> > > function call can be immediately returned instead of storing the result in
> > > the return variable. When the condition evaluates as false, the constant
> > > initially stored in the return variable at declaration is returned instead.
> > > 
> > > Signed-off-by: Pierce Griffiths <pierceagriffiths@gmail.com>
> > 
> > Not bad, as it does safe a couple of lines.  Is it possible to save
> > a few more by using "if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))" instead
> > of the #ifdef?  Or does that end up breaking the build for either
> > CONFIG_HOTPLUG_CPU=y or CONFIG_HOTPLUG_CPU=n builds?
> > 
> > 							Thanx, Paul
> > 
> > > ---
> > >  kernel/torture.c | 22 ++++++++--------------
> > >  1 file changed, 8 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/kernel/torture.c b/kernel/torture.c
> > > index 1ac24a826589..f4cec6db7f3c 100644
> > > --- a/kernel/torture.c
> > > +++ b/kernel/torture.c
> > > @@ -233,16 +233,15 @@ torture_onoff(void *arg)
> > >   */
> > >  int torture_onoff_init(long ooholdoff, long oointerval)
> > >  {
> > > -	int ret = 0;
> > > -
> > >  #ifdef CONFIG_HOTPLUG_CPU
> > >  	onoff_holdoff = ooholdoff;
> > >  	onoff_interval = oointerval;
> > >  	if (onoff_interval <= 0)
> > >  		return 0;
> > > -	ret = torture_create_kthread(torture_onoff, NULL, onoff_task);
> > > -#endif /* #ifdef CONFIG_HOTPLUG_CPU */
> > > -	return ret;
> > > +	return torture_create_kthread(torture_onoff, NULL, onoff_task);
> > > +#else /* #ifdef CONFIG_HOTPLUG_CPU */
> > > +	return 0;
> > > +#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
> > >  }
> > >  EXPORT_SYMBOL_GPL(torture_onoff_init);
> > > 
> > > @@ -513,15 +512,13 @@ static int torture_shutdown(void *arg)
> > >   */
> > >  int torture_shutdown_init(int ssecs, void (*cleanup)(void))
> > >  {
> > > -	int ret = 0;
> > > -
> > >  	torture_shutdown_hook = cleanup;
> > >  	if (ssecs > 0) {
> > >  		shutdown_time = ktime_add(ktime_get(), ktime_set(ssecs, 0));
> > > -		ret = torture_create_kthread(torture_shutdown, NULL,
> > > +		return torture_create_kthread(torture_shutdown, NULL,
> > >  					     shutdown_task);
> > >  	}
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(torture_shutdown_init);
> > > 
> > > @@ -619,13 +616,10 @@ static int torture_stutter(void *arg)
> > >  /*
> > >   * Initialize and kick off the torture_stutter kthread.
> > >   */
> > > -int torture_stutter_init(int s)
> > > +int torture_stutter_init(const int s)
> > >  {
> > > -	int ret;
> > > -
> > >  	stutter = s;
> > > -	ret = torture_create_kthread(torture_stutter, NULL, stutter_task);
> > > -	return ret;
> > > +	return torture_create_kthread(torture_stutter, NULL, stutter_task);
> > >  }
> > >  EXPORT_SYMBOL_GPL(torture_stutter_init);
> > > 
> > > -- 
> > > 2.19.0
> > > 
> > 
> 

