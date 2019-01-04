Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C90C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB3218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 21:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmPjhki0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfADVC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 16:02:26 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45358 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfADVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 16:02:26 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so26290154lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9jvpOX6TG4VMH72TiP/TwjBS3vyqyVbxfJQtyqsZ8M=;
        b=lmPjhki0E1SIzG9vI4l5Yn/KJcjz02X2cSF9fh/vtWIO9h7mgWJpPdWT36sif9j6F/
         /c8x7T6AQviVGtStu1sjFNP+dSQ5h48bbWplcFYxSbeHTChqIBh9oB9bk6ATvmgdMgvn
         NE9mIWdYoMRxDsuUnTDm46pe0rAmnCm4AHBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9jvpOX6TG4VMH72TiP/TwjBS3vyqyVbxfJQtyqsZ8M=;
        b=PZJyExuK4v/E6X8wk1KhmFwUbT4a/ibOzoTvUHZyuPlwMCX0N6Jm1yR3XiKV+hNh2b
         Xe7MCjae8/LTZ1GntzGywayoydlDdZFLccgobwR8V5yMDPxvdJPy+Jn0K8lJfYA2rc4V
         HHvTlWCivCIlIVhH8ljNOZVxJLM18YupfpYsJcFzCI8lQkrJU5EZHjBbiE+FdETYkxiB
         rKv2+hdHCAU/ibkapvxDGqiNJl3u06zZDIWp5N3xsGX1ooj64YfSY+nSPNEDnhCmm64v
         NrJ88oVhnmxem9JnZ3CybyEtTEF/67/CZdF2mYpndQGqbMgFw51uECT5fDeNC/zj0lBC
         K+nQ==
X-Gm-Message-State: AA+aEWa222ebxxY0zoZN49nUlkUfI/0yFyBvMimkV3PSgPhOSWGaalgL
        poLFNH6AXXQkd4ytKpzaYGLuGJpBrjY=
X-Google-Smtp-Source: AFSGD/UXtyHSjQdOxS/DKIKswdE9QQSxIrO8HiHdXxYmVIsl7eR1mAqtHNG/zcQPObwIhBdwGl2pzg==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr27719791lfe.45.1546635742827;
        Fri, 04 Jan 2019 13:02:22 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id h22-v6sm12505140ljg.24.2019.01.04.13.02.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 13:02:21 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id v1-v6so33531928ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 13:02:21 -0800 (PST)
X-Received: by 2002:a2e:9d17:: with SMTP id t23-v6mr29234181lji.57.1546635741201;
 Fri, 04 Jan 2019 13:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20190103174657.251968-1-swboyd@chromium.org>
