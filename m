Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7CAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A32082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 09:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyCYe7zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9A32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeKBSoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 14:44:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41507 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeKBSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 14:44:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id 189so2014685qkj.8;
        Fri, 02 Nov 2018 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/9Iyp3okCvgWgBh8Hzeaag1xV5h4AxyW3BErMjdIjI=;
        b=QyCYe7zc4ddAL7Q2T5MD4hwIcZDsShhGz+xU0lVFSYNOqISLvAsP5ySGeylsIuZniH
         OWuSSYulG+kBRn8zFLWkb/PpAlXyRR/aU4x7Z1NvlnVj4p0xeh7ucr6HKiI2ZRCOEP52
         TNbfaKtN7JIYxbQ2Zg4JHikM4fn5lbzM5VXsPlKmMLNUNaXEkwyxGwGzcRB2MLcoaTRm
         cGo1/3td+KGQtdbicnVbHWVUtoujW5c9uNog8YH7mnpI73OTA2t6zXoHDeqmKZaPM+P5
         Wje+cptnSINp0ONs45zuiah5ERiXzQi7scWbya4k3KFBVRS5BDeHQWeTt8QzLs085NxP
         xaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/9Iyp3okCvgWgBh8Hzeaag1xV5h4AxyW3BErMjdIjI=;
        b=uh6LQw8eC7gWFoJLvh5JKHzVp0mNY1mGAYX1KqaZBx1NO1bD2hL8AFwTy7TgykmhEH
         lCclZhz84ducLxuVN4Uq7ee2nekjlMCSftypjf/9UFXm9K1/gKJXibLEp/fJpCX8ZEQW
         Ls3A0u7mReCxWy/kGXrhJv0G0Fa+clUU/GjC0Cy6KaNd/F+PoR5ogWKgktfk+8tHam7S
         FfDA/1ZlRdB5AuIntJQKC3HQLf/xkX/oi+5f4EiOuRnKSwYvZ67w8sNln5uhzJM3QYL2
         Hzyuox1G1pZ2i1YPoD8w+jkXJjSYioIgAghrTSbCTvSZRfyMK+ajobuiYGSZfNHtdxqA
         GczQ==
X-Gm-Message-State: AGRZ1gIWtTRY9ybU1gFSSLBSd6ZVD5yUxm+/03vjOARe263KbhLNGUBE
        XYpvLlZRXoMi7903AWMYj3W2ghmsxZH6xlGnyCbBArrPFXU=
X-Google-Smtp-Source: AJdET5dR/Mm9hptPvTXvCKjguRb1sMHJNIL7TYwQwDnCtZBY+hqsMy30xW8tTAOZV5VWr55emhgJjGX3sg4SbU8C5ng=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr9473887qkf.33.1541151451575;
 Fri, 02 Nov 2018 02:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <1541163378-54047-1-git-send-email-peng.hao2@zte.com.cn> <1541163378-54047-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1541163378-54047-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 11:37:20 +0200
Message-ID: <CAHp75VfxGpR1PWaP+FbTcgxsM8sRgyuCZBjTigZWbxJShFDrxQ@mail.gmail.com>
Subject: Re: [PATCH V6 3/8] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:46 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.
>

0day complains b/c of 1st patch in the series.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

This wasn't suggested by me. It's your idea to support to MMIO.

> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 49c59e1..22fb487 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -41,7 +41,7 @@
>
>  #define PVPANIC_PANICKED       (1 << 0)
>
> -static u16 port;
> +static void __iomem *base;
>
>  static struct acpi_driver pvpanic_driver = {
>         .name =         "pvpanic",
> @@ -57,7 +57,7 @@
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -       outb(event, port);
> +       iowrite8(event, base);
>  }
>
>  static int
> @@ -80,7 +80,11 @@
>         struct resource r;
>
>         if (acpi_dev_resource_io(res, &r)) {
> -               port = r.start;
> +               base = (void __iomem *) ioport_map(r.start,
> +                                       r.end - r.start + 1);
> +               return AE_OK;
> +       } else if (acpi_dev_resource_memory(res, &r)) {
> +               base = ioremap(r.start, r.end - r.start + 1);
>                 return AE_OK;
>         }
>
> @@ -101,7 +105,7 @@ static int pvpanic_add(struct acpi_device *device)
>         acpi_walk_resources(device->handle, METHOD_NAME__CRS,
>                             pvpanic_walk_resources, NULL);
>
> -       if (!port)
> +       if (!base)
>                 return -ENODEV;
>
>         atomic_notifier_chain_register(&panic_notifier_list,
> @@ -115,6 +119,8 @@ static int pvpanic_remove(struct acpi_device *device)
>
>         atomic_notifier_chain_unregister(&panic_notifier_list,
>                                          &pvpanic_panic_nb);
> +       iounmap(base);
> +
>         return 0;
>  }
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
