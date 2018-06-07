Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yt3kE0LfGFsmfQAAmS7hNA
	; Thu, 07 Jun 2018 07:31:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4194A6089E; Thu,  7 Jun 2018 07:31:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C5528605A2;
	Thu,  7 Jun 2018 07:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5528605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFGHbK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:31:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752336AbeFGHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:31:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w577TJeR026896
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 03:31:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jeyeht8bp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 03:31:08 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 03:31:06 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Jun 2018 03:31:03 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w577V26764225470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jun 2018 07:31:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74BE4B2066;
        Thu,  7 Jun 2018 04:32:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F73BB2064;
        Thu,  7 Jun 2018 04:32:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.197.56])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  7 Jun 2018 04:32:33 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 84A0516C6719; Thu,  7 Jun 2018 00:32:52 -0700 (PDT)
Date: Thu, 7 Jun 2018 00:32:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525101958.13277-1-bigeasy@linutronix.de>
 <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com>
 <20180529120443.GE3803@linux.vnet.ibm.com>
 <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
 <20180529172611.GL3803@linux.vnet.ibm.com>
 <CAJZ5v0gYcFywNZh+-EHSmwU89AER=a8ouKtK93j=Lu4DSHUzNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gYcFywNZh+-EHSmwU89AER=a8ouKtK93j=Lu4DSHUzNw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060707-2213-0000-0000-000002B4A6D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-07 07:31:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060707-2214-0000-0000-00005A642B96
Message-Id: <20180607073252.GD3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806070091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 01:09:57PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 29, 2018 at 7:26 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, May 29, 2018 at 07:14:49PM +0200, Rafael J. Wysocki wrote:
> >> On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
> >> >> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
> >> >> <bigeasy@linutronix.de> wrote:
> >> >> > There are macros for static initializer for the three out of four
> >> >> > possible notifier types, that are:
> >> >> >         ATOMIC_NOTIFIER_HEAD()
> >> >> >         BLOCKING_NOTIFIER_HEAD()
> >> >> >         RAW_NOTIFIER_HEAD()
> >> >> >
> >> >> > This patch provides a static initilizer for the forth type to make it
> >> >> > complete.
> >> >> >
> >> >> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> >> >> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> >>
> >> >> I cannot apply this without an ACK from Paul.
> >> >
> >> > I have both queued, but if you would prefer to take them, then for the
> >> > SRCU piece:
> >> >
> >> > Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >> > Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >>
> >> Thanks!
> >>
> >> I'll route them along with the other cpufreq material then.
> >
> > Please let me know when you have them queued so that I can remove
> > them from -rcu.
> 
> I've just added them to my linux-next branch.

And I have removed them, thank you!

							Thanx, Paul
