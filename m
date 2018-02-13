Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934670AbeBMQMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:12:23 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:32875 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934056AbeBMQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:12:22 -0500
X-Google-Smtp-Source: AH8x224vdfr3V7MwuQ+C7zlZpxj/RfzfCarHPdcsM42XvdKpMDATosJ34ZLusFrUbwFBRdRIjFZE8Q==
Subject: Re: [PATCH v3] blk: optimization for classic polling
To: Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, linux-nvme@lists.infradead.org, joshi.k@samsung.com
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7@epcas1p3.samsung.com>
 <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f797a075-4ef2-410f-4eda-fa70d426d58f@kernel.dk>
Date: Tue, 13 Feb 2018 09:12:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/18 8:48 AM, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

Thanks, applied.

-- 
Jens Axboe
