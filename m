Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66947C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A3C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A3C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeG0EeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:34:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbeG0EeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:34:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6R33Zhj165547
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:14:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kfsrd385d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 23:14:30 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 26 Jul 2018 23:14:29 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Jul 2018 23:14:27 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6R3EQGh8323400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 03:14:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16001B2064;
        Thu, 26 Jul 2018 23:14:06 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9EDFB205F;
        Thu, 26 Jul 2018 23:14:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.139.164])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jul 2018 23:14:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0BF6A16CA220; Thu, 26 Jul 2018 20:14:26 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:14:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [rcutorture]  3b745c8969:
 WARNING:at_mm/slab_common.c:#kmalloc_slab
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180726085015.GA29979@shao2-debian>
 <20180726115325.GE24813@linux.vnet.ibm.com>
 <20180726233436.GA211260@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726233436.GA211260@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18072703-0040-0000-0000-000004548025
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009435; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066676; UDB=6.00548045; IPR=6.00844537;
 MB=3.00022343; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-27 03:14:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072703-0041-0000-0000-0000085AB727
Message-Id: <20180727031426.GU24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:34:36PM -0700, Joel Fernandes wrote:
> On Thu, Jul 26, 2018 at 04:53:25AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 26, 2018 at 04:50:15PM +0800, kernel test robot wrote:
> > > 
> > > FYI, we noticed the following commit (built with gcc-5):
> > > 
> > > commit: 3b745c8969c752601cb68c82a06735363563ab42 ("rcutorture: Make boost test more robust")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > in testcase: boot
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -smp 2 -m 512M
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > Is this fixed by 4babd855fd61 ("rcutorture: Add support to detect
> > if boost kthread prio is too low")?  That could address the
> > rcu_torture_stats_print() failures, depending on exactly what they were.
> > (Yes, I should have reversed these two commits, but they are in -tip
> > now, so that ship has sailed.)
> > 
> > Joel, any other thoughts?
> 
> I ran the next tree myself and was not able to reproduce the issue with the
> same configuration. Although I don't have rcupdate.rcu_cpu_stall_timeout=100
> passed in like they do (which I can also try if you think its of significance
> here).
> 
> It seems from their logs that most Locking API self tests are failing. the
> Lock API test suite is run before rcutorture where rcutorture hasn't even
> started.
> 
> Also as per their rcutorture output, it appears the 'rtf' value is also
> non-zero (rcu_torture_free test). Which makes sense if the earlier memory
> allocation warnings are somehow related.

It could potentially be an OOM issue.  Something to keep an eye out for,
then.

							Thanx, Paul

