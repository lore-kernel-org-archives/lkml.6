Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE99DC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A970B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="asxtgY6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfAWIO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:14:26 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38475 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfAWIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:14:25 -0500
Received: by mail-vs1-f65.google.com with SMTP id x64so782161vsa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5hmhgQ/0b/F9xqFpWDh22NOhDUhOT74zfuvcF36VUM=;
        b=asxtgY6AveU55uD0CVh/7KZzmfLmK+DcqRODMCg5Z6qyl1uZtJwO2qM7KFQOQ8pwTk
         1YOZrDY+IiloFO70oEuK+WjraSmZWNISg5Q01PLFH8Arj7nMpV+J41nmJjsCzvwYWeCZ
         iSkpYtbK46QPnHMKRxOMLAtlLpZba2q1UNwe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5hmhgQ/0b/F9xqFpWDh22NOhDUhOT74zfuvcF36VUM=;
        b=YZaQQJ/lbvSHj1HILyC66AVAEh9fEqCw0/jLvhg4pwkK8mZ+H1TF0HRnBo4k1aYbai
         c8s9GwPLd8GMgYSbxkQoFFXQc6zXAG7bHHQ0RUfr9+FIvg1NoENrW/uYu4IfikPE6BPS
         hE1a5YB/ocLp1Z7RKj+UQWmfJXWPNwN/SglZq1VdkDiTLoykw4UrmG9Qz1aFc/1VnUoj
         sMRd42LuoMZGDW11A1Lhb/HNIansWSnRQXZu0NqMQh+ZeN11xLjl6NraK7hJUi2w3NSh
         fZUKAkLAoRfIaH7u5MrU6tiJrGLJggDicUOk+zkwJcAIG525mtUTb/JG9pERKaC1oVN8
         MRng==
X-Gm-Message-State: AJcUukf4iI39HshZR1DXJov32hZNDBD6UliqOuD5F8q8WAYvvHaabadg
        IO2IMPYQjglVzIMGGmta8fCz/nilrBoMhRYign2v9Q==
X-Google-Smtp-Source: ALg8bN6afGADSkhNTn+YnEkw5+/bIW8EpDBXg0wqOLL+UwUUlx9bylkc/AfYCRiC8cArWXSQb4LU2hxjsucv/tBaNy0=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr473316vsa.165.1548231264414;
 Wed, 23 Jan 2019 00:14:24 -0800 (PST)
MIME-Version: 1.0
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org> <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1548167070-421-2-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Jan 2019 09:13:47 +0100
Message-ID: <CAPDyKFqeo1Yxso-iYF4Co-eRYXKDRmiFHi9i5wiZSCXGtgSdkQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] PM-runtime: update accounting_timestamp only when enable
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 at 15:24, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Initializing accounting_timestamp to something different from 0 during
> pm_runtime_init() doesn't make sense and put useless ordering constraint between
> timekeeping_init() and pm_runtime_init().
> PM runtime should start accounting time only when it is enable and discard
> the period when disabled.
> Set accounting_timestamp to now when enabling PM runtime.

Hmm, my first impression is that this sounds like a reasonable thing
to do. However, there are couple of more things to consider.

1) update_pm_runtime_accounting() is setting a new value of
dev->power.accounting_timestamp, no matter of whether runtime PM has
been enabled. That's seems wrong to me, at least from the perspective
of what we are trying to change here. So you probably needs to fix
that too.

2) I don't think you explicitly need to set
dev->power.accounting_timestamp to zero at pm_runtime_init(). Just
leave it uninitialized, as we are anyways going to initialize it
before we make use of it.

3) How will this change affect accounting while being system
suspended? As you know, the PM core disables and re-enables runtime PM
during a system suspend/resume sequence. It looks to me, that you
actually need to call update_pm_runtime_accounting() from
pm_runtime_enable|disable(), or something along those lines, as to get
the accounting correct, no?

>
> Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/base/power/runtime.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index fb5e2b6..7df1d05 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1306,6 +1306,10 @@ void pm_runtime_enable(struct device *dev)
>
>         spin_lock_irqsave(&dev->power.lock, flags);
>
> +       /* About to enable runtime pm, set accounting_timestamp to now */
> +       if (dev->power.disable_depth == 1)
> +               dev->power.accounting_timestamp = jiffies;
> +
>         if (dev->power.disable_depth > 0)
>                 dev->power.disable_depth--;
>         else
> @@ -1506,7 +1510,7 @@ void pm_runtime_init(struct device *dev)
>         dev->power.request_pending = false;
>         dev->power.request = RPM_REQ_NONE;
>         dev->power.deferred_resume = false;
> -       dev->power.accounting_timestamp = jiffies;
> +       dev->power.accounting_timestamp = 0;
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires = 0;
> --
> 2.7.4
>
