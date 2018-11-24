Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD9A20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD9A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeKXWdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:33:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbeKXWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:33:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAOBhMwr133483
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:45:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ny3h6cxb1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 06:45:22 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sat, 24 Nov 2018 11:45:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 24 Nov 2018 11:45:12 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAOBjBlM61603844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 24 Nov 2018 11:45:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2108BAE045;
        Sat, 24 Nov 2018 11:45:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94967AE053;
        Sat, 24 Nov 2018 11:45:10 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.68])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 24 Nov 2018 11:45:10 +0000 (GMT)
Date:   Sat, 24 Nov 2018 13:45:08 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: NO_BOOTMEM breaks alpha pc164
References: <8c8e3dba-7adf-96c6-195c-311050256743@linux.ee>
 <20181123071448.GE5704@rapoport-lnx>
 <78de90df-d88b-d82f-baf1-f0218af7a341@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78de90df-d88b-d82f-baf1-f0218af7a341@linux.ee>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112411-0012-0000-0000-000002CF8A1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112411-0013-0000-0000-00002104C1EC
Message-Id: <20181124114507.GC28634@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811240113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding linux-mm, the beginning of the thread is at
https://lkml.org/lkml/2018/11/22/1032)

On Fri, Nov 23, 2018 at 06:11:09PM +0200, Meelis Roos wrote:
> >>The bad commit is swith to NO_BOOTMEM.
> >
> >[ ... ]
> >>How do I debug it?
> >
> >Apparently, some of the early memory registration is not properly converted
> >from bootmem to memblock + nobootmem for your system.
> >
> >You can try applying the below patch to enable debug printouts from
> >memblock, maybe it'll shed some more light.
> 
> Here is the serial console output from a boot with the debug patch applied:
> 
> (boot dka0.0.0.5.0 -flags 0)
> block 0 of dka0.0.0.5.0 is a valid boot block
> reading 161 blocks from dka0.0.0.5.0
> bootstrap code read in
> base = 180000, image_start = 0, image_bytes = 14200
> initializing HWRPB at 2000
> initializing page table at 172000
> initializing machine state
> setting affinity to the primary CPU
> jumping to bootstrap code
> aboot: Linux/Alpha SRM bootloader version 1.0_pre20040408
> aboot: switching to OSF/1 PALcode version 1.23
> aboot: booting from device 'SCSI 0 5 0 0 0 0 0'
> aboot: valid disklabel found: 4 partitions.
> aboot: loading uncompressed test...
> aboot: loading compressed test...
> aboot: PHDR 0 vaddr 0xfffffc0000310000 offset 0x2000 size 0x79925c
> aboot: bss at 0xfffffc0000aa925c, size 0x16469c
> aboot: zero-filling 1459868 bytes at 0xfffffc0000aa925c
> aboot: starting kernel test with arguments root=/dev/sda2 console=ttyS0
> [    0.000000] Linux version 4.20.0-rc2-00068-gda5322e65940-dirty (mroos@pc164) (gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)) #115 Fri Nov 23 17:38:17 EET 2018
> [    0.000000] Booting on EB164 variation PC164 using machine vector PC164 from SRM
> [    0.000000] Major Options: EV56 LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ
> [    0.000000] Command line: root=/dev/sda2 console=ttyS0
> [    0.000000] Raw memory layout:
> [    0.000000]  memcluster  0, usage 1, start        0, end      192
> [    0.000000]  memcluster  1, usage 0, start      192, end    32651
> [    0.000000]  memcluster  2, usage 1, start    32651, end    32768
> [    0.000000] Initializing bootmem allocator on Node ID 0
> [    0.000000]  memcluster  1, usage 0, start      192, end    32651
> [    0.000000]  Detected node memory:   start      192, end    32651
> [    0.000000] memblock_add: [0x0000000000000000-0x000000000ff15fff] setup_memory+0x39c/0x478
> [    0.000000] memblock_reserve: [0x0000000000300000-0x0000000000c11fff] setup_memory+0x444/0x478
> [    0.000000] 1024K Bcache detected; load hit latency 30 cycles, load miss latency 212 cycles
> [    0.000000] pci: cia revision 2
> [    0.000000] memblock_alloc_try_nid: 104 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pci_controller+0x2c/0x50
> [    0.000000] memblock_reserve: [0x000000000ff15f80-0x000000000ff15fe7] memblock_alloc_internal+0x170/0x278
> [    0.000000] memblock_alloc_try_nid: 64 bytes align=0x20 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_resource+0x2c/0x40
> [    0.000000] memblock_reserve: [0x000000000ff15f40-0x000000000ff15f7f] memblock_alloc_internal+0x170/0x278

...
 
> halted CPU 0
> 
> halt code = 7
> machine check while in PAL mode
> PC = 1814c
> boot failure
> >>>

Two things that might cause the hang. 
First, memblock_add() is called after node_min_pfn has been rounded down to
the nearest 8Mb and in your case this cases memblock to see more memory that
is actually present in the system.
I'm not sure why the 8Mb alignment is required, I've just made sure that
memblock_add() will use exact available memory (the first patch below).

Another thing is that memblock allocates memory from high addresses while
bootmem was using low memory. It may happen that an allocation from high
memory is not accessible by the hardware, although it should be. The second
patch below addresses this issue.

It would be really great if you could test with each patch separately and
with both patches applied :)


Patch 1
------------------------------------------------------------------------------------
diff --git a/arch/alpha/mm/numa.c b/arch/alpha/mm/numa.c
index 74846553..7db1cb5 100644
--- a/arch/alpha/mm/numa.c
+++ b/arch/alpha/mm/numa.c
@@ -144,14 +144,14 @@ setup_memory_node(int nid, void *kernel_end)
 	if (!nid && (node_max_pfn < end_kernel_pfn || node_min_pfn > start_kernel_pfn))
 		panic("kernel loaded out of ram");
 
+	memblock_add(PFN_PHYS(node_min_pfn),
+		     (node_max_pfn - node_min_pfn) << PAGE_SHIFT);
+
 	/* Zone start phys-addr must be 2^(MAX_ORDER-1) aligned.
 	   Note that we round this down, not up - node memory
 	   has much larger alignment than 8Mb, so it's safe. */
 	node_min_pfn &= ~((1UL << (MAX_ORDER-1))-1);
 
-	memblock_add(PFN_PHYS(node_min_pfn),
-		     (node_max_pfn - node_min_pfn) << PAGE_SHIFT);
-
 	NODE_DATA(nid)->node_start_pfn = node_min_pfn;
 	NODE_DATA(nid)->node_present_pages = node_max_pfn - node_min_pfn;
 
Patch 2
------------------------------------------------------------------------------------
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index a37fd99..4b5b1b2 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -634,6 +634,7 @@ setup_arch(char **cmdline_p)
 
 	/* Find our memory.  */
 	setup_memory(kernel_end);
+	memblock_set_bottom_up(true);
 
 	/* First guess at cpu cache sizes.  Do this before init_arch.  */
 	determine_cpu_caches(cpu->type);


> -- 
> Meelis Roos <mroos@linux.ee>
> 

-- 
Sincerely yours,
Mike.

