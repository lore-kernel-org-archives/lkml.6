Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B120873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 06:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8B120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeG0IMP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 04:12:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:33069 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeG0IMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 04:12:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 23:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,408,1526367600"; 
   d="scan'208";a="67934257"
Received: from pgsmsx112-dag.png.intel.com (HELO PGSMSX112.gar.corp.intel.com) ([10.108.55.234])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2018 23:51:47 -0700
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.206]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.172]) with mapi id 14.03.0319.002;
 Fri, 27 Jul 2018 14:51:46 +0800
From:   "Ooi, Tzy Way" <tzy.way.ooi@intel.com>
To:     'Russell King - ARM Linux' <linux@armlinux.org.uk>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>,
        "Nguyen, Dinh" <dinh.nguyen@intel.com>,
        "Aw, Khai Liang" <khai.liang.aw@intel.com>
Subject: RE: Enquiry on unbalanced memory throughput for dual-Cortex A9 core.
Thread-Topic: Enquiry on unbalanced memory throughput for dual-Cortex A9
 core.
Thread-Index: AdQgBgDwE8ZxdM9cQg6mUrKZHryEF///mOiA//m+0TD/7noZ4A==
Date:   Fri, 27 Jul 2018 06:51:45 +0000
Message-ID: <5F1105621EDF844291AF8B109E27C06D34C4DBA5@PGSMSX109.gar.corp.intel.com>
References: <5F1105621EDF844291AF8B109E27C06D34C4BEBD@PGSMSX109.gar.corp.intel.com>
 <20180720103627.GA29084@n2100.armlinux.org.uk>
 <5F1105621EDF844291AF8B109E27C06D34C4C35C@PGSMSX109.gar.corp.intel.com>
