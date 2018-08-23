Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD3AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61892150F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61892150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHXAUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:20:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbeHXAUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:20:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NKdbfu027002
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:49:16 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m231vk31s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:49:16 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 16:49:15 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 23 Aug 2018 16:49:11 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NKnBHt26083360;
        Thu, 23 Aug 2018 20:49:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C288B2064;
        Thu, 23 Aug 2018 16:48:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C4FCB2066;
        Thu, 23 Aug 2018 16:48:15 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:48:15 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9947016C6B17; Thu, 23 Aug 2018 13:49:11 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:49:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Ray Clinton <mr.ray.clinton@gmail.com>
Cc:     nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <CAPMnawvzuAaXmuMg_Z4_Av59zHmxeWzdbfZv3GaX6Vmw48t+Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPMnawvzuAaXmuMg_Z4_Av59zHmxeWzdbfZv3GaX6Vmw48t+Aw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082320-0068-0000-0000-0000032E9222
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077842; UDB=6.00555749; IPR=6.00857815;
 MB=3.00022893; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 20:49:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082320-0069-0000-0000-0000457E6E00
Message-Id: <20180823204911.GY4225@linux.vnet.ibm.com>
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

On Thu, Aug 23, 2018 at 03:22:48PM -0400, Ray Clinton wrote:
> On Thu, Aug 23, 2018 at 7:44 PM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> 
> To be honest I'm a total newb to kernel dev, so much so that I copied and
> pasted the above quote in the hopes that I did the formatting right. I'm such
>  a newb that I realize I might not even understand your question.

;-) ;-) ;-)

> That beingsaid, wouldn't building a uImage of the kernel and loading it onto
> your device using tftpboot accomplish this?

I do something vaguely similar, but instead use qemu, passing it arguments
to grab the kernel from the filesystem.  Here is an example qemu command
generated by the rcutorture scripts:

qemu-system-x86_64 -enable-kvm -nographic -smp 1 -serial file:/home/paulmck/public_git/linux-rcu/tools/testing/selftests/rcutorture/res/2018.08.23-10:22:45/TREE09/console.log -m 512 -kernel /home/paulmck/public_git/linux-rcu/tools/testing/selftests/rcutorture/res/2018.08.23-10:22:45/TREE09/bzImage -append "noapic selinux=0 initcall_debug debug console=ttyS0 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=600 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1"

This runs single-threaded, captures console output on a file named
"console.log", provides 512MB of memory, grabs the kernel from the
specified "bzImage" file, and passes in a bunch of kernel parameters.

See tools/testing/selftests/rcutorture in recent Linux-kernel source
trees for more information, should you want more.  ;-)

							Thanx, Paul

> Ray On Thu, Aug 23, 2018 at 1:46 PM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > Hello!
> >
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> >
> > The reason I as is that such a mode would be mildly useful for rcutorture.
> >
> > You see, rcutorture runs entirely out of initrd, never mounting a real
> > root partition.  The user has been required to supply the initrd, but
> > more people are starting to use rcutorture.  This has led to confusion
> > and complaints about the need to supply the initrd.  So I am finally
> > getting my rcutorture initrd act together, with significant dracut help
> > from Connor Shu.  I added mkinitramfs support for environments such as
> > mine that don't support dracut, at least not without significant slashing
> > and burning.
> >
> > The mkinitramfs approach results in about 40MB of initrd, and dracut
> > about 10MB.  Most of this is completely useless for rcutorture, which
> > isn't interested in mounting filesystems, opening devices, and almost
> > all of the other interesting things that mkinitramfs and dracut enable.
> >
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
> >
> > This further prompted the idea of modifying kernel_init() to just loop
> > forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> > Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> > this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> > a wasted 800K might have offended my 30-years-ago self.  If I take this
> > next step, there have to be quite a few others benefiting significantly
> > from it.
> >
> > So, does anyone in the deep embedded space already do this?
> >
> >                                                         Thanx, Paul
> >
> > [*]     What zombies???  There is no userspace!!!
> >
> 

