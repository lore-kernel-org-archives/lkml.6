Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B374C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93E221872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAkMsB3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWXf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:35:28 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45853 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:35:27 -0500
Received: by mail-vs1-f68.google.com with SMTP id x28so2410529vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QuWuA765ZTNxh+94a6MQJgi2I22ROrlNN1gYJzlx7tg=;
        b=pAkMsB3eC8Fgyqn+h248c9nq20cz3in4rkJdvrKrC43lAVlJOLMb2+YuBvGk7z+xpX
         g54yYdob4+1W8jJXOCV+kgrt8Vl7a5PRnH4tAVdkjMLx/rfC0chTkxYjsUExY6RKwMRU
         lmnv2wKyS0cYAgfayM71mCxa3Ony1w0twRhDZVoZWVilGuM+1EBc9A5Ux7hhfsSk2/Lj
         Ef+22UKU4T8X3EKpkg33ZKlMvgutc7SllKnbyrDXRrqM4nSOQfsqzp4Q7cv64nfX5pec
         BtpBBG4ZV85wFm3Uvxi8df1A/Xw/1+O4VnNPb6iorwrrcQu147CvuGXEqc+dOhWTEY7O
         FXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QuWuA765ZTNxh+94a6MQJgi2I22ROrlNN1gYJzlx7tg=;
        b=cBtVGu+FgmGhZ2JLD6njHxp5aqD+5gqvuROT+aIo/YZ8cWaSn8+5aDHdIWuBf0fozY
         Es7tLBIX2u8mHjHtUFabgqeFSiyaud+Pv9NQbHKDatWVSojjtgVCP6A35DfmN5iOzW1r
         WSaDVxq+RPdNhEOr3TIDktGZur4AyuICggbb1lS/IQbVulyBsqgpbJuMBaLaHAQFgDt6
         URgJfbXN7DzCbKcPEuO2h5roioAUghYPPOj8t0qI0iaBKBQWfHPFD5YxmyVjruGW+WeQ
         BrxeVPVnMAF3qkti7K/3unCQ+aRHtAcuQGY9BebgiieD1vNIvQ3y5Ez1Ur0vBeSpRCwT
         lzCQ==
X-Gm-Message-State: AJcUukcvzTsRcJ0/Az0b1Ay6gSeZ5HinzskVEF/bpgP5uQshi786JtfM
        51IpOFkH+sVpeSQErAYuIiyPOo7589gsZj8MkK4=
X-Google-Smtp-Source: ALg8bN7XwX/rszvw0PWE+6GVTQgJ9cdEk0TaadY7MPtVxp79F6i4oQhyFGAkH4joV2U02++AzVwNA/SlWm65QrgI0KE=
X-Received: by 2002:a67:87cf:: with SMTP id j198mr1723711vsd.104.1548286525639;
 Wed, 23 Jan 2019 15:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com> <20190123232052.GD1257@redhat.com>
In-Reply-To: <20190123232052.GD1257@redhat.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 01:35:00 +0200
Message-ID: <CAFCwf11PadVOM1jg+JnSzvLxro1PP6hEWX8WtRne9WVN26PaYQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Olof Johansson <olof@lixom.net>, Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        andrew.donnellan@au1.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 1:20 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Jan 23, 2019 at 03:04:33PM -0800, Olof Johansson wrote:
> > On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com> wro=
te:
> > > >
> > > > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wr=
ote:
> > > > >
> > > > > Adding Daniel as well.
> > > > >
> > > > > Dave.
> > > > >
> > > > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wro=
te:
> > > > > >
> > > > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.co=
m> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > For those who don't know me, my name is Oded Gabbay (Kernel M=
aintainer
> > > > > > > for AMD's amdkfd driver, worked at RedHat's Desktop group) an=
d I work at
> > > > > > > Habana Labs since its inception two and a half years ago.
> > > > > >
> > > > > > Hey Oded,
> > > > > >
> > > > > > So this creates a driver with a userspace facing API via ioctls=
.
> > > > > > Although this isn't a "GPU" driver we have a rule in the graphi=
cs
> > > > > > drivers are for accelerators that we don't merge userspace API =
with an
> > > > > > appropriate userspace user.
> > > > > >
> > > > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-sou=
rce-userspace-requirements
> > > > > >
> > > > > > I see nothing in these accelerator drivers that make me think w=
e
> > > > > > should be treating them different.
> > > > > >
> > > > > > Having large closed userspaces that we have no insight into mea=
ns we
> > > > > > get suboptimal locked for ever uAPIs. If someone in the future =
creates
> > > > > > an open source userspace, we will end up in a place where they =
get
> > > > > > suboptimal behaviour because they are locked into a uAPI that w=
e can't
> > > > > > change.
> > > > > >
> > > > > > Dave.
> > > >
> > > > Hi Dave,
> > > > While I always appreciate your opinion and happy to hear it, I tota=
lly
> > > > disagree with you on this point.
> > > >
> > > > First of all, as you said, this device is NOT a GPU. Hence, I wasn'=
t
> > > > aware that this rule might apply to this driver or to any other dri=
ver
> > > > outside of drm. Has this rule been applied to all the current drive=
rs
> > > > in the kernel tree with userspace facing API via IOCTLs, which are =
not
> > > > in the drm subsystem ?  I see the logic for GPUs as they drive the
> > > > display of the entire machine, but this is an accelerator for a
> > > > specific purpose, not something generic as GPU. I just don't see ho=
w
> > > > one can treat them in the same way.
> > >
> > > The logic isn't there for GPUs for those reason that we have an
> > > established library or that GPUs are in laptops. They are just where
> > > we learned the lessons of merging things whose primary reason for
> > > being in the kernel is to execute stuff from misc userspace stacks,
> > > where the uAPI has to remain stable indefinitely.
> > >
> > > a) security - without knowledge of what the accelerator can do how ca=
n
> > > we know if the API you expose isn't just a giant root hole?
> > >
> > > b) uAPI stability. Without a userspace for this, there is no way for
> > > anyone even if in possession of the hardware to validate the uAPI you
> > > provide and are asking the kernel to commit to supporting indefinitel=
y
> > > is optimal or secure. If an open source userspace appears is it to be
> > > limited to API the closed userspace has created. It limits the future
> > > unnecessarily.
> > >
> > > > There is no way that "someone" will create a userspace
> > > > for our H/W without the intimate knowledge of the H/W or without th=
e
> > > > ISA of our programmable cores. Maybe for large companies this reque=
st
> > > > is valid, but for startups complying to this request is not realist=
ic.
> > >
> > > So what benefit does the Linux kernel get from having support for thi=
s
> > > feature upstream?
> > >
> > > If users can't access the necessary code to use it, why does this
> > > require to be maintained in the kernel.
> > >
> > > > To conclude, I think this approach discourage other companies from
> > > > open sourcing their drivers and is counter-productive. I'm not sure
> > > > you are aware of how difficult it is to convince startup management=
 to
