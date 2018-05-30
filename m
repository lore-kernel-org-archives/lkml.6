Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968815AbeE3JUG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:20:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965167AbeE3JUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:20:03 -0400
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
 <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
 <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
 <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
Date: Wed, 30 May 2018 17:20:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=502
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ming

On 05/30/2018 05:13 PM, Ming Lei wrote:
>> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
>> lists, and not need to iterate the whole rq_list any more.
>> But what's about the dispatch when there is no io scheduler.
> blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
> fine in case of 'none' if per-domain list is added to ctx. Then we can make
> none to be a bit fair on READ/WRITE.
> 

But how to determine when to dispatch READ, WRITE or other more, when there is no io scheduler ?

Thanks
Jianchao
