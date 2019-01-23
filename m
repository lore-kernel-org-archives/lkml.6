Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48084C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2F921855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZpG/lgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAWXYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:24:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44196 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:24:08 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so2399880vsp.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHYpnG/g9WDfT3aCzkrlDd3Eap7tWV5pYu5PjMhobrI=;
        b=EZpG/lgFudyH30BLG0iAp2wrC9T8wsOGbBy4SXN0m1UEHiwsm/wMipdR+Hy8slojN2
         6EgYRpa++94VDyI2LilerJlLTciK8rBHgXZ3DjdNr4I6akLlAs1AYYpnBSmlPm5NM80u
         Mue9UQi2jXPHkjddzJ4DZaT3yt3b88eXRPY8KU3fsEOFF1MXylyUB9bykP/YTTqnyelY
         mPkGt6yzOfb399yfUZo205Shc9wvgIPLz+2gwxURX8vvkza6/09zb4zLs3EWdjjhezg6
         e2tvvOdEtu+DXYpD5SmRGtp4CpcHJeJqBFscHOXd6lpgb3SDKd5eIjxMVcj3ICrXI6xR
         h4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHYpnG/g9WDfT3aCzkrlDd3Eap7tWV5pYu5PjMhobrI=;
        b=VZY07AX/t3ukl8NBOCq+DfLre9CEg8+G9mGB2Wn8I05rjqx19QXiR21Q8ym4V4jCdd
         M/Cq/JXfJvYqMB4PlrTUSzMVvRmgoJEtkLjFhNfrao1lWPwwavfRE4L4sHwo3upzE4OL
         zU4aARXZ2wVOqoVgaAn6jQ9CthVOFfL+YeUm4JfaCGoBOw/ehsrnabU6UubtSnhiv1Rc
         d3EKPIecAqlt9d02cwRjH2kyqvw1Zp1EzvPvWjq+V1hjMjjY8W90JtghWR+solmMLUqr
         +IXChObgwI1WM1emZnqchpxuRz2FkAYKsEM7iFQMvyuDnnK+80FXpLIfG1Utmn+J8ugv
         Fe6g==
X-Gm-Message-State: AJcUukdyo0rJCUxiDSAsyhkNJF139ggarfWuK5QTmgW/irYxU7YBoKEL
        Dec7DN090VYCbyPuWn2FNHyPbsCBJOiFgAW4FcjlX/w6iOA=
X-Google-Smtp-Source: ALg8bN47WW7z2fONpphvPNuQmrsR3SWnCbx8ap4wP/Af2SwSqTSoxGfKoaaEaGHhr51dkfopf79hCpdb/qE5rNI0UQE=
X-Received: by 2002:a67:ea50:: with SMTP id r16mr1716474vso.61.1548285847061;
 Wed, 23 Jan 2019 15:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com> <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
In-Reply-To: <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 01:23:41 +0200
Message-ID: <CAFCwf12M6EN_E=DzDM-xYmOpk-jKsw9uxKsZYB+QUv5sPLzEMg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Olof Johansson <olof@lixom.net>
Cc:     Dave Airlie <airlied@gmail.com>,
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

On Thu, Jan 24, 2019 at 1:04 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > Adding Daniel as well.
> > > >
> > > > Dave.
> > > >
> > > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
> > > > >
> > > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > > > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > > > > Habana Labs since its inception two and a half years ago.
> > > > >
> > > > > Hey Oded,
> > > > >
> > > > > So this creates a driver with a userspace facing API via ioctls.
> > > > > Although this isn't a "GPU" driver we have a rule in the graphics
> > > > > drivers are for accelerators that we don't merge userspace API with an
> > > > > appropriate userspace user.
> > > > >
> > > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > > > >
> > > > > I see nothing in these accelerator drivers that make me think we
> > > > > should be treating them different.
> > > > >
> > > > > Having large closed userspaces that we have no insight into means we
> > > > > get suboptimal locked for ever uAPIs. If someone in the future creates
> > > > > an open source userspace, we will end up in a place where they get
> > > > > suboptimal behaviour because they are locked into a uAPI that we can't
> > > > > change.
> > > > >
> > > > > Dave.
> > >
> > > Hi Dave,
> > > While I always appreciate your opinion and happy to hear it, I totally
> > > disagree with you on this point.
> > >
> > > First of all, as you said, this device is NOT a GPU. Hence, I wasn't
> > > aware that this rule might apply to this driver or to any other driver
> > > outside of drm. Has this rule been applied to all the current drivers
> > > in the kernel tree with userspace facing API via IOCTLs, which are not
> > > in the drm subsystem ?  I see the logic for GPUs as they drive the
> > > display of the entire machine, but this is an accelerator for a
> > > specific purpose, not something generic as GPU. I just don't see how
> > > one can treat them in the same way.
> >
> > The logic isn't there for GPUs for those reason that we have an
> > established library or that GPUs are in laptops. They are just where
> > we learned the lessons of merging things whose primary reason for
> > being in the kernel is to execute stuff from misc userspace stacks,
> > where the uAPI has to remain stable indefinitely.
> >
> > a) security - without knowledge of what the accelerator can do how can
> > we know if the API you expose isn't just a giant root hole?

