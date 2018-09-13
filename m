Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8879AC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40540206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/fVXnoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40540206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeIMTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:22:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46670 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeIMTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:22:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id e23-v6so4912872lfc.13;
        Thu, 13 Sep 2018 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOgcO6mBn1jiAi0Ex1ECqXA+TeFJik2cY4nC4ifTTyQ=;
        b=b/fVXnoXRam31htcGgTY+/CGn2uN2AKJ4RQE9kPFPMFXXkuJKdjaG7EwgB1MH7l2Y3
         3yESH8WP8X15t3pIQc8LjnVvMLhzvM8JuQS0ZuYP2ymfndqWKs5gKjQ9L29FZRPgCIBw
         OGbUU2KHt9UpEUIPIOrtW4JwVqBI9nowTMDMqY7k0iZm9oIQo0CmOVnTYBqYmb/IfeB3
         FYPohaa29BwKAon96SCysFV9tdGlEDz/5fP8k92/EWtrgIu7DJYvzZ6HkOo4jwkuAj0E
         0N9ryg9sdnj99WGWr0nl1ORfojMTl0/4HJspilrdkFoQXzAKQ+wEhOThP5ZbR9NNguBM
         ShQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOgcO6mBn1jiAi0Ex1ECqXA+TeFJik2cY4nC4ifTTyQ=;
        b=JKQ4ROCjYLsKKhzx7ofZ6amOXlLSh4r0PXx1AtU0tLQG2GUmGSEdbjt8fmCKhOYmwX
         xLwg7lY+rRynazBvBbtJTJAqvnBZnSmS07F4omD7kQrEqikxm/d2G9NWVwkZlJx13FlD
         qxNjn4W5ON8r27cb47S4xh1axR0RWamsTj5T1HnEvn4IZp8HjST6oS9dR3Sn3CzG5C/Q
         RaRTeD6qQzQW8JVODD7n9G/vo47jd9pacjp8lpgqR/fySAih1mrrbI6O6FXb4IGqRuqD
         z6zAdysISzh/071W1LFx1AY12gzQRYVLx4ImZZLjwzpcomZCtIRcRNRAoqFKUhU/iof9
         4aaQ==
X-Gm-Message-State: APzg51Dxx2YTlNo+3C9+txSU6fX6DgFx/iIVBT5azV6O95OMQg1/4JbK
        F4MaBYNvoa47LLWxT2Yngs2yQgnDzsO2HHArKH8=
X-Google-Smtp-Source: ANB0VdZJQmevUefTImclxh180T+PLEXJ9x1IKrcD+i657uDY8u+oNXnkbFNq5xokeGIW7XZM8ZMOXgI2D4BKB9qLGqk=
X-Received: by 2002:a19:4283:: with SMTP id p125-v6mr5249890lfa.104.1536847936567;
 Thu, 13 Sep 2018 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
In-Reply-To: <20180913133704.15739-1-ricardo.ribalda@gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 13 Sep 2018 16:11:59 +0200
Message-ID: <CAPybu_1e8qTGY2W5sXVMPU95dfSRqKUq8yQmSKCOrx5rZU13aA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Free the last requested descriptor
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     timur@codeaurora.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: Jan Lorenzen <jl@newtec.dk>
On Thu, Sep 13, 2018 at 3:37 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> The current code only frees N-1 gpios if an error occurs during
> gpiod_set_transitory, gpiod_direction_output or gpiod_direction_input.
> Leading to gpios that cannot be used by userspace nor other drivers.
>
> Cc: Timur Tabi <timur@codeaurora.org>
> Cc: stable@vger.kernel.org
> Fixes: ab3dbcf78f60f46d ("gpioib: do not free unrequested descriptors)
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e8f8a1999393..a57300c1d649 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -571,7 +571,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>                 if (ret)
>                         goto out_free_descs;
>                 lh->descs[i] = desc;
> -               count = i;
> +               count = i + 1;
>
>                 if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
>                         set_bit(FLAG_ACTIVE_LOW, &desc->flags);
> --
> 2.18.0
>


-- 
Ricardo Ribalda
