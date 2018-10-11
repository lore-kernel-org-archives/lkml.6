Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341CC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ACD20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibWalWRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36ACD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJKUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:20:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37024 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:20:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so9625319qto.4;
        Thu, 11 Oct 2018 05:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WiisVeaokxrggFjYWd9TMHTxF/+mkEYNMP9lY2MUBMs=;
        b=ibWalWRkFYCYUoFTRaTwafWVwZgyNKUKQ4br3HfDBiO6MuriiykAcT88HGrR6r4gGI
         ig7LgaRryv+1cB8xZWbMVv16a2I4rAfDeDOzY+2fwkUfK765d3BBimyI6NvTx0TiAZqi
         4UpJIZoB8tIQTnRSKtzSZucv6I/OHRTnhfMJD4Gk3qwy432xh8LstiOuU7d5aQGlG/H0
         zIkSbT5YkMei+KcbyqYrnhWCTdD4x5y8D8uSHlBqpK/Veb13iYJN41YHg4sogdzaan2N
         5x3vhP9AtW7f1+xm9O4kDm+1OFUytf6FYcavRKXEVVzM70r1QOs624AOWl8QSiMigsqk
         hfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WiisVeaokxrggFjYWd9TMHTxF/+mkEYNMP9lY2MUBMs=;
        b=r6cTRy3yRDn8How3519TlORyzv1AJKuyQURpo9h4r1yWdGFJPT5NJevCiSiEV3tT9i
         0i1IUXfqrQTS6Sn9A76H41a/kJri/mdlVNII3jEjAQskUlA+jijzTqyGOa/cNpXqZcVd
         zUNo1erxQquy2IvLVl9Le6NulZn92gqR8XIOtcSNQ4UV6p12LjkJpb9irO8vspG54Alg
         x2Ior9+6w3ePFKKZNdMXM3NSwl9PLsXk81DyRZOc0sxBLYpue7h2aqOU0xeW9ol8gEvV
         mGiTwPxV5mUZVEaaQD86J8RhFWvm7k3cuMch4XLT/f5l9Og+ZY+RqsN22hIdUzLxdF2c
         IbrQ==
X-Gm-Message-State: ABuFfoigSAHYPydLzQj/RkbX5BhVMlsgO7OfoYZB012BxrPQIsFU0UTP
        5zyczL8MgziaRmJ8rWQMk5sBSRHDMN4illMAIIEtMQ==
X-Google-Smtp-Source: ACcGV61e1sMf6mtDsr5hPG0+U5yjV8rQkeljv7PYObseKwKLFuOh2EM00ycsDOhmKnaFprcNA2DD0ksGU+2GB1hcoBc=
X-Received: by 2002:aed:3968:: with SMTP id l95-v6mr1305683qte.96.1539262377581;
 Thu, 11 Oct 2018 05:52:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 05:52:56
 -0700 (PDT)
In-Reply-To: <CAF6AEGvXVv6iurN-FBd1F4NNufsuSP9=PaLBnMgMZNaAVVSKsg@mail.gmail.com>
References: <20181010151801.21489-1-robdclark@gmail.com> <CAK8P3a3LjB=y+3XXD_FuRpvYL5XAQP_zqCM3R0T4buRYw4tgRg@mail.gmail.com>
 <CAF6AEGs3dStuF6GfhfL7Y+zOZFGrLU_CaiDMzdHrD4OQ3ynm=g@mail.gmail.com>
 <CAK8P3a1zWzm4AS8C18NRQE7gaMy1jjo70+0b1h=yrxE395-2fg@mail.gmail.com> <CAF6AEGvXVv6iurN-FBd1F4NNufsuSP9=PaLBnMgMZNaAVVSKsg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 14:52:56 +0200
X-Google-Sender-Auth: ZNAdWoHwEQkLbjKX969hLNg3SY8
Message-ID: <CAK8P3a3RDzxj8H8Kd6ywsm5K25Nc5RApBjzUDdDyCaTtMHCudg@mail.gmail.com>
Subject: Re: [PATCH] fbdev: make FB_BACKLIGHT a tristate
To:     Rob Clark <robdclark@gmail.com>
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

On 10/11/18, Rob Clark <robdclark@gmail.com> wrote:
> On Thu, Oct 11, 2018 at 3:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Oct 11, 2018 at 3:16 AM Rob Clark <robdclark@gmail.com> wrote:
>> >
>> > On Wed, Oct 10, 2018 at 11:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> > >
>> > > On 10/10/18, Rob Clark <robdclark@gmail.com> wrote:
>> > > > BACKLIGHT_CLASS_DEVICE is already tristate, but a dependency
>> > > > FB_BACKLIGHT prevents it from being built as a module.  There
>> > > > doesn't seem to be any particularly good reason for this, so
>> > > > switch FB_BACKLIGHT over to tristate.
>> > > >
>> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
>> > >
>> > > I don't see anything immediately wrong, but anything related to
>> > > BACKLIGHT_CLASS_DEVICE, BACKLIGHT_LCD_SUPPORT
>> > > and FB_BACKLIGHT is really fragile in Kconfig, because of the
>> > > way those interact with other options.
>> > >
>> > > I've applied your patch to my randconfig build tree for testing,
>> > > let's see what happens there before you apply it.
>> > >
>> >
>> > thanks.. tbh the fragility of backlight vs kconfig is why I've
>> > procrastinated on fixing this for a while.. in the end the solution
>> > seems not as bad as I feared (and after a iteration or two makes rhel
>> > kernel builds for various archs happy, at least).. but defn some
>> > randconfig build testing is in order.
>>
>> Ok, my overnight testing shows no regression, so please add
>>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks
>
>>
>> > PS. discovering that the thing you need to fix (a) never really worked
>> > as intended, and (b) involves backlight + fbdev.. is never a good way
>> > to start your day ;-)
>>
>> I still have a bunch of related fixes in my tree that address
>> randconfig builds that never worked. I think at one point
>> I got a few 'Reviewed-by' replies from DRM folks, but then
>> nobody picked it up and subsequently it stopped applying.
>> I need to go back and dig out all the dependent patches from
>> my randconfig tree and resend that.
>
> I assume those patches (and this one) would be picked up via fbdev tree?

I think the others should go through the DRM tree, but I don't think
I'll have time to revisit them before the merge window, so don't wait
for that.

      Arnd
