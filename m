Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA975C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A865921B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWlBTld9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfBKNg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56225 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfBKNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so17610786wmh.5;
        Mon, 11 Feb 2019 05:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqBNnbIu4ogAFHQv0IkubaNotkX2xJx7RZvZ6dahxA0=;
        b=dWlBTld9j8T52lCHFf1Ji9Oq9JA3yqNuZYTfA0CidfToNWajVNFt+SqVtGK8FZGIGS
         dA7Zc26RNnFiDFZbMKadqPTEJvebkib38hlO0bTffDmt2zKmpj8YPtRVy3GyVWBSXRmn
         5EknEw6wOsqXbSwRGAZURYB9Mh0VIxwYIRa+ViTmqxTOFxZGTu1rm8Fm5Vu1TFX3QNDO
         32t/nYBTJiweu0/hYuvVvTWbnIxtk/BoZ+3jxcZ8RBGdqFeQKHEJB/llZQVJuknf6wHw
         bevQJtKjc1OKoCQ/wUNTU8UnPP1AMyOFmO9rBW7v5YbTFqAmdhz5tixs407i2QbTEXl0
         JDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqBNnbIu4ogAFHQv0IkubaNotkX2xJx7RZvZ6dahxA0=;
        b=CjpQKkSj3HzDiD1yNeSE/336XwnvTCJ8/9t6EkNnAdvPpW4SBqbYCcngQ50okUK85N
         0BhL6FJIpW/L4ZD6bz30tqqzEYmgOj8Tj9MWPuhaxKCyZi5cFvXNtFFnSj95RXuFvDRc
         XGfPt92xxgfN5fqvp14UGNVRRNQYziHX7CSoxT7+bHiz5iqWTXP+c6rxr7rmQR8fcb5N
         2yRdzfwluS+XzgHL+7RoeFrEkFyxMypwaMf2E+fHnWrE79dQXOpaEd8S/LXyTmBLG5rr
         rM2eC2j2jqRhRnRqR5LagLle60u1par0clmg8TRB+iw1I9qqBSUHzsHKiDFAl4Ypvb/j
         UCHg==
X-Gm-Message-State: AHQUAub2HA2GLTQ4O+QxOcFKqiAqSSI/MluB83yu4RLnWSA6frZj4Gen
        Mdzf9zWjVSL7H4bd6nfRO3f5x+F49bcJnT/BZUo=
X-Google-Smtp-Source: AHgI3IZepcynd+Hv6C7k9ZWYerJsqdBdRwCbYM4kp8mARDKItdDCOe9hcRBOaK0i7Z7lpyAruqQFHGPkWDC3gLSxo/A=
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr9215345wml.142.1549892213289;
 Mon, 11 Feb 2019 05:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208104046.21817-1-thomas.petazzoni@bootlin.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 11 Feb 2019 19:06:42 +0530
Message-ID: <CAKfKVtFu0V7GVrZJ_THHAm-gAddp37iKv=JQQaWt_C+xZJEEWw@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: properly support runtime PM for GPIO used as interrupts
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the patch.

On Fri, Feb 8, 2019 at 4:13 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> The Zynq GPIO driver currently implements runtime PM by:
>
>  - Enabling runtime PM support in ->probe() and letting the runtime PM
>    reference counter drop to zero at the end of ->probe().
>
>  - Increasing the runtime PM reference counter in ->request() and
>    decreasing it in ->free().
>
> However, the latter is not sufficient: when a GPIO is used as an
> interrupt, ->request() and ->free() are not called. Due to this, the
> runtime PM counter remains to zero when the only GPIOs in use are used
> as interrupts, causing them to simply not work.
>
> To address this problem, this commit implement the
> ->irq_request_resources() and ->irq_release_resources() hooks,
> ensuring that the runtime PM counter is properly
> incremented/decremented. Since we override the default hooks, we keep
> the existing behavior by making sure they call gpiochip_reqres_irq() /
> gpiochip_relres_irq() respectively.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
