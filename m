Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D0421872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="V5kM8us6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfAWXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:41:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35482 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAWXl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:41:57 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so1845504itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvXFbasy0KxJM4oUz3E4CVPaZ2aAQL9LoekKdZeuEn0=;
        b=V5kM8us6izsZVg7y0ePyVsfkkHkw2wTAs/4GLXIg4gRUBqaB+DwQ+c61lQgEnDwf5w
         n+2pCsd840/UgkO8tlFFlH7V1ogiU6MShYfBT1Oja0Ur71C9If98XapdRhCSAEBGyg+P
         WBzbbWC4CytiuaW0dHJ95TJv6S23usRhjLT7PzKyTFWxohygQbz3JWeTMtbqx3krwCLQ
         FQEG4zHR0zrlNc/4EfT4Q+Ar8haA8AuHHaY8PTnz8sEp9UekSp5tkigZi1eZZMK0WIc3
         6tP52tgsxNmk4Egs0CsLx6+HRrA+g/6E5GnMxwCbGKq8+KHl5rkNCHAYxps5QwUFNhdl
         KwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvXFbasy0KxJM4oUz3E4CVPaZ2aAQL9LoekKdZeuEn0=;
        b=Jn6MPFXjB/G27SihWnOa5Ij71ouk9ssemquasmH8PtGTZdnN8pNi/GnL8v8Wq+MqIy
         MPLNZnkLfzGTYFXFM3yMwg+soqzW80nE72UfYN7teTfQDU9dhVyuxfKudogvPk+hIPW0
         JCZFas5Cmm8jZD/U28T7Un5Be+LlgGUz3aaZhHvfku5ZiBaEd5L33K/MKGP3uA4NKVx4
         yMuPh4DOhTPJoiQExLV0HNEfVbhZErJ+b1exy6NcqiED7CJFALa2V5xWVORUFwq/IdmV
         yH2YcAgyE8sf7tTrzAXSiVR4O/C4n1zT3DyMIbS2SSvG4cd3VCUf4v1nGbN5bAfPzMAZ
         t5YQ==
X-Gm-Message-State: AJcUukey+RufpyE0iqOj2VK4mbKSNpVkSq30yrppY0RIRZDcGdeu80PI
        Heopfj0kQU2cGOmwnM8OPkPEZsc9/x6Ldz1xsjYcsA==
X-Google-Smtp-Source: ALg8bN7Ihps31c2yhVHOQXYtHFfI6aQ9OVSXSNqHPcJlsQcPyTOKejjQbrYMgq9CfDolMugkQ5rvG8DmwcuvEUlYPi8=
X-Received: by 2002:a02:89dd:: with SMTP id e29mr3064676jak.21.1548286916412;
 Wed, 23 Jan 2019 15:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAFCwf11PadVOM1jg+JnSzvLxro1PP6hEWX8WtRne9WVN26PaYQ@mail.gmail.com>
