Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BBCC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5552077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+y9CkC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5552077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeJKT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:59:00 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54232 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:59:00 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so13124126itb.3;
        Thu, 11 Oct 2018 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e60FdofV9MbJnwMkfh2fikEoup8wf4R5ARPW9Bxb4bI=;
        b=O+y9CkC0V4XwePtsBRmRKwf1CmnW7ao/T+Frkbu7VunGvEZ6B5iKUOcKqqFgnSq7No
         QrmxRquhyLTePiCUYnLEgicvTE7GHHnuq3jZ3nxdTpIBf3zug0bsI1aAiM3KcsfOwz7H
         Fddkvj68skAIwN8CMevaBdlCcYcTEMZJj7rfY/lqYV4g0RpC93dfZ0ESU73qtDNZ6Qs5
         UEWZnbyUtejnDrRR4AzbMjnd5XWA1nrQ4fK+uI5dEetcsYPp9e3RHE8H8UFR0UDbQn5M
         QkJcQKYgu166eq6LzfGkerVcTm6kWBk3UZBDDYC24+lMDVHNBY76hJpdhJMf4U9E2KzB
         5y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e60FdofV9MbJnwMkfh2fikEoup8wf4R5ARPW9Bxb4bI=;
        b=csjg1vxJScFxtbnzJeY8736LT41YXCS8lrSgM2M3RvX6F0Rw5WcnE8cQLcMsyAYCeK
         YMsn2zNIKZd1B8c2pW9R5WZDRmMXipsmz0f3XpeJcEL9hHBXkJ4gA1jCW4tKwEFIK7y8
         OqaNgDlNDJotpM+/msez9bBxOjnJjLvWizaPSSHbqY2yeGrvsiZDaIHCOxMghbH+waXG
         /qmW6AWBOZSJ0NEn0YYR6zDt0YRuFE2/lYeP8Jc67g4NywFjO+y7VX7/lO46wIlNNhpJ
         JvVQ3/kpHCsl15iZGE0gKS6PnMFGdvtB6v5MPLJBKbmg7ntYcSuiN5pbCDS2ZUU/FcYC
         yu2A==
X-Gm-Message-State: ABuFfohlylCFeTYTqDEIrZD4h1r2Mku3z6u0yubgZa1jdV4NhtN9rsEi
        rOX6xWBlU7bhWjaVVOcZBa8C3IolCcrizBcl3b4=
X-Google-Smtp-Source: ACcGV60kuqDthSRoOjcmUzlTCzaoMBe+BhlAn9OVY4sINhDx7Vq28NVCO20tvES8vxHjllp+3TVMu7WtQ+h1GqQQygo=
X-Received: by 2002:a24:9c86:: with SMTP id b128-v6mr1335182ite.104.1539261119251;
 Thu, 11 Oct 2018 05:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181010151801.21489-1-robdclark@gmail.com> <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
 <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com> <CAK8P3a1zWzm4AS8C18NRQE7gaMy1jjo70+0b1h=yrxE395-2fg@mail.gmail.com>
In-Reply-To: <CAK8P3a1zWzm4AS8C18NRQE7gaMy1jjo70+0b1h=yrxE395-2fg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 11 Oct 2018 08:31:45 -0400
Message-ID: <CAF6AEGvXVv6iurN-FBd1F4NNufsuSP9=PaLBnMgMZNaAVVSKsg@mail.gmail.com>
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

On Thu, Oct 11, 2018 at 3:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 11, 2018 at 3:16 AM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> > > > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> > > > FB_BACKLIGHT prevents it from being built as a module.  There
> > > > doesn't seem to be any particularly good reason for this, so
> > > > switch FB_BACKLIGHT over to tristate.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > >
> > > I don't see anything immediately wrong, but anything related to
> > > BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
> > > and FB_BACKLIGHT is really fragile in Kconfig, because of the
> > > way those interact with other options.
> > >
> > > I've applied your patch to my randconfig build tree for testing,
> > > let's see what happens there before you apply it.
> > >
> >
> > thanks.. tbh the fragility of backlight vs kconfig is why I've
> > procrastinated on fixing this for a while.. in the end the solution
> > seems not as bad as I feared (and after a iteration or two makes rhel
> > kernel builds for various archs happy, at least).. but defn some
> > randconfig build testing is in order.
>
> Ok, my overnight testing shows no regression, so please add
>
> Tested-by: Arnd Bergmann <arnd@arndb.de>

Thanks

>
> > PS. discovering that the thing you need to fix (a) never really worked
> > as intended, and (b) involves backlight + fbdev.. is never a good way
> > to start your day ;-)
>
> I still have a bunch of related fixes in my tree that address
> randconfig builds that never worked. I think at one point
> I got a few 'Reviewed-by' replies from DRM folks, but then
> nobody picked it up and subsequently it stopped applying.
> I need to go back and dig out all the dependent patches from
> my randconfig tree and resend that.

I assume those patches (and this one) would be picked up via fbdev tree?

BR,
-R
