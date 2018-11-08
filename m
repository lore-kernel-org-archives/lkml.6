Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E4C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA78208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA78208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeKHUrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:47:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:14628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeKHUrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:47:11 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76EC984308F8B;
        Thu,  8 Nov 2018 19:12:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 8 Nov 2018
 19:12:06 +0800
Subject: Re: [PATCH -next] iommu/amd: remove set but not used variable 'tag'
To:     Joerg Roedel <joro@8bytes.org>
References: <1541657560-73681-1-git-send-email-yuehaibing@huawei.com>
 <20181108093237.GE19831@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <6fef1aaf-e58e-720b-7060-353d6fd3901d@huawei.com>
Date:   Thu, 8 Nov 2018 19:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181108093237.GE19831@8bytes.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/8 17:32, Joerg Roedel wrote:
> On Thu, Nov 08, 2018 at 06:12:40AM +0000, YueHaibing wrote:
>> -		tag = event[1] & 0x03FF;
>>  		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>>  			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>>  			pasid, address, flags);
> 
> This looks like tag was just missed in the error message. It is better
> to add it there instead of removing it.

Ok, will post a new patch.

> 
> Regards,
> 
> 	Joerg
> 
> .
> 

