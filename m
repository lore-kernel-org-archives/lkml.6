Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FD8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED5A20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn9ENnZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfAHVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:31:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45667 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbfAHVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:31:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so6069922qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FwHmDrn++Ae2PLXrTIS2YUngfmaXKgYGEjynr5kyTw=;
        b=Hn9ENnZjtW0QawKxgwagD/nVEGfyUxg21eAkkXLS63SAxSBepVJxqYWmuPJfTgpmL5
         nteunaAeHj8t9y0/vHy4RjVQTdDMEZWqQMQDgHOy9kl8mpKrSoOvhFvSuF14owEQerG1
         mk2KueUGymfnXRq6rsTANg3l7k2EL3I9z1rsgEPuI3a64PKlKqwa62tZ7xBTWUbHcP8K
         mDx5PeJs3NZEtlM2xvZ+Gogbz7VJ8TR+C2AorQUn45VkdZJUX7DaBiWtOAeZs/299H/t
         fR3GlbMGmO2GPM/aLiKCedih4MzkOqeYYhGdQDhCsnhBiLTKmxTtXQkw1ho2w61W6xVF
         uw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FwHmDrn++Ae2PLXrTIS2YUngfmaXKgYGEjynr5kyTw=;
        b=GWA12C91yU16XpCloSqA+TOliuO88r1St4D+3hSLF1azjBCSnhvH0bjL6lELx4HuW6
         axZY/hclsEAdiHFyr8C8JtPVfIVsQLFGY6tWUMV7DxHzzWntQAOmO8omGljER19wAOTP
         amvwc03QZFTWfW9/zrM3k0/rzk1pYSNgY7pZskNBuJgRecNpfH9Jml9SU5tv4kLB9J0s
         LNsG8wnjAruaPAm8wON/o4nUyb7TBDL+jVy84YhefDahdIlKe4luiYt3gWjysCpvkotu
         WtGCZdACUtN496maGSKbCdxVloTpltO3+JLwcuPZRnH7BkVuwDh3zx7iOUI/PuKBbIrQ
         7ZJg==
X-Gm-Message-State: AJcUukczD/5uX3aIQl6uV//NhySP8gc0cJIfQQeARTDbqcWG25oH5V0h
        SFKtorwWrqxFSCq+sR0I4h0SihOSUgfM1DXYAY8=
X-Google-Smtp-Source: ALg8bN4vBZZ5bx07Kfv2UwE+HOABWBnOoCTM3B0o58jXJ5TDUsfAAdsAFwT1DkZ2BwaYnNqqCi/JJVkwO8kspKIDPKM=
X-Received: by 2002:a0c:9aca:: with SMTP id k10mr3372254qvf.185.1546983101747;
 Tue, 08 Jan 2019 13:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20190108161016.12361-1-enric.balletbo@collabora.com>
 <20190108161016.12361-5-enric.balletbo@collabora.com> <CABXOdTdbzr0GW0NPf7SQRW-ra1-GCeWNDk=vPF-w-8gZuSvqoA@mail.gmail.com>
In-Reply-To: <CABXOdTdbzr0GW0NPf7SQRW-ra1-GCeWNDk=vPF-w-8gZuSvqoA@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 8 Jan 2019 22:31:30 +0100
Message-ID: <CAFqH_502c0F30sHWq596spcsiLFy0RC57Jywc64ZrWVu8Ng_8g@mail.gmail.com>
Subject: Re: [PATCH 04/10] platform/chrome: cros_ec_vbc: remove unused includes
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Missatge de Guenter Roeck <groeck@google.com> del dia dt., 8 de gen.
2019 a les 18:19:
>
> On Tue, Jan 8, 2019 at 8:10 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> > None of these are required at the moment.
> >
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> >
> >  drivers/platform/chrome/cros_ec_vbc.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> > index af9bfe6f385c..86903bc31b27 100644
> > --- a/drivers/platform/chrome/cros_ec_vbc.c
> > +++ b/drivers/platform/chrome/cros_ec_vbc.c
> > @@ -18,10 +18,8 @@
> >   * GNU General Public License for more details.
> >   */
> >
> > -#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mfd/cros_ec.h>
> > -#include <linux/mfd/cros_ec_commands.h>
>
> It is customary to not rely on secondary includes. Yet, with this
> removal, the code will rely on cros_ec.h including cros_ec_commands.h,
> for the definition of EC_VBNV_CONTEXT_OP_READ. Does this really make
> sense ?
>

Ok, I didn't know that.

> [ I didn't check the other patches, but I suspect the same applies
> there as well ]
>

I'll recheck all the patches to make sure I only remove the includes
that are not needed.

Thanks,
  Enric

> Guenter
>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > --
> > 2.20.1
> >
