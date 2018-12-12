Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69660C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357552084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357552084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeLLOOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:14:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726169AbeLLOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:14:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCE9c5W014608
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:14:53 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pb1njpp3p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:14:53 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <haver@linux.vnet.ibm.com>;
        Wed, 12 Dec 2018 14:14:51 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 14:14:48 -0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCEElC923658646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 14:14:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54401C6057;
        Wed, 12 Dec 2018 14:14:47 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 187CFC6055;
        Wed, 12 Dec 2018 14:14:47 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.16.170.189])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 14:14:46 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Dec 2018 15:18:55 +0100
From:   haver <haver@linux.vnet.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genwqe: Fix size check
In-Reply-To: <20181212134518.4587-1-borntraeger@de.ibm.com>
References: <20181212134518.4587-1-borntraeger@de.ibm.com>
X-Sender: haver@linux.vnet.ibm.com
User-Agent: Roundcube Webmail/1.0.1
X-TM-AS-GCONF: 00
x-cbid: 18121214-0016-0000-0000-000009635567
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130712; UDB=6.00587571; IPR=6.00910845;
 MB=3.00024669; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 14:14:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121214-0017-0000-0000-0000416114EC
Message-Id: <64f068a535ab7bfe15f04ba86fb067b0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 2018-12-12 14:45, Christian Borntraeger wrote:
> Calling the test program genwqe_cksum with the default buffer size of
> 2MB triggers the following kernel warning on s390:
> 
> WARNING: CPU: 30 PID: 9311 at mm/page_alloc.c:3189
> __alloc_pages_nodemask+0x45c/0xbe0
> CPU: 30 PID: 9311 Comm: genwqe_cksum Kdump: loaded Not tainted
> 3.10.0-957.el7.s390x #1
> task: 00000005e5d13980 ti: 00000005e7c6c000 task.ti: 00000005e7c6c000
> Krnl PSW : 0704c00180000000 00000000002780ac
> (__alloc_pages_nodemask+0x45c/0xbe0)
>            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
> Krnl GPRS: 00000000002932b8 0000000000b73d7c 0000000000000010 
> 0000000000000009
>            0000000000000041 00000005e7c6f9b8 0000000000000001 
> 00000000000080d0
>            0000000000000000 0000000000b70500 0000000000000001 
> 0000000000000000
>            0000000000b70528 00000000007682c0 0000000000277df2 
> 00000005e7c6f9a0
> Krnl Code: 000000000027809e: de7195001000	ed	1280(114,%r9),0(%r1)
> 	   00000000002780a4: a774fead		brc	7,277dfe
> 	  #00000000002780a8: a7f40001		brc	15,2780aa
> 	  >00000000002780ac: 92011000		mvi	0(%r1),1
> 	   00000000002780b0: a7f4fea7		brc	15,277dfe
> 	   00000000002780b4: 9101c6b6		tm	1718(%r12),1
> 	   00000000002780b8: a784ff3a		brc	8,277f2c
> 	   00000000002780bc: a7f4fe2e		brc	15,277d18
> Call Trace:
> ([<0000000000277df2>] __alloc_pages_nodemask+0x1a2/0xbe0)
>  [<000000000013afae>] s390_dma_alloc+0xfe/0x310
>  [<000003ff8065f362>] __genwqe_alloc_consistent+0xfa/0x148 
> [genwqe_card]
>  [<000003ff80658f7a>] genwqe_mmap+0xca/0x248 [genwqe_card]
>  [<00000000002b2712>] mmap_region+0x4e2/0x778
>  [<00000000002b2c54>] do_mmap+0x2ac/0x3e0
>  [<0000000000292d7e>] vm_mmap_pgoff+0xd6/0x118
>  [<00000000002b081c>] SyS_mmap_pgoff+0xdc/0x268
>  [<00000000002b0a34>] SyS_old_mmap+0x8c/0xb0
>  [<000000000074e518>] sysc_tracego+0x14/0x1e
>  [<000003ffacf87dc6>] 0x3ffacf87dc6
> 
> turns out the check in __genwqe_alloc_consistent uses "> MAX_ORDER"
> while the mm code uses ">= MAX_ORDER". Fix genwqe.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/misc/genwqe/card_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/genwqe/card_utils.c 
> b/drivers/misc/genwqe/card_utils.c
> index 3fcb9a2fe1c9..efe2fb72d54b 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -215,7 +215,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
>  void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
>  			       dma_addr_t *dma_handle)
>  {
> -	if (get_order(size) > MAX_ORDER)
> +	if (get_order(size) >= MAX_ORDER)
>  		return NULL;
> 
>  	return dma_zalloc_coherent(&cd->pci_dev->dev, size, dma_handle,

Thanks for sending a fix for this ugly message.
Regards

Frank

Signed-off-by: Frank Haverkamp <haver@linux.vnet.ibm.com>

