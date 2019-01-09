Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D3E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547071396;
	bh=vYfAgQMrFGb5D26bc2hZExMM5un920i4NknCWNFOC8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ca8trbG4s4zjt19oHQ+Fr97pMvDMrZmK55Q/wPiSHFLWtXghF/WLv1wJwLYZB3KQb
	 rUVGrcT9n7yL7eG3mQvc6aisSzOB9DAszor9psKcSSXOAVPnRyvW53RY3TiaYbz3lP
	 nQRs9qYIDnYk7/dK2vompZhooSWrgzNcoKVEpTn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfAIWDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:03:16 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43588 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfAIWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:03:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so8119391otr.10;
        Wed, 09 Jan 2019 14:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD8lUbgsvAgC2PXrMO7w5wwrxNUokLAV2D7ynhhr574=;
        b=CiwwG7xqXkgodko4KQGcbi6cvO1Ck14xNtC96PWsvnp3+jUthZ0xNM3I77yWNUaiSY
         igqEKwJN/q0W6Kv3rjY+xTFcwqleKPrhoESiam7o+v4/dvYVB0UzRjSzdSCt3XRlc142
         Alg+vyMW3fkEu0fR5ubibZVsMknUOo5UOgXpEf1lTXuDRyoDiXEN0N3ytHEosgSCu9En
         bcMsljAT3ZWzRljn+e+mV38GzUNMrUdSxdzLDnbSlyfhuxG1fUFrF0Jhpe3PGXalU2DX
         S6Y8e6ecYh+XUiyTYrLBU1JAOQGoKFQ5nmAezFsd7yOpgW2bBEAzdHjtTO5JF5lQ7Zy/
         ACZQ==
X-Gm-Message-State: AJcUukcCTbEGIeztXhf2a4bgmKmO5ccr2tt1gMVonO2qySH5NTZn0G73
        TpfsPBeL/GkBVYyB8pExxEXBLxp/O34k8rmNNkk=
X-Google-Smtp-Source: ALg8bN6JPkj8zPGL+hDj+gDB3JHRHqo/RX+LTAF3UuPg3qMzOmh0lPVUEdKMDE3ucPx79EAzbbYqPlAWArizfACxGeg=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr4884682otf.124.1547071394509;
 Wed, 09 Jan 2019 14:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20190109172336.GA1711@lenoch>
In-Reply-To: <20190109172336.GA1711@lenoch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jan 2019 23:03:02 +0100
Message-ID: <CAJZ5v0iZRUaAb-eiodgByZiEAe8AWxk9G2p8zHK45J-LuXgaAA@mail.gmail.com>
Subject: Re: [PATCH] PM/runtime: Fix 'jiffies' in comments after move to hrtimers
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 6:23 PM Ladislav Michl <ladis@linux-mips.org> wrote:
>
> PM-runtime now uses the hrtimers infrastructure for autosuspend, however
> comments still reference 'jiffies'.
>
> Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 70624695b6d5..096f7996d914 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -121,7 +121,7 @@ static void pm_runtime_cancel_pending(struct device *dev)
>   * Compute the autosuspend-delay expiration time based on the device's
>   * power.last_busy time.  If the delay has already expired or is disabled
>   * (negative) or the power.use_autosuspend flag isn't set, return 0.
> - * Otherwise return the expiration time in jiffies (adjusted to be nonzero).
> + * Otherwise return the expiration time in nanoseconds (adjusted to be nonzero).
>   *
>   * This function may be called either with or without dev->power.lock held.
>   * Either way it can be racy, since power.last_busy may be updated at any time.
> @@ -905,7 +905,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
>         spin_lock_irqsave(&dev->power.lock, flags);
>
>         expires = dev->power.timer_expires;
> -       /* If 'expire' is after 'jiffies' we've been called too early. */
> +       /* If 'timer_expires' after 'now' we've been called too early. */

I would say "If 'expires' is after the current time, we've been called
to early" here.

>         if (expires > 0 && expires < ktime_to_ns(ktime_get())) {
>                 dev->power.timer_expires = 0;
>                 rpm_suspend(dev, dev->power.timer_autosuspends ?
> --
> 2.20.1
