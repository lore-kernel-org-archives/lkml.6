Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeE3Qs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:48:56 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:40556 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeE3Qsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:48:54 -0400
X-Google-Smtp-Source: ADUXVKJDHcsoMxLKkohMMivshrr7UK568CApmv/+3jRQhPTDfWDIhd45nLbGRO7kePoCEaVAcyvJtw==
Subject: Re: [PATCH V3 0/2] block: kyber: make kyber more friendly with
 merging
To: Jianchao Wang <jianchao.w.wang@oracle.com>, osandov@osandov.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527665168-1965-1-git-send-email-jianchao.w.wang@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3f44d1dc-6b81-9f51-9e2d-68f1faba1684@kernel.dk>
Date: Wed, 30 May 2018 10:48:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1527665168-1965-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/18 1:26 AM, Jianchao Wang wrote:
> Hi Jens
> 
> This is the 3rd version patchset to make the kyber io scheduler more firendly
> with merging.
> 
> Most of time, kyber io scheduler will not leave any requests in ctx rq_list,
> this is because even if tokens of one domain is used up, kyber will try to
> dispatch requests from other domain and flush the rq_list there. So there is not
> any change to do merge.
> 
> To improve this, setup kyber_ctx_queue (kcq) which is similar with blk_mq_ctx but has
> rq_list for every domain, and build mapping between kcq and khd as ctx and hctx.
> Then we could merge, insert and dispatch on rq_list of different domains separately.
> At the same time, only flush the rq_list of kcq after get domain token
> successfully, then the requests could be left in the rq_list of that domain and 
> maybe merged with following io. In my local test on NVMe card, the sequential io
> performance could be improved a lot, especially on high workload. More details
> please refer to the second patch.

Great work, thanks Jianchao - applied for 4.18.

-- 
Jens Axboe
