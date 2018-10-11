Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73CAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D602087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D602087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeJKR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:26:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbeJKR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:26:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C97217DB53D02;
        Thu, 11 Oct 2018 17:59:24 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Thu, 11 Oct 2018
 17:59:17 +0800
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
To:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com> <20181011063603.GA3456@infradead.org>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <118d01db-05f4-a85b-850c-c4e5a5616a16@huawei.com>
Date:   Thu, 11 Oct 2018 10:59:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181011063603.GA3456@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 07:36, Christoph Hellwig wrote:
> On Wed, Oct 10, 2018 at 09:58:25PM -0400, Martin K. Petersen wrote:
>>> This is because the IPTT index must be a unique value per HBA. However,
>>> if we switched to SCSI MQ, the block layer tag becomes unique per queue,
>>> and not per HBA.
>>
>> That doesn't sound right.
>

Hmmm, well this is what I was told ...

> blk-mq tags are always per-host (which has actually caused problems for
> ATA, which is now using its own per-device tags).
>

So, for example, if Scsi_host.can_queue = 2048 and 
Scsi_host.nr_hw_queues = 16, then rq tags are still in range [0, 2048) 
for that HBA, i.e. invariant on queue count?

> .
>

Thanks,
John

