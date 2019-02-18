Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36178C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9E821773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfBRMVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:21:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44126 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbfBRMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:21:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so18830186qte.11;
        Mon, 18 Feb 2019 04:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtdHAxqUhnuyM/EBdJXTnZgqZt7coVP/9zTgLi4hYLc=;
        b=L25Kiy5erjpNYYb8EZNKhAKow2tn7HETDcTfM8GafQhaizPK3142RREe3tXxRnQRkY
         DXH3tb7DvfyO7BHhRovEXsElZQjADvcd9HR48bScOTg5Df6dvNyHV0mdYHKUr5ptelw+
         29y1er7BJ3QJA5D+rQX3syVJ7gkXoxH4fho8mh95LeLuzqHSxKT+XkQDUnTI274Pzbe+
         R8SdhI4FVvrl0VEkCM/2mtDI5uRsydZABM+wJMLp7CKAoYrxdRQdy5spdUeM0brTaImF
         ZrhmUJJ/Bg/DCGCz3roUZfR3Yck2eNnC22UZIjmLyLW1jakHHyBnU3tyoG1A+Dl0ckBv
         7qHg==
X-Gm-Message-State: AHQUAuZ94bjECJ12MhxwdCsgjNiw7cja3MKyL8MfO5Bqshjwb/U0pDsf
        RHjSWFgB6NdbLj5ducYp/p9guJhtbmv7rCiBI4M=
X-Google-Smtp-Source: AHgI3IbPmfMKPiuYDvNuoy/KqNDakxv45mdQ6ShE9ZD55+wx/xPOcgvWXm6tMRjltLkvO7gXAdJX+v37uwlFstrCzxM=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3806848qtb.343.1550492459208;
 Mon, 18 Feb 2019 04:20:59 -0800 (PST)
MIME-Version: 1.0
References: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1549628687-29628-1-git-send-email-sugaya.taichi@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 13:20:42 +0100
Message-ID: <CAK8P3a3_j2W+KXSynW_SkVZk_+PJ-DqyxjLkgJL-OichS0fwWw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] Add basic support for Socionext Milbeaut M10V SoC
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 1:24 PM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi,
>
> Here is the series of patches the initial support for SC2000(M10V) of
> Milbeaut SoCs. "M10V" is the internal name of SC2000, so commonly used in
> source code.
>
> SC2000 is a SoC of the Milbeaut series. equipped with a DSP optimized for
> computer vision. It also features advanced functionalities such as 360-degree,
> real-time spherical stitching with multi cameras, image stabilization for
> without mechanical gimbals, and rolling shutter correction. More detail is
> below:
> https://www.socionext.com/en/products/assp/milbeaut/SC2000.html
>
> Specifications for developers are below:
>  - Quad-core 32bit Cortex-A7 on ARMv7-A architecture
>  - NEON support
>  - DSP
>  - GPU
>  - MAX 3GB DDR3
>  - Cortex-M0 for power control
>  - NAND Flash Interface
>  - SD UHS-I
>  - SD UHS-II
>  - SDIO
>  - USB2.0 HOST / Device
>  - USB3.0 HOST / Device
>  - PCI express Gen2
>  - Ethernet Engine
>  - I2C
>  - UART
>  - SPI
>  - PWM
>
> Support is quite minimal for now, since it only includes timer, clock,
> pictrl and serial controller drivers, so we can only boot to userspace
> through initramfs. Support for the other peripherals  will come eventually.

I've looked over the platform once more. Overall, it looks very good, and
I'd still like to merge this for linux-5.1, but we are running out of time
there. If you send the patches to soc@kernel.org quickly, we can try to
still merge them in, but if anything goes wrong, it will have to wait until
we start merging patches for 5.2, directly after 5.1 is out.

I did not look at the device driver patches (clk, clocksource, pinctrl, serial)
in much detail. If you have an Ack from the maintainers, feel free to
include them in the series, otherwise let's merge the rest now and then
you can send the updated patches for inclusion through the subsystem
trees in 5.2.

I have sent a few comments. The only one that is really important
here is the missing platform check in the suspend options. Please
try to address most of the other commentsm, either by changing the
code, or by explaining why your version is correct.



     Arnd
