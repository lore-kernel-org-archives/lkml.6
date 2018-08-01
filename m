Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF776C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1D20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QTpOHkWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC1D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeHAWKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:10:42 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42602 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeHAWKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:10:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so37004472oib.9;
        Wed, 01 Aug 2018 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C6JZFXgvKR3m8yh00tOxVf5OPwMRnfOIjVxVh6cUq7g=;
        b=QTpOHkWcsdI66H3tGJc+NFrwNJWCGqTdPySFUQs0ZH9rh3R51xFwHSLGpu4PEJSl4O
         2D+9yrx5awmiWdQxJLnIYf6Bgxo1a6sxIHzpQzX5leEYmmYl3cmSe+CaU3KoYztTl04G
         pz7pBYZRUeIAkhvAkoxHze66Q2f2pro858ET77o1x6Y6lfBWZMMfLw0GLiMvM/XUH0aR
         QdH/b+/5VClEoCnf8rM6wNvmJ8GzGDyucIN6F9w/V2EJ9e05OW7+WUyyqYKYdNDbIS8Z
         oDrvvVxOB1XXbx5GtrSG5ybzQnJKRaL/hyVF0yjbCtp51J0rSI11/iUHSOmuAA2XHBwn
         cAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C6JZFXgvKR3m8yh00tOxVf5OPwMRnfOIjVxVh6cUq7g=;
        b=fLOdDScjJGN1mMn6y5D+mW2CqRaqoyOZ3Kr3y8Rg4uwTS/ddQsuJXgHhNoZ/GjYf6F
         edQslVSK1PdtRjy0VIV1gI/ONSUMLMZ/j7n3vPKbbApQPZfZxLaRKrBlxosHk8V7YgvP
         tHDekY7ezonxAsogjq15XWkkzVimI9JXP4+SHmCisCAe5R+642t78aC1nOcoOi332k6O
         lTAgbvBDZ13h9AjBfp5XwJhOrKrmsaTMAIP0X2679uhzUZU0Dx3Kw7p7pVW7Ap91P3xE
         H2d7F6FiX2+i6jQhKLd12xZrq/4JLuBoH8nkthjNVmOnFYySRgsLjNFOfx82zZvJKXbb
         yFtg==
X-Gm-Message-State: AOUpUlFNmC4YUJbJU9RRbqJ/vTYlcXDkA13EIfEcjxH8bS7PpfjSFS30
        5jWdFsLBUlNa6B3P9eNugbcHLz2hmoTJCM1DTro=
X-Google-Smtp-Source: AAOMgpfrmF6dnTzs8ZiSUtaCtB5u2R+loP7KvjMorvOuq5X36fy6/Te36ExF1XfRQYK7OGGhAGJ0QJKzcYAZQ98RKKY=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr5276429oif.97.1533154991308;
 Wed, 01 Aug 2018 13:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com> <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 1 Aug 2018 22:23:00 +0200
Message-ID: <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linus.walleij@linaro.org,
        linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> set the TEST_N pin direction.
> This patch adds a "smc" boolean to the bank structure to differentiate
> the TEST_N bank and call the Secure Monitor in the _input/_output functions.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pinctrl/meson/Kconfig         |  1 +
>  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
>  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
>  3 files changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> index c80951d..1b90470 100644
> --- a/drivers/pinctrl/meson/Kconfig
> +++ b/drivers/pinctrl/meson/Kconfig
> @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
>         select GPIOLIB
>         select OF_GPIO
>         select REGMAP_MMIO
> +       select MESON_SM
I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
instead?
selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
don't have the GX secure monitor), but I haven't tested it yet


Regards
Martin
