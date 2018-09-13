Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBEC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAEE20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQdjBkur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADAEE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeINBHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:07:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45104 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeINBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:07:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so5862658lff.12;
        Thu, 13 Sep 2018 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23cXMf47zlG+EXF0BN9s0/N/8EQyzAWSeFPZ7wusQ0M=;
        b=sQdjBkurYhDtyIpVEU5d1yW1iamI4km64Sxb+pQNBQJj5ssnxId7QM0NxrU3U2P9Ez
         Txh98jT1VJo9/owj2Pl8uTX1OMJkb970op9CbVWpl3/ijndjPfwtLv4BPNPcxsLC8mM4
         H0/+MjB/0FGrDC3yMU/Rx2Ns16AzbHDUHOf3ufy6rJaXZ9YLaNEtjCfxdAwNOkO0fnTa
         XrYft/satqpr5qEpgoLZLqU+GxzoTaDmesvADADDRfSBpUtaMEqUOwFoAqnVwskG35Lg
         meuhKmHrocl8jRjwgz6090jGzGQjUEZBYW9+8OMDmBDlcC2u+rXMT929xmFalF71GLsQ
         DS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23cXMf47zlG+EXF0BN9s0/N/8EQyzAWSeFPZ7wusQ0M=;
        b=A683z67/nLEBov22djSIg1Z3rtW8hmEFQCcHAwzoBXFZPxJkOf4OWs3LtWcxNdXqbN
         /Q43r9e4XSuDoVdq4Tn5iVAnNLII3DmMAIE9V6KyEcU1zzV6Kp344MD6MUnSHeTssyRv
         ABdutoU2vfQ8n1nOOvz+F2b61z+UrAZLHdp59ngp6TlM2wH1/bHyYwfFTpFT61yGtbPW
         Miu3b9T3WKbPrlojpFZbXeCWIxtuKW+TLFub0lTNjTc8FJsfvlOKhLZBs8EYnBExoCSj
         6X8zEmaTVvCjAptzT2/IujpcJhh/R6fFXM23mP8o2duQIUtiQLrHTD/dxN80xHgEA9+c
         ztiA==
X-Gm-Message-State: APzg51A/j9rIQy0rmhN7qvx8an35leW23oaGCPoGDbPKNVYwooWA1R2G
        cq2/LNYTwTWG8oHhvoRVQqolQ0kfgPOms1UPQk0=
X-Google-Smtp-Source: ANB0Vdage30185YePREijZciNGVyGfrQ2yDWs0DhAdv1r5D5xeSNfpnhb3KnrJYbievFu7/WB9TVp++4Qxa4FOSImQQ=
X-Received: by 2002:a19:4a09:: with SMTP id x9-v6mr6171212lfa.80.1536868584754;
 Thu, 13 Sep 2018 12:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180913163541.7364-1-jim@jtan.com>
In-Reply-To: <20180913163541.7364-1-jim@jtan.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 13 Sep 2018 21:56:08 +0200
Message-ID: <CAPybu_1WO8jcJbKJfiyCcfTahtxqSvdvyhyYaZsog05ab+OXWw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix freeing of descriptors on error
To:     Jim Paris <jim@jtan.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim

I have sent an identical patch 3 hours before you [1] ;)
Seems that we are working on the same stuff.

Cheers

[1] https://www.spinics.net/lists/linux-gpio/msg32541.html

On Thu, Sep 13, 2018 at 6:42 PM Jim Paris <jim@jtan.com> wrote:
>
> When the main loop in linehandle_create() encounters an error, it
> fails to free one of the previously-requested GPIO descriptors.
> This renders the unfreed GPIO unusable until reboot, and leaves
> its label pointing to free'd kernel memory.
>
> Cc: stable@vger.kernel.org
> Fixes: ab3dbcf78f60 ("gpioib: do not free unrequested descriptors")
> Signed-off-by: Jim Paris <jim@jtan.com>
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
