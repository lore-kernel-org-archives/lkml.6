Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D750FC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693F32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693F32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJLSTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:19:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbeJLSTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:19:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6906FFBBEE3F2;
        Fri, 12 Oct 2018 18:47:15 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Fri, 12 Oct 2018
 18:47:10 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com>
CC:     <jejb@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <e771c366-2824-8774-4c90-9906992ee813@huawei.com>
Date:   Fri, 12 Oct 2018 11:47:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <yq18t354532.fsf@oracle.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 02:58, Martin K. Petersen wrote:
>
> John,
>

Hi Martin,

>> However it does block us in future from enabling SCSI MQ in the driver.
>
> We're going to remove the legacy I/O path so I'm not particularly keen
> on merging something that's going in the opposite direction.

What I really meant was that we cannot expose multiple queues to upper 
layer, and nothing related to legacy IO path.

>
>> This is because the IPTT index must be a unique value per HBA. However,
>> if we switched to SCSI MQ, the block layer tag becomes unique per queue,
>> and not per HBA.
>
> That doesn't sound right.
>

Again, my wording my probably was not accurate. I meant that rq tag is 
not unqiue across all hw queues.

As I mentioned in the thread that spawned from this, we actually can't 
expose multiple hw queues at the moment. And, if we did, we find a 
performance drop due to having to go back to manage this IPTT internally.

So how to handle? We're going to continue to work towards exposing 
multiple queues to upper layer, but for the moment I think patch 6/7 is 
a good change.

Please let me know.

Thanks,
John


