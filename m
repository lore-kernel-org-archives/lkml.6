Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770BDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DC62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="By0oLYvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DC62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbeGIWtH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:49:07 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34359 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932797AbeGIWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:49:04 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so18590941ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ttyBgDC3fPfabBvwfvaxBiX5W+j+74kz617j902WAf0=;
        b=By0oLYvVhRtdsfhabkxEmV+Aw1o2NNoL0iwWOKknjVgBgmTNJI3hqg8lowQiIi+KaA
         vWLO+0UotLHMJgVVJ04WXEzCD0jOhRcNbZIAZC4B7Z0XcUGOGLX6yhF5WH3wloGN2ldq
         YiTrmLrnOIcDwVdCK5h7+/Yb6+9P/1kXzxuHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ttyBgDC3fPfabBvwfvaxBiX5W+j+74kz617j902WAf0=;
        b=CyCLPjzcFOLddnkQWkedlJfZg5UsSB9rRR8pgztsE8GfPXFdDulrlHLjakhyiay9X3
         o6YS1A7XIHwQXhmBBADT99RrDR3CwS6NldgpF7pyaBy8Sox1GiHS/raWz9CKQPmySZg2
         62M3RuZvqViGlD3OYwyU/gEiPtmzu1mTNDa9xv5D74OaFGKyxTiAJl+9kgjeGS+Ew7H0
         0T7CHR02wOo9BnQydo7BA6eF09DnQ0RdtAx1W1+2nlbe5RQpFpHwsOVFERZ7huVsdjTX
         sTRlXcToy/7aVfnwj7BlkxSpLg8ta4XA5Qjk7aeqnNgg5D+jS3DfdjBSsHfsFbjlUlwE
         qHrg==
X-Gm-Message-State: AOUpUlHROvjQaVTMWjRXXXR+9tgjQftpQgj3BRZYFEE0rsGSaUZODHzC
        JSBX73Q4um1NFcFk27QLS7fbAUyF7GLORK979sCpcw==
X-Google-Smtp-Source: AAOMgpc79U1tFWPOTTJxWVE5SGe0j23nmJc0MOzW/8nCcLZF8rLUcpHyy9leYj/4JAzlmq0vlCawgbV+tIrVcBD7lg0=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr19354908iof.266.1531176544341;
 Mon, 09 Jul 2018 15:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 15:49:03 -0700 (PDT)
In-Reply-To: <20180709154153.15742-7-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org> <20180709154153.15742-7-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 00:49:03 +0200
Message-ID: <CAPDyKFoN1=16dGKmkFp6Khgs5zx+BguOs3qOcm+rAZw=b38JVg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] PM / Domains: Stop deferring probe at the end of initcall
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 17:41, Rob Herring <robh@kernel.org> wrote:
> All PM domain drivers must be built-in (at least those using DT), so
> there is no point deferring probe after initcalls are done. Continuing
> to defer probe may prevent booting successfully even if managing PM
> domains is not required. This can happen if the user failed to enable
> the driver or if power-domains are added to a platform's DT, but there
> is not yet a driver (e.g. a new DTB with an old kernel).
>
> Call the driver core function driver_deferred_probe_check_init_done()
> instead of just returning -EPROBE_DEFER to stop deferring probe when
> initcalls are done.
>
> Acked-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>  - Add Rafael's ack
>
> v3:
>   - Update to new function name
>
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4925af5c4cf0..8c12213875c6 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2253,7 +2253,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return -EPROBE_DEFER;
> +               return driver_deferred_probe_check_state(dev);
>         }

This isn't the only error path where -EPROBE_DEFER may be returned
during attach in genpd.

Have a look at the callers of __genpd_dev_pm_attach() and also have a
second look inside __genpd_dev_pm_attach() itself. And in Rafael's
tree.

>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> --
> 2.17.1

Besides the above, I am fine with the approach as such.

Kind regards
Uffe
