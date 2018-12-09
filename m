Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D8C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46ED20837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpHRcQpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46ED20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLIGQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:16:03 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38485 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:16:02 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so13200475ith.3;
        Sat, 08 Dec 2018 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vrhetxe5JEQr5YFQjqbyZU4vP8XfbVV/XNi3/NaCzFM=;
        b=bpHRcQplsjBPKIDeeMktxHK6kkbMG8Sh0a1Vv2CD/5zwnDiP/7vTEWN2gqduQdNyNV
         5jdd3VIgXX3ju/ZN4WD6mcmi6AaHAzWwBQ54DEUoMtneUa9UWYBNf0PRPTx46iTGmO0n
         9mWkoBAXepg4qj/GJ+1HyJiI8K2F3Z8CjtzJ6sylfkBtPObdZkFPhmnEgZA6jswdpq8y
         /LD2LRJ6xeHwLrm6dCKcVGKGtb5WMGDDz+ELS61wSEi4e40U++3gU+vFB/td6NkLL8IC
         p0yAHX52Dz1x3zXdgTPzryNBHZIrNKVhHJ/BYbTtSGoM0FUU4VxVS+ZeAbTYU+oO0Czx
         /7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vrhetxe5JEQr5YFQjqbyZU4vP8XfbVV/XNi3/NaCzFM=;
        b=ouYIm+VMOYeeJos5tiSCS0Due3e80LEBL2FQROL+ky+Oe2ukaHolUpV7X77eUyhVLe
         EE8QG9dNbrCbvNYGNKT36rZ/a5sR1T2VWEn6eNeyVnItu5LOLv6845MN/9MkIK6zZI4K
         Xl7xLEFNwK7mc95Zm7XeqRt9MTGG3sqUp83ut0xhbFrrXTj+YfASBrujmDj6rJUzHNLq
         mTn28CDFSD7K3CnZUkiGXbdNS2EBCfF5lmBLcXQLcYUzvDZYZqa9wLkZmmlwKelf6TQT
         voFsuAGb8pnvOvapeVaTYmChmTfessq8RMxU6FvckqLHYAM1/m6rPq854qMnVibINiCv
         IlKQ==
X-Gm-Message-State: AA+aEWanVDtOxM9RLFELHsDN+9xsv/SnOsJpDW1c6BNgsU5GTdwvAIKR
        St/STF+yOyI/kJCY2H+4eszxB93tJnsoHKm7MqI3OaXk
X-Google-Smtp-Source: AFSGD/URBu4XvDqZHL9GRgrovhuGQOKPBVTzFCMC/b9Kp5TIX2+JqTAA37C0UsLeYVp8xOIAlcmPj66NGBPZPhOi1i8=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr6916720itk.78.1544336161553;
 Sat, 08 Dec 2018 22:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20181209051900.19035-1-tiny.windzz@gmail.com> <20181209054014.GA237502@dtor-ws>
In-Reply-To: <20181209054014.GA237502@dtor-ws>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 9 Dec 2018 14:15:38 +0800
Message-ID: <CAEExFWsu-tUMv3M=i-B+tNa5bL7boOfaAs3PjcFjbDx6LAXV+Q@mail.gmail.com>
Subject: Re: [PATCH v2] Input: i8042 fix refcount leak
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 9, 2018 at 1:40 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sun, Dec 09, 2018 at 12:19:00AM -0500, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/input/serio/i8042-sparcio.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
> > index 796289846204..cc6777b4c4ea 100644
> > --- a/drivers/input/serio/i8042-sparcio.h
> > +++ b/drivers/input/serio/i8042-sparcio.h
> > @@ -111,13 +111,17 @@ static int __init i8042_platform_init(void)
> >       struct device_node *root = of_find_node_by_path("/");
> >
> >       if (!strcmp(root->name, "SUNW,JavaStation-1")) {
> > +             of_node_put(root);
> >               /* Hardcoded values for MrCoffee.  */
> >               i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
> >               kbd_iobase = ioremap(0x71300060, 8);
> >               if (!kbd_iobase)
> >                       return -ENODEV;
> >       } else {
> > -             int err = platform_driver_register(&sparc_i8042_driver);
> > +             int err;
> > +
> > +             of_node_put(root);
> > +             err = platform_driver_register(&sparc_i8042_driver);
> >               if (err)
> >                       return err;
>
> This is not really what I asked for, as in this version you left out
> leaky reference in i8042_platform_exit(). Please make the "detect Mr
> Coffee" function and use it in both i8042_platform_init() and
> i8042_platform_exit().
How about the newer?

Yours,
Yangtao
>
> Thanks.
>
> --
> Dmitry
