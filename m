Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4994420861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAVEBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:01:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbfAVEBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:01:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0M3wp6O043168
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:01:51 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5uprgbvh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:01:51 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 22 Jan 2019 04:01:50 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 22 Jan 2019 04:01:46 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0M41jXC24182970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 04:01:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E396B2064;
        Tue, 22 Jan 2019 04:01:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC8F2B206A;
        Tue, 22 Jan 2019 04:01:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.160.179])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jan 2019 04:01:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0243916C2FEC; Mon, 21 Jan 2019 20:01:44 -0800 (PST)
Date:   Mon, 21 Jan 2019 20:01:44 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Su Yue <suy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, "Li, Philip" <philip.li@intel.com>,
        lkp-developer@eclists.intel.com
Subject: Re: rcutorture: meaning of "End of test: RCU_HOTPLUG"
Reply-To: paulmck@linux.ibm.com
References: <996df745-8434-b92c-bad9-334cc6bf4b7f@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996df745-8434-b92c-bad9-334cc6bf4b7f@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012204-0068-0000-0000-000003865FE7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010451; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01149960; UDB=6.00599240; IPR=6.00930290;
 MB=3.00025231; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-22 04:01:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012204-0069-0000-0000-000047387961
Message-Id: <20190122040144.GB4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901220032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:40:53AM +0800, Su Yue wrote:
> Hi, guys
>   While running rcutorture tests with "onoff_interval", some tests
> failed and results show like:
> 
> =====================================================================
> [  316.354501] srcud-torture:--- End of test: RCU_HOTPLUG:
> nreaders=1 nfakewriters=4 stat_interval=60 verbose=2
> test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fq\
> s_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0
> test_boost_interval=7 test_boost_duration=4 shutdown_secs=0
> stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_ba\
> rrier_cbs=0 onoff_interval=3 onoff_holdoff=0
> ====================================================================
> 
> I am wondering that meaning of "RCU_HOTPLUG". Is it expected because
> cpu hotplug is enabled in the test? Or just represents another type of
> failure?

This says that at least one CPU hotplug operation failed, that is,
the CPU didn't actually come online or go offline as requested.  If you
are introducing CPU hotplug to an architecture, this usually indicates
that you have bugs in your CPU-hotplug code.  Or it nmight be that
RCU grace periods failed to progress -- though this would normally
also result in RCU CPU stall warnings.

There should be lines containing "ver:" in your console output.  What
does one of the later one of these say?

							Thanx, Paul

