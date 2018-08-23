Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C49C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD9421568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD9421568
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeHXAJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726405AbeHXAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:09:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NKYbWH023374
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:37:51 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m22n4ktye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:37:51 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 16:37:50 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 16:37:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NKblj818612328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 20:37:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 867F4B2064;
        Thu, 23 Aug 2018 16:36:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 559C7B205F;
        Thu, 23 Aug 2018 16:36:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:36:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9E14916C374D; Thu, 23 Aug 2018 13:37:47 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:37:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     josh@joshtriplett.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <nycvar.YSQ.7.76.1808231414190.10215@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1808231414190.10215@knanqh.ubzr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082320-0040-0000-0000-000004644729
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077838; UDB=6.00555746; IPR=6.00857811;
 MB=3.00022893; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 20:37:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082320-0041-0000-0000-0000086B5B7D
Message-Id: <20180823203747.GU4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 02:42:45PM -0400, Nicolas Pitre wrote:
> On Thu, 23 Aug 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> 
> Not that I know of.  For one thing, you'd lose the ability to license 
> your application code the way you want.

Good point!  I could see where that might reduce the number of potential
users below the point of usefulness.

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
> 
> No surprise there.

;-)

> > Those who know me will not be at all surprised to learn that I went
> > overboard making the resulting initrd as small as possible.  I started
> > by throwing out everything not absolutely needed by the dash and sleep
> > binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> 
> That is possibly still very big. You could probably get away with a 
> statically linked busybox containing only the shell facilities you 
> require for 100K or so.

That does sound considerably more reasonable.

> > This situation of course prompted me to create an initrd containing
> > a statically linked binary named "init" and absolutely nothing else
> > (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> 
> This still looks big for a custom binary, unless you do have a lot of 
> code in there. It is already possible to have a kernel binary about that 
> size, and even if that's a configured down kernel, quite some complex 
> code remains.
> 
> The bloat might come from the C library you use. It's been a while since 
> glibc stopped caring about not pulling a lot of unneeded code when all 
> you want to do is printf(). It carries all those locale dependencies, 
> etc. You should look at alternative C libs to get things small.

Yes, I really was stupid enough to be using glibc.  Sounds like I have
an easy change to reduce the size further, then.  ;-)

> > This is a great improvement over 10MB, to say nothing of 40MB, but 800KB
> > for a C-language "for" loop containing nothing more than a single call to
> > sleep()?  Much of the code is there for things that I might do (dl_open(),
> > for example), but don't.  All I can say is that there clearly aren't many
> > of us left who made heavy use of systems with naked-eye-visible bits!
> > (Or naked-finger-feelable, for that matter.)
> 
> :-)
> 
> > This further prompted the idea of modifying kernel_init() to just loop
> > forever, perhaps not even reaping orphaned zombies [*], given an appropriate
> > Kconfig option and/or kernel boot parameter.  I obviously cannot justify
> > this to save a sub-one-megabyte initrd for rcutorture, no matter how much
> > a wasted 800K might have offended my 30-years-ago self.  If I take this
> > next step, there have to be quite a few others benefiting significantly
> > from it.
> 
> You could easily do it from your init binary with less trouble than 
> having the kernel carry such an option.

Got it, thank you!

> > So, does anyone in the deep embedded space already do this?
> 
> Not that I know of. Normally, if the init process dies, you typically 
> want the whole system to reboot (you may force a reboot upon any kernel 
> panic for example).

Indeed, your licensing point earlier explains quite a bit.

Thank you again!

							Thanx, Paul

