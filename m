Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E37FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AF32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AF32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbeKNBJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:09:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62965 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbeKNBJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:09:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADFA8x5061632
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:10:42 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nr0bttaj3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 10:10:42 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 13 Nov 2018 15:10:41 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Nov 2018 15:10:38 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wADFAbmh18743516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 15:10:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7C9B2070;
        Tue, 13 Nov 2018 15:10:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B60AB2072;
        Tue, 13 Nov 2018 15:10:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.162.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Nov 2018 15:10:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2CC3916C5D5F; Tue, 13 Nov 2018 07:10:37 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:10:37 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [REGRESSION 4.20-rc1] 45975c7d21a1 ("rcu: Define RCU-sched API
 in terms of RCU for Tree RCU PREEMPT builds")
Reply-To: paulmck@linux.ibm.com
References: <20181113135453.GW9144@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113135453.GW9144@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18111315-0064-0000-0000-000003735440
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010042; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116880; UDB=6.00577118; IPR=6.00896988;
 MB=3.00024143; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-13 15:10:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111315-0065-0000-0000-00003B524B8D
Message-Id: <20181113151037.GG4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 03:54:53PM +0200, Ville Syrjälä wrote:
> Hi Paul,
> 
> After 4.20-rc1 some of my 32bit UP machines no longer reboot/shutdown.
> I bisected this down to commit 45975c7d21a1 ("rcu: Define RCU-sched
> API in terms of RCU for Tree RCU PREEMPT builds").
> 
> I traced the hang into
> -> cpufreq_suspend()
>  -> cpufreq_stop_governor()
>   -> cpufreq_dbs_governor_stop()
>    -> gov_clear_update_util()
>     -> synchronize_sched()
>      -> synchronize_rcu()
> 
> Only PREEMPT=y is affected for obvious reasons, but that couldn't
> explain why the same UP kernel booted on an SMP machine worked fine.
> Eventually I realized that the difference between working and
> non-working machine was IOAPIC vs. PIC. With initcall_debug I saw
> that we mask everything in the PIC before cpufreq is shut down,
> and came up with the following fix:
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7aa3dcad2175..f88bf3c77fc0 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2605,4 +2605,4 @@ static int __init cpufreq_core_init(void)
>         return 0;
>  }
>  module_param(off, int, 0444);
> -core_initcall(cpufreq_core_init);
> +late_initcall(cpufreq_core_init);

Thank you for testing this and tracking it down!

I am glad that you have a fix, but I hope that we can arrive at a less
constraining one.

> Here's the resulting change in inutcall_debug:
>   pci 0000:00:00.1: shutdown
>   hub 4-0:1.0: hub_ext_port_status failed (err = -110)
>   agpgart-intel 0000:00:00.0: shutdown
> + PM: Calling cpufreq_suspend+0x0/0x100
>   PM: Calling mce_syscore_shutdown+0x0/0x10
>   PM: Calling i8259A_shutdown+0x0/0x10
> - PM: Calling cpufreq_suspend+0x0/0x100
> + reboot: Restarting system
> + reboot: machine restart
> 
> I didn't really look into what other ramifications the cpufreq
> initcall change might have. cpufreq_global_kobject worries
> me a bit. Maybe that one has to remain in core_initcall() and
> we could just move the suspend to late_initcall()? Anyways,
> I figured I'd leave this for someone more familiar with the
> code to figure out ;) 

Let me guess...

When the system suspends or shuts down, there comes a point after which
there is only a single CPU that is running with preemption and interrupts
are disabled.  At this point, RCU must change the way that it works, and
the commit you bisected to would make the change more necessary.  But if
I am guessing correctly, we have just been getting lucky in the past.

It looks like RCU needs to create a struct syscore_ops with a shutdown
function and pass this to register_syscore_ops().  Maybe a suspend
function as well.  And RCU needs to invoke register_syscore_ops() at
a time that causes RCU's shutdown function to be invoked in the right
order with respect to the other work in flight.  The hope would be that
RCU's suspend function gets called just as the system transitions into
a mode where the scheduler is no longer active, give or take.

Does this make sense, or am I confused?

							Thanx, Paul

