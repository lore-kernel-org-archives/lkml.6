Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE45C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295E20854
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7295E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbeIJAcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:32:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36697 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbeIJAcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:32:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so36319401oie.3;
        Sun, 09 Sep 2018 12:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/oB3qXrpiAr52+3SJpPftWE9bf8evMi4susKK5GVMo=;
        b=tXfc635MepN2XNsu/YORM+g7bGTkC/msJssHeF7AINZcJYcXvGjwOwxLxxJc50p+qS
         Rq6JWG1wuAOPu4Zs+eM+4UeCurfu61yBci7/Xrseuh/CIFTcEpl5D9OEZUEwU0hsIMMG
         f/VvKYs3rFPdF8kEeqx4QYRXKj/EJUQ8xSi1nnv32/MzwBiOzdVx9He9AAyHzddekkN7
         1l6v/+AX02xRNsO01KW7H/X0MrJhTe5K8134Zi7bXSOaofHuaCky2T5zSYIrKT4aH/jd
         FchynBPju/s6CgYqf+cvCoddZDj8IKF8eYuuwkoFHO8dyo8/KhQsUAtuuUrq6Qedusm7
         4HWw==
X-Gm-Message-State: APzg51C9JeJfY5YTsiNEIgAGktW/XYx0vYexBvUa1QDUTkhUL0Ws2mqW
        X3DCne4oqOjZAKXyuJL24G2P+O0LKaJ2x74SvrI=
X-Google-Smtp-Source: ANB0Vdb4tKtn8QIsJbcGELNV515x4fHPLmXTgrpTy9g9GHIqfB7N83tGhABqko7iDIavznZJzW8OPRit35R75J9YY4g=
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr19189790oii.307.1536522095264;
 Sun, 09 Sep 2018 12:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180907185448.30987-1-kw@fieahl.im>
In-Reply-To: <20180907185448.30987-1-kw@fieahl.im>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 9 Sep 2018 21:41:19 +0200
Message-ID: <CAJZ5v0h7tbyi3vYtQVoWrLS_HJh_3mhvqy_sts73Jiwnr13zdw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: enter_state: Don't needlessly calculate diff time
To:     kw@fieahl.im
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:55 PM Fieah Lim <kw@fieahl.im> wrote:
>
> ktime_us_delta() is not that cheap on some platform,
> and I think this is also the right thing to do.
> While at it, fix some coding style as well.
>
> Signed-off-by: Fieah Lim <kw@fieahl.im>
> ---
>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 6df894d65d9e..5f6b2c9b6555 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         if (!cpuidle_state_is_coupled(drv, index))
>                 local_irq_enable();
>
> -       diff = ktime_us_delta(time_end, time_start);
> -       if (diff > INT_MAX)
> -               diff = INT_MAX;
> -
> -       dev->last_residency = (int) diff;
> +       dev->last_residency = 0;
>
>         if (entered_state >= 0) {
> -               /* Update cpuidle counters */
> -               /* This can be moved to within driver enter routine
> +               /* Update cpuidle counters
> +                * This can be moved to within driver enter routine,
>                  * but that results in multiple copies of same code.
>                  */
> +               diff = ktime_us_delta(time_end, time_start);
> +               if (diff > INT_MAX)
> +                       diff = INT_MAX;
> +
> +               dev->last_residency = (int)diff;
>                 dev->states_usage[entered_state].time += dev->last_residency;
>                 dev->states_usage[entered_state].usage++;
> -       } else {
> -               dev->last_residency = 0;

Besides, what's wrong with this branch?

>         }
>
>         return entered_state;
> --
> 2.18.0
>
