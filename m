Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeC0HPF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:15:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750907AbeC0HPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:15:03 -0400
Subject: Re: [PATCH] RDMA/hns: ensure for-loop actually iterates and free's
 buffers
To: Colin King <colin.king@canonical.com>, Lijun Ou <oulijun@huawei.com>,
        "Wei Hu" <xavier.huwei@huawei.com>, Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180326151018.21066-1-colin.king@canonical.com>
From: "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <ed57c631-94ec-82ad-8621-12f36bb017e1@huawei.com>
Date: Tue, 27 Mar 2018 15:14:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180326151018.21066-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/3/26 23:10, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current for-loop zeros variable i and only loops once, hence
> not all the buffers are free'd.  Fix this by setting i correctly.

Hi Colin,

Thank you very much for this patch! It's a typo when I prepared the patch set.

Reviewed-by: Yixian Liu <liuyixian@huawei.com>

> 
> Detected by CoverityScan, CID#1463415 ("Operands don't affect result")
> 
> Fixes: a5073d6054f7 ("RDMA/hns: Add eq support of hip08")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 684c2d1a0ed0..8b84ab7800d8 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4391,7 +4391,7 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
>  	eq->l0_dma = 0;
>  
>  	if (mhop_num == 1)
> -		for (i -= i; i >= 0; i--)
> +		for (i -= 1; i >= 0; i--)
>  			dma_free_coherent(dev, buf_chk_sz, eq->buf[i],
>  					  eq->buf_dma[i]);
>  	else if (mhop_num == 2) {
> 
