Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE3A2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEc3d10N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfBTJp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:45:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39884 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfBTJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:45:59 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so20216891ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ekov2nfU/3oV445InqreP8lt16tkHw13TkSeZkK2qF4=;
        b=gEc3d10NEwAaalnQxB0sD5MModnZPQXXi7S+HwwRRcSq8ESZZERX0EPRfpyBR1+PzT
         mg7BMR9JGyjQeJRt5+3SDJHb1iLu2EL51jUu89V7iW0OoAVCHmU8kAxzI+3SQF6u2TRU
         YKKtrwKynfHxORmfCq4EjvPxdyBpq35ZZrg5hrq7NKljv7HNX9knzndZdDyHp7E6FWWb
         Ux1HCrFo9uZWx+QvLMBFJGrKfYbh9a6h9aI1QP0lNgGAxIYKm/LVuMYHmmAIWpzcgEbv
         is1lZY5hJbB3fAwjmOZhB8uBd34S/1230nEuT1twZL9zvY3+bT60j/CfO9xCRkIh5qW1
         TKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ekov2nfU/3oV445InqreP8lt16tkHw13TkSeZkK2qF4=;
        b=g5i8C2QgUBc/cpys0N6pVJZ6sb24YanTNzh/ina5vvBH0kuymjHEflgexoUwJHPQWu
         7pbVJjPKYh0oASdjD4DPZFqXDFBgokfomI5+xiknIEWJ3Ng06WdImWm/uxtypHddOusN
         XfXg5EYK4O0wR/06/KNwb51w8a8w8RKWb9yxVWTmhlwT7CjP6r3ViG5jl6WtF3+3bDEK
         MMkmR39M2xyxUhT0wZL2e+x9JteyKp2Etws5evP/s5Zw/P7HERGh6B3+1T4BRiUgs7MQ
         fWCmMeHJ08PH+qKAY9EzQxx90G03r4liOORxpFvy7EYUajmanoF+w/T49DuYhwReg9tW
         43SA==
X-Gm-Message-State: AHQUAuYNlClNeA0bNMiXNcm4uop27RR3GsN25HGfDPpepMTsDYKUNASg
        g5q7a3DwgM041oYSQLLMdQEYdEcwFa7EDIdxGs9YFw==
X-Google-Smtp-Source: AHgI3IZ//j6PXS3GVqYXuR99SO6k8uOhk5KMTch2eaTH8Zr5yemkCqcPcXpYm4JXtjWwvAduA0PNCaujdMJZv+OOouo=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr19814440ljb.126.1550655957122;
 Wed, 20 Feb 2019 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <1550091448-28578-1-git-send-email-info@metux.net>
 <1550181897-2596-1-git-send-email-info@metux.net> <1550181897-2596-2-git-send-email-info@metux.net>
In-Reply-To: <1550181897-2596-2-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:45:45 +0100
Message-ID: <CACRpkdYM6An1gEvw=Kw52WfAEr176oHoUBKquXtjaSvwrMbWrQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: AMD G-Series PCH gpio driver
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:05 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> GPIO platform driver for the AMD G-series PCH (eg. on GX-412TC)
>
> This driver doesn't registers itself automatically, as it needs to
> be provided with platform specific configuration, provided by some
> board driver setup code.
>
> Didn't implement oftree probing yet, as it's rarely found on x86.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: linus.walleij@linaro.org
> Cc: bgolaszewski@baylibre.com
> Cc: dvhart@infradead.org
> Cc: andy@infradead.org
> Cc: platform-driver-x86@vger.kernel.org
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

(...)
> +config GPIO_AMD_FCH
> +       tristate "GPIO support for AMD Fusion Controller Hub (G-series SOCs)"
> +       select GPIO_GENERIC

Now I see that you do this

> +       spin_lock_irqsave(&priv->gc.bgpio_lock, flags);
(...)
> +       spin_unlock_irqrestore(&priv->gc.bgpio_lock, flags);

Only to get that spinlock.

That's not what GPIO_GENERIC is for, just put a spinlock in your
local state container struct amd_fch_gpio_priv instead.

Yours,
Linus Walleij
