Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9765C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A48217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e7epFr8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfAXBVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:21:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39464 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAXBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:21:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so3720887ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTHhqoL0KpN75j2es1CQvn5vBD0ICFGfp92qRcNHM9U=;
        b=e7epFr8B3O/8owaemu6RyOVfVtS1rdFOJliBIJgaj2jWzJYqEEQUSro2bgA/hxqSS2
         BZ4jwFoT6Com5CuAUG8etmSoBWTg3AjhVmtjwkYysh+3l/3C8XMZsMrzxdH41cJMrT/s
         OHrEpr7ixplaEiIwcUOaWpaONtHTSbUrXWhrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTHhqoL0KpN75j2es1CQvn5vBD0ICFGfp92qRcNHM9U=;
        b=jvgql8CcuzuuihvAzPRqhEmSCyPcrRpcF43ADZHuvRMZxPct1zB3SrN7ZME8hh6qPD
         HjqL97zpjh5Q/JH2yDr/Ed2s325Xo53S6pFPOmxnyuiaHnRzJ28+Vfma5KsJpKZqIeCy
         bp+kR+54YarS41YFt6+TE6zn0oUoRSB/3eQhFakVWUC9w5ovHKw93ram+SYH6jM5Dyub
         IvGlK0hqGappwjN3g83WErdQ1A4ITi/4f1OC5/fxXI1AAsja1Fwqzhc0g4yk/BWdhToD
         R3PRBqNgVPlvydSLNALNJk/qbLUI1sFZvdVeEjHOxtEks+XisPBeBclp6JdoqwNkjfm3
         mPSQ==
X-Gm-Message-State: AJcUukfeMbdxOYRqFaxN4VjUkNac8jisI4dG9e5k5F31Xw3CRZ5I5Aa+
        jXkPEIeOSpcrJZoTrUFQS9+VEZRUW/Y=
X-Google-Smtp-Source: ALg8bN5DJVHuPCtj4on40f6o6/PIyjdtIa80BripZMHsmGP4/PzpBJQadakct6ATrZBT/BE8YCG3aQ==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr3731585ljg.150.1548292890048;
        Wed, 23 Jan 2019 17:21:30 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h203sm733796lfe.44.2019.01.23.17.21.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 17:21:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id k15-v6so3717436ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:21:29 -0800 (PST)
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr3810694lji.60.1548292888859;
 Wed, 23 Jan 2019 17:21:28 -0800 (PST)
MIME-Version: 1.0
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org> <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
In-Reply-To: <1548138816-1149-5-git-send-email-alokc@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 23 Jan 2019 17:20:52 -0800
X-Gmail-Original-Message-ID: <CAE=gft7+=k-KcN9pk1fRR8RuGkdskkJPzn70FFZjOhAyr_-9aQ@mail.gmail.com>
Message-ID: <CAE=gft7+=k-KcN9pk1fRR8RuGkdskkJPzn70FFZjOhAyr_-9aQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
To:     Alok Chauhan <alokc@codeaurora.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:34 PM Alok Chauhan <alokc@codeaurora.org> wrote:
>
> Get the interconnect paths for SPI based Serial Engine device
> and vote accordingly based on maximum supported SPI frequency.
>
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index fdb7cb88..7bbbe9d 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -12,6 +12,7 @@
>  #include <linux/qcom-geni-se.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
> +#include <linux/interconnect.h>

Sorted includes please, as mentioned by others.

>
>  /* SPI SE specific registers and respective register fields */
>  #define SE_SPI_CPHA            0x224
> @@ -589,6 +590,15 @@ static int spi_geni_probe(struct platform_device *pdev)
>         spin_lock_init(&mas->lock);
>         pm_runtime_enable(&pdev->dev);
>
> +       /* Set the bus quota to a reasonable value */
> +       mas->se.avg_bw = Bps_to_icc(2500);
> +       mas->se.peak_bw = Bps_to_icc(200000000);

Like the i2c case, can we compute real value based on clock speed?
