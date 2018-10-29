Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9EBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAC62084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg7t6Smk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAC62084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbeJ3E7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:59:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35855 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeJ3E7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:59:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so10846619qth.3;
        Mon, 29 Oct 2018 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkv3qF7y9iY4kbDaD1mJ5Nvrt911anUCyGXGGijLQVU=;
        b=dg7t6SmkzAZjE7iugzNg6Vcsbg7tYgQCdh4VlK7rffGaB6hzlpsJdUhQ5kvMgOTx46
         zauNi15wXW3TfaQGkkDDYUUXCGNVg0XfDF6eR3egj/SRFosz1obfMn5wK6Js4eupM8wY
         aDzDB0mCSsTCZnLWWXCDwjqY+eemmvb5wgXsqJF52QpYH30/bZvD0lpA766y0wp60MlW
         WamfWmaF6OxieD8/v0AqTCDCUvZ4vU50TPFvruLSzi/IPnYn9hJQ+2fzofAiIasZQe7d
         JcGRwUQStE/h3oJkPJCEzX8t9vUTmzDPAJVc03WmnZWMfhxnkbqUdXuxtUdoIgLwVYpF
         r7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkv3qF7y9iY4kbDaD1mJ5Nvrt911anUCyGXGGijLQVU=;
        b=BYKCr1TljXZybgDgqLXZwE9w52Ku7WcnFrtMEdB6tAvTGmgMOkjPoh7bIxgbW6sSIv
         rMUNcnk2FJAK96+25a5DM7UpxIZTnmFZUPb0VtI+D4AJkOg1C3B66pz8xW/3VT8l43Y8
         5YCTtkEUfignGqEF9a5frR7J80Iasqstsz245ksvC/+Ign8/OEzlPxQ598Ypk3jS1jaZ
         l872+1WIOty5a5jBgkhqZNTYtD9uaJqb/3UO/Wl8OlI12IFCQkAFVmo3a05RP49qR8VH
         yPd0YwkeMbkt1xB6F68SS4yGBZRb89y+AdoAnyx+737k1D6ZVF+K53WeT5j6x4qMUk1C
         mZow==
X-Gm-Message-State: AGRZ1gJKgOBAmJXA/qlLsylZgEiVOJx0omITdRW5z5RCwhCu5MqKX5Z6
        xu5whWsfZagIEzjrhBWvoAYj/itPkpRqv4ClHYxQ6rDJ
X-Google-Smtp-Source: AJdET5eCGxI47znjfi6jFDeTF9RXiKH0xUiHza1Feu/7LgYfbgEhlm+omLBkrCXzbqL0Ot3DM8Oc4ut/BU9S8bqiw5o=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr14510120qvh.136.1540843734803;
 Mon, 29 Oct 2018 13:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181029200311.16947-1-semen.protsenko@linaro.org> <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
In-Reply-To: <CAKaJLVvpNZW2a+3xc7PE0+iU1nm39A7PEjCu8F9ijrT+wEXOag@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 22:08:43 +0200
Message-ID: <CAHp75VdWYkPyLvDfYt+8tF2KSR6uH0nLM5R-n=OafXTPOWgpDw@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Praneeth Bajjuri <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Arnd, I guess it might be useful for kernel-ci activity as well.

On Mon, Oct 29, 2018 at 10:05 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Hi Greg,
>
> On Mon, Oct 29, 2018 at 10:03 PM, Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > The kernel is self-contained project and can be built with bare-metal
> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> > this u_quad_t type is not defined when using bare-metal toolchain and
> > codafs build fails. This patch fixes it by defining u_quad_t type
> > unconditionally.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
>
> Can you please pull this one, if this applicable? I sent it a while
> ago, but I guess it got lost in mailing list. It might be also
> applicable to stable branch (as it fixes allmodconfig build for ARM
> with bare-metal toolchain).
>
> Thanks!
>
> >  include/linux/coda.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/linux/coda.h b/include/linux/coda.h
> > index d30209b9cef8..0ca0c83fdb1c 100644
> > --- a/include/linux/coda.h
> > +++ b/include/linux/coda.h
> > @@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
> >  #ifndef _CODA_HEADER_
> >  #define _CODA_HEADER_
> >
> > -#if defined(__linux__)
> >  typedef unsigned long long u_quad_t;
> > -#endif
> > +
> >  #include <uapi/linux/coda.h>
> >  #endif
> > --
> > 2.19.1
> >



-- 
With Best Regards,
Andy Shevchenko
