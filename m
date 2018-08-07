Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D948C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337882174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J491FvLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337882174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389552AbeHGQlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:41:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43778 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:41:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id a14-v6so1109890pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pe3BpNLVnZGrvO8hDi2pRavfHXAY2cgIaUw9o3R4Ols=;
        b=J491FvLCGV1m6X7OqS5cOzMdZHoN4lJDsWi32JhDp44gfiwERisccEH2GVEaMGjFWi
         wVTguo0/Yn9+GEXvZmABXFVV4tfri2JoU+8KI6JFenDrE0U3YrNYnbqfqFplUVGFUBTv
         GDXomIMfhLrdZNxm+FfGBZXqieicmfQqVkzccOFYwnFZpVI1Ytc6yEGudnFU6DybTFoE
         9KXEBSJJ33c+FfAcAm7yaKn1w+ry09tJsnW90b33RNdoP8uEPM5ASxpWWDwV0crM/i9q
         O5QYTO3XCfPMCX9mrNeAQFvCzcwODYSDXZB3Fh1zg9/MCLHqWoleEsEw3YMakh9t3P7Y
         Q6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pe3BpNLVnZGrvO8hDi2pRavfHXAY2cgIaUw9o3R4Ols=;
        b=JV0SXV4VHDwEUH1DXToer7DvIOR7jXpSMeQoxIjpdFuh0qLYwrlhk+evdVd2n1BETv
         4ERtlC3hye1cVb9J+TCN9WXejuBUp4UUg9lGF9CDqvYzhYUUGYGHUdeFMCbS+YhbI86X
         llpZ2vFhbw8EvcEoILe5SnAznq4cVpNB85vVlMXHNE6ipAVPOt+3e2KkDwfqb6f2qAPh
         4mGeAo0c48H1ORcexYPHo5CbejsjriG0u9v2yac4VPJaOwWi48YNifp1UNflBWWdyQfj
         X1/MBVUPMn5nn67eAcgN8bmqLqWG8tcQTjWX7b2Hpi5YVbIdzFTYANez7GFGVGKbbHQq
         v64w==
X-Gm-Message-State: AOUpUlH7e89qpABcZG/1g+SMcaT/A3gAseJ5gziXwPOXM742GuzXglCf
        V7gR5sHZ3u7vWz6waf3Z1XNVrRkTFe5Fwny5LwztRw==
X-Google-Smtp-Source: AAOMgpeUOkwxtqkIpNTGP8de/YlPoxoHFOO3NrmgT2WVMrN+w3aKWKGEkAHW2Qiv+oOhY1zCqwSFiQh3eB2IeFYmqlY=
X-Received: by 2002:a62:3184:: with SMTP id x126-v6mr22325236pfx.49.1533652035137;
 Tue, 07 Aug 2018 07:27:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 7 Aug 2018 07:26:54
 -0700 (PDT)
In-Reply-To: <20180806221834.GA140172@dtor-ws>
References: <20180806221834.GA140172@dtor-ws>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 7 Aug 2018 16:26:54 +0200
Message-ID: <CACT4Y+a0=RxugZyD_HZN7nOjxOY2zkKugHfUfnDBkVv3k_WdKQ@mail.gmail.com>
Subject: Re: [PATCH] Input: do not use WARN() in input_alloc_absinfo()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:18 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Some of fuzzers set panic_on_warn=1 so that they can handle WARN()ings
> the same way they handle full-blown kernel crashes. We used WARN() in
> input_alloc_absinfo() to get a better idea where memory allocation
> failed, but since then kmalloc() and friends started dumping call stack
> on memory allocation failures anyway, so we are not getting anything
> extra from WARN().
>
> Because of the above, let's replace WARN with dev_err(). We use dev_err()
> instead of simply removing message and relying on kcalloc() to give us
> stack dump so that we'd know the instance of hardware device to which we
> were trying to attach input device.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/input.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 90453e2ab6cf..260f00ebe34d 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -481,11 +481,19 @@ EXPORT_SYMBOL(input_inject_event);
>   */
>  void input_alloc_absinfo(struct input_dev *dev)
>  {
> -       if (!dev->absinfo)
> -               dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo),
> -                                       GFP_KERNEL);
> +       if (dev->absinfo)
> +               return;
>
> -       WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
> +       dev->absinfo = kcalloc(ABS_CNT, sizeof(*dev->absinfo), GFP_KERNEL);
> +       if (!dev->absinfo) {
> +               dev_err(dev->dev.parent ?: &dev->dev,
> +                       "%s: unable to allocate memory\n", __func__);
> +               /*
> +                * We will handle this allocation failure in
> +                * input_register_device() when we refuse to register input
> +                * device with ABS bits but without absinfo.
> +                */
> +       }
>  }
>  EXPORT_SYMBOL(input_alloc_absinfo);

Thanks!

Acked-by: Dmitry Vyukov <dvyukov@google.com>
