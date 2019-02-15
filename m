Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E997FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88E3222F7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HciA2shR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405148AbfBOJlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:41:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50903 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405116AbfBOJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:41:50 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so22726960iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z4kLOxk0Pqr+y6/o713VrCidz873BkOSKyDdosL1Pfw=;
        b=HciA2shRZ8CjL7saNAMB4rI0wOSnALHbJrOdQkn9XPS6PHj7UJGiykrf9pvoRpm3gm
         Z/sn+KvXjvnYN3Xo+uViLssd1tfIt8LQMOZFvpYqnRvCXlERvH0WUCZ6/Eh7JnY7cmxa
         1epHIlphADiaGMga7MxzpIEOdHYs8pRSD3J6+B25PdC6EUNpwunzTAXe6IeaR8AawOgo
         yAl5LOzbKheLRwlF7xSm5F9bGQPpOn1elmEXML+QM1l+DR44foHSvxHfE9NRi/HQ6+x6
         YDenlqD2DdC2kO7zxJHkv/Hjvc8q7qfjmpraHb28gxXXEDYSH8ZA2zne7fSrM86uNgyW
         C6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z4kLOxk0Pqr+y6/o713VrCidz873BkOSKyDdosL1Pfw=;
        b=txAfQlMn5eThIHvapylnw5GD2sBIjINJ8/aidfmZTusdvTy+wytcgVgrM0n+X0qB9+
         CbLrSGRmD+cW759aljTlK6HYzjrb7Lfh9lwOtr+Z59CjnSx/4CPJ1XI7sM7vbQz4NJJv
         uZL8m9/dGXNIb6nd+fNx6CIQp9RYBCiEFquSvue5VeAndflaJpPa6WV1s08Eqhej0MNJ
         w+gtlVnpm95Z3WEPhQCWOPF2Ev24naTAwH8jA5YrUU5KmwL0O+SNlKv8eAcgi5msjKA9
         GwT1JYDZM87mySSYu159DMcMnowbH16dw/9A/D24kwaWvzrozHnQMFw6SnysCClwPrg0
         l0PA==
X-Gm-Message-State: AHQUAuYgSHObY+GEU5Q3NonLEGRk+RvdN7b30uo0hmiFD+iBfDGa6pTk
        36D8RXjdMJR81/OZBpqK7Fh2Ure/AkGPQ8aWdp82Ig==
X-Google-Smtp-Source: AHgI3Ia5Hjlue/Mr3PJspIk50HO5My1AWiWGZeENYt73SIeJ5U0THF9hr292qsKLr5lLQMKPmLhOx5PjYq457LgQObc=
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr5423601iol.187.1550223709534;
 Fri, 15 Feb 2019 01:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20190214162349.22740-1-brgl@bgdev.pl> <e566b4ba-0f3e-052a-bf08-ad881cf7b7c0@linaro.org>
In-Reply-To: <e566b4ba-0f3e-052a-bf08-ad881cf7b7c0@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 Feb 2019 10:41:38 +0100
Message-ID: <CAMRc=MdW47YspeOv+9U6h9Ps35S0As2yBVXPdiwJFXNg_hMZZg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: core: fix the return value check when calling the
 notifier chain
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 15 lut 2019 o 10:28 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 14/02/2019 16:23, Bartosz Golaszewski wrote:
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index f7301bb4ef3b..a3bed2d9aec7 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -687,7 +687,7 @@ struct nvmem_device *nvmem_register(const struct nv=
mem_config *config)
> >               goto err_remove_cells;
> >
> >       rval =3D blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD,=
 nvmem);
> > -     if (rval)
> > +     if (rval < 0)
> >               goto err_remove_cells;
>
> rval will be masked with STOP MASK, so the above statement could be
> false even if we have error.
> So you should consider returning an errono which can be understood by use=
r:
>
> may be something like this:
>
> if (rval & NOTIFY_STOP_MASK) {
>         rval =3D notifier_to_errno(rval);
>         goto err_remove_cells
> }
>

Actually I'm now thinking we can remove this check at all - most users
never check the return values of notifier chain calls. This function
cannot fail in itself. What do you think?

Bart
