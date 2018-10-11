Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF08C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32C20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B32C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJKO2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:28:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35125 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:28:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id v19-v6so8708060qtg.2;
        Thu, 11 Oct 2018 00:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPiZS29GUVPhOPr0LbbUSONNZbqhgn6DJ1DCAu/Er38=;
        b=Gp/c/iiIchegG+oQfH2op7oBqTQ0Gw5hPtqZM5uVBaQhDYkT/PHrvq8HhYUQx+K4Lz
         wpek+pjRAHJ0tAFeZzNX3/6Ux5V7BMefbYa2WHVo9uYyr6ouJhOkw+m53pZ5FOXPHks3
         wKesCHh51bdLQfYlURzQDQjBLYKVdxoJwKZckQiL07V/g1l6T225lRmtENZtv1ivkDUd
         RLQhWdZTDpo9QqbMRXB7l6QAs3Q/Lo54iVHHcuf73t6R68UronvIjOvAZH+R04r+RdJm
         krilKmb0tF6kjkDoN7BPGdc1K7SJqYemBPXn/XzxToJvUqQ6uWrP21rz6LDH324Ao4sz
         sO0Q==
X-Gm-Message-State: ABuFfojisE2h8Hv9Da+d7vc7pWQ38gkYlkgrSAofRq8xdpfG+GV/JbSE
        FkzesS4sunOaKYhY/m1fUbx8xaVsQAJluTxMFmA=
X-Google-Smtp-Source: ACcGV62x7YEIQKSd8HTAQEh7wjFwUyUpPT0Utq54/79N4DJ0ZZsCneMzVFwpmFAh7ZabraprkToDhNUrqp8SS2NqXpE=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr363883qtn.152.1539241362881;
 Thu, 11 Oct 2018 00:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181010151801.21489-1-robdclark@gmail.com> <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
 <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
In-Reply-To: <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:02:25 +0200
Message-ID: <CAK8P3a1zWzm4AS8C18NRQE7gaMy1jjo70+0b1h=yrxE395-2fg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
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

On Thu, Oct 11, 2018 at 3:16 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
> > > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
> > > FB_BACKLIGHT prevents it from being built as a module.  There
> > > doesn't seem to be any particularly good reason for this, so
> > > switch FB_BACKLIGHT over to tristate.
> > >
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> >
> > I don't see anything immediately wrong, but anything related to
> > BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
> > and FB_BACKLIGHT is really fragile in Kconfig, because of the
> > way those interact with other options.
> >
> > I've applied your patch to my randconfig build tree for testing,
> > let's see what happens there before you apply it.
> >
>
> thanks.. tbh the fragility of backlight vs kconfig is why I've
> procrastinated on fixing this for a while.. in the end the solution
> seems not as bad as I feared (and after a iteration or two makes rhel
> kernel builds for various archs happy, at least).. but defn some
> randconfig build testing is in order.

Ok, my overnight testing shows no regression, so please add

Tested-by: Arnd Bergmann <arnd@arndb.de>

> PS. discovering that the thing you need to fix (a) never really worked
> as intended, and (b) involves backlight + fbdev.. is never a good way
> to start your day ;-)

I still have a bunch of related fixes in my tree that address
randconfig builds that never worked. I think at one point
I got a few 'Reviewed-by' replies from DRM folks, but then
nobody picked it up and subsequently it stopped applying.
I need to go back and dig out all the dependent patches from
my randconfig tree and resend that.

      Arnd
