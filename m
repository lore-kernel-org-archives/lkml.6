Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4D8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDB72082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjyVHdET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFDB72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeLEGjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:39:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53842 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:39:01 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so19598625ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWNOXW9ydDvrlIB9EdoJvokK+6eem4mZ9KOjD+Pslh4=;
        b=FjyVHdET9DQVV7R+EoBb2CrME2QYEzFiC06DAzcicXCGdJK3XTc07Bx1TNQJF0A764
         /Am3fe13i41r/fsE6jFdJkRadVlY08IHRpab2/IKGG3gBuGS/OKYE4nUKJ2zlhQTHUOv
         U4YxwEKRpYT9weqGauYSo91oAgPh+HRWhVl+92bELTY9ltEMHDA8tbu/5Husoi1c9lj/
         Yn9OvpcFpEwSPJEnx4wYLZ8vvrTlsCZbW8FBlxbW0HD1EgA3TgO9DAXZF1k6t3HTcgtv
         OXfxwFbH23wYUJea1v7fAyZaRZDs9sE7gRIwoHzdLBJ4ppaGp8yOyyUY/WTProqEVz/O
         KQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWNOXW9ydDvrlIB9EdoJvokK+6eem4mZ9KOjD+Pslh4=;
        b=MkX/OLQZaRpSHIRxRaSIM++Ec4xLcqdaJVvoqQTF81O6vFEI5Wxn8Tkr8+kzP8J96b
         K+rJfrlUuqBv8pboSLbxU/74MXnwjG2pLvt7L+EbxpbqqPSpPhdAE0L1RKIINzrhEuC5
         xJ4NUlMVeveaInkrBYEGLLA/Byr3QbHvrfTPNnVBpwvczlQyXm0Iy+N83h+Q78TFCd54
         nUcNLlob8KAZb9u5PlPW1E91bh93TIS5VzOEeLxvB+uTWQP6b+KOf7YIFtrSMh8g2hhh
         IQ4w9O+SOKUrAdGzwUKVYs5+OUttVWTIGjqZ4u+tHf+EC+Y+0WQrqA3JZCdyd3l7eJwN
         fY9A==
X-Gm-Message-State: AA+aEWaZUo8IMHTimwH8CXWXo/evF1vs/iSzdrjX4K8m4LEAlz8guFua
        QcSK256AffJ7oApTfqeTB1+cNAeCZ+c8Lo/lJRnQeZSW
X-Google-Smtp-Source: AFSGD/Uc3iE0+PF8C/s2cZ5jToSXM4xtF9WP/aJbVQ8TaAB3V9Dzmvx4nOari+MFuWULOYZ37sWi1bzU3ohknSRfU14=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr13992067ita.65.1543991941061;
 Tue, 04 Dec 2018 22:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar> <CAFqtX7kba2UBiNoMhG79joLL2N1_Hup7y+xrKrYsesXwj6-grA@mail.gmail.com>
In-Reply-To: <CAFqtX7kba2UBiNoMhG79joLL2N1_Hup7y+xrKrYsesXwj6-grA@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 5 Dec 2018 12:08:47 +0530
Message-ID: <CAFqtX7=7E9JSevhQVXQ+=Oor_k2Yk_eiZRmC2zStXUD8ncVQ+g@mail.gmail.com>
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

On Fri, Nov 16, 2018 at 8:45 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Thu, Nov 8, 2018 at 8:14 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove linux/tty.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  arch/arm/mach-sa1100/hackkit.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> > index 643d5f2d9af9..0016d25e7deb 100644
> > --- a/arch/arm/mach-sa1100/hackkit.c
> > +++ b/arch/arm/mach-sa1100/hackkit.c
> > @@ -22,7 +22,6 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/mtd/mtd.h>
> >  #include <linux/mtd/partitions.h>
> > -#include <linux/tty.h>
> >  #include <linux/gpio.h>
> >  #include <linux/leds.h>
> >  #include <linux/platform_device.h>
> > --
> > 2.17.1
> >
