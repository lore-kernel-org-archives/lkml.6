Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6577BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331D420684
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 04:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331D420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKKO3L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 09:29:11 -0500
Received: from mout.gmx.net ([212.227.17.21]:42401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeKKO3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 09:29:10 -0500
Received: from [192.168.1.153] ([74.104.183.64]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LnlmV-1fr2Bb47At-00hzmj; Sun, 11
 Nov 2018 05:41:37 +0100
From:   Qian Cai <cai@gmx.us>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: crashkernel=512M is no longer working on this aarch64 server
Message-Id: <1A7E2E89-34DB-41A0-BBA2-323073A7E298@gmx.us>
Date:   Sat, 10 Nov 2018 23:41:34 -0500
Cc:     linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.39)
X-Provags-ID: V03:K1:XtDa7QJ6K0jE3PIxeDoHWzJQZIiQxEpx5w1p9Lso7Y3ZQGNv8li
 3Lp1V5H9KNvlT8NVhg/XuAZVXYGfpoZD0pGxGJ/wN/1/YsB22hOHXoemoo1VpK6o1gLHD/w
 vCepLtLb/XLcl2VPsURvH5CrVBAAWVm84/p5oD0RNPp6drdWdR9V6t35tS/THZanPrJUmAy
 TdrYi86rgCKvCBkxKiXIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mt+vNIJAjvY=:k+eOiqbSviZsSJQV5TJVRT
 Dq+yuPwOsAUmPnpEJM16y80lQlQHm9tegHufURSApcdnreOI+H0g0d2jmxyyN1RIYP22RXgf6
 Z25OwNneGUODftxPGb7k2AoL7vgrfrDvvDHWZMXDcFNzlPVLQ0O+u1CaLQ5YqvuyJEvhWJR53
 DbuiPeQK4TwEkxlzwfLgocKgRVMr6xxCjJFnDnSVlWtdj9lS6G47g9AQr6jlyh4CJsj76h9+z
 XyXmTCuXC0QCQXQnFxhXKvVW8kBozU0x1g64Ps6elZ0RyPkR5Kxa++1/MtA/GQhMrMNExe1tm
 BPZx3SbzgLUXZaMuo2t1wLSQN6qW3Gxrlaq+qtQa22UYVRF0hD/si2MyovL6N5sLKD1cDD4zE
 Q7oxK1+w8Rw2HZ0ExuCZ6Ta6xN6OxP132LlsqrASmbKUPST5pHgEb7Mv/P18ONkVSBfqsJ3kA
 yDeJHI/iUO29ld+LzSj2Z14538n9zi0iGVhOqnE5ufrWfthIBuEr5aT5hNKInwk07OTAcQemg
 5iYu3mBZbK/1dNS1faB+gi38EFwEuGTS1iaIvxF6+DIdoOGj8mNM1Tl83f2B5GomrFBSez61P
 cK4NbHVCZpk5Wp0b++CmO4m4LRYsbRp80lnAsh8Y+KX5/8r8pxD/XRbcWZQ41z+YUMa6uJSSb
 aKbZhxZEQUsg5ngxTjLUNDpwlo83fasTDuQJc+r/8pt0ryQ2xYqEmry+HbzEldkj6p71vMS1J
 iVOxMlmWmZr7W+kuZe/mOuheFzfglbQZeEIOMY8ztp7GOYNU7v02V9eD85Yp/Gqwr3vELgiL3
 ZgsklpkBra55zoA1kl8gbG/Hs29lylvxMaU6EgSF8bcHexzlg5pldVUmQU1nyDE2BpHhoAmMb
 4LOnn8+HQEVf+pXgF3H6N5rqQpfnfF8IiVIVSHYsA4FB4oGOQK4yUDA9wwkczp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was broken somewhere between b00d209241ff and 3541833fd1f2.

[    0.000000] cannot allocate crashkernel (size:0x20000000)

Where a good one looks like this,

[    0.000000] crashkernel reserved: 0x0000000008600000 - 0x0000000028600000 (512 MB)

Some commits look more suspicious than others.

      mm: add mm_pxd_folded checks to pgtable_bytes accounting functions
      mm: introduce mm_[p4d|pud|pmd]_folded
      mm: make the __PAGETABLE_PxD_FOLDED defines non-empty

# diff -u ../iomem.good.txt ../iomem.bad.txt 
--- ../iomem.good.txt	2018-11-10 22:28:20.092614398 -0500
+++ ../iomem.bad.txt	2018-11-10 20:39:54.930294479 -0500
@@ -1,9 +1,8 @@
 00000000-3965ffff : System RAM
   00080000-018cffff : Kernel code
-  018d0000-020affff : reserved
-  020b0000-045affff : Kernel data
-  08600000-285fffff : Crash kernel
-  28730000-2d5affff : reserved
+  018d0000-0762ffff : reserved
+  07630000-09b2ffff : Kernel data
+  231b0000-2802ffff : reserved
   30ec0000-30ecffff : reserved
   35660000-3965ffff : reserved
 39660000-396fffff : reserved
@@ -127,7 +126,7 @@
   7c5200000-7c520ffff : 0004:48:00.0
 1040000000-17fbffffff : System RAM
   13fbfd0000-13fdfdffff : reserved
-  16fba80000-17fbfdffff : reserved
+  16fafd0000-17fbfdffff : reserved
   17fbfe0000-17fbffffff : reserved
 1800000000-1ffbffffff : System RAM
   1bfbff0000-1bfdfeffff : reserved

The memory map looks like this,

[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000398D0014 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x00000000398C00E8 000064 (v01 HISI   HIP07    00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039770000 000114 (v06 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: DSDT 0x0000000039730000 00691A (v02 HISI   HIP07    00000000 INTL 20170728)
[    0.000000] ACPI: MCFG 0x00000000397C0000 0000AC (v01 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: SLIT 0x00000000397B0000 00003C (v01 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: SRAT 0x00000000397A0000 000578 (v03 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: DBG2 0x0000000039790000 00005A (v00 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: GTDT 0x0000000039760000 00007C (v02 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: APIC 0x0000000039750000 0014E4 (v04 HISI   HIP07    00000000 INTL 20151124)
[    0.000000] ACPI: IORT 0x0000000039740000 000554 (v00 HISI   HIP07    00000000 INTL 20170728)
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x3fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x1800000000-0x1fffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0x17ffffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x9000000000-0x97ffffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x8800000000-0x8fffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17fbffe5c0-0x17fbffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x1ffbffe5c0-0x1ffbffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x8ffbffe5c0-0x8ffbffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x97fadce5c0-0x97fadcffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000097fbffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003965ffff]
[    0.000000]   node   0: [mem 0x0000000039660000-0x00000000396fffff]
[    0.000000]   node   0: [mem 0x0000000039700000-0x000000003977ffff]
[    0.000000]   node   0: [mem 0x0000000039780000-0x000000003978ffff]
[    0.000000]   node   0: [mem 0x0000000039790000-0x00000000397cffff]
[    0.000000]   node   0: [mem 0x00000000397d0000-0x00000000398bffff]
[    0.000000]   node   0: [mem 0x00000000398c0000-0x00000000398dffff]
[    0.000000]   node   0: [mem 0x00000000398e0000-0x0000000039d5ffff]
[    0.000000]   node   0: [mem 0x0000000039d60000-0x000000003ed4ffff]
[    0.000000]   node   0: [mem 0x000000003ed50000-0x000000003ed7ffff]
[    0.000000]   node   0: [mem 0x000000003ed80000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000001040000000-0x00000017fbffffff]
[    0.000000]   node   1: [mem 0x0000001800000000-0x0000001ffbffffff]
[    0.000000]   node   2: [mem 0x0000008800000000-0x0000008ffbffffff]
[    0.000000]   node   3: [mem 0x0000009000000000-0x00000097fbffffff]

