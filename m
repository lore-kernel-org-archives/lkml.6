Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85314C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4784C21874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPWtL22x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAEExF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:53:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52026 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEExE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:53:04 -0500
Received: by mail-it1-f196.google.com with SMTP id w18so4395600ite.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oArCE7r/iquZmO+ZhvjUvMjIDHq7e0pvyq/5mlSzAas=;
        b=rPWtL22xaeqGCs6FdExcr58WWsrNnExioA1v0quu1h+SQl0orbInQSSF23r7jGsUUY
         34t2JyTtOyxyNVnqJlb7UFc679Gqxcxff9EUcnj5hIlp8iveUnox5x9AXO1lsGPR6g2Z
         aG9uyWcSK9cwVNCBpJo4y770L1NR98cEfSSgo3z/kazzPxe9AW5rWj8jwj0J8wm66wh4
         YC4zHnM9w1GXN/wgusqd6X5NzMsuB7tI/w2onw84+Y9BFzDd1CR5pxtkLMfhQpCPMGTl
         WfZylZ6CB810sM9lLOcnlbSVDq2ChaLHTx9zhMEPpXL0O3KqKM0vWaNaNZytWN0L/92R
         E8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oArCE7r/iquZmO+ZhvjUvMjIDHq7e0pvyq/5mlSzAas=;
        b=MZjo99m6wuwiFi/7jbE5OKUssCIJCjrTixxO5olRcfHf+YEKqgz1yhnplN7LQ9difg
         roevq1fLPZU00xjf/ihSUv5VWZeVpQj7iWAET/Cel0hVrT/4cnCM8bsqxPUxfsKhnmHS
         J83x+tdrL7PJkcWd4whGzL0Wb8r11knyffsG3Iji9i90rKp2U3BZqASgz2KRQWnhmVXz
         r5TrVQrZAvsGOs7XW2XPvt/a2j7+Wsat3eLQvNwWfQ11+QImPOSfEMUTSxxylVfmFy3S
         075RwRTzH5JYLyX8Wv8FMf/SPXgEoeAYS9CTdeLBpy4QTK1nsZ82U3oFwr6ENJAXilDP
         2gcA==
X-Gm-Message-State: AA+aEWbZhW92uKaOZIsMCD+C/RAHP+p2Xlkf4+YjbHq8SNGjOt5pXela
        t/L/xJAA6NwbL31I4UWc0QxHawcU1vFOnySOJ9shnkyF
X-Google-Smtp-Source: AFSGD/VJwldMJ3Woj4oi7DTgGorzEKL+102FsP5siGrApBVZn4Sg6V/TyNelQnNp+0W4h+iipiec/yZXn1xKeyeTHJc=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr36366178jad.98.1546663983944;
 Fri, 04 Jan 2019 20:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
 <CAFqtX7kfSuWkjYHPWsxRaYcsQRD4OtJVyUBAezZu3HQT4QjoYg@mail.gmail.com> <CAFqtX7k4dqpTqKwUmfLP__=pKXga5QBovnZMT7JNDk07A=pUBA@mail.gmail.com>
In-Reply-To: <CAFqtX7k4dqpTqKwUmfLP__=pKXga5QBovnZMT7JNDk07A=pUBA@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Sat, 5 Jan 2019 10:22:52 +0530
Message-ID: <CAFqtX7=aS56+=Gt9VCRjk5fc5XfpP9q7roPO7w3d6VKGBs4SYg@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
To:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 12:10 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 8:47 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > On Fri, Nov 9, 2018 at 3:21 PM Brajeswar Ghosh
> > <brajeswar.linux@gmail.com> wrote:
> > >
> > > Remove linux/fsl/mc.h which is included more than once
> > >
> > > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> >
> > Any comment on this patch?
>
> Any comment on this patch?

Any comment on this patch?

>
> >
> > > ---
> > >  drivers/bus/fsl-mc/dpbp.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> > > index 17e3c5d2f22e..9003cd3698a5 100644
> > > --- a/drivers/bus/fsl-mc/dpbp.c
> > > +++ b/drivers/bus/fsl-mc/dpbp.c
> > > @@ -5,7 +5,6 @@
> > >   */
> > >  #include <linux/kernel.h>
> > >  #include <linux/fsl/mc.h>
> > > -#include <linux/fsl/mc.h>
> > >
> > >  #include "fsl-mc-private.h"
> > >
> > > --
> > > 2.17.1
> > >
