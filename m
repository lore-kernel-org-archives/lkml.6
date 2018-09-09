Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3096C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838A620854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838A620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIJAeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:34:10 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37575 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIJAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:34:09 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so36304350oic.4;
        Sun, 09 Sep 2018 12:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeTOEPm+QZm1PMfjta63oYJtPNHoGwur7V22F3SzMyM=;
        b=FLemqeZWc7Xkab2XNPaJSAGgnY9fa3HGnbSUYTWGirxGdz+6ZT37dxdTd/D+Z2yJn/
         SIjIgaXzghGZ5ZFCrz6Avw3e0xJyjhes0wfeyFTpJrY71+p+q6zVn/QU7HuMbsRi1pGJ
         2glOSoANOfzWAwGAQOAWerA6o9DbO2s/Y1+ym/o0JEYW21hbziM2NjDu2PiQWqPZKKpZ
         nlXTuKl6j6APeBv6dADFHOrHyQGADhrNxf6WwP2geFdbZRgo9BvJ8Brcyg6K14XBtipI
         D65ksx8VlJry2GkGoh25Z9SzGUzrGhyKa2qzUancDUzCg5He3HdvDOOpoQWHRlglsC/I
         B3Sg==
X-Gm-Message-State: APzg51BlpTQ8vMsHqadIvY+3ZO9O+t0JE0RkPM5S81p2lT3InsawqJbV
        n8rBl7nD63KyRqDWckDWNrSlgmtVRE1LFlDs3m0=
X-Google-Smtp-Source: ANB0VdZ/qw7dR32UylGev6EXdBwa1juogd1f5p+FJZeNbas8ov8f617DzakTfzJuUZ+mxqIWyLX5SfJofyP8j/LjXc8=
X-Received: by 2002:aca:b844:: with SMTP id i65-v6mr19364658oif.177.1536522205036;
 Sun, 09 Sep 2018 12:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180907200838.4966-1-kw@fieahl.im>
In-Reply-To: <20180907200838.4966-1-kw@fieahl.im>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Sep 2018 21:43:09 +0200
Message-ID: <CAJZ5v0jxKQv9x3wOAg-+XNQJ8LgzGDr0EPF9PcHZG1D4GAJObA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
To:     kw@fieahl.im
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 10:09 PM Fieah Lim <kw@fieahl.im> wrote:
>
> There's no magic inside, let's just make it more intuitive.

Again, please fix the changelog.  It is not useful as is.

> Signed-off-by: Fieah Lim <kw@fieahl.im>
> ---
>  drivers/cpuidle/governors/ladder.c |  2 +-
>  drivers/cpuidle/governors/menu.c   |  2 +-
>  include/linux/cpuidle.h            | 10 ----------
>  3 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 704880a6612a..f0dddc66af26 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>
>         last_state = &ldev->states[last_idx];
>
> -       last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
> +       last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
>
>         /* consider promotion */
>         if (last_idx < drv->state_count - 1 &&
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 1aef60d160eb..715520e339da 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>                 measured_us = 9 * MAX_INTERESTING / 10;
>         } else {
>                 /* measured value */
> -               measured_us = cpuidle_get_last_residency(dev);
> +               measured_us = dev->last_residency;
>
>                 /* Deduct exit latency */
>                 if (measured_us > 2 * target->exit_latency)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 4325d6fdde9b..d262f620890e 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -99,16 +99,6 @@ struct cpuidle_device {
>  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>  DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>
> -/**
> - * cpuidle_get_last_residency - retrieves the last state's residency time
> - * @dev: the target CPU
> - */
> -static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
> -{
> -       return dev->last_residency;
> -}
> -
> -
>  /****************************
>   * CPUIDLE DRIVER INTERFACE *
>   ****************************/
> --
> 2.18.0
>