In-Reply-To: <5F1105621EDF844291AF8B109E27C06D34C4C35C@PGSMSX109.gar.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Ooi, Tzy Way
> Sent: Tuesday, July 24, 2018 10:23 AM
> To: Russell King - ARM Linux <linux@armlinux.org.uk>
> Cc: linux-kernel@vger.kernel.org; See, Chin Liang
> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>;
> Nguyen, Dinh <dinh.nguyen@intel.com>; Aw, Khai Liang
> <khai.liang.aw@intel.com>
> Subject: RE: Enquiry on unbalanced memory throughput for dual-Cortex A9
> core.
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux <linux@armlinux.org.uk>
> > Sent: Friday, July 20, 2018 6:36 PM
> > To: Ooi, Tzy Way <tzy.way.ooi@intel.com>
> > Cc: linux-kernel@vger.kernel.org; See, Chin Liang
> > <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>;
> > Nguyen, Dinh <dinh.nguyen@intel.com>; Aw, Khai Liang
> > <khai.liang.aw@intel.com>
> > Subject: Re: Enquiry on unbalanced memory throughput for dual-Cortex
> > A9 core.
> >
> > On Fri, Jul 20, 2018 at 08:49:47AM +0000, Ooi, Tzy Way wrote:
> > > Hi Russell,
> > >
> > > I am trying the memory write operation with the LM benchmark test. I
> > > tried to execute the memory write operation here
> > > <http://lmbench.sourceforge.net/cgi-
> > bin/man?section=8&keyword=bw_mem>
> > > twice to get both Cortex A9 core processor to work on each processes.
> > > Both processors is going to perform write operation at almost the
> > > same time to the memory.
> > >
> > > As shown in the pictures below, the memory throughput from one of
> > > the cores is about double the throughput of another core. i.e.
> > > 377MB/s VS 728MB/s
> > >
> > > [cid:image001.png@01D42049.5A7D0070]
> > >
> > > I have tested this operation across few dual cores Cortex A9 boards
> > > and all the board is having the same result. The test is tested on
> > > kernel version 4.9 and newest Linux kernel version 4.18.0-rc2
> >
> > Here's how 4.14 behaves on an iMX6D SoC (also dual core Cortex A9):
> >
> > $ taskset -c 0 ./bw_mem -N 1000 1M fwr & taskset -c 1 ./bw_mem -N 1000
> > 1M fwr [1] 21799
> > 1.00 521.10
> > 1.00 497.27
> > [1]+  Done                    taskset -c 0 ./bw_mem -N 1000 1M fwr
> > $ taskset -c 0 ./bw_mem -N 1000 1M fwr & taskset -c 1 ./bw_mem -N 1000
> > 1M fwr [1] 21803
> > 1.00 520.83
> > 1.00 496.44
> >
> > which shows some asymmetry but nowhere near yours.
> >
> > I'm using taskset to force each to be locked to a particular CPU -
> > you'll see why further down.  Even without it, I get similar results
> > to those I mention above.
> >
> > Now, playing around with this, so we can identify which bw_mem output
> > is
> > which:
> >
> > $ taskset -c 0 ./bw_mem -N 1000 1M fwr & c1=$(taskset -c 1 ./bw_mem -N
> > 1000 1M fwr 2>&1); echo "c1: $c1"
> > [1] 21876
> > 1.00 521.92
> > c1: 1.00 496.69
> > $ taskset -c 1 ./bw_mem -N 1000 1M fwr & c1=$(taskset -c 0 ./bw_mem -N
> > 1000 1M fwr 2>&1); echo "c0: $c1"
> > [1] 21881
> > c0: 1.00 521.83
> > 1.00 496.20
> >
> > CPU0 is always the slightly faster of the two.  If we use
> > /usr/bin/time to time
> > these:
> >
> > CPU0:
> > 6.10user 0.25system 0:06.56elapsed 96%CPU (0avgtext+0avgdata
> > 1664maxresident)k
> > 0inputs+0outputs (0major+407minor)pagefaults 0swaps
> >
> > CPU1:
> > 6.36user 0.24system 0:06.77elapsed 97%CPU (0avgtext+0avgdata
> > 1600maxresident)k
> > 0inputs+0outputs (0major+399minor)pagefaults 0swaps
> >
> > So, CPU1 takes slightly longer in userspace, has less resident pages
> > and less minor faults which is rather odd.  Repeatedly running just
> > one instance gives different results each time... disabling virtual
> > address space randomisation solves that:
> >
> >   echo 0 >/proc/sys/kernel/randomize_va_space
> >
> > which then gives me:
> >
> > CPU0: 1.00 520.20
> > 6.18user 0.20system 0:06.59elapsed 96%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> > CPU1: 1.00 496.61
> > 6.46user 0.14system 0:06.77elapsed 97%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> >
> > CPU0: 1.00 521.10
> > 6.13user 0.21system 0:06.57elapsed 96%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> > CPU1: 1.00 498.01
> > 6.40user 0.18system 0:06.75elapsed 97%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> >
> > which is rather more stable as far as resource usage goes between the
> > two CPUs, but still an asymmetry in the reported bandwidths and times.
> > So, this has ruled out differences in VA layout.
> >
> > Now for the interesting bit... it's important to understand what and
> > how stuff is being measured.  Looking at the bw_mem.c and associated
> > source code, it measures the performance against the wall clock, which
> > includes everything that the system is doing on each particular CPU.
> > So, if a CPU is interrupted by another thread wanting to run, it'll
> > affect the results.  Hence, it's best to run on an otherwise quiet
> > system, eg, without an init daemon (eg, booted with init=/bin/sh on
> > the kernel command line - but note there won't be any job control, so
> > ^C won't work!)
> >
> > However, continuing on...
> >
> > If I run bw_mem on just one CPU:
> >
> > CPU1: 1.00 2617.31
> > 5.74user 0.18system 0:06.03elapsed 98%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> >
> > Same number of iterations, same memory size, but notice that it
> > appears to be a lot faster reported by bw_mem, but the time taken is
> about the same.
> > cpufreq comes to mind, but that's disabled on this system.
> >
> > So, it brings up a rather obvious question: what exactly is bw_mem
> > measuring, and is it measuring it correctly?
> >
> > $ /usr/bin/time taskset -c 1 ./bw_mem -P 1 -N 1000 1M fwr
> > 1.00 2601.26
> > 5.80user 0.16system 0:06.06elapsed 98%CPU (0avgtext+0avgdata
> > 1700maxresident)k
> > 0inputs+0outputs (0major+403minor)pagefaults 0swaps
> > $ /usr/bin/time ./bw_mem -P 2 -N 1000 1M fwr ^CCommand terminated
> by
> > signal 2 5.54user 0.13system 1:12.20elapsed 7%CPU (0avgtext+0avgdata
> > 1696maxresident)k
> > 0inputs+0outputs (0major+365minor)pagefaults 0swaps
> >
> > so requesting a parallelism of 2 results in the program never
> > seemingly ending in a reasonable period of time, which suggests a bug
> somewhere.
> > Are we sure that bw_mem is actually working as intended?
> >
> > Maybe if Larry is reading this, he could share some thoughts.
> >
> > --
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down
> > 630kbps up According to speedtest.net: 13Mbps down 490kbps up
> 
> Thanks for the detail explanation on LM bench test.
> 
> Initially, I tested to run my own's created memory test program and
> encountered the same unbalanced memory throughput whenever two
> threads are running on different cores. I tested to run the memory test
> program on either one core or two cores. The unbalanced memory
> throughput is seen when running on two cores. Hence, I tried out the
> bw_mem test as it is a general benchmark program and it appears to be alike
> to my own test case.
> 
> Attached is the memory test program memtest.c file and the Linux
> executable file. The memtest -a1 will forces the two threads running on
> different cores while memtest -a2 will forces the two threads running on one
> core.
> May I know if is it possible if you could try out my test program on your
> iMX6D SoC (also dual core Cortex A9) board?
> 
> Below show the comparison between two threads running on one core vs
> two cores
> 
> One core:
> ========= Multi Thread =========
> 
> Thread 3067511920 - data size 1 MB, runs = 1000 Thread 3059123312 - data
> size 1 MB, runs = 1000 Thread :3059123312: Datarate: 974.887201 MB/s
> Thread :3067511920: Datarate: 960.289834 MB/s Thread :3067511920:
> Datarate: 1083.249741 MB/s Thread :3059123312: Datarate: 1055.545769 MB/s
> Thread :3067511920: Datarate: 1085.555446 MB/s Thread :3059123312:
> Datarate: 1084.503430 MB/s Thread :3067511920: Datarate: 1063.379303 MB/s
> Thread :3059123312: Datarate: 1070.705338 MB/s Thread :3067511920:
> Datarate: 1050.933243 MB/s Thread :3059123312: Datarate: 1050.153330 MB/s
> Thread :3067511920: Datarate: 1085.489144 MB/s Thread :3059123312:
> Datarate: 1071.774560 MB/s Thread :3067511920: Datarate: 1084.506795 MB/s
> Thread :3059123312: Datarate: 1060.260066 MB/s Thread :3067511920:
> Datarate: 1074.058027 MB/s Thread :3059123312: Datarate: 1069.279388 MB/s
> Thread :3067511920: Datarate: 1073.924924 MB/s Thread :3059123312:
> Datarate: 1080.818992 MB/s Thread :3067511920: Datarate: 1081.871683 MB/s
> Thread :3067511920: Average Datarate: 1064.325814 MB/s
> Thread :3059123312: Datarate: 1097.549768 MB/s Thread :3059123312:
> Average Datarate: 1061.547784 MB/s Finished!
> 
> Two cores:
> ========= Multi Thread =========
> 
> Thread 3067954288 - data size 1 MB, runs = 1000 Thread 3059565680 - data
> size 1 MB, runs = 1000 Thread :3067954288: Datarate: 741.930805 MB/s
> Thread :3059565680: Datarate: 377.979641 MB/s Thread :3067954288:
> Datarate: 741.976479 MB/s Thread :3067954288: Datarate: 740.548015 MB/s
> Thread :3059565680: Datarate: 376.706463 MB/s Thread :3067954288:
> Datarate: 740.313260 MB/s Thread :3067954288: Datarate: 740.363440 MB/s
> Thread :3059565680: Datarate: 376.129877 MB/s Thread :3067954288:
> Datarate: 740.056194 MB/s Thread :3067954288: Datarate: 740.219191 MB/s
> Thread :3059565680: Datarate: 376.114092 MB/s Thread :3067954288:
> Datarate: 740.152311 MB/s Thread :3067954288: Datarate: 724.094688 MB/s
> Thread :3059565680: Datarate: 388.118117 MB/s Thread :3067954288:
> Datarate: 740.556383 MB/s Thread :3067954288: Average Datarate:
> 739.021077 MB/s Thread :3059565680: Datarate: 1323.735631 MB/s
> Thread :3059565680: Datarate: 2072.948256 MB/s Thread :3059565680:
> Datarate: 2069.817984 MB/s Thread :3059565680: Datarate: 2069.295149 MB/s
> Thread :3059565680: Datarate: 2040.932474 MB/s Thread :3059565680:
> Average Datarate: 1147.177768 MB/s Finished!
> 
> Thanks
> Tzy Way


Hi Russell,

Sorry for interrupt. I would like to check with you if do you have the chance to try out the memory test program on your iMX6D SoC board?
Currently, I do not have other board with me and I wish to test it across other platform to see if the same issue will be seen on other board.

Really appreciate on your help to run the test program on your board. Hope to hear from you soon.

Thank you

Best regards,
Tzy Way
