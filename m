Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DCCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B859B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 20:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B859B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHXA0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 20:26:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727383AbeHXA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 20:26:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NKddJT027209
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:54:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m231vk92f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:54:53 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 Aug 2018 16:54:52 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 23 Aug 2018 16:54:48 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NKsmOj25952390;
        Thu, 23 Aug 2018 20:54:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 587A3B2065;
        Thu, 23 Aug 2018 16:53:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29138B2064;
        Thu, 23 Aug 2018 16:53:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:53:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 776C516C86E3; Thu, 23 Aug 2018 13:54:48 -0700 (PDT)
Date:   Thu, 23 Aug 2018 13:54:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     nicolas.pitre@linaro.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel-only deployments?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180823174359.GA13033@linux.vnet.ibm.com>
 <d47f1f4b828e6099c7db2ca4a4728536b3ad2723.camel@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47f1f4b828e6099c7db2ca4a4728536b3ad2723.camel@petrovitsch.priv.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18082320-0060-0000-0000-000002A35378
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009599; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077843; UDB=6.00555749; IPR=6.00857817;
 MB=3.00022894; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-23 20:54:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082320-0061-0000-0000-0000464525C0
Message-Id: <20180823205448.GZ4225@linux.vnet.ibm.com>
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

On Thu, Aug 23, 2018 at 09:52:17PM +0200, Bernd Petrovitsch wrote:
> Hi all!
> 
> On Thu, 2018-08-23 at 10:43 -0700, Paul E. McKenney wrote:
> > [...]
> > Does anyone do kernel-only deployments, for example, setting up an
> > embedded device having a Linux kernel and absolutely no userspace
> > whatsoever?
> [...]
> > You see, rcutorture runs entirely out of initrd, never mounting a real
> > root partition.  The user has been required to supply the initrd, but
> 
> IMHO running programs from the initrd is in user-space, but anyways:

Agreed, rcutorture still has a userspace, albeit a small one.  I was
wondering if I should take the next step and eliminate userspace entirely.
Josh Triplett pointed out that doing so would reduce my test coverage,
so the answer is that I should not eliminate userspace entirely for
rcutorture.

> Ages ago at some former employer, we built an embedded Linux device on
> an MPC-860 board (but that shouldn't make a significant difference to
> other architectures) based on the (at that time) brand new 2.4 kernel
> which ran completely out of the initrd (which obviously contained the
> whole root filesystem).

Cute!  The rcutorture test scripts do something similar, but you
clearly got there long before I did.

> [...]
> > by throwing out everything not absolutely needed by the dash and sleep
> > binaries, which got me down to about 2.5MB, 1.8MB of which was libc.
> 
> We had a working glibc binary (which as the largest binary on the
> filesystem) and just used it (and never got time and/or necessity to
> use something else like ulibc, newlibc or build glibc ourselves to
> leave all unneeded stuff out).
> 
> We basically built the filesystem - the distribution as such;-) - from
> scratch (only self-crafted `configure` calls around[0]) and - thus -
> used busybox and ash (IIRC) - so throw dash, core-utils etc. away and
> just use busybox (or something similar) for further space savings.
> 
> The whole startup and daemon management was done with busybox' "init"
> via a simple /etc/inittab (that were the good old times;-) and it was
> enough as one can start one-time programs at boot time (e.g. to load
> kernel modules (and remove the file in the filesystem from the
> filesystem[0]) or configure stuff via sysctl) and restart daemons. We
> didn't need run-levels ...

Indeed, concerns about possible additional boot-time kernel-userspace
interactions led me to use dracut or mkinitramfs if available, and
hand-craft the "init" binary only if neither was present.

> > This situation of course prompted me to create an initrd containing
> > a statically linked binary named "init" and absolutely nothing else
> > (not even /dev or /tmp directories), which weighs in at not quite 800KB.
> 
> That is probably the smallest solution - if it's enough. If it's all
> GPL, just link it statically against dietlibc ....

Sounds like there are a number of reduced-weight libc libraries
available.

> We had all of the usual directories and a somewhat filled /dev
> (completely static in the initrd IIRC, no udev or similar dynamic stuff
> was needed) as we had dropbear as ssh-server, a small webserver+CGI-
> script for a web interface and a SNMP agent (hacked net-smtp as we had
> our own configuration daemon and needed SNMP only as a transport
> protocol).

Cool!  Me, I currently leave networking out.  I compile it into the
kernel to catch build problems, but don't actually exercise the
networking code.

> [...]
> 
> MfG,
> 	Bernd
> 
> [0]: Every byte counts and size does matter;-)

;-) ;-) ;-)

							Thanx, Paul

> -- 
> Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
>                      LUGA : http://www.luga.at
> 

