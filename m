Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0BE20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 13:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0BE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeKYADh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 19:03:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeKYADh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 19:03:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A590BA9D4E17;
        Sat, 24 Nov 2018 21:15:05 +0800 (CST)
Received: from [127.0.0.1] (10.57.115.182) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sat, 24 Nov 2018
 21:14:58 +0800
Subject: Re: [PATCH rdma-next 0/3] RDMA/hns: Updates for reset process of roce
 device in hip08
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
 <20181123204256.GK3395@ziepe.ca>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <liuyixian@huawei.com>,
        <zhangxiping3@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <xavier_huwei@163.com>
From:   "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5BF94ED2.7070701@huawei.com>
Date:   Sat, 24 Nov 2018 21:14:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181123204256.GK3395@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/11/24 4:42, Jason Gunthorpe wrote:
> On Fri, Nov 23, 2018 at 11:14:22PM +0800, Wei Hu (Xavier) wrote:
>> Hi, Doug and Janson
>>
>> This series mainly include updates for reset process of roce device
>> in hip08.
>> One patch adds support for reset and loading or unloading driver occur
>> simultaneously to ensure work normally, one stops sending mailbox&cmq&
>> doorbell when reset occured or reset is occuring, the last one modifies
>> the name of hns RoCE device's name in order to ensure that the name is
>> consistent before and after reset.
>>
>> This series relies on the the new interfaces in hns NIC driver those
>> had been accepted by David, the related commit as below:
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 
>> commit cb7ea80c6dfda472a068d40f4f9755d034b2dfde
> Then you can't send patches to RDMA until the next cycle. Please
> reasend after v4.21-rc1 is out.
>
> We can only coordinate with Dave's tree if you are able to setup a
> shared branch like Mellanox does.
>
> Also, I don't even see cb7ea80c6dfda472a068d40f4f9755d034b2dfde in
> that tree???
Hi, Jason

    Sorry, this is my mistake.
    The dependent patch of hns NIC driver as below:
    https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
    commit    4d60291b6b53afd246a57817fdae0c61a4655182

    We will try to setup the branch, Thanks.

    Best Regards
Xavier
> Jason
>
> .
>


