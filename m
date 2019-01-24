Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0900D217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJa0fODu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfAXKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:30:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42361 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfAXKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:30:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so3893335lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lykotvuc/Owiur2r6ivujuM/FpLfS64/shmPDMqWZsY=;
        b=GJa0fODuHUwiln1OsSIcYDxuK/36a2sQrPjjL1ivb68vkD+zjjVP7yv0fzst2qGydC
         ebtLUySg8KxkPRtyl9u21Du1gWMXiz0UX6VAwcgqsa7hHYmoOVMuZvtxcbc9T3BK7kb6
         sb8xBAVqanUpcGCgd0UWJtVUTTmRdLarONveI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lykotvuc/Owiur2r6ivujuM/FpLfS64/shmPDMqWZsY=;
        b=YS7grdd9Jiozms5MLe7beYH6ASRvNeCENhrKR6z8ZTrlyVIzPhPCsSitsbs5Jh3Ck/
         CXYwyhnc141B7JSg8mtEIRUzN3/bGT0VkgMxFOHQty2Zq2XNm2457Og3r+5E7MXgZmta
         4OflaRDVTbc96iJWhe1xUnflcjBNl9CEwIHWrQMOzKnpO5B+xZYWzgdOcf/dRuGL8IFq
         eBUFlskckk2rG6ObDHtO8A2twzRGz2O6aOKWnHVoS3kbLpHz7cglnC+y5cFRV11qpVoS
         p5ndeTAEhmNiImkjVJ18KU+Ob43WhUPCoGtcPkbW226WKdza50mX5w+irtTIMTE5gUaJ
         f9sQ==
X-Gm-Message-State: AJcUukf0b1QWO+OeNOEyUszmsumBybSOGiqRWOicXs8HEN0UmOYl+ySU
        vmKv/k4bmSWVjeC52CjfEqwsESfHSp/9HIYuC0Xnlg==
X-Google-Smtp-Source: ALg8bN4NwEvBdC003+Vfu1hm2XKJ+upEKFkLEGvgX9sADXYkXB7n8P4lJrVDsISqhQ0oaro5MmtZcIwjctkEQQ14Rx4=
X-Received: by 2002:ac2:53b1:: with SMTP id j17mr4654943lfh.167.1548325830860;
 Thu, 24 Jan 2019 02:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com> <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
In-Reply-To: <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Jan 2019 11:30:18 +0100
Message-ID: <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 6:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Thank you for your review. While I think you're right about the issue
> being present in this driver, I'm not sure it's really a problem. Do
> we actually require every gpio-controller to also be a stand-alone
> interrupt-controller?

Absolutely not :D

Just GPIO is fine.

> The binding document for the GPIO module doesn't
> mention this - it only requires the gpio-controller property. Without
> the "interrupt-controller" property dtc will bail-out if anyone uses
> this node as the interrupt parent.
>
> If I'm wrong and we do require it, then I think we need to update
> Documentation/devicetree/bindings/gpio/gpio.txt.

What is weird is if a driver with DT bindings not mentioning IRQ
and only probing from DT start implementing IRQ support, that
becomes quite inconsistent. So then max77650_gpio_to_irq()
should just return -ENOTSUPP
or something for now, then it's fine.

We can add the (complicated) IRQ handling later.

I am trying to eat my own dogfood here, I was sweating all
last night trying to implement a hierarchical IRQ controller.
There is no running away from that now. :/

Apparently doing hierarchical IRQs demand that all irq
controllers up to the top-level SoC IRQ controller support
hierarchical interrupts using the v2 version of the irqdomain
API, and currently it seems like the ARM
GIC seems like the only top level IRQ controller that can
do that.

Yours,
Linus Walleij
