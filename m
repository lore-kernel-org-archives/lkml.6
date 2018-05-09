Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeEIEHw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:07:52 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52609 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeEIEHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:07:50 -0400
X-Google-Smtp-Source: AB8JxZqpTqbJIE8wC2rX7CX8Mt1FYbABmYqMgM7pnDvp2EG0jDGYx+fSu7dRtPo5OlH6sWugScgls8XDsy6fd83gvPw=
MIME-Version: 1.0
References: <20180503095326.7414-1-sj38.park@gmail.com>
In-Reply-To: <20180503095326.7414-1-sj38.park@gmail.com>
From: SeongJae Park <sj38.park@gmail.com>
Date: Wed, 09 May 2018 04:07:24 +0000
Message-ID: <CAEjAshryoCKbsmdBiB3GMza1LsH_0muREq2Qz4mpbXk4PSaBSg@mail.gmail.com>
Subject: Re: [PATCH] brd: Mark as non-rotational
To: axboe@kernel.dk, dan.j.williams@intel.com, mpatocka@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sending this mail for another chance of review.


Thanks,
SeongJae Park
On Thu, May 3, 2018 at 6:53 PM SeongJae Park <sj38.park@gmail.com> wrote:

> This commit sets QUEUE_FLAG_NONROT and clears up QUEUE_FLAG_ADD_RANDOM
> to mark the ramdisks as non-rotational device.

> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> ---
>   drivers/block/brd.c | 4 ++++
>   1 file changed, 4 insertions(+)

> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 66cb0f857f64..39c5b90cc187 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -402,6 +402,10 @@ static struct brd_device *brd_alloc(int i)
>          set_capacity(disk, rd_size * 2);
>          disk->queue->backing_dev_info->capabilities |=
BDI_CAP_SYNCHRONOUS_IO;

> +       /* Tell the block layer that this is not a rotational device */
> +       blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> +       blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
> +
>          return brd;

>   out_free_queue:
> --
> 2.13.0
