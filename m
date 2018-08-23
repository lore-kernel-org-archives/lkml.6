Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10DAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903AB21557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903AB21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeHXAQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:16:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726740AbeHXAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:16:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NKdNC0042727
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:45:05 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m23q01bh9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:45:05 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 16:45:04 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 23 Aug 2018 16:45:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NKj11g26083472;
        Thu, 23 Aug 2018 20:45:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A97B2066;
        Thu, 23 Aug 2018 16:44:05 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98507B2065;
        Thu, 23 Aug 2018 16:44:05 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:44:05 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E182116C6B17; Thu, 23 Aug 2018 13:45:01 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:45:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     nicolas.pitre@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <20180823191235.GA3243@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823191235.GA3243@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082320-2213-0000-0000-000002E0FE21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077840; UDB=6.00555748; IPR=6.00857814;
 MB=3.00022893; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 20:45:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082320-2214-0000-0000-00005B4E9A8C
Message-Id: <20180823204501.GX4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 12:12:35PM -0700, Josh Triplett wrote:
> On Thu, Aug 23, 2018 at 10:43:59AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> 
> I would very much *like* to do this. One day I'd like to have a
> CONFIG_USERSPACE that I can disable, and then just have the kernel call
> an in-kernel main() where it would normally start init.

This looks to be an easy change, though it might not seem so easy
after starting to try it out.  ;-)

> > Those who know me will not be at all surprised to learn that I went
> > overboard making the resulting initrd as small as possible.  I started
> > by throwing out everything not absolutely needed by the dash and sleep
> > binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> > This situation of course prompted me to create an initrd containing
> > a statically linked binary named "init" and absolutely nothing else
> > (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> > This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> > for a C-language "for" loop containing nothing more than a single call to
> > sleep()?  Much of the code is there for things that I might do (dl_open(),
> > for example), but don't.  All I can say is that there clearly aren't many
> > of us left who made heavy use of systems with naked-eye-visible bits!
> > (Or naked-finger-feelable, for that matter.)
> 
> I have definitely built initramfs images containing nothing but a single
> statically linked /init before.

Cool!

> If you want to make it even smaller, you could avoid linking in libc at
> all, and just write a short assembly stub, but I don't know any way to
> do that *portably* without writing raw assembly for each target
> platform. That would get you down to a few kB though.

I do need portability.  And even 800K isn't -that- big a deal, much
though my earlier self would disbelieve this.

> > This further prompted the idea of modifying kernel_init() to just loop
> > forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> > Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> > this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> > a wasted 800K might have offended my 30-years-ago self.  If I take this
> > next step, there have to be quite a few others benefiting significantly
> > from it.
> 
> I would *love* to have support for omitting userspace entirely. And once
> we have that, we can start ripping out so many other things...

;-)

> One thought, though: that won't necessarily give you a representative
> rcutorture experience, given that you need to test things like the
> nohz-on-non-idle support, which interacts with "am I in userspace".

That is an excellent point.  I should keep the initrd specifically to
retain userspace execution, and should also occasionally run CPU-bound
in userspace.  Easy enough!  And thank you!

							Thanx, Paul

