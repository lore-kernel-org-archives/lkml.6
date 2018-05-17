Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEQOvC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:51:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752627AbeEQOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:50:59 -0400
Subject: Re: [PATCH V2] nvme-rdma: fix double free in nvme_rdma_free_queue
To: Max Gurtovoy <maxg@mellanox.com>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
 <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <fcfa5a80-83db-c5bf-a46d-c53629a3c9db@oracle.com>
Date: Thu, 17 May 2018 22:50:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=784
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max

Thanks for kindly review and suggestion for this.

On 05/16/2018 08:18 PM, Max Gurtovoy wrote:
> I don't know exactly what Christoph meant but IMO the best place to allocate it is in nvme_rdma_alloc_queue just before calling
> 
> "set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);"
> 
> then you will never get to double free since we clear the NVME_RDMA_Q_ALLOCATED bit in the beginning of nvme_rdma_free_queue.

Yes, I will investigate the whether there is some special reason for async_event_sqe is not allocated in nvme_rdma_alloc_queue next.

Thanks
Jianchao
