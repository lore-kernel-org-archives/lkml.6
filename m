Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D131C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD01B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FPG0FDDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbfAPQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:18:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34550 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfAPQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:18:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so3149477otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZH1kjbCFBnhNgMc1b6ksnUKlBzkEZ8vpRmL7Cqg2hEk=;
        b=FPG0FDDJg7gq48lLP/uJB6mtqE+I8whBdW4cqBuQQjhhr+zpxXf9YOsHUQCj1p1y9/
         LS+1ih3Azh9tPzMHInNhhsAb2NTm0Db8L9BzI3LMYX0JqutIY+3XfNUAy1g9u+IC1SDc
         m0ki+vxgk4mpqR70KFHzcNZIQt7ljfDbHDgdzbCxSUU5OAiR61yafMGwJXbmN781NIB3
         SIeasj6L4NOvbG/qjwoMbfsXFWvrcgPhpYMcaQ0ycno1tM16vGIYZnEf1RB2rc2IwGFU
         qyrs/fQTX77ifd1XEEBoA5I/8wZkqX32mVaLKo31XFEhQ6qdCQ4/7ep8WHA3jYGS8CRC
         9j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZH1kjbCFBnhNgMc1b6ksnUKlBzkEZ8vpRmL7Cqg2hEk=;
        b=MmRYjoRlAy6W30fvBof8FpqHM1BqsQAWY85tINy5X2p3rpyg+EW2V0kMjXWu3CXzk4
         LE+KsjKQm1qL5bUWBJ8cIkrltkCrZy0Us2rSTwbiZcOybo8DDWQde6ZSA7Nn7vUpdkzg
         rt9lWJYA6NYSeO/Dkqi3mp8CIgfcKKoLQ3bKjaFGPcBlU/YnhghXzVe4evxgCkhV7/Xh
         Hf7IEXmv0rXDSzMNL5ICIyd7tyLfU5QBqfbZOnKncyE5+9mRq8OVtXYDlnmpFhl3cKdw
         DCW2aacOBRgtGXvz/1LglOct1nxFVg5eQdCI6rZnT9s22X4rjIJu0VyDJcfQyPZV4ugl
         Guuw==
X-Gm-Message-State: AJcUukf4JGEmQNwy0j+AccUFXw3LJz3qmNN7mXuzjHfrkMUJlz+o/r++
        NRwmKt25vPrDxPu9Pf9YYA+upCelV7qRINPUmV9TJQ==
X-Google-Smtp-Source: ALg8bN41Uv6p35HZnI7DnvSbejJxTLdXs8a2ITFj706jVwAiIR/Go+/j6JdYxHr3eTqCyrKHkylTBmquYuMLp6Vpr2I=
X-Received: by 2002:aca:57d7:: with SMTP id l206mr5344565oib.277.1547655505206;
 Wed, 16 Jan 2019 08:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20190116153557.13720-1-brgl@bgdev.pl> <20190116160216.GA4594@kroah.com>
In-Reply-To: <20190116160216.GA4594@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 16 Jan 2019 17:18:14 +0100
Message-ID: <CAMpxmJWAT2-Fr-fxBW+DcmrrUyNyJ8rtpSvLhD74GP1DcE30rQ@mail.gmail.com>
Subject: Re: [PATCH STABLE v4.19.15] gpiolib: fix line event timestamps for
 nested irqs
To:     Greg KH <greg@kroah.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sasha Levin <sashal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 16 sty 2019 o 17:02 Greg KH <greg@kroah.com> napisa=C5=82(a):
>
> On Wed, Jan 16, 2019 at 04:35:57PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Nested interrupts run inside the calling thread's context and the top
> > half handler is never called which means that we never read the
> > timestamp.
> >
> > This issue came up when trying to read line events from a gpiochip
> > using regmap_irq_chip for interrupts.
> >
> > Fix it by reading the timestamp from the irq thread function if it's
> > still 0 by the time the second handler is called.
> >
> > Fixes: d58f2bf261fd ("gpio: Timestamp events in hardirq handler")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > Hi Sasha,
> >
> > this is a backport for v4.19.y series. The original patch didn't apply
> > due to a conflict.
>
> What is the git commit id for this patch in Linus's tree?
>

I'm not sure if you mean Linus Torvalds or Linus Walleij (through whom
my GPIO patches go) but neither has picked this one up yet. I'm not
sure why it got processed for stable already, I thought it must go
into Linus Torvalds' master branch first.

Anyway, in my GPIO branch its commit id is
8d694dcdbbdcfe4f27a52bcc6f2ce733ba5ec53c and it should get merged into
Linus Walleij's tree soon. I have already sent a PR.

Best regards,
Bartosz Golaszewski
