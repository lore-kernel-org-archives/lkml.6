Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C238C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D27220837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 05:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw0H3/W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D27220837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLIFW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 00:22:28 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54782 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeLIFW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 00:22:28 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so12824148ita.4;
        Sat, 08 Dec 2018 21:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dr5fiuGTimj0QyQjA4YwKZqOjOBmbivB5a9ee69i4UQ=;
        b=Vw0H3/W45mCQpt9kSE0EACAjy3dFTpq37TcpmlnJlBLHe1ZFAtzUmKRzDQMYqhV14t
         2jmsLLYmqv+ONVP9rov9+w1Op7LYpWfKzcjcjonbwaSN/BdSmbG24+CEDrmcZ2vhs6pq
         ABXtJ6dwzB+d8E5ASPWeCqN8gnrbn6zKuuquwOZkeX35SN/w+xlCSX37ihiya1j+zqxw
         VhNj4tLcsiM6pc6tajssZhnEJdbrU8y4fpNKfdV6voNnOa7KyC4LiMax4toGQzPk8q36
         98D11Bfc9vlJyA9XZsLta0+HtxD49Hy5x8DrzVBja+PNZvilgPF1a92fMpcQ9Op8fbnz
         8liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dr5fiuGTimj0QyQjA4YwKZqOjOBmbivB5a9ee69i4UQ=;
        b=lsrLuh2A+L9+5BzH2tD189GPSuOVrgy7Ptv9eQuQMO/8hW43K/Ftl56tRCZsy7B/1R
         /2WXLQn4FRP0fcn2R9XG17Ag448Duuw+ldLZNRDAGA/rhA0RPzqXRWl9Ce6Bpn9AmDGA
         w2mNdjdJJ+/FvN16sJjMIRXyobWFTxtOyIr0ze54qOk1L/pqv4cORBNadiwJQWF32NZZ
         bKTlpuk5zBmIdMzsYNW3bwqJkxFS4LW79kgbbNhlm/dN0hZpy75TGIbbTLElG+DGLzcJ
         0ZABwYkmyH5tw6Dq699EQBpGIQGicytgAyUfCvJ4z6lS6ufqMbF2kC4LqByutnhFnxtf
         f0iA==
X-Gm-Message-State: AA+aEWaNxC86pBxWpFV4fWpfIctBEiubOSO4XIBAhQyjdZ/GLRGFamyu
        ZkevhPdPw2p+1z6b83wC9dPYsYlOTbMkJgO7nt0=
X-Google-Smtp-Source: AFSGD/VjcYFO0Fuignhc7Oj1PXJ5icmrHT51LFiI3G+uzaQXicRjdXboyUEwS1uIV/H0KIfPVNc7U8dRvIwlpIMuQaQ=
X-Received: by 2002:a24:648f:: with SMTP id t137mr6958213itc.95.1544332945963;
 Sat, 08 Dec 2018 21:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20181121143513.22961-1-tiny.windzz@gmail.com> <20181129183657.GD54791@dtor-ws>
In-Reply-To: <20181129183657.GD54791@dtor-ws>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 9 Dec 2018 13:22:03 +0800
Message-ID: <CAEExFWuw5Fr_pjS1vLm-gq1VnJfZ5E7rw01LFU4-M1dwOAoM2A@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 add of_node_put()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:37 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Yangtao,
>
> On Wed, Nov 21, 2018 at 09:35:13AM -0500, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/input/serio/i8042-sparcio.h | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> > index 796289846204..5495bc035518 100644
> > --- a/drivers/input/serio/i8042-sparcio.h
> > +++ b/drivers/input/serio/i8042-sparcio.h
> > @@ -108,18 +108,21 @@ static struct platform_driver sparc_i8042_driver = {
> >
> >  static int __init i8042_platform_init(void)
> >  {
> > +     int rc;
> >       struct device_node *root = of_find_node_by_path("/");
> >
> >       if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> >               /* Hardcoded values for MrCoffee.  */
> >               i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> >               kbd_iobase = ioremap(0x71300060, 8);
> > -             if (!kbd_iobase)
> > -                     return -ENODEV;
> > +             if (!kbd_iobase){
> > +                     rc = -ENODEV;
> > +                     goto out;
> > +             }
> >       } else {
> > -             int err = platform_driver_register(&sparc_i8042_driver);
> > -             if (err)
> > -                     return err;
> > +             rc = platform_driver_register(&sparc_i8042_driver);
> > +             if (rc)
> > +                     goto out;
> >
> >               if (i8042_kbd_irq == -1 ||
> >                   i8042_aux_irq == -1) {
> > @@ -127,13 +130,18 @@ static int __init i8042_platform_init(void)
> >                               of_iounmap(kbd_res, kbd_iobase, 8);
> >                               kbd_iobase = (void __iomem *) NULL;
> >                       }
> > -                     return -ENODEV;
> > +                     rc = -ENODEV;
> > +                     goto out;
> >               }
> >       }
> >
> >       i8042_reset = I8042_RESET_ALWAYS;
> >
> > -     return 0;
> > +     rc = 0;
> > +out:
> > +     of_node_put(root);
> > +
> > +     return rc;
>
> Instead of rearranging code like this, can we instead have:
>
> static inline bool i8042_is_mr_coffee(void)
> {
>         struct device_node *root;
>         bool is_mr_coffree;
>
>         root = of_find_node_by_path("/");
>         is_mr_coffree = !strcmp(root->name, "SUNW,JavaStation-1");
>         of_node_put(root);
>
>         return is_mr_coffee;
> }
>
> ?
Yes, we should do this. The modified patch has been sent.
Also, I am very sorry to reply so late.

MBR,
Yangtao
>
> Thanks.
>
> --
> Dmitry
