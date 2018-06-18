Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE13C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3115A208B1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3115A208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbeFRQy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:54:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934623AbeFRQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:54:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IGnNJr057587
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:54:53 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jpg6xs4t6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:54:53 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 12:54:52 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 12:54:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IGslQE10093260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Jun 2018 16:54:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17A83B205F;
        Mon, 18 Jun 2018 12:54:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED4E8B2064;
        Mon, 18 Jun 2018 12:54:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jun 2018 12:54:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DEC2516C6AFC; Mon, 18 Jun 2018 09:56:46 -0700 (PDT)
Date:   Mon, 18 Jun 2018 09:56:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        mingo@redhat.com, Steven Rostedt <rostedt@goodmis.org>,
        tglx@linutronix.de, lkp@01.org
Subject: Re: [lkp-robot] [rcutorture]  46e26223e3:
 WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_stats_print
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180610234544.150933-2-joel@joelfernandes.org>
 <20180613065711.GZ16472@yexl-desktop>
 <20180613072948.GA142000@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613072948.GA142000@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18061816-2213-0000-0000-000002BBB3D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009215; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01048839; UDB=6.00537370; IPR=6.00827813;
 MB=3.00021721; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-18 16:54:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061816-2214-0000-0000-00005A8664E0
Message-Id: <20180618165646.GA3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 12:29:48AM -0700, Joel Fernandes wrote:
> (I'm actually not working this week, but still thought of replying :))
> 
> On Wed, Jun 13, 2018 at 02:57:11PM +0800, kernel test robot wrote:
> > 
> > FYI, we noticed the following commit (built with gcc-4.9):
> > 
> > commit: 46e26223e39c64763e321f229e324be15179c505 ("rcutorture: Make boost test more robust")
> > url: https://github.com/0day-ci/linux/commits/Joel-Fernandes/rcutorture-Disable-RT-throttling-for-boost-tests/20180611-074731
> > base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> > 
> > in testcase: trinity
> > with following parameters:
> > 
> > 	runtime: 300s
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> 
> I'll try to reproduce this, but it could be because after this patch, the
> boost test is actually working.

Quite possibly.  ;-)

> The reason for the rcutorture test failure could be that the default
> kthread_prio for the system's RCU threads is set to 1 (unless overridden by
> rcutree.kthread_prio) which is also equal to the priority of the rcutorture's
> boost threads. Due to this the rcutorture test could starve the RCU threads
> as well and defeat the boosting mechanism. I was able to solve a similar
> issue by just passing rcutree.kthread_prio of 50 on the kernel command line.
> 
> Paul, would it be ok if we changed the default kthread_prio to something > 1
> so that rcutorture can test properly without needing to pass any extra
> rcutree.* parameters?
> 
> so something like this in kernel/rcu/tree.c ?
> 
> static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 2 : 0;

Would it be possible to also condition this on rcutorture being built
in?  Or are they doing modprobes for rcutorture?

							Thanx, Paul