In-Reply-To: <CAFCwf11PadVOM1jg+JnSzvLxro1PP6hEWX8WtRne9WVN26PaYQ@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 23 Jan 2019 15:41:45 -0800
Message-ID: <CAOesGMjU133pMS2CMb0GADuJgGrH75mtq8w0Eh3c29DbvYh_0w@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 3:35 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Thu, Jan 24, 2019 at 1:20 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Wed, Jan 23, 2019 at 03:04:33PM -0800, Olof Johansson wrote:
> > > On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com> wrote:
> > > > > >
> > > > > > Adding Daniel as well.
> > > > > >
> > > > > > Dave.
> > > > > >
> > > > > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > > > > > > > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > > > > > > > Habana Labs since its inception two and a half years ago.
> > > > > > >
> > > > > > > Hey Oded,
> > > > > > >
> > > > > > > So this creates a driver with a userspace facing API via ioctls.
> > > > > > > Although this isn't a "GPU" driver we have a rule in the graphics
> > > > > > > drivers are for accelerators that we don't merge userspace API with an
> > > > > > > appropriate userspace user.
> > > > > > >
> > > > > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> > > > > > >
> > > > > > > I see nothing in these accelerator drivers that make me think we
> > > > > > > should be treating them different.
> > > > > > >
> > > > > > > Having large closed userspaces that we have no insight into means we
> > > > > > > get suboptimal locked for ever uAPIs. If someone in the future creates
> > > > > > > an open source userspace, we will end up in a place where they get
> > > > > > > suboptimal behaviour because they are locked into a uAPI that we can't
> > > > > > > change.
> > > > > > >
> > > > > > > Dave.
> > > > >
> > > > > Hi Dave,
> > > > > While I always appreciate your opinion and happy to hear it, I totally
> > > > > disagree with you on this point.
> > > > >
> > > > > First of all, as you said, this device is NOT a GPU. Hence, I wasn't
> > > > > aware that this rule might apply to this driver or to any other driver
> > > > > outside of drm. Has this rule been applied to all the current drivers
> > > > > in the kernel tree with userspace facing API via IOCTLs, which are not
> > > > > in the drm subsystem ?  I see the logic for GPUs as they drive the
> > > > > display of the entire machine, but this is an accelerator for a
> > > > > specific purpose, not something generic as GPU. I just don't see how
> > > > > one can treat them in the same way.
> > > >
> > > > The logic isn't there for GPUs for those reason that we have an
> > > > established library or that GPUs are in laptops. They are just where
> > > > we learned the lessons of merging things whose primary reason for
> > > > being in the kernel is to execute stuff from misc userspace stacks,
> > > > where the uAPI has to remain stable indefinitely.
> > > >
> > > > a) security - without knowledge of what the accelerator can do how can
> > > > we know if the API you expose isn't just a giant root hole?
> > > >
> > > > b) uAPI stability. Without a userspace for this, there is no way for
> > > > anyone even if in possession of the hardware to validate the uAPI you
> > > > provide and are asking the kernel to commit to supporting indefinitely
> > > > is optimal or secure. If an open source userspace appears is it to be
> > > > limited to API the closed userspace has created. It limits the future
> > > > unnecessarily.
> > > >
> > > > > There is no way that "someone" will create a userspace
> > > > > for our H/W without the intimate knowledge of the H/W or without the
> > > > > ISA of our programmable cores. Maybe for large companies this request
> > > > > is valid, but for startups complying to this request is not realistic.
> > > >
> > > > So what benefit does the Linux kernel get from having support for this
> > > > feature upstream?
> > > >
> > > > If users can't access the necessary code to use it, why does this
> > > > require to be maintained in the kernel.
> > > >
> > > > > To conclude, I think this approach discourage other companies from
> > > > > open sourcing their drivers and is counter-productive. I'm not sure
> > > > > you are aware of how difficult it is to convince startup management to
> > > > > opensource the code...
> > > >
> > > > Oh I am, but I'm also more aware how quickly startups go away and
> > > > leave the kernel holding a lot of code we don't know how to validate
> > > > or use.
> > > >
> > > > I'm opening to being convinced but I think defining new userspace
> > > > facing APIs is a task that we should take a lot more seriously going
> > > > forward to avoid mistakes of the past.
> > >
> > > I think the most important thing here is to know that things are
> > > likely to change quite a bit over the next couple of years, and that
> > > we don't know yet what we actually need. If we hold off picking up
> > > support for hardware while all of this is ironed out, we'll miss out
> > > on being exposed to it, and will have a very tall hill to climb once
> > > we try to convince vendors to come into the fold. It's also not been a
> > > requirement for the other two drivers we have merged, as far as I can
> > > tell (CAPI and OpenCAPI) so the cat's already out of the bag.
> > >
> > > I'd rather not get stuck in a stand-off needing the longterm solution
> > > to pick up the short term contribution. That way we can move over to a
> > > _new_ API once there's been a better chance of finding common grounds
> > > and once things settle down a bit, instead of trying to bring some
> > > larger legacy codebase for devices that people might no longer care
> > > much about over to the newer APIs.
> > >
> > > It's better to be exposed to the HW and drivers now, than having
> > > people build large elaborate out-of-tree software stacks for this.
> > > It's also better to get them to come and collaborate now, instead of
> > > pushing them away until things are perfect.
> > >
> > > Having a way to validate and exercise the userspace API is important,
> > > including ability to change it if needed. Would it be possible to open
> > > up the lowest userspace pieces (driver interactions), even if some
> > > other layers might not yet be, to exercise the device/kernel/userspace
> > > interfaces without "live" workload, etc?
> >
> > Yes and to exercise the userspace API you need at very least to
> > know the ISA so that you can write program for the accelerator.
> > You also need to know the set of commands the hardware has. The
> > ioctl and how to create a userspace that interact with the kernel
> > is the easy part, the hard part is the compiler.
>
> So actually in my case in order to exercise the IOCTL API, you can
> give "work" to the device that will not trigger the compute parts, but
> only the different queues and the DMA engines.
> I think that is enough to validate that the IOCTLs won't break.
> All the "commands" that you can give to the queue logic (QMAN) is
> exposed in one of the files in the driver (goya_packets.h).
>
> I want to stress this - To validate the IOCTLs, it is enough to do DMA
> work. You will use ALL the 5 IOCTLs to do just that - give work to the
> DMA engines.

I personally think this is a reasonable trade-off, given that you have
a communication layer between. For hardware that doesn't have that,
and where device behavior and data movement depends on execution on
the compute parts, more would need to be open.


-Olof
