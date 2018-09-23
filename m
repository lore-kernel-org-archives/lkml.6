Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05CECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9010C21479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9010C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeIWXKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 19:10:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37135 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbeIWXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 19:10:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id w8-v6so7108687vsl.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 10:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g226QrU0rfDNU+hW8okZJGhf58i+AkXwu/pGhdlpsjI=;
        b=dPnh7tvRHkApTqA1HimqdMokEo2BoFqPoFLViRgRQ2g69gNizH0ecq1GimejKZSkQM
         ac0NInThGWWIES/5gvUrZ7pLbgJKZPe6AODg4VFGGGn6MJGMpljqP2xN/lNPjgdCa/KR
         VX56VXkvVAxXVQKXjtGPQGlUomuuSA3+ZrA5TgJ5RqGtpTPNtG6mZK+300COQUtaqGhs
         Ei9dL3HJMTOCeSDvfNvQxjw7EcR6jDlhzNzPl8moCWTgHmFvTi92cuYb9J2vxmGKNNvv
         QRjDfMfJ5dm+y98Hv3MnmOeEMojVrsLm1yV7IuDVzIr0CPdAJISI2xuNmxGjVc+3N8ou
         BcOA==
X-Gm-Message-State: APzg51CGr7tqirmhbNYxhl2nROd8OtnlyHlCFa/KsLBVpOCo6G/IMpME
        JncxnjSN1m7oAjMWSlaq5A6lLB2C9AwJmYiJ92Y=
X-Google-Smtp-Source: ANB0VdZQjEuZWPwlAvK2G2D4horBa+jRkHZLTbobpHxVS+oXlKwhOXbd07Asjs5u76f3BT1yqMWIPWQgq7aFPIpYNIg=
X-Received: by 2002:a67:d19b:: with SMTP id w27-v6mr1584968vsi.166.1537722760992;
 Sun, 23 Sep 2018 10:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180923143344.2709-1-benmoore422@gmail.com> <CANiq72ncdwQi1HC+2pcs+HOep-9_mrG=W4UExz0Dmni9V3A9Cg@mail.gmail.com>
In-Reply-To: <CANiq72ncdwQi1HC+2pcs+HOep-9_mrG=W4UExz0Dmni9V3A9Cg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 23 Sep 2018 19:12:28 +0200
Message-ID: <CAMuHMdVMrYmMHt3yAD-pajrWCs27MQdkfMmQT_gHkWz44xNS9g@mail.gmail.com>
Subject: Re: [PATCH] drivers/auxdisplay: TRIVIAl removed unnessecary braces
 from if statements
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     benmoore422@gmail.com, Jiri Kosina <trivial@kernel.org>,
        Willy Tarreau <willy@haproxy.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

On Sun, Sep 23, 2018 at 5:33 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Sun, Sep 23, 2018 at 4:33 PM,  <benmoore422@gmail.com> wrote:
> > From: Ben Moore <benmoore422@gmail.com>
> >
> > removed braches from single line if statements
> >
> > Signed-off-by: Ben Moore <benmoore422@gmail.com>

Thanks for you patch!

> > --- a/drivers/auxdisplay/panel.c
> > +++ b/drivers/auxdisplay/panel.c
> > @@ -695,11 +695,10 @@ static void lcd_send_serial(int byte)
> >         for (bit = 0; bit < 8; bit++) {
> >                 clear_bit(LCD_BIT_CL, bits);    /* CLK low */
> >                 panel_set_bits();
> > -               if (byte & 1) {
> > +               if (byte & 1)
> >                         set_bit(LCD_BIT_DA, bits);
> > -               } else {
> > +               else
> >                         clear_bit(LCD_BIT_DA, bits);
> > -               }
> >
> >                 panel_set_bits();
> >                 udelay(2);  /* maintain the data during 2 us before CLK up */
> > @@ -1025,9 +1024,8 @@ static void lcd_init(void)
> >                         lcd.pins.rs = DEFAULT_LCD_PIN_RS;
> >                 if (lcd.pins.rw == PIN_NOT_SET)
> >                         lcd.pins.rw = DEFAULT_LCD_PIN_RW;
> > -       } else {
> > +       } else
> >                 charlcd->ops = &charlcd_tilcd_ops;
> > -       }

Please keep braces for single-statement branches if the other branch needs
the braces.

I think running scripts/checkpatch.pl on your patch would tell you about that
rule.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
