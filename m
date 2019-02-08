Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539220857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmBaQFmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfBHNeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:34:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44124 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfBHNeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:34:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so2963055lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hT1KpY7uPwpUpPExJQn6LeYhsQy0SUPQZ6+Yia9oUwg=;
        b=GmBaQFmcXEalcDOu4gHMRZ21n9xIEPIl9HxZcel8s5jmjPclNDRkM4jbYPMfZILZtA
         nnxOjLNCSOby5vRyTXetSzD+ojNuR5vMkDE5hklsCSQEZjk1KqK37G3a9KW3TyFd0EFD
         cJw13Q7Y3Gc/vFmTKlggFs7nAamUXu/VL7bWdsU+LNL9ftKHQPvJy2xsAgt+IzTghvqo
         QrkcLZlbnh5G48Gei1pRR1wIbb5ulGE6Jg1f7cakCHFkfgSlH5bwD2ZdfSW60yGlbsm+
         VuVSFBk2Hxa/JfLRxgLLHUF416rLsAmAENaR/ZEaeywVqL+I1Oms7MWluxOZdcz96CAJ
         DlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hT1KpY7uPwpUpPExJQn6LeYhsQy0SUPQZ6+Yia9oUwg=;
        b=mhUw7HLIEgnXfMk2dHQKq1QS2vXW7IsFi8aGgLMfnH2/Fs/uJbtUX8R3Q9A6YRNxH6
         CpWo/+uFeIVvUIhefhQcP36lM2d18PKdfO3lJz+5V1PZyjp7OidrKLwJ5xqI3MGscehi
         3ebIYfz+flSpl+JNiSTp0L1k/UY2syuoHflG7o7Dd1X7dAOvHDjuTjLggYxOfRjCEmS3
         vXBW19puS4GcYK1Gstz9MAgd2k2NlUfGBiQSOeJ9QdUQA4/HQ8V51C+0TW4+tmC2EI9G
         9IgYBqmDfGPai4cks/HBZpIBiU8fzLeTrLB5KrtJvLlu80OPCwtlr3nq8OzwSX0ae6dg
         5dXg==
X-Gm-Message-State: AHQUAubziU+dY0OXVFgPJ8/Mn68c++nFEld30T3/GWu7MUYm7/7gy6mW
        0lURakFIJu3Q0YRZtFzM9GC2bwwlR6qM6jfSUsH8Lw==
X-Google-Smtp-Source: AHgI3Iaa0doTUcfElIHZkbhRRkiTXKSNmm7NJ0pPtA0V5s51LJ2KkNa6Zn53Exc4EUrJT0jR4A1Sy1mIw09I8Xbj+Os=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr13293584ljb.126.1549632847307;
 Fri, 08 Feb 2019 05:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20190205102546.29457-1-brgl@bgdev.pl> <20190205102546.29457-4-brgl@bgdev.pl>
In-Reply-To: <20190205102546.29457-4-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:33:55 +0100
Message-ID: <CACRpkdakUOgnkNb1FVfycoq4u50wVo8Aj_57EUBs5QkvrYN7wg@mail.gmail.com>
Subject: Re: [PATCH 3/8] ARM: davinci: omapl138-hawk: use gpio lookup entries
 for usb gpios
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 11:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add lookup entries for the vbus and overcurrent gpios for omapl138-hawk.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
