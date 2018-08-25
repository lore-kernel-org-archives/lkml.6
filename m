Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06754C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D8021581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 00:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D8021581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeHYEPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 00:15:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725738AbeHYEPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 00:15:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7P0Y9pg061219
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 20:38:23 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m2qe4t0x9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 20:38:23 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 18:38:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 18:38:17 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7P0cGgw27263050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 17:38:16 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F15BC6055;
        Fri, 24 Aug 2018 18:38:16 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1D40C6057;
        Fri, 24 Aug 2018 18:38:10 -0600 (MDT)
Received: from morokweng.localdomain (unknown [9.85.162.69])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Aug 2018 18:38:10 -0600 (MDT)
References: <20180824162535.22798-1-bauerman@linux.ibm.com> <20180824162535.22798-12-bauerman@linux.ibm.com> <45561478-ee75-ee62-52d6-a96d60132669@infradead.org>
User-agent: mu4e 1.0; emacs 25.3.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 11/11] powerpc/svm: Increase SWIOTLB buffer size
In-reply-to: <45561478-ee75-ee62-52d6-a96d60132669@infradead.org>
Date:   Fri, 24 Aug 2018 21:38:02 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18082500-0036-0000-0000-00000A2A60C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009605; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078397; UDB=6.00556082; IPR=6.00858371;
 MB=3.00022918; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-25 00:38:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082500-0037-0000-0000-000048B49054
Message-Id: <87mutbxout.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=691 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808250004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Randy,

Thanks for your quick review.

Randy Dunlap <rdunlap@infradead.org> writes:

> On 08/24/2018 09:25 AM, Thiago Jung Bauermann wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> SWIOTLB buffer default size (64MB) is not enough for large sequential write
>> operations which eventually leads to kernel crash like here.
>>
>> virtio-pci 0000:00:05.0: swiotlb buffer is full (sz: 327680 bytes)
>> virtio-pci 0000:00:05.0: DMA: Out of SW-IOMMU space for 327680 bytes
>> Kernel panic - not syncing: DMA: Random memory could be DMA read
>> CPU: 12 PID: 3985 Comm: mkfs.ext4 Not tainted 4.18.0-rc4+ #285
>> Call Trace:
>> [c0000007d2a27020] [c000000000cfdffc] dump_stack+0xb0/0xf4 (unreliable)
>> [c0000007d2a27060] [c000000000112a98] panic+0x140/0x328
>> [c0000007d2a270f0] [c0000000001b4f88] swiotlb_full+0x108/0x130
>> [c0000007d2a27180] [c0000000001b5f6c] swiotlb_map_page+0x25c/0x2c0
>> [c0000007d2a271e0] [c0000000007bfaf8] vring_map_one_sg.isra.0+0x58/0x70
>> [c0000007d2a27200] [c0000000007c08dc] virtqueue_add_sgs+0x1bc/0x690
>> [c0000007d2a272f0] [d0000000042a1280] virtio_queue_rq+0x358/0x4a0 [virtio_blk]
>> [c0000007d2a273d0] [c0000000006b5d68] blk_mq_dispatch_rq_list+0x1f8/0x6d0
>> ..................
>>
>> Increase the SWIOTLB size to 1GB on Ultravisor based secure guests.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/Kconfig | 5 +++++
>>  kernel/dma/swiotlb.c | 5 +++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 1466d1234723..fee7194ce9e4 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -457,6 +457,11 @@ config PPC_SVM
>>
>>  	 If unsure, say "N".
>>
>> +config SWIOTLB_DEFAULT_SIZE
>> +       int "Size of Software I/O TLB buffer (in MiB)"
>> +       default "1024"
>
> I would add a "range" to limit (restrict) how small or large that can be.  E.g.:
>
> 	range 16 102400
>
> or even smaller for the maximum value...

That's an interesting idea. Since this config option is restricted to
PPC_SVM it may be possible to find out what reasonable limits would be.
I'll have to experiment a bit to find out. Though I can say that 16 MB
is too small since even with 64 MB the kernel panics with the simple
task of formatting a filesystem...

--
Thiago Jung Bauermann
IBM Linux Technology Center

