Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9372BC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05C206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 12:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YBu98m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAFMAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 07:00:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45003 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfAFMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 07:00:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so35825705lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 04:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmvxQl9c7Lc7b0AWwauBPm55fIAMi+wKNqcfPDJqCBI=;
        b=b5YBu98mBWBPGotylBvovFa8zLjnyW1IldZIGPXJWpnwTogl2eBeKd1PvrB5Xoc8Us
         SOo8bRLv1XdoM+bitMLYIWsyz3JHD1/SMv4nSqLnHLHAbQsOy16Ar3+I73nc6zQZ61a0
         Njf3rJdOGAEi5iPAXL1mIQHERl1CBw4QRU6pqJ6xv14x4QpntwaYy9lR5PmBEFuYtujx
         i/myymQMOj2+xVWS6PJw2yj+V9lo+I5Ob5FOQ2KxAm3K1NEcZBxkUYqZSwFaFdYZAzCD
         ROmbT3h66r55FZEpJE9Bl81Y1BGEGKFi4Ca6w7P4uBGy3VLNOV8Kd+48xPYtXVt5Weim
         chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmvxQl9c7Lc7b0AWwauBPm55fIAMi+wKNqcfPDJqCBI=;
        b=ZslA2Ml14w/LqcEX2Flw+w5XNc1aGH0vFlC+CrolXedYmMYtJyp5pp2WHN3E5cZ7po
         oCqrErw9xZ+vMOaaSeah1oKXL8Jr4aX50rdLYetxvpUEMycUDVBoenfo+Luxk8Dhl9LY
         GbeeYVQ6rYSNam4xdEfisrJnBXLRcgPX9fTr0zJJU5O8f3FmmjDp6+Zecg/92vRZLLyb
         WTtnlSOQRl/omNQDD8P0Sxig8dFIu+7h2EHxqFisxewkq+I3sgQd6etPiijr6tuxdhJp
         1eZd5/nGDRrf/u9TCO1eFhojXz4txr6xWXJi2nY0zW6FsIJfCLZh0Uz2VuMf2oOJEp0Y
         UvTw==
X-Gm-Message-State: AJcUukfFjkyylF9Y91iJ5FnD1LShCzogSi//63oKiFW2UExvrxP4G7IB
        jTV5pyySRo+lVvBbywDRO722rm6DlFNnXLR4EWg=
X-Google-Smtp-Source: AFSGD/UoUf0HJtnR5r+W/JbW6Ag6O6uOBxKQkYqMfO5Vb48jDc7Ym7BjXPwlpRcrRz4MZ3Jbw7kVSSyveuhO0ymEaWk=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr31960570lji.93.1546776015082;
 Sun, 06 Jan 2019 04:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20181109095101.GA2558@hp-pavilion-15-notebook-pc-brajeswar>
 <CAFqtX7kfSuWkjYHPWsxRaYcsQRD4OtJVyUBAezZu3HQT4QjoYg@mail.gmail.com>
 <CAFqtX7k4dqpTqKwUmfLP__=pKXga5QBovnZMT7JNDk07A=pUBA@mail.gmail.com> <CAFqtX7=aS56+=Gt9VCRjk5fc5XfpP9q7roPO7w3d6VKGBs4SYg@mail.gmail.com>
In-Reply-To: <CAFqtX7=aS56+=Gt9VCRjk5fc5XfpP9q7roPO7w3d6VKGBs4SYg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 6 Jan 2019 17:34:07 +0530
Message-ID: <CAFqt6zZ7U1VJCbKoRRCnOxUn+C6RgQROQPhVTn=VKKNOiuCNkg@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpbp.c: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 10:23 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Wed, Dec 5, 2018 at 12:10 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 8:47 PM Brajeswar Ghosh
> > <brajeswar.linux@gmail.com> wrote:
> > >
> > > On Fri, Nov 9, 2018 at 3:21 PM Brajeswar Ghosh
> > > <brajeswar.linux@gmail.com> wrote:
> > > >
> > > > Remove linux/fsl/mc.h which is included more than once
> > > >
> > > > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > >
> > > Any comment on this patch?
> >
> > Any comment on this patch?
>
> Any comment on this patch?

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>
> >
> > >
> > > > ---
> > > >  drivers/bus/fsl-mc/dpbp.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> > > > index 17e3c5d2f22e..9003cd3698a5 100644
> > > > --- a/drivers/bus/fsl-mc/dpbp.c
> > > > +++ b/drivers/bus/fsl-mc/dpbp.c
> > > > @@ -5,7 +5,6 @@
> > > >   */
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/fsl/mc.h>
> > > > -#include <linux/fsl/mc.h>
> > > >
> > > >  #include "fsl-mc-private.h"
> > > >
> > > > --
> > > > 2.17.1
> > > >
