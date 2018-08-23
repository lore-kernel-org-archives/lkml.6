Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E62C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CAD20C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CAD20C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeHWOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:54:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbeHWOyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:54:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AB10B625ABBE;
        Thu, 23 Aug 2018 19:25:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Thu, 23 Aug 2018
 19:25:34 +0800
Message-ID: <5B7E99AD.4050900@huawei.com>
Date:   Thu, 23 Aug 2018 19:25:33 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <aacraid@microsemi.com>
CC:     <andy.shevchenko@gmail.com>, <joe@perches.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Use dma_zalloc_coherent and kvcalloc to replace
 open code
References: <1533209314-1074-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1533209314-1074-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI, martin

Can you pick up the patchset? Thanks

Best wishes,
zhong jiang

On 2018/8/2 19:28, zhong jiang wrote:
>  
> v1->v2: 
>
> According to Andy and Joe suggestions. 
> [patch 1/4] get rid of unnessary parens and use kvcalloc and kvfree to
> replace the vmalloc and vfree.
> [patch 2/4] modify the changelog as Andy's suggestion.
> [patch 3/4] replace vmalloc and vfree by using kvcalloc adn kvfree.
> [patch 4/4] do nothing. just add Andy's review-by.
>
>
> zhong jiang (4):
>   driver/scsi/fnic/fnic_trace: Use kvcalloc instead of vmalloc+memset
>   drivers/scsi/dpt_i2o: Use dma_zalloc_coherent to repalce
>     dma_alloc_coherent+memset
>   drivers/scsi/snic/snic_trc: Use kvcalloc instead of vmalloc+memset
>   drivers/scsi/mvsas/mv_init: Use dma_zalloc_coherent to replace
>     dma_alloc_coherent+memset
>
>  drivers/scsi/dpt_i2o.c         | 12 ++++--------
>  drivers/scsi/fnic/fnic_trace.c |  7 +++----
>  drivers/scsi/mvsas/mv_init.c   | 12 ++++--------
>  drivers/scsi/snic/snic_trc.c   |  7 +++----
>  4 files changed, 14 insertions(+), 24 deletions(-)
>


