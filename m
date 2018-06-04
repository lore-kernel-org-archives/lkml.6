Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeFDKnp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:43:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751168AbeFDKno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:43:44 -0400
Date: Mon, 4 Jun 2018 18:43:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
Message-ID: <20180604104327.GA23074@ming.t460p>
References: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 05:03:55PM +0800, Jianchao Wang wrote:
> if hctx is stopped, don't run the queue in blk_mq_run_work_fn.
> 
> Fixes: 15fe8a9 (blk-mq: remove blk_mq_delay_queue())
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 9ce9cac..d0ee928 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1578,7 +1578,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
>  	 * If we are stopped, don't run the queue.
>  	 */
>  	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
> -		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
> +		return;
>  
>  	__blk_mq_run_hw_queue(hctx);
>  }
> -- 
> 2.7.4
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
