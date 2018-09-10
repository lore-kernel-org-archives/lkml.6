Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B00C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208672087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqPh42co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208672087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeIJTNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:13:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33810 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbeIJTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:13:13 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so771630iob.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y2uNSq5asWlq/4LtS6DI2f5UoPV1sEkPu5yZEStD6Lw=;
        b=eqPh42coJVC2oVSUY/6G3Sx3t3HqRJ61OULx82HK4NhAjCqczwBUmHEw3D2Z6geJ/p
         KNHPwzAesjhb+3wxWRc2HKMOrs8x2Rut4G/0NlqygfPnd6twDwifSDKrTgWVzNKitf7f
         PpXpUyo6pku4Ud8cJ0qSU+0145d33cuo1o69o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y2uNSq5asWlq/4LtS6DI2f5UoPV1sEkPu5yZEStD6Lw=;
        b=DRn8YkIpzYDxixn0NnQZb17PzWELtYmHC8lKAtLxyJT//GlmphO3FrsztHTx25UmrE
         KI0hYuyoU0HnZG6EuJh2KfgSGLMUhcCIhUxuqHJK9HhC3MLy26GuxmfEbBAIN+ryAXos
         fJJzJfT2+L22hZoE/ghmF8r+kD5v5kjGuGIPQB/mRBDAxZQ3PdxuV7Bw3jL/mkfLl3Gq
         j/gg3uz83j/S2QHZ+ZQyULoGdXpVBQoTB0NYasQ6YVUrkVDg6Pzpg162an8etQmA7TR+
         Stp9ACQ7jzLzC5AzWqY5nLsn8lCAAsvgGUfToPmqdVsSfQYuqmiShOVHLeVcZy3MQVnK
         u7HA==
X-Gm-Message-State: APzg51An/M9qbGC6M4bnMToEMiqVNdc49N5BAxGdjMAt3d7JnUq6Qo3X
        OirDI7ZCq+qAdCU0oQjvVUOMFTDR24/m0ZVoPtPFEw==
X-Google-Smtp-Source: ANB0VdbTgDpl7hlneDJHPYR9L87Msdi+Iypy0bKEQjRIjHynm9dTLPU79lqMe+Nm6Gx90x5ZM59ljcscl2ozq4x/+Us=
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr16530449iou.218.1536589133797;
 Mon, 10 Sep 2018 07:18:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6a18:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 07:18:53
 -0700 (PDT)
In-Reply-To: <282ac8092650c95595c84213dc87a4bf6b278da8.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org> <282ac8092650c95595c84213dc87a4bf6b278da8.1530252803.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Sep 2018 16:18:53 +0200
Message-ID: <CAPDyKFrM2x9NwSS0JTjoyu-SdtckQdbZHjWeqmH8NF3_Q2tw-w@mail.gmail.com>
Subject: Re: [PATCH 06/10] OPP: Add dev_pm_opp_{set|put}_required_device() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 June 2018 at 08:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Multiple generic power domains for a device are supported with the help
> of virtual devices, which are created for each device-genpd pair. These

What "device-genpd" pair are you referring to?

> are the device structures which are attached to the power domain and are
> required by the OPP core to set the performance state of the genpd.
>
> The helpers added by this commit are required to be called once for each
> genpd of a device. These are required only if multiple domains are
> present for a device, otherwise the actual device structure will be used
> instead by the OPP core.
>
> This commit also updates the genpd core to automatically call the new
> helper to set the required devices with the OPP layer, whenever the
> virtual devices are created for multiple genpd. The prototype of
> __genpd_dev_pm_attach() is slightly updated for this.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 31 ++++++++++++++---
>  drivers/opp/core.c          | 69 +++++++++++++++++++++++++++++++++++++
>  drivers/opp/of.c            | 12 +++++++
>  drivers/opp/opp.h           |  2 ++
>  include/linux/pm_opp.h      |  8 +++++
>  5 files changed, 118 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index c298de8a8308..e9c85c96580c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2219,8 +2219,14 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>         genpd_queue_power_off_work(pd);
>
>         /* Unregister the device if it was created by genpd. */
> -       if (dev->bus == &genpd_bus_type)
> +       if (dev->bus == &genpd_bus_type) {
> +               struct opp_table *opp_table = dev_get_drvdata(dev);

This feels wrong, to me. Genpd is not a driver, but rather a
subsystem, hence I think it's a bad idea to "abuse" the driver data
pointer like this.

Instead, in genpd we store device specific data, through the
dev->power.subsys_data.

Seems like a better option is to extend the subsys_data, to also
include data needed to be shared for opp/performance states.

In that way, we might not even need to call into the opp library
(dev_pm_opp_set_required_device()) API, but rather the opp library can
itself check what is in the subsys_data for the device that is being
targeted. Would that work?

[...]

Kind regards
Uffe
