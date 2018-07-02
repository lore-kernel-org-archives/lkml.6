Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACABC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F97F2548E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F97F2548E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGBHHD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:07:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41438 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932864AbeGBHHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:07:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D12441C2E5756;
        Mon,  2 Jul 2018 15:06:56 +0800 (CST)
Received: from [127.0.0.1] (10.63.173.108) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 15:06:50 +0800
Subject: Re: [PATCH net-next 05/10] net: hns3: using modulo for cyclic
 counters in hclge_cmd_send
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
 <1530271385-49668-6-git-send-email-lipeng321@huawei.com>
 <20180630.210342.804224843120744818.davem@davemloft.net>
From:   "lipeng (Y)" <lipeng321@huawei.com>
Message-ID: <5ef0b797-67ff-e84a-367d-bd3da96a13b3@huawei.com>
Date:   Mon, 2 Jul 2018 15:06:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180630.210342.804224843120744818.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.63.173.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/30 20:03, David Miller wrote:
> From: Peng Li <lipeng321@huawei.com>
> Date: Fri, 29 Jun 2018 19:23:00 +0800
>
>> @@ -228,8 +228,7 @@ int hclge_cmd_send(struct hclge_hw *hw, struct hclge_desc *desc, int num)
>>   		desc_to_use = &hw->cmq.csq.desc[hw->cmq.csq.next_to_use];
>>   		*desc_to_use = desc[handle];
>>   		(hw->cmq.csq.next_to_use)++;
>> -		if (hw->cmq.csq.next_to_use == hw->cmq.csq.desc_num)
>> -			hw->cmq.csq.next_to_use = 0;
>> +		hw->cmq.csq.next_to_use %= hw->cmq.csq.desc_num;
>>   		handle++;
> I would advise against this.
>
> The "%" modulus operation takes many cpu cycles, and the current code
> is thus much faster.
>
> .
Agree with you.

Thanks for your review, we  concentrate on  the code style and ignore the
performance in this patch, It is not good.

I will remove this patch from the patchset.

>


