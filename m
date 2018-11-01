Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735CFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCAD20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCAD20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeKAS3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:29:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:50082 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbeKAS3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:29:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64601AF6A;
        Thu,  1 Nov 2018 09:27:18 +0000 (UTC)
Subject: Re: [PATCH 09/16] blk-mq: cache request hardware queue mapping
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-10-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <222351ec-bf5b-526c-33dd-bd2e8ba051fa@suse.de>
Date:   Thu, 1 Nov 2018 10:27:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030183252.17857-10-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 7:32 PM, Jens Axboe wrote:
> We call blk_mq_map_queue() a lot, at least two times for each
> request per IO, sometimes more. Since we now have an indirect
> call as well in that function. cache the mapping so we don't
> have to re-call blk_mq_map_queue() for the same request
> multiple times.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-flush.c      | 12 ++++--------
>   block/blk-mq-debugfs.c |  4 +---
>   block/blk-mq-sched.c   |  6 ++----
>   block/blk-mq-tag.c     |  9 +--------
>   block/blk-mq.c         | 22 +++++++++-------------
>   block/blk-mq.h         |  5 +----
>   include/linux/blkdev.h |  1 +
>   7 files changed, 19 insertions(+), 40 deletions(-)
> 
Hehe.
I had been wondering about this since the original mq implementation, 
but was told not to worry :-)

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


