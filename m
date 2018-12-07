Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7752C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7285C20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7285C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeLGKH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:07:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbeLGKH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:07:27 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB253EAFE43D6;
        Fri,  7 Dec 2018 18:07:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 7 Dec 2018
 18:07:18 +0800
Subject: Re: [PATCH v4 2/5] scsi: hisi_sas: Relocate some code to reduce
 complexity
To:     Johannes Thumshirn <jthumshirn@suse.de>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
 <1544103284-100497-3-git-send-email-john.garry@huawei.com>
 <c7ec9e23-6da8-35e0-1996-02db3d640f4b@suse.de>
 <2da87e22-1bbc-aff9-c0be-85a3fd8f4393@huawei.com>
 <778770d5-b377-2aaa-c2a0-9c548de74f17@suse.de>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0cfe35c7-89c4-b65a-ba25-dfcf5d59a564@huawei.com>
Date:   Fri, 7 Dec 2018 10:07:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <778770d5-b377-2aaa-c2a0-9c548de74f17@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 16:20, Johannes Thumshirn wrote:
> On 06/12/2018 16:37, John Garry wrote:
>> which is important. Let me know if you disagree and I can change it.
>
> Sure, it's your driver. It was just because the patch is even titled
> "Relocate some code to reduce complexity", so I thought of reducing the
> complexity for readers even further (like you don't need the line wrap
> at 80 chars, and so on).
>
> Byte,
> 	Johannes
>

I would rather not change if you don't mind. When we say "reduce 
complexity", we are talking about moving the DMA mapping code from the 
task prep function, as, when we add the DIX-related DMA mapping code, 
leaving all the DMA mapping code in the task prep function would make it 
a monster.

Thanks,
John

