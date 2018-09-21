Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5044BECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057342156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7MBEh5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057342156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeIVFBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:01:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45790 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIVFBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:01:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so14240454wrb.12;
        Fri, 21 Sep 2018 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNhyzaUexFCKBZ+aCqSjGBwnBdZhvzCbFHGFKh3Pz8s=;
        b=D7MBEh5YA/f5kW4ale8SwR1HuxmNGX7D1/+fi1mX7NYS/IFfHTjN5uoVnbGTXnN+fz
         RQ611IPk2dICOaOF8Ud4FkYv1WiL3IbkWNEBEPLC9GPGv4FZpkPyImFUesmx+fKWkBcr
         gnCK3xymWjLi4apuxOWggb8QNM343A/PAmLvqEZCzP1QFhD9TIKtF2C1S06uHWVBywAf
         ozx2A0qLDRT05shVXiNamNb4rmK3p3u/6snLzTWjjyoSoZyTzju2CaIYTyMg9AbfPjmy
         pZFD7D3o3zuJbu8QC2E6Dy+O8uXnd1RCC1smYO4ZNylwtqMi+pHrErBlEMJidsyAUjLw
         7RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNhyzaUexFCKBZ+aCqSjGBwnBdZhvzCbFHGFKh3Pz8s=;
        b=ugqTr1iU9cXQRkH3+LStcWh4IJ+6uET2UamVeTFUGHSMcdoI4HZEg3kRMXaeRFRybg
         0HENisW+Kpx2/fDQvTHFna0jaMx06BGcrCXE7GHt1ojvQkktIoEeh0wTszxWSdViGRbI
         2Ky/9pF5/PCKds8EP7ZrmYSN1zFXjZTk102iIa998u1zoOLNN8NFNgqz/QwNRQYYc2pU
         8hpHzXjAqpBaEQ5ob4wI5tZ+BhzMVjzoylgrJVuwqJkcx39WB01vrfMxOKWbzIjnGC6R
         ROt6Fapt2D8Ru+ZVgQbI4ZqxFJ36KY6WKL3ZnB+EePbWrMDD5p2Ul2ql7S2t4kTG3fMV
         L12w==
X-Gm-Message-State: ABuFfogjZYaSJ2pCCIV/rdWxOtt7DOwprQkTHw0uLMjQ/prD6MsLgGIO
        jc0DquuGL82lzLQk/V268H8=
X-Google-Smtp-Source: ACcGV61cKaG4OoyiVRaLFeNHT2ctIZAta0/lEWxTrEhGjRhJMzzbANtmKO+nrrxVJoube7gl7ypYWA==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr9212380wru.197.1537571450492;
        Fri, 21 Sep 2018 16:10:50 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c12-v6sm21649154wrr.6.2018.09.21.16.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 16:10:49 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:10:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call
 led_classdev_unregister
Message-ID: <20180921231047.GA25998@flashbox>
References: <20180921202130.12480-1-natechancellor@gmail.com>
 <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:48:50PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 21, 2018 at 1:23 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns that the address of a pointer will always evaluated as true
> > in a boolean context.
> >
> > drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> > 'pchip->cdev_torch' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (&pchip->cdev_torch)
> >         ~~   ~~~~~~~^~~~~~~~~~
> > drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> > 'pchip->cdev_flash' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (&pchip->cdev_flash)
> >         ~~   ~~~~~~~^~~~~~~~~~
> > 2 warnings generated.
> >
> > These statements have been present since 2012, introduced by
> > commit 0f59858d5119 ("backlight: add new lm3639 backlight
> > driver"). Given that they have been called unconditionally since
> > then presumably without any issues, removing the always true if
> > statements to fix the warnings without any real world changes.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/119
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > Alternatively, it's possible the address wasn't supposed to be taken or
> > the dev in these structs should be checked instead. I don't have this
> > hardware to make that call so I would appreciate some review and
> > opinions on what was intended here.
> >
> > Thanks!
> >
> >  drivers/video/backlight/lm3639_bl.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> > index cd50df5807ea..086611c7bc03 100644
> > --- a/drivers/video/backlight/lm3639_bl.c
> > +++ b/drivers/video/backlight/lm3639_bl.c
> > @@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
> >
> >         regmap_write(pchip->regmap, REG_ENABLE, 0x00);
> >
> > -       if (&pchip->cdev_torch)
> > -               led_classdev_unregister(&pchip->cdev_torch);
> > -       if (&pchip->cdev_flash)
> > -               led_classdev_unregister(&pchip->cdev_flash);
> > +       led_classdev_unregister(&pchip->cdev_torch);
> > +       led_classdev_unregister(&pchip->cdev_flash);
> 
> led_classdev_unregister() requires that its arg is non-null (as it
> dereferences it without any kind of check).  It's not clear that
> i2c_get_clientdata() can never return a null pointer, so I think all
> references to pchip in this function should instead be guarded with a
> null check.  Would you mind making that change and sending a v2?
> 

Hi Nick,

I did a quick grep throughout the tree and I didn't see any place where
there were null checks for i2c_get_clientdata, leading me to believe
that such a check isn't necessary although I am nowhere close to an expert
into this stuff. I'm not sure I follow the rest of the request though,
where should the check be? Before regmap_write?

Furthermore, the probe function seems to make sure all of these get
initialized properly, doesn't remove imply that probe was successful?

Thank you for the comment and review!
Nathan

> >         if (pchip->bled)
> >                 device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
> >         return 0;
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
