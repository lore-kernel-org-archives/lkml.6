Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965080AbeBMOm0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:42:26 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:43642 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935370AbeBMOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:42:24 -0500
X-Google-Smtp-Source: AH8x224TNGYhfhwwWmiU64cLULT0WNO+xlrusPPTKLYIV9A+nYXQLTP90LSbTvkhEo/WNDm9pszkcg==
Subject: Re: [PATCH v2 RESENT] blk: optimization for classic polling
To: Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6@epcas1p4.samsung.com>
 <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <620867e2-2a0c-5c32-10c6-7cc5268ac944@kernel.dk>
Date: Tue, 13 Feb 2018 07:42:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/18 11:56 AM, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

__set_current_state() should suffice here.

-- 
Jens Axboe