In-Reply-To: <20190103174657.251968-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 4 Jan 2019 13:01:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com>
Message-ID: <CAE=gft6M7aaPjS0KRg7dyfLOGtgXdU1qaT7oNeRHeNFQpRouWA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh: Avoid accessing freed memory from batch API
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lina Iyer <ilina@codeaurora.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 9:47 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Using the batch API from the interconnect driver sometimes leads to a
> KASAN error due to an access to freed memory. This is easier to trigger
> with threadirqs on the kernel commandline.
>
>  BUG: KASAN: use-after-free in rpmh_tx_done+0x114/0x12c
>  Read of size 1 at addr fffffff51414ad84 by task irq/110-apps_rs/57
>
>  CPU: 0 PID: 57 Comm: irq/110-apps_rs Tainted: G        W         4.19.10 #72
>  Call trace:
>   dump_backtrace+0x0/0x2f8
>   show_stack+0x20/0x2c
>   __dump_stack+0x20/0x28
>   dump_stack+0xcc/0x10c
>   print_address_description+0x74/0x240
>   kasan_report+0x250/0x26c
>   __asan_report_load1_noabort+0x20/0x2c
>   rpmh_tx_done+0x114/0x12c
>   tcs_tx_done+0x450/0x768
>   irq_forced_thread_fn+0x58/0x9c
>   irq_thread+0x120/0x1dc
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  Allocated by task 385:
>   kasan_kmalloc+0xac/0x148
>   __kmalloc+0x170/0x1e4
>   rpmh_write_batch+0x174/0x540
>   qcom_icc_set+0x8dc/0x9ac
>   icc_set+0x288/0x2e8
>   a6xx_gmu_stop+0x320/0x3c0
>   a6xx_pm_suspend+0x108/0x124
>   adreno_suspend+0x50/0x60
>   pm_generic_runtime_suspend+0x60/0x78
>   __rpm_callback+0x214/0x32c
>   rpm_callback+0x54/0x184
>   rpm_suspend+0x3f8/0xa90
>   pm_runtime_work+0xb4/0x178
>   process_one_work+0x544/0xbc0
>   worker_thread+0x514/0x7d0
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  Freed by task 385:
>   __kasan_slab_free+0x12c/0x1e0
>   kasan_slab_free+0x10/0x1c
>   kfree+0x134/0x588
>   rpmh_write_batch+0x49c/0x540
>   qcom_icc_set+0x8dc/0x9ac
>   icc_set+0x288/0x2e8
>   a6xx_gmu_stop+0x320/0x3c0
>   a6xx_pm_suspend+0x108/0x124
>   adreno_suspend+0x50/0x60
>  cr50_spi spi5.0: SPI transfer timed out
>   pm_generic_runtime_suspend+0x60/0x78
>   __rpm_callback+0x214/0x32c
>   rpm_callback+0x54/0x184
>   rpm_suspend+0x3f8/0xa90
>   pm_runtime_work+0xb4/0x178
>   process_one_work+0x544/0xbc0
>   worker_thread+0x514/0x7d0
>   kthread+0x248/0x260
>   ret_from_fork+0x10/0x18
>
>  The buggy address belongs to the object at fffffff51414ac80
>   which belongs to the cache kmalloc-512 of size 512
>  The buggy address is located 260 bytes inside of
>   512-byte region [fffffff51414ac80, fffffff51414ae80)
>  The buggy address belongs to the page:
>  page:ffffffbfd4505200 count:1 mapcount:0 mapping:fffffff51e00c680 index:0x0 compound_mapcount: 0
>  flags: 0x4000000000008100(slab|head)
>  raw: 4000000000008100 ffffffbfd4529008 ffffffbfd44f9208 fffffff51e00c680
>  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
>
>  Memory state around the buggy address:
>   fffffff51414ac80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   fffffff51414ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >fffffff51414ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   fffffff51414ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   fffffff51414ae80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> The batch API sets the same completion for each rpmh message that's sent
> and then loops through all the messages and waits for that single
> completion declared on the stack to be completed before returning from
> the function and freeing the message structures. Unfortunately, some
> messages may still be in process and 'stuck' in the TCS. At some later
> point, the tcs_tx_done() interrupt will run and try to process messages
> that have already been freed at the end of rpmh_write_batch(). This will
> in turn access the 'needs_free' member of the rpmh_request structure and
> cause KASAN to complain.
>
> Let's fix this by allocating a chunk of completions for each message and
> waiting for all of them to be completed before returning from the batch
> API. Alternatively, we could wait for the last message in the batch, but
> that may be a more complicated change because it looks like
> tcs_tx_done() just iterates through the indices of the queue and
> completes each message instead of tracking the last inserted message and
> completing that first.
>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Fixes: c8790cb6da58 ("drivers: qcom: rpmh: add support for batch RPMH request")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c7beb6841289..3b3e8b0b2d95 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -348,11 +348,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>  {
>         struct batch_cache_req *req;
>         struct rpmh_request *rpm_msgs;
> -       DECLARE_COMPLETION_ONSTACK(compl);
> +       struct completion *compls;
>         struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>         unsigned long time_left;
>         int count = 0;
>         int ret, i, j;
> +       void *ptr;
>
>         if (!cmd || !n)
>                 return -EINVAL;
> @@ -362,10 +363,15 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>         if (!count)
>                 return -EINVAL;
>
> -       req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
> +       ptr = kzalloc(sizeof(*req) +
> +                     count * (sizeof(req->rpm_msgs[0]) + sizeof(*compls)),
>                       GFP_ATOMIC);
> -       if (!req)
> +       if (!ptr)
>                 return -ENOMEM;
> +
> +       req = ptr;
> +       compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
> +
>         req->count = count;
>         rpm_msgs = req->rpm_msgs;
>
> @@ -380,7 +386,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>         }
>
>         for (i = 0; i < count; i++) {
> -               rpm_msgs[i].completion = &compl;
> +               struct completion *compl = &compls[i];
> +
> +               init_completion(compl);
> +               rpm_msgs[i].completion = compl;
>                 ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msgs[i].msg);
>                 if (ret) {
>                         pr_err("Error(%d) sending RPMH message addr=%#x\n",

It's a little weird that we call rpmh_tx_done on a bunch of transfers
we never submitted, just so the completion will get signaled so we can
wait on it in the next loop. We could just do count = i; break; here
instead.

> @@ -393,12 +402,12 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>
>         time_left = RPMH_TIMEOUT_MS;
>         for (i = 0; i < count; i++) {
> -               time_left = wait_for_completion_timeout(&compl, time_left);
> +               time_left = wait_for_completion_timeout(&compls[i], time_left);

So we give RPMH_TIMEOUT_MS for all the completions to finish. I wonder
if it would be better to have that as RPMH_TIMEOUT_MS per completion.

-Evan
