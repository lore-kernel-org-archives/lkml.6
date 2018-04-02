Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeDBVKw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:10:52 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38919 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbeDBVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:10:50 -0400
X-Google-Smtp-Source: AIpwx4+KcJu7SZ5dBlO4jWMVeIg5k1b0nTuLw8/zXb9L98y1e925lS4GO/eEWS6yXUW1qRx6p1BnYg==
Date: Mon, 2 Apr 2018 14:10:47 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Message-ID: <20180402211047.GF388343@devbig577.frc2.facebook.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
 <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 02:08:37PM -0700, Bart Van Assche wrote:
> On 04/02/18 12:01, Tejun Heo wrote:
> >+	 * As nothing prevents from completion happening while
> >+	 * ->aborted_gstate is set, this may lead to ignored completions
> >+	 * and further spurious timeouts.
> >+	 */
> >+	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> >+		blk_mq_rq_update_aborted_gstate(rq, 0);
> 
> Hello Tejun,
> 
> Since this patch fixes one race but introduces another race, is this
> patch really an improvement?

Oh, that's not a new race.  That's the same non-critical race which
always existed.  It's just being documented.

Thanks.

-- 
tejun
