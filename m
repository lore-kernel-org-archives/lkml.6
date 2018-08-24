Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30CC208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30CC208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeHXHJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 03:09:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43484 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeHXHJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 03:09:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 01D2B24E51B0;
        Fri, 24 Aug 2018 11:36:42 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Fri, 24 Aug 2018
 11:36:42 +0800
Message-ID: <5B7F7D49.10206@huawei.com>
Date:   Fri, 24 Aug 2018 11:36:41 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bing Bu Cao <bingbu.cao@linux.intel.com>
CC:     <yong.zhi@intel.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <mchehab@kernel.org>,
        <matthias.bgg@gmail.com>, <tian.shu.qiu@intel.com>,
        <jian.xu.zheng@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH 1/2] media: ipu3-cio2: Use dma_zalloc_coherent to replace
 dma_alloc_coherent + memset
References: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com> <1534605415-11452-2-git-send-email-zhongjiang@huawei.com> <541b8c22-018f-4df6-85d1-82a72d9ab669@linux.intel.com>
In-Reply-To: <541b8c22-018f-4df6-85d1-82a72d9ab669@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/24 10:58, Bing Bu Cao wrote:
> Hi, Jiang
>
> This looks fine for me in ipu3-cio2.
> Actually, we already have this change locally, but I think we miss submit it to community.
> Thanks!
 It's ok,  Anyway,  Thank you for let me know that.

 Best wishes,
 zhong jiang
> On 08/18/2018 11:16 PM, zhong jiang wrote:
>> dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset(),
>> We prefer to dma_zalloc_coherent instead of open-codeing.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/media/pci/intel/ipu3/ipu3-cio2.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
>> index 2902715..f0c6374 100644
>> --- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
>> +++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
>> @@ -218,13 +218,11 @@ static int cio2_fbpt_init(struct cio2_device *cio2, struct cio2_queue *q)
>>  {
>>  	struct device *dev = &cio2->pci_dev->dev;
>>  
>> -	q->fbpt = dma_alloc_coherent(dev, CIO2_FBPT_SIZE, &q->fbpt_bus_addr,
>> -				     GFP_KERNEL);
>> +	q->fbpt = dma_zalloc_coherent(dev, CIO2_FBPT_SIZE, &q->fbpt_bus_addr,
>> +				      GFP_KERNEL);
>>  	if (!q->fbpt)
>>  		return -ENOMEM;
>>  
>> -	memset(q->fbpt, 0, CIO2_FBPT_SIZE);
>> -
>>  	return 0;
>>  }
>>  
>
> .
>


