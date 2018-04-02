Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeDBVIj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:08:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40966 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeDBVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:08:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="75770677"
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
 <20180402190120.GD388343@devbig577.frc2.facebook.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
Date: Mon, 2 Apr 2018 14:08:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402190120.GD388343@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/18 12:01, Tejun Heo wrote:
> +	 * As nothing prevents from completion happening while
> +	 * ->aborted_gstate is set, this may lead to ignored completions
> +	 * and further spurious timeouts.
> +	 */
> +	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> +		blk_mq_rq_update_aborted_gstate(rq, 0);

Hello Tejun,

Since this patch fixes one race but introduces another race, is this 
patch really an improvement?

Thanks,

Bart.
