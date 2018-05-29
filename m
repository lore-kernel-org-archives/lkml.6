Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933377AbeE2LhT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:37:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57470 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932949AbeE2LhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:37:08 -0400
Subject: Re: [PATCH V3 rdma-next 4/4] RDMA/hns: Implement the
 disassociate_ucontext API
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <1527324107-56593-1-git-send-email-xavier.huwei@huawei.com>
 <1527324107-56593-5-git-send-email-xavier.huwei@huawei.com>
 <20180528165323.GC17505@ziepe.ca>
CC: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <lijun_nudt@163.com>, <oulijun@huawei.com>,
        <charles.chenxin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <leonro@mellanox.com>
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5B0D3B4E.4020909@huawei.com>
Date: Tue, 29 May 2018 19:36:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180528165323.GC17505@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/29 0:53, Jason Gunthorpe wrote:
> On Sat, May 26, 2018 at 04:41:47PM +0800, Wei Hu (Xavier) wrote:
>> This patch implemented the IB core disassociate_ucontext API.
>>
>> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
>>
>> v2->v3: Addressed the comments from Jason. The related link:
>> 	https://lkml.org/lkml/2018/5/22/967
>> v1->v2: no change.
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++++
>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 70 ++++++++++++++++++++++++++++-
>>  2 files changed, 77 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index da8512b..31221d5 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -217,11 +217,19 @@ struct hns_roce_uar {
>>  	unsigned long	logic_idx;
>>  };
>>  
>> +struct hns_roce_vma_data {
>> +	struct list_head list;
>> +	struct vm_area_struct *vma;
>> +	struct mutex *vma_list_mutex;
>> +};
> This stuff is basically shared in all the drivers too - would it make
> sense to maintain this information and do the zap_pte in the core code
> as well?
>
> There is no way to implement dis-associate without also doing the
> zaps..
>
> Jason
>
> .
Hi, Jason
    You may have noticed there are difference about the process of
zap_vmp_ptes
    between mlx4_ib_disassociate_ucontext and mlx5_ib_disassociate_ucontext
    If I hoist zap_vmp_ptes process into the core code, Maybe need to
modify more mlx4 code.
    Maybe I am not the right person to do this thing,  Could you give
more suggestion?
    Thanks   

    Regards
Wei Hu
>
