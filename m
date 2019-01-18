Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5AC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568D20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UytB8Qkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfARSQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:16:03 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44245 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfARSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:16:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so11140628lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbuMDh62Bl9UBEecI/smNrqHrt5PFEqkU025XFrUPsY=;
        b=UytB8Qkhfyc5ejZsvOG4ji99JmSuWKM2iw1N90zLPptzQqOOec1c1WgxFTU3qoTXkC
         VyXsre9HvWgafZKsXkRl5gS3DiFiWISu9siocB5/xHCeZLfUOo2SeKk0VLfJxeEzM7m8
         XJGnRDN7t6QGGF/lRWu4iAeHZ3+vowO8wSwEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbuMDh62Bl9UBEecI/smNrqHrt5PFEqkU025XFrUPsY=;
        b=fZEj/ZPRfBGzhda970jDh/Jqqjvesq/8zc3j8i5NBxgieku+A01Fg6O6G3lxkwXDOT
         CWdYx2avrlAeBn5EYk0lCzuydwfwUtT93WGe+qZHxSqGq5FF6c8bMYYISv0brPV9d6fA
         953vTNwNgT8x5D7Ap3Dak3cFJ/mahCb3hnMcnmdSyxbuPptM20d6Q1rSMfZknDxb6jpt
         zbpSE2BFYSNaLKOr+BFC7hbc2NVVBW83Iwi6TG6JJ5xfLQGlGHfjz0qFMXF10eebn9Kc
         DxpJ70ygUBslHdmLJ6oP8ckoXDxprosVYpcfJNqxHE8j1uvyCFerapKZ+KHducoPpBYq
         iIbg==
X-Gm-Message-State: AJcUukeeZG1bRiL68ntfUGat8h/FljM44N5iW0MEQT12eGczpPGnrY0h
        Ltpe5V4yZYC4FV+Z0hG+nIfaA0+1Uzw=
X-Google-Smtp-Source: ALg8bN5LVdnuxgvHluAeTyh3UhmRwhmsPkqJUi2luz7/bRtLAsEW7A/lCc1PIgvJJ7lFONN7WT9ysw==
X-Received: by 2002:a19:2906:: with SMTP id p6mr12962498lfp.17.1547835359722;
        Fri, 18 Jan 2019 10:15:59 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 4-v6sm836512ljw.84.2019.01.18.10.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:15:58 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l10so11144698lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:15:58 -0800 (PST)
X-Received: by 2002:a19:1f54:: with SMTP id f81mr12979411lff.153.1547835358395;
 Fri, 18 Jan 2019 10:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20190115225447.75212-1-swboyd@chromium.org>
In-Reply-To: <20190115225447.75212-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 18 Jan 2019 10:15:21 -0800
X-Gmail-Original-Message-ID: <CAE=gft6wHBzN6BK40vcRODGebRmozpOvSk_QHccJms_kLRP8wQ@mail.gmail.com>
Message-ID: <CAE=gft6wHBzN6BK40vcRODGebRmozpOvSk_QHccJms_kLRP8wQ@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: rpmh: Avoid accessing freed memory from
 batch API
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lina Iyer <ilina@codeaurora.org>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 2:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
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
> cause KASAN to complain. Furthermore, if there's a message that's
> completed in rpmh_tx_done() and freed immediately after the complete()
> call is made we'll be racing with potentially freed memory when
> accessing the 'needs_free' member:
>
>         CPU0                         CPU1
>         ----                         ----
>         rpmh_tx_done()
>          complete(&compl)
>                                      wait_for_completion(&compl)
>                                      kfree(rpm_msg)
>          if (rpm_msg->needs_free)
>          <KASAN warning splat>
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
>
> Changes from v1:
>  * Incorporated needs_free check earlier
>  * Simplified logic to no longer flush everything out on failure
>
>  drivers/soc/qcom/rpmh.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
