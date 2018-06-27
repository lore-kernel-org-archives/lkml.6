Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2416AC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B1225879
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Z1tr+O3l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gMPRirt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B1225879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965814AbeF0V4X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:56:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43678 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754928AbeF0V4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:56:21 -0400
Received: by mail-yb0-f195.google.com with SMTP id g3-v6so1345252ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gDQTp0Sm8sU86irNW/iQllUIEA+d7U51SM0FHn3pr1w=;
        b=Z1tr+O3lShaE1hpHn4AP7Oxu5a3B49WrKo7g/l6LcmetJ3ErsVCFkhWPekzcSwGlUL
         P6bo7q376SXP9KAhmrN+fKHYvJ+WG1D00udM1N52mR53uYz9DI9FwpHwAQXnyFpkIFFO
         LNb9bxf8+otG89lsm++j8ipOFUaVNWgTOyHsZxYA6Df9QG51QP0LPuOCnAHO0IZMBKfP
         TvZ8m8T9McOXkZTlA8yZO2NJvC+7Y/fisBK6U/mwAV+CAV0mTitgmtgUFZA7tcJCdvkS
         zxpIp139sI2CCkFFiTW9ajIdHfmw2ZExmIvO3xZ6Jf4isF88AnXtuAogjvtmPSPQ5ulE
         +Klg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gDQTp0Sm8sU86irNW/iQllUIEA+d7U51SM0FHn3pr1w=;
        b=gMPRirt0lH/YXh6yro0aB8UfWC3iTvQRW387uaYgyA3tNEIQUA3QqjkPAvRmwWuXuH
         daUlx6kghmOeZEgclFP4nlLxHKILwn4A+STFMje4RASuSiRcqj9nUF4fF7LcwmJvSV+o
         kl27YQNTEVhsvwiqoBwVd+mqvsKQdwOkEuJIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gDQTp0Sm8sU86irNW/iQllUIEA+d7U51SM0FHn3pr1w=;
        b=uOCiB95FnZO2M2CvN93zdwb6AEt8Doo6oIFYKdn7QZJmxFiziMRLdRgwXYdkaWYVbq
         YGQzr5XYZpzq0KwgowF0L9VGPpRXCpUd3k2o16NJvzKQFIC0fsPq4bpaRXi14dpHx4xP
         s+ajLwrRcLjb01i1MoiZ3xUq5ijlUdaApoQIpMC9NlLvB1oYm5rZLMW05Z+SybIHikiT
         QTjsQH0ZlGeDe3xCFf1idLKN78HEWnUYaRF18q+ekYP/61SxkCuqWPZSngP8xlrQA6L9
         ykoGihY2BwWP5AfZehiobnntpPZaXLkO4me8bCjOuqQ1lFHvpljddNSeQ3MJkDl44WIr
         bunA==
X-Gm-Message-State: APt69E0eZ/9ieEj+IEdyGjoPKVBlehXn4RxfRilXQdBbxS8PtM9Vg61X
        C6d6c4WkPo2oU5Q9qBQvKRwWb2PWtDgsP2c4tkzdk2Sv
X-Google-Smtp-Source: ADUXVKL1z7Cv4+4vU4R85cNz11/nlmMIb1RzGw28E5MM+Yb86CYy8GORpvlwy2aCGjpuzpTZR/KDuZ0TrmIrq9nU5x4=
X-Received: by 2002:a5b:b4e:: with SMTP id b14-v6mr4105956ybr.463.1530136581002;
 Wed, 27 Jun 2018 14:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 14:56:20
 -0700 (PDT)
In-Reply-To: <20180618174549.GA1893@beast>
References: <20180618174549.GA1893@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 27 Jun 2018 14:56:20 -0700
X-Google-Sender-Auth: 1d29yzD9OFvfhfxfhNbgrygbXAY
Message-ID: <CAGXu5jJZH0fh_q7o2w2_tX3Xxyn2xm-55J62JcucgfWBUYkU5Q@mail.gmail.com>
Subject: Re: [PATCH] bus: ti-sysc: Use 2-factor allocator arguments
To:     Tony Lindgren <tony@atomide.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:45 AM, Kees Cook <keescook@chromium.org> wrote:
> This adjusts the allocator calls to use 2-factor argument call style, as
> done treewide already for improved defense against allocation overflows.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Friendly ping! :) This is the last 2-factor devm* allocation left in
4.18 to be fixed.

Thanks!

-Kees

> ---
>  drivers/bus/ti-sysc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index 1cc29629d238..80d60f43db56 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -169,9 +169,9 @@ static int sysc_get_clocks(struct sysc *ddata)
>         const char *name;
>         int nr_fck = 0, nr_ick = 0, i, error = 0;
>
> -       ddata->clock_roles = devm_kzalloc(ddata->dev,
> -                                         sizeof(*ddata->clock_roles) *
> +       ddata->clock_roles = devm_kcalloc(ddata->dev,
>                                           SYSC_MAX_CLOCKS,
> +                                         sizeof(*ddata->clock_roles),
>                                           GFP_KERNEL);
>         if (!ddata->clock_roles)
>                 return -ENOMEM;
> @@ -200,8 +200,8 @@ static int sysc_get_clocks(struct sysc *ddata)
>                 return -EINVAL;
>         }
>
> -       ddata->clocks = devm_kzalloc(ddata->dev,
> -                                    sizeof(*ddata->clocks) * ddata->nr_clocks,
> +       ddata->clocks = devm_kcalloc(ddata->dev,
> +                                    ddata->nr_clocks, sizeof(*ddata->clocks),
>                                      GFP_KERNEL);
>         if (!ddata->clocks)
>                 return -ENOMEM;
> --
> 2.17.0
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