I'm willing to explain the security mechanisms we have in our device
and how the driver initialize them in order to protect the host, and
to isolate between users.
I've done a LOT of work on that during the design of the ASIC and I
believe we have a good story there. If you want, we can go over that
code and explain the architecture in more detail.

> >
> > b) uAPI stability. Without a userspace for this, there is no way for
> > anyone even if in possession of the hardware to validate the uAPI you
> > provide and are asking the kernel to commit to supporting indefinitely
> > is optimal or secure. If an open source userspace appears is it to be
> > limited to API the closed userspace has created. It limits the future
> > unnecessarily.
I understand what you are saying and I think (but I can't guarantee it
yet) that I may be able to provide some minimal userspace to make sure
this interface won't break.

> >
> > > There is no way that "someone" will create a userspace
> > > for our H/W without the intimate knowledge of the H/W or without the
> > > ISA of our programmable cores. Maybe for large companies this request
> > > is valid, but for startups complying to this request is not realistic.
> >
> > So what benefit does the Linux kernel get from having support for this
> > feature upstream?
> >
> > If users can't access the necessary code to use it, why does this
> > require to be maintained in the kernel.
> >
> > > To conclude, I think this approach discourage other companies from
> > > open sourcing their drivers and is counter-productive. I'm not sure
> > > you are aware of how difficult it is to convince startup management to
> > > opensource the code...
> >
> > Oh I am, but I'm also more aware how quickly startups go away and
> > leave the kernel holding a lot of code we don't know how to validate
> > or use.
> >
> > I'm opening to being convinced but I think defining new userspace
> > facing APIs is a task that we should take a lot more seriously going
> > forward to avoid mistakes of the past.
>
> I think the most important thing here is to know that things are
> likely to change quite a bit over the next couple of years, and that
> we don't know yet what we actually need. If we hold off picking up
> support for hardware while all of this is ironed out, we'll miss out
> on being exposed to it, and will have a very tall hill to climb once
> we try to convince vendors to come into the fold. It's also not been a
> requirement for the other two drivers we have merged, as far as I can
> tell (CAPI and OpenCAPI) so the cat's already out of the bag.
>
> I'd rather not get stuck in a stand-off needing the longterm solution
> to pick up the short term contribution. That way we can move over to a
> _new_ API once there's been a better chance of finding common grounds
> and once things settle down a bit, instead of trying to bring some
> larger legacy codebase for devices that people might no longer care
> much about over to the newer APIs.
>
> It's better to be exposed to the HW and drivers now, than having
> people build large elaborate out-of-tree software stacks for this.
> It's also better to get them to come and collaborate now, instead of
> pushing them away until things are perfect.
>
> Having a way to validate and exercise the userspace API is important,
> including ability to change it if needed. Would it be possible to open
> up the lowest userspace pieces (driver interactions), even if some
> other layers might not yet be, to exercise the device/kernel/userspace
> interfaces without "live" workload, etc?
>
>
> -Olof

As I wrote above, I do think I could provide a very low userspace
piece that will contain the IOCTL facing functions and perhaps an
additional test code that will show how to run some simple tests on
the hardware to provide users the ability to do minimal liveness
checking.
I do want to ask that it won't block the upstream process because it
could take some time to provide that as I would need to split our
userspace code.
I will also need to clear that internally first, but I don't see a
reason why I won't be able to do that.

But before I start doing that internally, I need to have some kind of
assurance I won't do that for nothing. i.e, providing this library's
code will be enough to satisfy this specific requirement (I'm not
talking about other stuff of course that might show up in the review).

Thanks,
Oded


Oded
