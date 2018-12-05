Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125A4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52D820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ednYvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52D820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeLEGlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:41:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54151 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:41:08 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so19604936ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtOi2nVexxLzKiWjW83BaTGqrU4qV6bim+lPlLvGd/c=;
        b=Z7ednYvBXi4e/V/CWlmv04m0VcwJOVOqpCdLn/txRj41vxEKXjOl7g2sFcSDGw8X8n
         bujVrl6LdKZt1ofY2XEeXa9aUvgLaRSbpuCmclNQt2CecLbFoYc9n30AZdn2fa++jdIq
         dFWr0Hhd6rAWfvxqHGfTvnvT4lMov8vA2zozFIB0tzyKLawafE698eSlR0cKtbTeAmpc
         CNkbrEm8hVXWIWz7tANQHLZq8oHsw26LqbMkx7YfNi70xvYn658LX4X2eFWc+8kotnPs
         ByRb2C6N9Da8YuJgIlFanyy68Vhr7ZF8pE1zqH4gunuokMScniK0YRlu5zOrVZrH+c/2
         tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtOi2nVexxLzKiWjW83BaTGqrU4qV6bim+lPlLvGd/c=;
        b=J3nymyOwNC+VRpswDe4CaFaS9BWIseeiiGFb/wg/Z3Mde2w+pkbzIaPVJfifdfO3Vu
         TK666jSVAQBUok/D4bxf/rDTXkc2NhDNw0tU0Q3UzuDz+CgemVNcR2mf0n7KgSrIi+UC
         NLLeMnpKUgPglg8STN3YGm7Ll6sc/lvO3nPc8LsYoJUg2M6hEwuBrqhzniN94S1aRnY6
         Sv+rbQIlcf5TOW6SI/yj33tGZNSBrydPKdo1HZvdDtk8QQiido6fzuviE5V1MPV4CAtl
         ZDusQ1rlawuO8x96vufcSTZwE9P1OT+Brt3+8hIzZvMjcfuSKMSp/O10J6wsxh7USWnS
         orwA==
X-Gm-Message-State: AA+aEWZJPkXKVjrCI4EopD+CFWmN+frubQg3IO0o7qE1NEBX2Fpwce71
        k4b1lD5woFwrcvdXmSlMWkaF1591065z6i77+k0=
X-Google-Smtp-Source: AFSGD/VVwRVTXsWl5dFKPy4rCGbuNlAPphiDM3Bapd6tE8ZkwxnbITcQMAMXpl+Hpduu4eaLTbL0i+NZCgaqqTjbhJk=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr13995539ita.65.1543992066316;
 Tue, 04 Dec 2018 22:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20181116100557.GA2497@hp-pavilion-15-notebook-pc-brajeswar> <CAFqtX7ne0tFJ7tuO0JSWh2HR3MbQPrLnzFctkaPd6ogsSn0EZQ@mail.gmail.com>
In-Reply-To: <CAFqtX7ne0tFJ7tuO0JSWh2HR3MbQPrLnzFctkaPd6ogsSn0EZQ@mail.gmail.com>
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
Date:   Wed, 5 Dec 2018 12:10:52 +0530
Message-ID: <CAFqtX7nqOs99ZdDziBU4cr23bYcFhzq+u_tbpJoYnaGXBnmpYA@mail.gmail.com>
Subject: Re: [PATCH] drivers/bus/fsl-mc/dpcon.c: Remove duplicate header
To:     Stuart Yoder <stuyoder@gmail.com>, laurentiu.tudor@nxp.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 1:53 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 3:36 PM Brajeswar Ghosh
> <brajeswar.linux@gmail.com> wrote:
> >
> > Remove linux/fsl/mc.h which is included more than once
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/bus/fsl-mc/dpcon.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
> > index 760555d7946e..97b6fa605e62 100644
> > --- a/drivers/bus/fsl-mc/dpcon.c
> > +++ b/drivers/bus/fsl-mc/dpcon.c
> > @@ -5,7 +5,6 @@
> >   */
> >  #include <linux/kernel.h>
> >  #include <linux/fsl/mc.h>
> > -#include <linux/fsl/mc.h>
> >
> >  #include "fsl-mc-private.h"
> >
> > --
> > 2.17.1
> >
