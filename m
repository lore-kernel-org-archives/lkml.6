Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BADC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F52098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxECYL58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9F52098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeIYDpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:45:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeIYDpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:45:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so2886539pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PqX6dQhmD5BtZQ8rqxymH87lOO+ZAPE9AtQsXIdg/es=;
        b=UxECYL58JBaQYEN2WoriHwq0l4fT3Tly7Qo2OYhTCntnBFvH6v3p1fVpGbewNBwQ2k
         8okxmoOvTRBf9SGIcs9wUqM70cwtDGAENhlNwl+uBarIucOIT4okuT8Hre29qy500GcT
         gXYzI55BVT7c5RvvSNefmNb74HIb5bDVpQP0CF6DkyJoLsOr13ugChdpAMC9QReddjGH
         tgUZaxAgO6H6N+G/7JrxpK0w+4z7KCtvhHR0JW+ji6fBLSKUGdc/IsUS0TdWiovzIT8Y
         H8FbSnlx/Tc2z7NSWe5FnC27XutIa37wsCCUwgAFYVyCHbq7xTd9R6JpLWvRfBfn4qHD
         /8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqX6dQhmD5BtZQ8rqxymH87lOO+ZAPE9AtQsXIdg/es=;
        b=I36VfY21dk6wg9ohufSPRpl9AN69SWqjK+yXyhw5YAXEWPvN+nxJmuPYzqUz7/spez
         5Ty4vfWdKMFrID7Zzi2hgKUHYDwRCgtCZJE7bBjLO2D1K/buODcDZVTUsPCqcv+HcEzo
         K/cO4T3W/F0784nqCqIZkVFmH00o5gTeMcFbRLSlVWiiUZIswcAKihtpbKkK0kNReRw/
         8lVsWHmM2YJIlVIG8n2I1rY9CUlGx39CNEQc2rvJx78ndHiuC2CqaRtEhnA+kHlpBP4n
         /2xWrC0LC4GHXx7apQr+XgDIYZahB6/NWb1jsTQNkICuRiTm7tRsXQZCn77o9A/tIsaj
         CW0Q==
X-Gm-Message-State: ABuFfoh87SaMvjd65NTq+GgW7bvkhqWk9sDZI0hokMh0IsZXvylzGkia
        y9uAtUBQsBJgvuVD90iqEGrIkqYese2TuDyR6RKAtQ==
X-Google-Smtp-Source: ACcGV61UBNNlp66c3/DP1//5/l5pcZQwtryiJKDBEm4HCF1AQHCalJwl49KOMax4o2QXlhiUSVTBXJw/YuPLRNDq2x0=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr603882pfi.174.1537825276122;
 Mon, 24 Sep 2018 14:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180921202130.12480-1-natechancellor@gmail.com>
 <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com> <20180921231047.GA25998@flashbox>
In-Reply-To: <20180921231047.GA25998@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 14:41:04 -0700
Message-ID: <CAKwvOdnRzGhDZw-O_5khqsi4Bi7QOrrQ9GBpfhxUGxkOkuX6CA@mail.gmail.com>
Subject: Re: [PATCH] backlight: lm3639: Unconditionally call led_classdev_unregister
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 4:10 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Sep 21, 2018 at 03:48:50PM -0700, Nick Desaulniers wrote:
> > On Fri, Sep 21, 2018 at 1:23 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > Clang warns that the address of a pointer will always evaluated as true
> > > in a boolean context.
> > >
> > > drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> > > 'pchip->cdev_torch' will always evaluate to 'true'
> > > [-Wpointer-bool-conversion]
> > >         if (&pchip->cdev_torch)
> > >         ~~   ~~~~~~~^~~~~~~~~~
> > > drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> > > 'pchip->cdev_flash' will always evaluate to 'true'
> > > [-Wpointer-bool-conversion]
> > >         if (&pchip->cdev_flash)
> > >         ~~   ~~~~~~~^~~~~~~~~~
> > > 2 warnings generated.
> > >
> > > These statements have been present since 2012, introduced by
> > > commit 0f59858d5119 ("backlight: add new lm3639 backlight
> > > driver"). Given that they have been called unconditionally since
> > > then presumably without any issues, removing the always true if
> > > statements to fix the warnings without any real world changes.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/119
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >
> > > Alternatively, it's possible the address wasn't supposed to be taken or
> > > the dev in these structs should be checked instead. I don't have this
> > > hardware to make that call so I would appreciate some review and
> > > opinions on what was intended here.
> > >
> > > Thanks!
> > >
> > >  drivers/video/backlight/lm3639_bl.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> > > index cd50df5807ea..086611c7bc03 100644
> > > --- a/drivers/video/backlight/lm3639_bl.c
> > > +++ b/drivers/video/backlight/lm3639_bl.c
> > > @@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
> > >
> > >         regmap_write(pchip->regmap, REG_ENABLE, 0x00);
> > >
> > > -       if (&pchip->cdev_torch)
> > > -               led_classdev_unregister(&pchip->cdev_torch);
> > > -       if (&pchip->cdev_flash)
> > > -               led_classdev_unregister(&pchip->cdev_flash);
> > > +       led_classdev_unregister(&pchip->cdev_torch);
> > > +       led_classdev_unregister(&pchip->cdev_flash);
> >
> > led_classdev_unregister() requires that its arg is non-null (as it
> > dereferences it without any kind of check).  It's not clear that
> > i2c_get_clientdata() can never return a null pointer, so I think all
> > references to pchip in this function should instead be guarded with a
> > null check.  Would you mind making that change and sending a v2?
> >
>
> Hi Nick,
>
> I did a quick grep throughout the tree and I didn't see any place where
> there were null checks for i2c_get_clientdata, leading me to believe
> that such a check isn't necessary although I am nowhere close to an expert
> into this stuff.

This seems to be the case.  We should start using
__attribute__((returns_nonnull)) (gated on gcc 5+).
I *think* that the device's driver_data is actually set in
drivers/video/backlight/backlight.c.  Looks like
CONFIG_BACKLIGHT_LM3639 depends on CONFIG_BACKLIGHT_CLASS_DEVICE so I
feel more confident in your patch.
I would still prefer the maintainers to review though.

> I'm not sure I follow the rest of the request though,
> where should the check be? Before regmap_write?
>
> Furthermore, the probe function seems to make sure all of these get
> initialized properly, doesn't remove imply that probe was successful?
>
> Thank you for the comment and review!
> Nathan
>
> > >         if (pchip->bled)
> > >                 device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
> > >         return 0;
> > > --
> > > 2.19.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
