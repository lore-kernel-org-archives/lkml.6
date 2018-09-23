Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFD5C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887CD21479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuGBSzyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887CD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeIWVb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:31:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37039 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeIWVb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:31:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id n6-v6so6446076qtl.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IoX21+HxmVne961HBg+0/13LQqqkjwflCm/H8JikV5M=;
        b=RuGBSzyMc6eXgM6+L8sOOEo5ZsywU3YFsQ88cdSV3sXfLAz7epBTmVQXZHD1/3TZ0G
         HQkb2BAQoW6aiTRq9DaL11OF989Mb7rsJVqeHIzywJBrd1jdvHMkSsmQNXnET3Ce7Mub
         usXiHyh/OrbvPbiGySqPcANN85GGgRtRP8MFlfUqZKAiMeSBlmaq1OGUGi88b/0WQ/yQ
         fzsSzjbl26wrSEPfNNeGnWB1AoUGZFPH0hRpAjevHpzkSSrbQ6uDIn40bLF4EITNg9NA
         47CA7L5cPrcoxVn3nBs32FWgaAMokLyO1YZm/4Pfzjx8qySHXAwpGVGhMirvArtY8pdP
         cCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IoX21+HxmVne961HBg+0/13LQqqkjwflCm/H8JikV5M=;
        b=Y2IXBZlMoAIG/JFhF2vRDupMCmUUagZO1bZXhzFttekHI2nX3a7if/Zi2HCJ8VtRqv
         UBJ/kdHFwdtPqXOwP4dgYaJrh9mBCuUScBGHgPk2AtE+05xgD4Z12Y+OWM4VmE95Q+5X
         ikk1R37TjCJCHiKk8dpWBAC8RPhbvnAyiI3paJME2WeDH7eK6jL3gyzPNH4r5N3gqM5e
         xXAT9uK3Z+rMl6W9vy7YDwWFaUS5jDmJvqmNkDpO+5uyNBaRh6qKJpCXByX1VZp/7i6b
         qRfinomDRhKnfx0AxgQZkj8NaIqWq2DzzQnOZ4EN3GGsGnHpDpHb9qf56HwDmoRy2EzH
         tIHw==
X-Gm-Message-State: APzg51BWKI2OyC/J5E3FlR8SgPFHyadIQyptiJnikBwdIgjwZ4Wab2sC
        6aoS2VFmJLCFdGiSL1EV9AiJ49Y2Cm0loZqyNfQ=
X-Google-Smtp-Source: ACcGV61rZDZVJyeXTK2CqK0AEWCwrDE3s4uOZIUsDuE8QzUGKZuSzx6xICFaeUNN+RoZIzzQvEB/eHyupwcyoVviF4Q=
X-Received: by 2002:ac8:3059:: with SMTP id g25-v6mr4549589qte.136.1537716815569;
 Sun, 23 Sep 2018 08:33:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 08:33:15
 -0700 (PDT)
In-Reply-To: <20180923143344.2709-1-benmoore422@gmail.com>
References: <20180923143344.2709-1-benmoore422@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 23 Sep 2018 17:33:15 +0200
Message-ID: <CANiq72ncdwQi1HC+2pcs+HOep-9_mrG=W4UExz0Dmni9V3A9Cg@mail.gmail.com>
Subject: Re: [PATCH] drivers/auxdisplay: TRIVIAl removed unnessecary braces
 from if statements
To:     Ben Moore <benmoore422@gmail.com>
Cc:     trivial@kernel.org, willy@haproxy.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sun, Sep 23, 2018 at 4:33 PM,  <benmoore422@gmail.com> wrote:
> From: Ben Moore <benmoore422@gmail.com>
>
> removed braches from single line if statements
>
> Signed-off-by: Ben Moore <benmoore422@gmail.com>
> ---
>  drivers/auxdisplay/panel.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
> index 3b25a643058c..0e4a7260dcc0 100644
> --- a/drivers/auxdisplay/panel.c
> +++ b/drivers/auxdisplay/panel.c
> @@ -695,11 +695,10 @@ static void lcd_send_serial(int byte)
>         for (bit = 0; bit < 8; bit++) {
>                 clear_bit(LCD_BIT_CL, bits);    /* CLK low */
>                 panel_set_bits();
> -               if (byte & 1) {
> +               if (byte & 1)
>                         set_bit(LCD_BIT_DA, bits);
> -               } else {
> +               else
>                         clear_bit(LCD_BIT_DA, bits);
> -               }
>
>                 panel_set_bits();
>                 udelay(2);  /* maintain the data during 2 us before CLK up */
> @@ -1025,9 +1024,8 @@ static void lcd_init(void)
>                         lcd.pins.rs = DEFAULT_LCD_PIN_RS;
>                 if (lcd.pins.rw == PIN_NOT_SET)
>                         lcd.pins.rw = DEFAULT_LCD_PIN_RW;
> -       } else {
> +       } else
>                 charlcd->ops = &charlcd_tilcd_ops;
> -       }
>
>         if (lcd.pins.bl == PIN_NOT_SET)
>                 lcd.pins.bl = DEFAULT_LCD_PIN_BL;
> --
> 2.11.0
>

A few more things (Ben's first patch, sent to me first in private):

  * The subject could be better as:

    [PATCH TRIVIAL] auxdisplay: remove unnecessary braces

    i.e. TRIVIAL inside the [...] (which will not appear in the Git
commit message); unnessecary -> unnecessary; drivers/auxdisplay ->
auxdisplay

  * The commit message body ("removed braches from single line if
statements") is redundant with the title of the commit (and has the
typo "braches"). You could say, instead, say something like "No
functional changes."; or if you tested that it generates the same
object file, something like "Tested, no codegen changes."; etc.

  * You can remove the "From:" line.

  * I think Willy uses the w@1wt.eu address nowadays.

  * It would be great if you can try to look for similar instances in
drivers/auxdisplay/* and send a v2 of the patch (you would need to say
in the subject "[PATCH v2 TRIVIAL]").

  * Don't forget to Cc the general linux-kernel mailing list, please!

Thank again for the patch and welcome to the kernel!

[Jiri, I can pick the v2 of this in my tree if you prefer.]

Cheers,
Miguel
