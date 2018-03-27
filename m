Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeC0OBd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:01:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752665AbeC0OBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:01:32 -0400
Subject: Re: 4.16-RC7 WARNING: CPU: 2 PID: 0 at block/blk-mq.c:1400
 __blk_mq_delay_run_hw_queue
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <96392d4b-f890-7b34-8f1e-8d51855327cc@linux.vnet.ibm.com>
 <20180327120143.GA20265@ming.t460p>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 16:01:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327120143.GA20265@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-TM-AS-GCONF: 00
x-cbid: 18032714-0012-0000-0000-000005C3D0DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032714-0013-0000-0000-000019400BE7
Message-Id: <c3c647d0-d44f-9711-de93-2b1453f0eeb5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This warning is harmless, please try the following patch:
>
> --
>  From 7b2b5139bfef80f44d1b1424e09ab35b715fbfdb Mon Sep 17 00:00:00 2001
> From: Ming Lei <ming.lei@redhat.com>
> Date: Tue, 27 Mar 2018 19:54:23 +0800
> Subject: [PATCH] blk-mq: only run mapped hw queues in blk_mq_run_hw_queues()
>
>  From commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule
> with each possisble CPU") on, it should be easier to see unmapped hctx
> in some CPU topo, such as, hctx may not be mapped to any CPU.
>
> This patch avoids the warning in __blk_mq_delay_run_hw_queue() by
> checking if the hctx is mapped in blk_mq_run_hw_queues().
>
> Reported-by: Stefan Haberland <sth@linux.vnet.ibm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---

Hi Ming,

thanks a lot for the patch. I tried it on top of our 4.16-rc7 branch and 
it works well.
I ran a small regression test set against it and I did not notice any 
warnings or other obvious impacts.

Regards,
Stefan
