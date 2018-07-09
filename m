Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B797F208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jDDTb62A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B797F208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeGISYO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:24:14 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42658 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeGISYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:24:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so37669728oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Dh+yt+GRmGrJg31FUlRV08rnkbDffD9W2Nni5tmYHs=;
        b=jDDTb62AC2H8w/2U9+F6pFrj/qgu0ctMZpEgy+uWRtFE2nYT5ZWA0mbdFIEE+TEYOm
         W4loaHUzMOFR4Y0LxtU1WQlgte8fUo3NogOxKbu3XTafKq5SQHXWqXS9DHiFM/ZCjSOO
         l5oDRAzQ0LxP6U3BwuVJwByczlG2eLHs4G+2c+CPYuszaYOu9HzHU+Hfu2xeS0UOk5Ww
         2GuM0eYuH8msBh+4s/ubbg9pm/qfcLZmOkSJbWBt5EpYisrh7DU9LvKAvchN1UOjpJmV
         dv0IZdyHkHIO+HKcZL2xDG3dTuEp6Et1WXWUhnHpaGZ/qhy/gQ88VZVKmYay5AYyw0XZ
         PIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Dh+yt+GRmGrJg31FUlRV08rnkbDffD9W2Nni5tmYHs=;
        b=VwVB7XGR4hDoBI06T7XLdoSwcXdm3tGPb11oQjb9sCMhPpVN1ZICEIHf/9RxSuHP4a
         IXtAcPUXKVfe5WjR0kDCNBd6d87ypSYEHI/X36U4PgEDnMLDJK2GvwnLc4vEB3nKguey
         1zhxaXdGRPN0ZCyigwG0CE8jr2HI9cNovVd5CG34obR8PUYeZ0aCd3amwIz1uj10PWuc
         ng8SqFwenfkP1PPy7zACG3xuc9Bq2PHPHLceCC65QAXAYGkvZxP894ncQO0uVHUdDIYN
         uK7QBBKaH34kzMuevmigNZxyrldYA8Cx8jQdfj6qqdjRGX0K0a9fufLkkslmAvoKWaN2
         cgxw==
X-Gm-Message-State: APt69E1DcWqVy7SzCO//5m5+TFmUiSGO1PjAbM6VBcPVAsaG8zUb5Oud
        6ll8RBElzemUdSOVORRYM8Wcng8AK3irEtvs9vwYRA==
X-Google-Smtp-Source: AAOMgpcGoW90/6qzsGuIkjoyOfCk0N823zmYwgZjFAaKvTxrRtywF4FCu0W73hokx1dgEplmag6vIYvdTSkqOC5Na0g=
X-Received: by 2002:aca:6a86:: with SMTP id f128-v6mr22795466oic.330.1531160652977;
 Mon, 09 Jul 2018 11:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 9 Jul 2018 11:24:01 -0700
Message-ID: <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "tick: Prefer a lower rating device only if
 it's CPU local device"
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.
>
> The original issue was not because of incorrect checking of cpumask for
> both new and old tick device. It was incorrectly analysed was due to the
> misunderstanding of the comment and misinterpretation of the return
> value from tick_check_preferred. The main issue is with the clockevent
> driver that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

And verified to fix a regression on the 32-bit ARM platform mesion8b-odroidc1.

Thanks,

Kevin


> ---
>  kernel/time/tick-common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Hi Thomas,
>
> As mentioned in the other thread, this needs to be reverted. Sorry for
> the misunderstanding the original issue and producing wrong fix.
>
> Regards,
> Sudeep
>
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index b7005dd21ec1..14de3727b18e 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -277,8 +277,7 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
>          */
>         return !curdev ||
>                 newdev->rating > curdev->rating ||
> -              (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
> -               !tick_check_percpu(curdev, newdev, smp_processor_id()));
> +              !cpumask_equal(curdev->cpumask, newdev->cpumask);
>  }
>
>  /*
> --
> 2.7.4
>
