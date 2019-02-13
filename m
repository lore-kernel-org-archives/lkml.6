Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C2C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2B92190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391752AbfBMLRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:17:54 -0500
Received: from mifar.in ([46.101.129.31]:50780 "EHLO mifar.in"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbfBMLRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:17:54 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 06:17:53 EST
Received: from mifar.in (p2E511F4B.dip0.t-ipconnect.de [46.81.31.75])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mifar.in", Issuer "mifar.in" (verified OK))
        by mifar.in (Postfix) with ESMTPS id 7668F60F4F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 12:08:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mifar.in 7668F60F4F
Received: (qmail 17265 invoked by uid 500); 13 Feb 2019 11:08:04 -0000
Date:   Wed, 13 Feb 2019 12:08:03 +0100
From:   Sami Farin <hvtaifwkbgefbaei@gmail.com>
To:     Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: 4.19.21: perf does not work on Ryzen, OK with 4.19.20
Message-ID: <20190213110803.xbnganrtvgmfgh3b@m.mifar.in>
Mail-Followup-To: Sami Farin <hvtaifwkbgefbaei@gmail.com>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.3 (365568a) (2019-01-08)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same .config, BIOS, and kernel boot parameters in both kernels.

# perf top -v
           ┌─Error:────────────────────────────────────────┐
           │Failed to mmap with 12 (Cannot allocate memory)│

mmap size 528384B

[    0.015080] smpboot: CPU0: AMD Ryzen 5 1600X Six-Core Processor (family: 0x17, model: 0x1, stepping: 0x1)
[    0.020092] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.020167] ... version:                0
[    0.020226] ... bit width:              48
[    0.020284] ... generic registers:      6
[    0.020342] ... value mask:             0000ffffffffffff
[    0.020404] ... max period:             00007fffffffffff
[    0.020465] ... fixed-purpose events:   0
[    0.020522] ... event mask:             000000000000003f

[    1.307185] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    1.307248] AMD-Vi: Extended features (0xf77ef22294ada):
[    1.307309]  PPR NX GT IA GA PC GA_vAPIC
[    1.307479] AMD-Vi: Lazy IO/TLB flushing enabled
[    1.308686] amd_uncore: AMD NB counters detected
[    1.308750] amd_uncore: AMD LLC counters detected
[    1.309133] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).


MemTotal:       32915748 kB
MemFree:         7423584 kB
MemAvailable:   30061500 kB
Buffers:            1300 kB
Cached:         22917432 kB
SwapCached:            0 kB
Active:          7432916 kB
Inactive:       17190244 kB
Active(anon):    1706056 kB
Inactive(anon):   266040 kB
Active(file):    5726860 kB
Inactive(file): 16924204 kB
Unevictable:          32 kB
Mlocked:              32 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:               140 kB
Writeback:             0 kB
AnonPages:       1704432 kB
Mapped:           668832 kB
Shmem:            271724 kB
Slab:             612960 kB
SReclaimable:     448016 kB
SUnreclaim:       164944 kB
KernelStack:       14976 kB
PageTables:        55184 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    16457872 kB
Committed_AS:    8749324 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
Percpu:            10944 kB
HardwareCorrupted:     0 kB
AnonHugePages:    608256 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB
DirectMap4k:     1221876 kB
DirectMap2M:    27021312 kB
DirectMap1G:     6291456 kB


-- 
Do what you love because life is too short for anything else.
https://samifar.in/

