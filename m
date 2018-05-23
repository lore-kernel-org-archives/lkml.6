Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeEWGP7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:15:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54384 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753936AbeEWGP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:15:57 -0400
Subject: Re: [PATCH rdma-next 3/5] RDMA/hns: Increase checking CMQ status
 timeout value
To: Leon Romanovsky <leon@kernel.org>
References: <1526544173-106587-1-git-send-email-xavier.huwei@huawei.com>
 <1526544173-106587-4-git-send-email-xavier.huwei@huawei.com>
 <20180523054918.GB2933@mtr-leonro.mtl.com> <5B0505A9.8040908@huawei.com>
CC: <dledford@redhat.com>, <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xavier.huwei@tom.com>,
        <lijun_nudt@163.com>
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5B050714.2040205@huawei.com>
Date: Wed, 23 May 2018 14:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <5B0505A9.8040908@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/23 14:09, Wei Hu (Xavier) wrote:
>
> On 2018/5/23 13:49, Leon Romanovsky wrote:
>> On Thu, May 17, 2018 at 04:02:51PM +0800, Wei Hu (Xavier) wrote:
>>> This patch increases checking CMQ status timeout value and
>>> uses the same value with NIC driver to avoid deficiency of
>>> time.
>>>
>>> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
>>> ---
>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>> index 182b672..f16df1b 100644
>>> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
>>> @@ -76,7 +76,7 @@
>>>  #define HNS_ROCE_V2_PAGE_SIZE_SUPPORTED		0xFFFFF000
>>>  #define HNS_ROCE_V2_MAX_INNER_MTPT_NUM		2
>>>  #define HNS_ROCE_INVALID_LKEY			0x100
>>> -#define HNS_ROCE_CMQ_TX_TIMEOUT			200
>>> +#define HNS_ROCE_CMQ_TX_TIMEOUT			30000
>> Don't you think that loop of 30 seconds too much?
>>
>> Thanks
> Leon, 30ms
Because firmware take turns excuting NIC and RoCE command.
Although RoCE command does not  take so long,  we still use
the same timeout value with NIC driver.
Thanks
>>>  #define HNS_ROCE_CONTEXT_HOP_NUM		1
>>>  #define HNS_ROCE_MTT_HOP_NUM			1
>>> --
>>> 1.9.1
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>
