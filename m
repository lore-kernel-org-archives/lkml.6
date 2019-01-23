Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="lgIF1c/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAWXEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:04:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53763 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:04:45 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so1948924ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3HBNti4noAOe+oOGqgGr2U4y04EwZInTbb25YMDCVo=;
        b=lgIF1c/fSR9z18Xsd3yPNoCVdRc57E0NClnv9ne0sYG9vsiUw8hYrMmr6S7GlS1wCL
         LrgX9v3lotJpYpOsZ66wb2uWQwA906YLe4sOJWEYU+x/yUgYIF/LI/q8RrRo460o53Y8
         3IvD8vxCu7AabfFzhm/K7HQfEqjp9VeO8b0tvx/BAYfUqPoGRbd8WEkPfOwrZ2wD4TU8
         6Gnb+0PgeVUOQfc/OtWwwwYBTsCG90QLHwRv7sxmG7MYBdNeY7rXMvL+HS36exVciA4L
         xAoKmL/G2fsxP2Q5LSGULtKkRMRSWACHYuuZrMJY0/eNXx2Ad/4WI7ScJQ6sJ5e0aEyR
         j12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3HBNti4noAOe+oOGqgGr2U4y04EwZInTbb25YMDCVo=;
        b=NDH3ryTIzFY3BQpbDq9S8AJXC4Waiaf84nw9RRBO6TJguE/5m0h/hFy8dtCJeuaPUq
         i/DKhbNYSALBRTfMLi8oqPC5iKtj45PVykFZAQMRmMVnQANBCfbPMoDXGuu1FnvsG5We
         jKj1jDFwyasEPm5ANzRQ3oF2SRE5G7boCw29Uu6h+l8D83EHWVpY2ftXrz6w9yFFOkSv
         1F+tl0Wd+RlLD+9baNESQc6yAFb68MDihqdrGHPY2A77kfaMVlcOndy+W/KODSxJ2RXN
         7H16zjJ7FY8u0o5uvNaYOE2xF2/fPGmCwIDLAUqVjP+r/tmT/hOUuamUxGU8fvT6BJa0
         T6Zg==
X-Gm-Message-State: AJcUuke17pdJGj/he5za41a/TaF+O53PaFCV4+8JKA9W4Go+gkqtVT3G
        15DOXrKPqGQ1FPC6vJ1K2UKXfI9vwU/LCigIVzBvpw==
X-Google-Smtp-Source: AHgI3IYI/7cprLW51c5EqJkV6pv2MDYG7yVZAIZpyCVe0lDVPly4+iYCNnDjat3zdSJPBA6KfPOjBsJJq/7+Muy6OvI=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr52098itg.136.1548284684512;
 Wed, 23 Jan 2019 15:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com> <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
In-Reply-To: <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Jan 2019 15:04:33 -0800
Message-ID: <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Dave Airlie <airlied@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        andrew.donnellan@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > Adding Daniel as well.
> > >
> > > Dave.
> > >
> > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > > > Habana Labs since its inception two and a half years ago.
> > > >
> > > > Hey Oded,
> > > >
> > > > So this creates a driver with a userspace facing API via ioctls.
> > > > Although this isn't a "GPU" driver we have a rule in the graphics
> > > > drivers are for accelerators that we don't merge userspace API with an
> > > > appropriate userspace user.
> > > >
> > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > > >
> > > > I see nothing in these accelerator drivers that make me think we
> > > > should be treating them different.
> > > >
> > > > Having large closed userspaces that we have no insight into means we
> > > > get suboptimal locked for ever uAPIs. If someone in the future creates
> > > > an open source userspace, we will end up in a place where they get
> > > > suboptimal behaviour because they are locked into a uAPI that we can't
> > > > change.
> > > >
> > > > Dave.
> >
> > Hi Dave,
> > While I always appreciate your opinion and happy to hear it, I totally
> > disagree with you on this point.
> >
> > First of all, as you said, this device is NOT a GPU. Hence, I wasn't
> > aware that this rule might apply to this driver or to any other driver
> > outside of drm. Has this rule been applied to all the current drivers
> > in the kernel tree with userspace facing API via IOCTLs, which are not
> > in the drm subsystem ?  I see the logic for GPUs as they drive the
> > display of the entire machine, but this is an accelerator for a
> > specific purpose, not something generic as GPU. I just don't see how
> > one can treat them in the same way.
>
> The logic isn't there for GPUs for those reason that we have an
> established library or that GPUs are in laptops. They are just where
> we learned the lessons of merging things whose primary reason for
> being in the kernel is to execute stuff from misc userspace stacks,
> where the uAPI has to remain stable indefinitely.
>
> a) security - without knowledge of what the accelerator can do how can
> we know if the API you expose isn't just a giant root hole?
>
> b) uAPI stability. Without a userspace for this, there is no way for
> anyone even if in possession of the hardware to validate the uAPI you
> provide and are asking the kernel to commit to supporting indefinitely
> is optimal or secure. If an open source userspace appears is it to be
> limited to API the closed userspace has created. It limits the future
> unnecessarily.
>
> > There is no way that "someone" will create a userspace
> > for our H/W without the intimate knowledge of the H/W or without the
> > ISA of our programmable cores. Maybe for large companies this request
> > is valid, but for startups complying to this request is not realistic.
>
> So what benefit does the Linux kernel get from having support for this
> feature upstream?
>
> If users can't access the necessary code to use it, why does this
> require to be maintained in the kernel.
>
> > To conclude, I think this approach discourage other companies from
> > open sourcing their drivers and is counter-productive. I'm not sure
> > you are aware of how difficult it is to convince startup management to
> > opensource the code...
>
> Oh I am, but I'm also more aware how quickly startups go away and
> leave the kernel holding a lot of code we don't know how to validate
> or use.
>
> I'm opening to being convinced but I think defining new userspace
> facing APIs is a task that we should take a lot more seriously going
> forward to avoid mistakes of the past.

I think the most important thing here is to know that things are
likely to change quite a bit over the next couple of years, and that
we don't know yet what we actually need. If we hold off picking up
support for hardware while all of this is ironed out, we'll miss out
on being exposed to it, and will have a very tall hill to climb once
we try to convince vendors to come into the fold. It's also not been a
requirement for the other two drivers we have merged, as far as I can
tell (CAPI and OpenCAPI) so the cat's already out of the bag.

I'd rather not get stuck in a stand-off needing the longterm solution
to pick up the short term contribution. That way we can move over to a
_new_ API once there's been a better chance of finding common grounds
and once things settle down a bit, instead of trying to bring some
larger legacy codebase for devices that people might no longer care
much about over to the newer APIs.

It's better to be exposed to the HW and drivers now, than having
people build large elaborate out-of-tree software stacks for this.
It's also better to get them to come and collaborate now, instead of
pushing them away until things are perfect.

Having a way to validate and exercise the userspace API is important,
including ability to change it if needed. Would it be possible to open
up the lowest userspace pieces (driver interactions), even if some
other layers might not yet be, to exercise the device/kernel/userspace
interfaces without "live" workload, etc?


-Olof
