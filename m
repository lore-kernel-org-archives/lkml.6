Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757085AbeDZUC7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:02:59 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37245 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeDZUCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:02:03 -0400
X-Google-Smtp-Source: AIpwx4/3uHePUjCu54q/4odq3lT5CBIWXKpLDVJM6iyGsIBGqzMaXun9m1HR10WOXjHt6cobf6LmNw==
Subject: Re: [PATCH] nvme: change order of qid and cmdid in completion trace
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <20180426194926.18767-1-jthumshirn@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3e927f7f-fa84-1792-b80e-bf5679e71bcf@kernel.dk>
Date: Thu, 26 Apr 2018 14:01:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180426194926.18767-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/18 1:49 PM, Johannes Thumshirn wrote:
> Keith reported that command submission and command completion
> tracepoints have the order of the cmdid and qid fileds swapped.
> 
> While it isn't easily possible to change the command submission
> tracepoint, as there is a regression test parsing it in blktests we
> can swap the command completion tracepoint to have the fileds aligned.

It also makes more sense to have qid before cmdid.

Also, fileds -> fields, in two spots.

With that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
