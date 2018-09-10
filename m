Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CC320890
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CC320890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeIJSco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:32:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbeIJSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:32:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8ADZSLQ003257
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:38:35 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mdpvjr8hb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:38:35 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Mon, 10 Sep 2018 14:38:32 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Sep 2018 14:38:30 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8ADcTtw51904716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 13:38:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB5D2AE051;
        Mon, 10 Sep 2018 16:37:46 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D21BAE04D;
        Mon, 10 Sep 2018 16:37:46 +0100 (BST)
Received: from [9.145.72.33] (unknown [9.145.72.33])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Sep 2018 16:37:46 +0100 (BST)
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc/pseries: use H_BLOCK_REMOVE
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au
Cc:     aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com
References: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
Date:   Mon, 10 Sep 2018 15:38:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18091013-0008-0000-0000-0000026F2CA2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091013-0009-0000-0000-000021D75FF0
Message-Id: <febd6c4b-e7b8-02a7-c570-0d1fe9e2e3a0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Do you plan to pull it for 4.20 ?

Cheers,
Laurent.

On 20/08/2018 16:29, Laurent Dufour wrote:
> On very large system we could see soft lockup fired when a process is
> exiting
> 
> watchdog: BUG: soft lockup - CPU#851 stuck for 21s! [forkoff:215523]
> Modules linked in: pseries_rng rng_core xfs raid10 vmx_crypto btrfs libcrc32c xor zstd_decompress zstd_compress xxhash lzo_compress raid6_pq crc32c_vpmsum lpfc crc_t10dif crct10dif_generic crct10dif_common dm_multipath scsi_dh_rdac scsi_dh_alua autofs4
> CPU: 851 PID: 215523 Comm: forkoff Not tainted 4.17.0 #1
> NIP:  c0000000000b995c LR: c0000000000b8f64 CTR: 000000000000aa18
> REGS: c00006b0645b7610 TRAP: 0901   Not tainted  (4.17.0)
> MSR:  800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22042082  XER: 00000000
> CFAR: 00000000006cf8f0 SOFTE: 0 
> GPR00: 0010000000000000 c00006b0645b7890 c000000000f99200 0000000000000000 
> GPR04: 8e000001a5a4de58 400249cf1bfd5480 8e000001a5a4de50 400249cf1bfd5480 
> GPR08: 8e000001a5a4de48 400249cf1bfd5480 8e000001a5a4de40 400249cf1bfd5480 
> GPR12: ffffffffffffffff c00000001e690800 
> NIP [c0000000000b995c] plpar_hcall9+0x44/0x7c
> LR [c0000000000b8f64] pSeries_lpar_flush_hash_range+0x324/0x3d0
> Call Trace:
> [c00006b0645b7890] [8e000001a5a4dd20] 0x8e000001a5a4dd20 (unreliable)
> [c00006b0645b7a00] [c00000000006d5b0] flush_hash_range+0x60/0x110
> [c00006b0645b7a50] [c000000000072a2c] __flush_tlb_pending+0x4c/0xd0
> [c00006b0645b7a80] [c0000000002eaf44] unmap_page_range+0x984/0xbd0
> [c00006b0645b7bc0] [c0000000002eb594] unmap_vmas+0x84/0x100
> [c00006b0645b7c10] [c0000000002f8afc] exit_mmap+0xac/0x1f0
> [c00006b0645b7cd0] [c0000000000f2638] mmput+0x98/0x1b0
> [c00006b0645b7d00] [c0000000000fc9d0] do_exit+0x330/0xc00
> [c00006b0645b7dc0] [c0000000000fd384] do_group_exit+0x64/0x100
> [c00006b0645b7e00] [c0000000000fd44c] sys_exit_group+0x2c/0x30
> [c00006b0645b7e30] [c00000000000b960] system_call+0x58/0x6c
> Instruction dump:
> 60000000 f8810028 7ca42b78 7cc53378 7ce63b78 7d074378 7d284b78 7d495378 
> e9410060 e9610068 e9810070 44000022 <7d806378> e9810028 f88c0000 f8ac0008
> 
> This happens when removing the PTE by calling the hypervisor using the
> H_BULK_REMOVE call. This call is processing up to 4 PTEs but is doing a
> tlbie for each PTE it is processing. This could lead to long time spent in
> the hypervisor (sometimes up to 4s) and soft lockup being raised because
> the scheduler is not called in zap_pte_range().
> 
> Since the Power7's time, the hypervisor is providing a new hcall
> H_BLOCK_REMOVE allowing processing up to 8 PTEs with one call to
> tlbie. By limiting the amount of tlbie generated, this reduces the time
> spent invalidating the PTEs.
> 
> This hcall requires that the pages are "all within the same naturally
> aligned 8 page virtual address block".
> 
> With this patch series applied, I couldn't see any soft lockup raised on
> the victim LPAR I was running the test one.
> 
> Changes since V1:
> - Remove a call to BUG_ON() in call_block_remove() since this one can be
>   handled gently.
> - Remove uneeded of current_vpgb to 0 when retrying entries in
>   hugepage_block_invalidate() and do_block_remove().
> 
> Laurent Dufour (3):
>   powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
>   powerpc/pseries/mm: factorize PTE slot computation
>   powerpc/pseries/mm: call H_BLOCK_REMOVE
> 
>  arch/powerpc/include/asm/firmware.h       |   3 +-
>  arch/powerpc/include/asm/hvcall.h         |   1 +
>  arch/powerpc/platforms/pseries/firmware.c |   1 +
>  arch/powerpc/platforms/pseries/lpar.c     | 241 ++++++++++++++++++++++++++++--
>  4 files changed, 230 insertions(+), 16 deletions(-)
> 

