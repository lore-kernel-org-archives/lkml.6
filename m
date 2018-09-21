Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C8CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5C62156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jo2s9TXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5C62156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbeIVEkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:40:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41695 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeIVEkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:40:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so6550932plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxNb/O8kat9l7AfbYi2oGxP2bO2plmRGKUcR2xOMbDA=;
        b=Jo2s9TXjFLwFi4qtD2CeCfGIelYoMLN0lgP2nm74nXW9kR5MJPR/InQqVe+iwrig71
         PYX3t2dOczUUfbON69Cf4Ufl6TG/doZJ4g9SdMaa1i2BtEwTOz5rcI2bwvqOzilXOJDp
         aAX6spHIJhh8m+NGKBpClmLzVZKiJdgTkUgPizPtCGpKuJmBuKF31csxkH7lcGKCYH+b
         xAXhNoWpSeO0cQ7AONpt0PtFZFHQmoKNZuuuNfXw9mg9UkFu8MarEQyyr29kzhZHt0Su
         DWn8NEq+PcuoFLzDeLkJghPxnsmijoernOQcdc1yKaDKOYNjKBvjCJrNoPYtx2MDVfDN
         ZsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxNb/O8kat9l7AfbYi2oGxP2bO2plmRGKUcR2xOMbDA=;
        b=L3scidA5Y89hGes31iY/XWlHXfmdD77O692+ASpP1q0Xd3aEZjyfVAmWrzIdHh2/uH
         6t9Fu6TQgnTdOJbSBBYoOf/4IMuqoxQ9W+nmCBhWT2/nWp+1NhTuzQC+OYMov2XSHqWg
         XBwPXkVu8wEKOHV0FRa/VSFyot7j63HCtcYYh7GTXATwZlJ9r4MiddF50oNBSWI1tZ2p
         P+cCwXEPKpYZ+5SiroiDUQtzoVQg8pFsLE0C5jDxAyHcIArghecphRivH2Qub4TWZWQj
         DOTUPHhKMWYMAeym5S43qrfaD6oj7XY0ofgv3JaGoXMM+6bPpizhyjVBFujtIbVx7uk7
         ANLg==
X-Gm-Message-State: ABuFfogINbH1Ldc7z0onIy2DqjzQTIFHAgyGhcPUmH45P47wabICuvAJ
        3Q37ZdUIKyA8lUHur8mPJ9ZDUNHejsTHTlPjAMQ4/Q==
X-Google-Smtp-Source: ACcGV62Bkw5+f5H0c5pjBZfNzLxVBHCVjGcdmpyiX9/H++Hw/8Qn0hd0kNgp1Orl8WbwkBikDMH6y2TjSO8ByWDlTF4=
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr3853441pls.217.1537570141237;
 Fri, 21 Sep 2018 15:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180921202130.12480-1-natechancellor@gmail.com>
In-Reply-To: <20180921202130.12480-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 15:48:50 -0700
Message-ID: <CAKwvOdnj5M1xTKue7qZCV-2=hLTATnB-J1QOVvaVVa+8h+vq4A@mail.gmail.com>
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

On Fri, Sep 21, 2018 at 1:23 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
>
> drivers/video/backlight/lm3639_bl.c:403:14: warning: address of
> 'pchip->cdev_torch' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_torch)
>         ~~   ~~~~~~~^~~~~~~~~~
> drivers/video/backlight/lm3639_bl.c:405:14: warning: address of
> 'pchip->cdev_flash' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (&pchip->cdev_flash)
>         ~~   ~~~~~~~^~~~~~~~~~
> 2 warnings generated.
>
> These statements have been present since 2012, introduced by
> commit 0f59858d5119 ("backlight: add new lm3639 backlight
> driver"). Given that they have been called unconditionally since
> then presumably without any issues, removing the always true if
> statements to fix the warnings without any real world changes.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/119
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Alternatively, it's possible the address wasn't supposed to be taken or
> the dev in these structs should be checked instead. I don't have this
> hardware to make that call so I would appreciate some review and
> opinions on what was intended here.
>
> Thanks!
>
>  drivers/video/backlight/lm3639_bl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
> index cd50df5807ea..086611c7bc03 100644
> --- a/drivers/video/backlight/lm3639_bl.c
> +++ b/drivers/video/backlight/lm3639_bl.c
> @@ -400,10 +400,8 @@ static int lm3639_remove(struct i2c_client *client)
>
>         regmap_write(pchip->regmap, REG_ENABLE, 0x00);
>
> -       if (&pchip->cdev_torch)
> -               led_classdev_unregister(&pchip->cdev_torch);
> -       if (&pchip->cdev_flash)
> -               led_classdev_unregister(&pchip->cdev_flash);
> +       led_classdev_unregister(&pchip->cdev_torch);
> +       led_classdev_unregister(&pchip->cdev_flash);

led_classdev_unregister() requires that its arg is non-null (as it
dereferences it without any kind of check).  It's not clear that
i2c_get_clientdata() can never return a null pointer, so I think all
references to pchip in this function should instead be guarded with a
null check.  Would you mind making that change and sending a v2?

>         if (pchip->bled)
>                 device_remove_file(&(pchip->bled->dev), &dev_attr_bled_mode);
>         return 0;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
