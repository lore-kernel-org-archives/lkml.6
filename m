Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B668204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v8cEvOCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B668204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbeKAVZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:25:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43223 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeKAVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:25:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so8948191pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2JfG/OVadBHur99ai6SqguXMYy+g5t8X4+mpHRvDL8A=;
        b=v8cEvOCKI7gk9xF6ijuFoeuTT+7xByhIHqdnhVLmUrXVSvZoSL0MkwVt+fPVVRv9Cc
         Pil7MUDJTlB9r5GTjmlLr7BQ61yHn5JWhw+Q9HrJuXxD41tfnl3VX7Moj8GMAkPaAI4g
         c+PcP2qBHgPjOocEGpQR6KLK2DFkma5N3XhpUq3K4x23IEBbDVP5dQgiHaq43xWOTN8V
         V5+mN7398ffeqYTXW6/ahrW6lhgWvTtP2zS73q3dK/YCrmAwQzuxePBerhQdMqzGUDYO
         ZSnxoNhdcOBRrgWzxmrvkZBw/fYWYzwF2S4nhtrQqaYZWjUn5EksZ+DOKWwijIEPXYkF
         5Lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2JfG/OVadBHur99ai6SqguXMYy+g5t8X4+mpHRvDL8A=;
        b=fsj3F3W8wzJ+an+yqzavAA90vT0fbkV/7oFiZqX1kj+qasgleo8ligepCsQNomkE0h
         O947VEKMQo/5Op3tmR6PbxhCMrMvxJrQ/AG2QlQPxu8TSwxNV2lEmCDHni2lEBWSxWYB
         0EVxGL0S56aSykaACunrmGh1UcBnAA/MSaW5rdvcP8IniLSpGl9JzWzA2kpH44rhVKli
         fgr5hfeQhJQ6kuWn4hvzEud1N/j2z1aBSdXCwc1VveKm5XDs2S/8dU4ZBqohSJiVH5NI
         J58gZhBPlcItS00qweAp3TezsHCRm9mFwBWnX93bRQDLahAtRkLJUM5Pr2/3KKJoDuRi
         l9Cg==
X-Gm-Message-State: AGRZ1gJnwJX6a3bcC7n/sbArchP656N/cQRRW+ECAMlylaBBuhIQ8t+v
        n6UhaSBCY7SiXbSgPkHOLmXj1W2kyvY=
X-Google-Smtp-Source: AJdET5cwY6Rv46iyH1axFTRP/bz3EWQA0kYsnXW3+AONK4/2aZzhJC85+fcE3tfIEaVYitROC0S57A==
X-Received: by 2002:a63:9712:: with SMTP id n18mr6897486pge.295.1541074937275;
        Thu, 01 Nov 2018 05:22:17 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p11-v6sm33895195pfo.65.2018.11.01.05.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:22:16 -0700 (PDT)
Subject: Re: [PATCH 09/16] blk-mq: cache request hardware queue mapping
To:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-10-axboe@kernel.dk>
 <222351ec-bf5b-526c-33dd-bd2e8ba051fa@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a12d8c2-cb16-168c-f8e2-ffe1649d6554@kernel.dk>
Date:   Thu, 1 Nov 2018 06:22:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <222351ec-bf5b-526c-33dd-bd2e8ba051fa@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/18 3:27 AM, Hannes Reinecke wrote:
> On 10/30/18 7:32 PM, Jens Axboe wrote:
>> We call blk_mq_map_queue() a lot, at least two times for each
>> request per IO, sometimes more. Since we now have an indirect
>> call as well in that function. cache the mapping so we don't
>> have to re-call blk_mq_map_queue() for the same request
>> multiple times.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   block/blk-flush.c      | 12 ++++--------
>>   block/blk-mq-debugfs.c |  4 +---
>>   block/blk-mq-sched.c   |  6 ++----
>>   block/blk-mq-tag.c     |  9 +--------
>>   block/blk-mq.c         | 22 +++++++++-------------
>>   block/blk-mq.h         |  5 +----
>>   include/linux/blkdev.h |  1 +
>>   7 files changed, 19 insertions(+), 40 deletions(-)
>>
> Hehe.
> I had been wondering about this since the original mq implementation, 
> but was told not to worry :-)

To be fair, it was just an array index. Now it's got an indirect
call, so it's more expensive.
 > Reviewed-by: Hannes Reinecke <hare@suse.com>

Thanks!

-- 
Jens Axboe

