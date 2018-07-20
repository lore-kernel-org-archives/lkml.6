Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38572ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDBF20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kx2IYbop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDBF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeGTLYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:24:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43562 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeGTLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JoflZbBJ2u2lfL5gaFUOfX0hUcv5Ie3nHW/Hdd8nNR8=; b=kx2IYbopP8UzuISGFUeMS9yL3
        VkIBf3/V1o4NrrotjP2MK1FvEgBBcod0IwKjM/baCkkxR74a/D1pIo0nr65Pl69zp4KccyUASWSp0
        MBemvXxwVl/qE56ql7hVA0M7y8PdpDJZUbA1SxmsU96IldTA5Cdohgit7sfVOe6xIMwpE=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:44129)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fgSlz-0002dV-54; Fri, 20 Jul 2018 11:36:31 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fgSlw-0008ML-L7; Fri, 20 Jul 2018 11:36:28 +0100
Date:   Fri, 20 Jul 2018 11:36:27 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     "Ooi, Tzy Way" <tzy.way.ooi@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        "Nguyen, Dinh" <dinh.nguyen@intel.com>,
        "Aw, Khai Liang" <khai.liang.aw@intel.com>
Subject: Re: Enquiry on unbalanced memory throughput for dual-Cortex A9 core.
Message-ID: <20180720103627.GA29084@n2100.armlinux.org.uk>
References: <5F1105621EDF844291AF8B109E27C06D34C4BEBD@PGSMSX109.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F1105621EDF844291AF8B109E27C06D34C4BEBD@PGSMSX109.gar.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 08:49:47AM +0000, Ooi, Tzy Way wrote:
> Hi Russell,
> 
> I am trying the memory write operation with the LM benchmark test. I
> tried to execute the memory write operation here
> <http://lmbench.sourceforge.net/cgi-bin/man?section=8&keyword=bw_mem>
> twice to get both Cortex A9 core processor to work on each processes.
> Both processors is going to perform write operation at almost the same
> time to the memory.
> 
> As shown in the pictures below, the memory throughput from one of the
> cores is about double the throughput of another core. i.e. 377MB/s VS
> 728MB/s
> 
> [cid:image001.png@01D42049.5A7D0070]
> 
> I have tested this operation across few dual cores Cortex A9 boards and
> all the board is having the same result. The test is tested on kernel
> version 4.9 and newest Linux kernel version 4.18.0-rc2

Here's how 4.14 behaves on an iMX6D SoC (also dual core Cortex A9):

$ taskset -c 0 ./bw_mem -N 1000 1M fwr & taskset -c 1 ./bw_mem -N 1000 1M fwr
[1] 21799
1.00 521.10
1.00 497.27
[1]+  Done                    taskset -c 0 ./bw_mem -N 1000 1M fwr
$ taskset -c 0 ./bw_mem -N 1000 1M fwr & taskset -c 1 ./bw_mem -N 1000 1M fwr
[1] 21803
1.00 520.83
1.00 496.44

which shows some asymmetry but nowhere near yours.

I'm using taskset to force each to be locked to a particular CPU - you'll
see why further down.  Even without it, I get similar results to those I
mention above.

Now, playing around with this, so we can identify which bw_mem output is
which:

$ taskset -c 0 ./bw_mem -N 1000 1M fwr & c1=$(taskset -c 1 ./bw_mem -N 1000 1M fwr 2>&1); echo "c1: $c1"
[1] 21876
1.00 521.92
c1: 1.00 496.69
$ taskset -c 1 ./bw_mem -N 1000 1M fwr & c1=$(taskset -c 0 ./bw_mem -N 1000 1M fwr 2>&1); echo "c0: $c1"
[1] 21881
c0: 1.00 521.83
1.00 496.20

CPU0 is always the slightly faster of the two.  If we use /usr/bin/time
to time these:

CPU0:
6.10user 0.25system 0:06.56elapsed 96%CPU (0avgtext+0avgdata 1664maxresident)k
0inputs+0outputs (0major+407minor)pagefaults 0swaps

CPU1:
6.36user 0.24system 0:06.77elapsed 97%CPU (0avgtext+0avgdata 1600maxresident)k
0inputs+0outputs (0major+399minor)pagefaults 0swaps

So, CPU1 takes slightly longer in userspace, has less resident pages and
less minor faults which is rather odd.  Repeatedly running just one
instance gives different results each time... disabling virtual address
space randomisation solves that:

  echo 0 >/proc/sys/kernel/randomize_va_space

which then gives me:

CPU0: 1.00 520.20
6.18user 0.20system 0:06.59elapsed 96%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps
CPU1: 1.00 496.61
6.46user 0.14system 0:06.77elapsed 97%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps

CPU0: 1.00 521.10
6.13user 0.21system 0:06.57elapsed 96%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps
CPU1: 1.00 498.01
6.40user 0.18system 0:06.75elapsed 97%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps

which is rather more stable as far as resource usage goes between the
two CPUs, but still an asymmetry in the reported bandwidths and times.
So, this has ruled out differences in VA layout.

Now for the interesting bit... it's important to understand what and
how stuff is being measured.  Looking at the bw_mem.c and associated
source code, it measures the performance against the wall clock, which
includes everything that the system is doing on each particular CPU.
So, if a CPU is interrupted by another thread wanting to run, it'll
affect the results.  Hence, it's best to run on an otherwise quiet
system, eg, without an init daemon (eg, booted with init=/bin/sh on
the kernel command line - but note there won't be any job control,
so ^C won't work!)

However, continuing on...

If I run bw_mem on just one CPU:

CPU1: 1.00 2617.31
5.74user 0.18system 0:06.03elapsed 98%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps

Same number of iterations, same memory size, but notice that it appears
to be a lot faster reported by bw_mem, but the time taken is about the
same.  cpufreq comes to mind, but that's disabled on this system.

So, it brings up a rather obvious question: what exactly is bw_mem
measuring, and is it measuring it correctly?

$ /usr/bin/time taskset -c 1 ./bw_mem -P 1 -N 1000 1M fwr
1.00 2601.26
5.80user 0.16system 0:06.06elapsed 98%CPU (0avgtext+0avgdata 1700maxresident)k
0inputs+0outputs (0major+403minor)pagefaults 0swaps
$ /usr/bin/time ./bw_mem -P 2 -N 1000 1M fwr
^CCommand terminated by signal 2
5.54user 0.13system 1:12.20elapsed 7%CPU (0avgtext+0avgdata 1696maxresident)k
0inputs+0outputs (0major+365minor)pagefaults 0swaps

so requesting a parallelism of 2 results in the program never seemingly
ending in a reasonable period of time, which suggests a bug somewhere.
Are we sure that bw_mem is actually working as intended?

Maybe if Larry is reading this, he could share some thoughts.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
