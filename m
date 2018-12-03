Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455402082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455402082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLCL5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:57:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbeLCL5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:57:15 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4DAE0BF84CA14;
        Mon,  3 Dec 2018 19:56:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Mon, 3 Dec 2018
 19:56:16 +0800
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
To:     Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
References: <20181130175449.2625-1-cai@gmx.us>
 <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
 <20181201163657.GA19557@lst.de>
CC:     Qian Cai <cai@gmx.us>, <netdev@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <yisen.zhuang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <53ab96d7-5dc9-e1a9-4cf2-bb8bf80a3acf@huawei.com>
Date:   Mon, 3 Dec 2018 11:56:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181201163657.GA19557@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2018 16:36, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 07:39:50PM +0000, Robin Murphy wrote:
>> I was assuming the point was to also add something like
>>
>> 	default 131072 if HNS_ENET
>>
>> so that DMA debug doesn't require too much thought from the user. If they
>> still have to notice the overflow message and empirically figure out a
>> value that does work, rebuilding the kernel each time is far less
>> convenient than simply adding "dma_debug_entries=..." to their kernel
>> command line and rebooting, which they can do today. If they do already
>> know up-front that the default will need overriding and what the
>> appropriate value is, then the command line still seems seems just as
>> convenient.
>
> I'm not so fond of random drivers changing the defaults.  My idea
> was rather to have the config option so that the defconfig files for
> the Hisilicon SOCs with this hardware could select a larger number
> without making a total mess of the kernel configuration.
>
> If we really have to we could do different defaults, but I'd still
> much rather do this on a arch/platform basis than specific drivers.

As I understand, some drivers could even use much more than this 
(131072), to such a point where I can't imagine that we would want to 
set an arch default to support them. For this HNS_ENET case, it is arm64 
specific so it would be an arch defconfig.

Thanks,
John

> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> .
>


