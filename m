Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CE20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjT7k9GL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBUMKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:10:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40411 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:10:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so4067413qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A598ezMQLuGr+otd3hlG9eq3WyNrI3RkGoiZaXWZ7Bg=;
        b=fjT7k9GLFoUncCpOr32/N3JUcmY6KLzl9SQle/oosQWRpLqoiSS8dO5tGHLda7OsHg
         UB9scIPapAxm5Tu2ObVbwFwCryFC3ly5MSztFeZg1IiqTNO6FPwkwuS55O6J5nUGZCyn
         0YywWHiRG2kpsDwdXdS0t82d9U6C6Ns7o/Qmd+xSH+ZdDoNDgaHHYcky/AeaeOCVMJe4
         FvWepVsjuD+yQCDT14kIwEr1B4sHya5xo39W92L0xnMBSjzxm1jczTOAVMwkImJrRWJU
         kZ8kizHiZkick+X2SgaeX2B04/acvEayBhvlW4XOsQEa3WbP5s24OP6946NmXutOU+Do
         3XFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A598ezMQLuGr+otd3hlG9eq3WyNrI3RkGoiZaXWZ7Bg=;
        b=Cn1RFvwGFhGOKH09ZK5ovS+kLAOjN0ol8Pa3HTnDhvQj8vLxM0P8WVgDLllj+3w4gg
         vNm51SGekgeV7FpCHzuIkFTB8ZcgVhKfrHcS6tFufK01uOR7CdOZkxACFF1DZQ2+cU2t
         ZEZaD0QDXqrpNZVGfSTMt2hMmyTpYwxJQpL47cBGsS8YQC5Gsdo8s87WjPr0bsLsQd6d
         3DEgNFwGVJFs6OCoab0bLhilsuVjlNAyoZQo5ICuoYhNcnvpMotPFrhHhh2HoHaQAsS3
         4959sHNXoVtI7Dnq7Bep5YBwbO0oVV6qh0q03U7BTiuogjczCyq2Q3YovQ3g5bsEbvf7
         lc4g==
X-Gm-Message-State: AHQUAuZBSAmn58gmVKyNOQ2HTQFjOyj0kMwwgG/OB4bw+Q6AGS3+5Wvl
        8tpQFqWqhDSng81qD88cV9jnP8XPs8nwnI4av7+8LQ==
X-Google-Smtp-Source: AHgI3IaARVcjJ0kj6fHSx2y9hflMvGQ54PuL5I9DIfg4N1fn91qRxm+Sxu86C2tzia2mhO1V3LVsUtOf3JkdFaeSGIA=
X-Received: by 2002:a37:a556:: with SMTP id o83mr23441121qke.78.1550751009954;
 Thu, 21 Feb 2019 04:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20190220105214.26618-1-thierry.reding@gmail.com>
In-Reply-To: <20190220105214.26618-1-thierry.reding@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:09:57 +0100
Message-ID: <CACRpkdbf4d3MMfZZh39ka9JVX57zNuVoX9xAqE7SKJ-u27QYqA@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: Restrict enable-gpio quirk to regulator-gpio
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:52 AM Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to
> enable-gpios") breaks the device tree ABI specified in the device tree
> bindings for fixed regulators (compatible "regulator-fixed"). According
> to these bindings the polarity of the GPIO is exclusively controlled by
> the presence or absence of the enable-active-high property. As such the
> polarity quirk implemented in of_gpio_flags_quirks() must be applied to
> the GPIO specified for fixed regulators.
>
> However, commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only
> to enable-gpios") restricted the quirk to the enable-gpios property for
> fixed regulators as well, whereas according to the commit message itself
> it should only apply to "regulator-gpio" compatible device tree nodes.
>
> Fix this by actually implementing what the offending commit intended,
> which is to ensure that the quirk is applied to the GPIO specified by
> the "enable-gpio" property for the "regulator-gpio" bindings only.
>
> This fixes a regression on Jetson TX1 where the fixed regulator for the
> HDMI +5V pin relies on the flags quirk for the proper polarity.
>
> Fixes: 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to enable-gpios")
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Patch applied with Marek's tested-by, thanks for thorough commit
message and helping out in sorting out this mess we've built
up over the years.

Yours,
Linus Walleij
