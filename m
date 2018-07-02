Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33AAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA6F25081
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HjTNHbTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA6F25081
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeGBTZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:25:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39556 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeGBTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:25:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so9760171wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tUnif5yH6Usb3sc0P6gTSL8F/AZ4ZoABmyDKr/7WYc8=;
        b=HjTNHbTsm8MB6PPpujVezpqEGLnRv2xLonbZ9GJ+8uJPd5wXgp7jsCufUnoYTTcLgG
         fY5CfmMi7iAXha6zFpV+++ny7vNsabr6LMxgQU1/HEau8vdJxKgkxOHq7y/24tfmUgFu
         iV4UL19clBXdZzRZTjjdo2XutuLE9OIDAkFBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tUnif5yH6Usb3sc0P6gTSL8F/AZ4ZoABmyDKr/7WYc8=;
        b=JsNlnAncCX4b8AzVsSmZzGHcebcQE8mjTwMmHEK0q/j66Lt3MrLVD8k84nRgD37YIs
         VZ+d+TRl+PIgQCHmnRl/xiUypfK0s8IW4W9cOn1wZOxZ57Z7EFboW5b1QvAiMBZ/7+tw
         8ZM5dQqNerM9a2uNi3IXiN/1gVYuvxEr9EAP9wOxhpYBc5Dv1SI3I63PJLEYh5aC+bMq
         5IwlOGKW2JKLTENEVUxGe8KTyQkw5E1KMv898zSzliqdBKLZ8jjPJGe8oVCutP9ItJT1
         nfpELq9TWoypFALrCb7INZyc84pjUettFcAbEzi3i/ipuxw8I8JEOmQkxB2kXObpbkFh
         TViQ==
X-Gm-Message-State: APt69E1PB0vGpYs3nPXV6f5BC50rkiBPpciNjuu3jeb4JJ3rZ7WJI4BJ
        HatVlZ+Q/Ooy4r8hqpbHuFtgk7XP+T8Hu1sbNCs06g==
X-Google-Smtp-Source: AAOMgpfZuKIZnyv/e2HmKqeQEELKegcImz8RocjnImp5kkn5GnFDbutjt+4s8i5m73azwMTPB4l0E7nNlA/e9ifEqO0=
X-Received: by 2002:a1c:1e4b:: with SMTP id e72-v6mr7968812wme.155.1530559527912;
 Mon, 02 Jul 2018 12:25:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 12:25:27 -0700 (PDT)
In-Reply-To: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com> <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 2 Jul 2018 12:25:27 -0700
Message-ID: <CALAqxLVK=EghPr=GVTKzX511XMO2NM4Ehh3pVP9QumpKRBP+rA@mail.gmail.com>
Subject: Re: hrtimer become inaccurate with RT patch
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, anna-maria@linutronix.de,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:34 AM, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Thomas/Anna/John,
>
>   Recently I found that the hrtimer become inaccurate when there is a RT
> process runs on the same cpu core, and the kernel has applied preempt_rt
> patch.
>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
> patch-4.1.46-rt52.patch.
>   I know that in the preempt_rt environment the interrupt handlers no
> longer run in interrupt context but in process context, so that RT
> process will not be interrupt. But if the hrtimer is also runs in
> process context the timer is useless when it's inaccurate. so I want to
> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
> handling to a thread?

I've not looked at the PREEMPT_RT code in a long time, but years ago
there was a tension in that there is not an easy way track ownership
of timers. Thus timers all fired at the same priority of the hrtimer
irq thread. This thread could be moved up or down in priority, but the
problem was all timers would fire with the same priority. So either
the thread priority was so high that low-priority process could
generate a bunch of timers which would interrupt higher priority
tasks, or the thread priority was lower, so a high priority task could
block all timers.

There was some handwavy talk of trying to keep per-process timer
lists, so the hrtimer irq could still be in irq context but the firing
logic it didn't do anything but mark its task as runnable and do the
the actual timer firing logic before we eventually run the task (in
proper rt priority order), in a fashion similar to signals. But I'm
not sure if any attempts were made in that direction. I also think it
was an open question if there's any logic in kernel that depend on
strict in-order kernel timer processing, so its possible there could
be odd inversion issues where high priority timer logic is waiting on
/expecting lower priority timers to fire, etc, so its probably an area
of research.

thanks
-john
