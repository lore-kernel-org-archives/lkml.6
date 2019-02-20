Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C284D2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orF/8HXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBTJ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:57:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43448 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfBTJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:57:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so19219570ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYh1Ys5wB17rpwifjqi/aUARw3GOb56gn6WN5DrDWAw=;
        b=orF/8HXtezrzv55otLIOCas/llXOqamgLnIlklqhdHEoA5eodR/wE70CMqhw52Leud
         A12wsGxQxY4u0rbLwjSdEzg5/avdFoGMFZPF8n//A0E4OnqASQMjm6Opo14slENuq2z0
         XkzaCTbaw/Jb+/6MiV1ZQA2Nx72Q23xSl3IvHnKVckWK82BCrT7XwRYqgH389DYhHZe+
         IxU9dPibMxqRqBHG1E+GdscGv1HYCEIFNCndWKliKUut1xxTGlwICEMPH/qF43cACr2Q
         Glc3hIr+eZpiq+UkMwyXXcVxUh9GA75fKm8CbNV+77bGywssjYcJkibZpaUpalper65n
         kNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYh1Ys5wB17rpwifjqi/aUARw3GOb56gn6WN5DrDWAw=;
        b=EdoTcBycG9RFeKidZoks0y1iDqpKevjPgLr1wD8l8YFP6Q58SeqGAw2W3Kbsbnd/QW
         QezZE/GNvtncm+uqc2vWrsd4LMrGElWhebjIv3SMaUcZUmqeFslgw9t9aV3Go+AmFwxl
         r8fQf1RfECkRcVLHJpy9u7wnqWkIOQ/vE9ceXb6RrclttuFibeNoamSF3pg+EA30dyWy
         VL93F5nVGI5en9QCUK7Zvrz0nz8ARm0qC+lNwtiiAzpE2l+xFDilVK3yHnv/OlJJNj7t
         YIU3MoiQ5mJ7Sw/P/wI3qf8iQn+Xoh0Q0yBqIsriLsIo6rjHVZmxHBh8OWvSBgYWGPCO
         GRNg==
X-Gm-Message-State: AHQUAuasH70FGIIxik5BoQWPWO9QBeL3PgbTD8jT1fa/Wlqrr+17ahp0
        Ikuvd4ckl7zx502ind86qqt1p1746HdFIMhtTaYTxH1m
X-Google-Smtp-Source: AHgI3Iap5sOLr6YWeMgipYzmOQvBgo5Umzvd3v75WJ8mb2T9gJP8rYxMpn7AT+9z6PXf0HJkvFG/3Eb18ypVGhRdqW4=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr15651611ljt.107.1550656635377;
 Wed, 20 Feb 2019 01:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20190215152507.31066-1-brgl@bgdev.pl> <20190215152507.31066-2-brgl@bgdev.pl>
In-Reply-To: <20190215152507.31066-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:57:03 +0100
Message-ID: <CACRpkdY43ojBZ1NUyvc0X8+3tc3=jhv4S2oJX2v-88TgrKxQqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: provide devm_platform_ioremap_resource()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 4:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> There are currently 1200+ instances of using platform_get_resource()
> and devm_ioremap_resource() together in the kernel tree.
>
> This patch wraps these two calls in a single helper. Thanks to that
> we don't have to declare a local variable for struct resource * and can
> omit the redundant argument for resource type. We also have one
> function call less.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This makes a lot of sense. I think Andy can confirm the value, he
knows a lot about good helpers.

I'd need Greg's ACK on this before merging through GPIO.

Can we make a script or coccinelle thing to fix them all when this
is applied?

Yours,
Linus Walleij
