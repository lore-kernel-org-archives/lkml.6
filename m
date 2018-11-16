Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95752087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2PscZ+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95752087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbeKQB2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:28:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQB2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:28:12 -0500
Received: by mail-io1-f67.google.com with SMTP id h19-v6so17292653iog.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJClaqXsMztzzxkvSYNmcX25WE9GvTF2Z0MgqIFayfg=;
        b=B2PscZ+O4/Mn2zxlhAd1ths139lX50IVCepLyhB0B8/2JiYf/FC22hWM8h4WQlJsHr
         7yVGukgH1Qi2WNrn5WToLj6FoEvlZVZ5q9xenbt80FGr1YJiDgRiqD6ESizR0to0OsxY
         JYk5V4ol5Z5iQyxoW6+dboV5PMKsg6ZbMy5sg9GzlTsRZKVHQWsIK0hEChB4Q7OV6EeT
         4Gv9GMnbEuwW91sj/dN2wTMROc6h64j9ah1G9/Tqor3UpT6zzOSNbXO3dhSoe8V0xVYl
         kkObKnLQoxqjWVaXTe95DCghQ16cE0u0UyGL1g4Xna6Gwl7qNIEb1EclLZO+LHuvLf5e
         xo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJClaqXsMztzzxkvSYNmcX25WE9GvTF2Z0MgqIFayfg=;
        b=RuCb8nAE4tE5xuxeznX/QUpYXb4EFzn2XQWKoU4i5cebIeDd7LYF2GrpK/EqfYnS4f
         S8Wxjp8Y8yyrlxhc3j+4LfVz7hjSc3empUtsNtgySBLZE1VTIehi/YfRnCBmYCMZHm1c
         CzSa2P+Y+auVGDRF77gQXNmSC4nF9U8o1SbiuY09hXvOTQt7F8JGfycnvi0sY2S9uoU3
         DqlXjfO14L/uo3p7QPuOfx7/MAF+bN9ikdQEzFrBgiFN8GSLyXUUADkevj+ffFxX688D
         D4oJakSGIbkkNpk51/vhL2qCinsIP96NlXdWZ8QYQnZGt7yOnbVllLcIUIP86Jb3MAGV
         Qljw==
X-Gm-Message-State: AA+aEWYmy0EuEOiJV36j+QpBzmDwKWeAM3XbSBjcgNsUplDgrAHN8c9c
        CJ1wFku1bgkD+bEZWsB5aSMCovFWAq0NpxrZTzM=
X-Google-Smtp-Source: AFSGD/VKz1l7PNHNhwQPh7qfuo9nrSTfT8yoQWSVrhhBo3X4J+TeDKCAHwrZL1rUvCI3V1bxhw59ziB/xasOz6mZZc4=
X-Received: by 2002:a5e:db48:: with SMTP id r8-v6mr5489259iop.165.1542381325057;
 Fri, 16 Nov 2018 07:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Fri, 16 Nov 2018 20:45:11 +0530
Message-ID: <CAFqtX7kba2UBiNoMhG79joLL2N1_Hup7y+xrKrYsesXwj6-grA@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/hackkit.c: Remove duplicate header
To:     linux@armlinux.org.uk
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 8:14 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove linux/tty.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Any comment on this patch?

> ---
>  arch/arm/mach-sa1100/hackkit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 643d5f2d9af9..0016d25e7deb 100644
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -22,7 +22,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> --
> 2.17.1
>
