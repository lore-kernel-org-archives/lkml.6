Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437EC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921092085A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAWDW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:22:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfAWDW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:22:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N3ImIR017969
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 22:22:57 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6f9msrjx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 22:22:57 -0500
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 23 Jan 2019 03:22:56 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 03:22:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0N3Mrf521954814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 03:22:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C1C6B2064;
        Wed, 23 Jan 2019 03:22:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CECCB2065;
        Wed, 23 Jan 2019 03:22:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.212.48])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jan 2019 03:22:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6C79F16C6133; Tue, 22 Jan 2019 19:22:51 -0800 (PST)
Date:   Tue, 22 Jan 2019 19:22:51 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Su Yue <suy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, "Li, Philip" <philip.li@intel.com>,
        lkp-developer@eclists.intel.com
Subject: Re: rcutorture: meaning of "End of test: RCU_HOTPLUG"
Reply-To: paulmck@linux.ibm.com
References: <996df745-8434-b92c-bad9-334cc6bf4b7f@cn.fujitsu.com>
 <20190122040144.GB4240@linux.ibm.com>
 <c2cf5125-2545-c325-0393-0dba4aab379d@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2cf5125-2545-c325-0393-0dba4aab379d@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012303-0064-0000-0000-0000039B77F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010459; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150420; UDB=6.00599518; IPR=6.00930755;
 MB=3.00025247; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-23 03:22:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012303-0065-0000-0000-00003C23B987
Message-Id: <20190123032251.GG4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:42:19PM +0800, Su Yue wrote:
> Thanks for your quick reply! Paul
> 
> On 1/22/19 12:01 PM, Paul E. McKenney wrote:
> >On Tue, Jan 22, 2019 at 11:40:53AM +0800, Su Yue wrote:
> >>Hi, guys
> >>   While running rcutorture tests with "onoff_interval", some tests
> >>failed and results show like:
> >>
> >>=====================================================================
> >>[  316.354501] srcud-torture:--- End of test: RCU_HOTPLUG:
> >>nreaders=1 nfakewriters=4 stat_interval=60 verbose=2
> >>test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fq\
> >>s_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0
> >>test_boost_interval=7 test_boost_duration=4 shutdown_secs=0
> >>stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_ba\
> >>rrier_cbs=0 onoff_interval=3 onoff_holdoff=0
> >>====================================================================
> >>
> >>I am wondering that meaning of "RCU_HOTPLUG". Is it expected because
> >>cpu hotplug is enabled in the test? Or just represents another type of
> >>failure?
> >
> >This says that at least one CPU hotplug operation failed, that is,
> >the CPU didn't actually come online or go offline as requested.  If you
> >are introducing CPU hotplug to an architecture, this usually indicates
> >that you have bugs in your CPU-hotplug code.  Or it nmight be that
> 
> It should hit the case since there is no RCU CPU stall warnings.
> 
> >RCU grace periods failed to progress -- though this would normally
> >also result in RCU CPU stall warnings.
> >
> >There should be lines containing "ver:" in your console output.  What
> >does one of the later one of these say?
> >
> 
> The line says:
> ======================================================================
> [  318.850175] busted_srcud-torture: rtc:           (null) ver:
> 27040 tfle: 0 rta: 27040 rtaf: 0 rtf: 27027 rtmbe: 0 rtbe: 0 rtbke:
> 0 rtbre: 0 rtbf: 0 rtb: 0 \
> nt: 9497 onoff: 2639/2639:2640/5310 40,373:10,355 162868:67542
> (HZ=1000) barrier: 0/0:0

Yes, you have many more offline attempts than successes, which is
why RCU_HOTPLUG was printed.

> =====================================================================
> 
> And here are useful errors:
> =====================================================================
> kern  :info  : [  135.379693] KVM setup async PF for cpu 1
> kern  :info  : [  135.381412] kvm-stealtime: cpu 1, msr 23fd16180
> kern  :alert : [  135.386897] busted_srcud-torture:torture_onoff

Just so your know, busted_srcud can sometimes fail by design.  Hence
the "busted" in the name.  But failure didn't happen this time.

> task: onlined 1
> kern  :alert : [  135.408241] busted_srcud-torture:torture_onoff
> task: offlining 1
> kern  :info  : [  135.423310] Unregister pv shared memory for cpu 1
> kern  :info  : [  135.427940] smpboot: CPU 1 is now offline
> kern  :alert : [  135.430106] busted_srcud-torture:torture_onoff
> task: offlined 1
> kern  :alert : [  135.436404] busted_srcud-torture:torture_onoff
> task: offlining 0
> kern  :alert : [  135.446173] busted_srcud-torture:torture_onoff
> task: offline 0 failed: errno -16
> kern  :alert : [  135.453076] busted_srcud-torture:torture_onoff
> task: offlining 0
> kern  :alert : [  135.457461] busted_srcud-torture:torture_onoff
> task: offline 0 failed: errno -16
> 
> 
> =====================================================================
> There are only two CPUs on the VM. Torture try to offline the last one
> but -EBUSY occured.
> 
> I spent time to understand kernel/torture.c.
> There is torture_onoff():
> 
> 225        while (!torture_must_stop()) {
> 226                cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
> 227                if (!torture_offline(cpu,
> 228                                     &n_offline_attempts,
> &n_offline_successes,
> 229                                     &sum_offline, &min_offline,
> &max_offline))
> 230                        torture_online(cpu,
> 231                                       &n_online_attempts,
> &n_online_successes,
> 232                                       &sum_online, &min_online,
> &max_online);
> 233                schedule_timeout_interruptible(onoff_interval);
> 234        }
> 235
> 
> torture_offline() and torture_offline() don't pre judge if the current
> cpu is only one usable.

That does appear to be the case, and that would be a problem with
the CONFIG_BOOTPARAM_HOTPLUG_CPU0 listed below.

Good catch!

> Our test machines are configured with CONFIG_BOOTPARAM_HOTPLUG_CPU0. If
> there are only one oneline and hotplugable cpux, then
> n_offline_successes != n_offline_attempts which caused "End of test:
> RCU_HOTPLUG".
> 
> Does I misunderstand something above? Feel free to correct me.

Does the following patch help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/torture.c b/kernel/torture.c
index a03ff722352b..2b6700ca2a43 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -101,6 +101,8 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 
 	if (!cpu_online(cpu) || !cpu_is_hotpluggable(cpu))
 		return false;
+	if (num_online_cpus() <= 1)
+		return false;  /* Can't offline the last CPU. */
 
 	if (verbose > 1)
 		pr_alert("%s" TORTURE_FLAG

