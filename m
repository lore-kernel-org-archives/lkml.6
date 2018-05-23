Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeEWGiT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:38:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753902AbeEWGiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:38:18 -0400
Subject: Re: [PATCH rdma-next 5/5] RDMA/hns: Fix the illegal memory operation
 when cross page
To: Leon Romanovsky <leon@kernel.org>
References: <1526544173-106587-1-git-send-email-xavier.huwei@huawei.com>
 <1526544173-106587-6-git-send-email-xavier.huwei@huawei.com>
 <20180523061706.GA5729@mtr-leonro.mtl.com>
CC: <dledford@redhat.com>, <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xavier.huwei@tom.com>,
        <lijun_nudt@163.com>
From: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Message-ID: <5B050C4A.8090307@huawei.com>
Date: Wed, 23 May 2018 14:38:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180523061706.GA5729@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.115.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/23 14:17, Leon Romanovsky wrote:
> On Thu, May 17, 2018 at 04:02:53PM +0800, Wei Hu (Xavier) wrote:
>> This patch fixed the potential illegal operation when using the
>> extend sge buffer cross page in post send operation. The bug
>> will cause the calltrace.
>>
>> Reported-by: Jie Chen <chenjie103@huawei.com>
>> Reported-by: Xiping Zhang (Francis) <zhangxiping3@huawei.com>
>> Fixes: b1c1583("RDMA/hns: Get rid of virt_to_page and vmap calls after dma_alloc_coherent")
> Documentation/process/submitting-patches.rst
> 183 If your patch fixes a bug in a specific commit, e.g. you found an issue using
> 184 ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> 185 the SHA-1 ID, and the one line summary.  For example::
> 186
> 187         Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
>
> Thanks
Thanks, Leon
    Got it. We will fix it in v2.
Wei Hu
>> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