> > > > opensource the code...
> > >
> > > Oh I am, but I'm also more aware how quickly startups go away and
> > > leave the kernel holding a lot of code we don't know how to validate
> > > or use.
> > >
> > > I'm opening to being convinced but I think defining new userspace
> > > facing APIs is a task that we should take a lot more seriously going
> > > forward to avoid mistakes of the past.
> >
> > I think the most important thing here is to know that things are
> > likely to change quite a bit over the next couple of years, and that
> > we don't know yet what we actually need. If we hold off picking up
> > support for hardware while all of this is ironed out, we'll miss out
> > on being exposed to it, and will have a very tall hill to climb once
> > we try to convince vendors to come into the fold. It's also not been a
> > requirement for the other two drivers we have merged, as far as I can
> > tell (CAPI and OpenCAPI) so the cat's already out of the bag.
> >
> > I'd rather not get stuck in a stand-off needing the longterm solution
> > to pick up the short term contribution. That way we can move over to a
> > _new_ API once there's been a better chance of finding common grounds
> > and once things settle down a bit, instead of trying to bring some
> > larger legacy codebase for devices that people might no longer care
> > much about over to the newer APIs.
> >
> > It's better to be exposed to the HW and drivers now, than having
> > people build large elaborate out-of-tree software stacks for this.
> > It's also better to get them to come and collaborate now, instead of
> > pushing them away until things are perfect.
> >
> > Having a way to validate and exercise the userspace API is important,
> > including ability to change it if needed. Would it be possible to open
> > up the lowest userspace pieces (driver interactions), even if some
> > other layers might not yet be, to exercise the device/kernel/userspace
> > interfaces without "live" workload, etc?
>
> Yes and to exercise the userspace API you need at very least to
> know the ISA so that you can write program for the accelerator.
> You also need to know the set of commands the hardware has. The
> ioctl and how to create a userspace that interact with the kernel
> is the easy part, the hard part is the compiler.

So actually in my case in order to exercise the IOCTL API, you can
give "work" to the device that will not trigger the compute parts, but
only the different queues and the DMA engines.
I think that is enough to validate that the IOCTLs won't break.
All the "commands" that you can give to the queue logic (QMAN) is
exposed in one of the files in the driver (goya_packets.h).

I want to stress this - To validate the IOCTLs, it is enough to do DMA
work. You will use ALL the 5 IOCTLs to do just that - give work to the
DMA engines.

And as I wrote to Dave, I can explain my security architecture in
detail and how I make sure the programmable cores can't be used by
malicious users.

And nice to hear from you Jerome :) I missed you!

Thanks,
Oded

>
> So if we want any kind of freedom to play with the UAPI, enhance
> it or change it in anyway we must be free to build program for the
> device ourself.
>
> I believe that the GPU sub-system requirement are a good guideline
> to follow and the only exception with drivers/ that i am aware of
> is the fpga. Everything else in driver as either an open source
> userspace, expose a common API (like network) or is so simple that
> anyone can write a userspace for it.
>
>
> For any complex device that execute program we should really enforce
> the open source userspace so that we can properly audit the driver
> as otherwise we only have half of the story with no idea what the
> other half might implies.
>
> Cheers,
> J=C3=A9r=C3=B4me
>
>
