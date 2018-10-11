Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08068C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B6F20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pks9K/Ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B6F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeJKIlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:41:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36835 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:41:32 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so10930735itd.1;
        Wed, 10 Oct 2018 18:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM5MtKKgbt67vMhEqA1VCx5TDr4GvvAw8CDmSN8Trl8=;
        b=pks9K/IpmWrWVpdFQSt1mYY5oq8Auo8d0lqqCm+k9wrpLcbnudkVOXKlO7d3o365i1
         4Nx8oPQGhtK9lg12wTPnpFCXhwda9q9D3Ev89BQ9KNC8KtZcVryFwSQ7g+E7pIBVv+Fr
         /SLpfxLSXfLpN8yKzEeccWZlhv6KgO8C4xN7SeYcja3fyaPxCOqjpGo6v6Th0jUue9tB
         5xiiYY8o8GdTneOQzD4ShVKs3RPoKrNNtzTo+ZHUhcg1hQPXgr4KzebQNLSFBUpAXI4T
         vekh2iT002TjLbLjbmWNeuS4ZLIVJgkh6reYRKFzy7YzjCr19BGEG3KCmEhMEr4ZeQie
         KQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM5MtKKgbt67vMhEqA1VCx5TDr4GvvAw8CDmSN8Trl8=;
        b=FqdD0oK1tgCQe1IWtfvKkz7X0EAFCcjrMYRPbdRRdjJ+sux+0v22GhIi5f/dRvuRGI
         LbAa0p5BCBt5ffGVILVCOAm+LW0O0lf6mNx/JxasX+nyxs8JUiKnbV1aKT+3LHwyOpRY
         FMfz48Co4F5gGmF/EcRnjDBLverxQjhoFTgDqUbEJI1Gyr4GFEkDOX2YdyUanYxJ5dlO
         XtUU0XjNrHzPUpj2GCEc1hPr2COITlOSBszfaXsnJa+3KugpYN5796i4HigYvOYsMyDO
         SF4Qkbig1zKK48FDco1yd/jr9g9206GVLcYyyqqZH4OlDS8UKA4GRfEDEM1pO9arUp6/
         2bGw==
X-Gm-Message-State: ABuFfoiOw4x9gFAVdHFRT3oX5znFU4T+dTQETIAAR8/PCtiaGMeRG8dz
        NS9PYE1gp30er1DUaKCVvTRuIf8p+2EQ6e+RQ/I=
X-Google-Smtp-Source: ACcGV62qcEb0XxNqHqnYeWeLkQMWQeJHkaMZo+uGIMeD2BglkNfDoHz2eJJexlnu64FrE6KU37GF1uh1bsX4M4RUpjQ=
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr26248011jam.78.1539220602693;
 Wed, 10 Oct 2018 18:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181010151801.21489-1-robdclark@gmail.com> <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
In-Reply-To: <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 10 Oct 2018 21:16:30 -0400
Message-ID: <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Hans de Goede <j.w.r.degoede@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> > FB_BACKLIGHT prevents it from being built as a module.  There
> > doesn't seem to be any particularly good reason for this, so
> > switch FB_BACKLIGHT over to tristate.
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
>
> I don't see anything immediately wrong, but anything related to
> BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
> and FB_BACKLIGHT is really fragile in Kconfig, because of the
> way those interact with other options.
>
> I've applied your patch to my randconfig build tree for testing,
> let's see what happens there before you apply it.
>

thanks.. tbh the fragility of backlight vs kconfig is why I've
procrastinated on fixing this for a while.. in the end the solution
seems not as bad as I feared (and after a iteration or two makes rhel
kernel builds for various archs happy, at least).. but defn some
randconfig build testing is in order.

PS. discovering that the thing you need to fix (a) never really worked
as intended, and (b) involves backlight + fbdev.. is never a good way
to start your day ;-)

BR,
-R
