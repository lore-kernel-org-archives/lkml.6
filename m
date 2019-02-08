Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CA2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F602146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDhFE5kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBHPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:20:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35451 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHPUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:20:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so1815930pfi.2;
        Fri, 08 Feb 2019 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JYq6QgVoT+Gga2+GP/vm5Id4ujMr1B0NvcQ454/VSkg=;
        b=rDhFE5kgsxt/+a5C7r33yzAYzk52/aZH0IReUhuCHxtfsLeYuqTQCcNw/jF0Wu3EWd
         9Q2E5EEkIf5tDQVLFScsQJF99JSwVN+ykTe0oWughEg7+txb8V/9+JLkUKZV1BQQQHFB
         3VXoa49aY0foUgdjU+WDD7JZFadcm5bOOMjqDE7tloDRzoqEYtsUimngJ81FNYRBCWoc
         U7EelYlK8bklmCvfhokf28ddjV3SVWeGJ+jATcO8wpXlNNbHvAHckM8Lun3BXK+oD+A8
         b9dd/0yTHF24BDH+HXkV5TQV/FgHxCCdOG3FeTMDoMlK6utMeNnBEEQeq94qAExhbOsg
         qf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JYq6QgVoT+Gga2+GP/vm5Id4ujMr1B0NvcQ454/VSkg=;
        b=ZVHlSg4f0RsMuVdtYoG/n77WQWz1sYY/aY0LsO86f03W50D0P4/XGdvCfsw7FSwFyV
         Kp5rNZklgu6hFkLzBdZs98rVoPnsUDjgeQKFSqV1Ij/ySiTQG4C5G3UWql0v2cXPUoNf
         pvJVg4gPJKyoUSkEgF89xYNxdiX4kXwHGwFFwOynOvjHdndBoCk9jwBLETXBu9uTJSd/
         51yGDYuVhRLaWqjiVuNv2yg91NpDFk7feo2lYyuKC1ZDfLyv1q0UOA4HBsp6C5eZvZo5
         r7ZQyXFF/p2i2xDGo5hYwgXQE/tQR+r7a90IhErHuvFyD+TuUh1u5QUL5JfwymPdRhNs
         JPdA==
X-Gm-Message-State: AHQUAub4m4frMNI4S9OQgQO6FBJWFS9dWXGhkJ5uMFN5/1l6jAYIWHYi
        79EzRgFHziAbnL3CTNd9ke6f1uDF++mF/r3Ooto=
X-Google-Smtp-Source: AHgI3IYXneLpghvuurwj+t4X0r5umyZr261FY9i8qo4v+dYbfXxt2+zd+fc60veZrthaKiBrqVSNLMJP9W1aTcW7vdw=
X-Received: by 2002:a65:6116:: with SMTP id z22mr20721494pgu.265.1549639217537;
 Fri, 08 Feb 2019 07:20:17 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net> <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
In-Reply-To: <CACRpkdaSEZMR7LuLbO1V0k9QEBu4FWxFbq4ZL1pE9dAvNT1z_Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Feb 2019 17:20:05 +0200
Message-ID: <CAHp75VeRatTj__4Vm4wxvLQZxRf4L5RNHvZ2QAGvDBynprkroA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: gpio: AMD G-Series pch gpio platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 4:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Enrico!
>
> Thanks for your patch! I would really like Andy to have a look at it
> too, he's more on top of things in the x86 world.

Seems that is the same version sent twice. I already gave a long review on it.

-- 
With Best Regards,
Andy Shevchenko
