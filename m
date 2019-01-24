Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3386EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979721855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fcjk676p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfAXHgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:36:03 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:50990 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAXHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:36:03 -0500
Received: by mail-it1-f173.google.com with SMTP id z7so3468822iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 23:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fUklUdLOWYom+lZFSBZY1OFeF485tB7cD3rZ74+c8W0=;
        b=fcjk676pRC1LEMPipJht6lCAa2WMy/b0M/lJEre3Mo6xzssMMQmr3BNhdpUs+CZyri
         4BKXn1xBymDSDU1LqZ1tPIPaKxhIjJUqwxwNp5AgOAdqZEy1TIkABaMxYZaiI9N6+d1I
         EJTCp03CsX/TPch0xwB1uXqckrjONtAD9fASg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fUklUdLOWYom+lZFSBZY1OFeF485tB7cD3rZ74+c8W0=;
        b=L8s3RPgwFHpjfmoxn5BxB0Tu6u3bAgZ6rev8UAdgWAx2mUahn6yReZ+ZOPtasKVAD9
         O2oH1bobr4QeVRWY95gG0SRVSrCG0xjElAhuGYfH22AEqrpTjQpF/07iPB0pBYDTIY1h
         X9npUi8GuaRz/tHC+EgjZEuYNZ87WE4CbAQIuiYAwo13RtTJpb5uMeml4LPyoa9aLG5x
         L+d1czBp/IFVBnj5FmlAQetlnDSETA+/1yKc4pCZkz441Dw8Yuk5dvE+mu3hoGohj6bC
         WtDj7eaNE2MfHAXAv0CSOD3Icid9rogd6akdOaJLzq9ILNNT5qvcfvImZlcGhKrZi32F
         FgwQ==
X-Gm-Message-State: AJcUukfZ+q2pQ+bYpKXBtjsNLcO8eHJZ3W8uX+qhkhR1Qbdp0hu4Qtpj
        wrFI3fPGN6NsiDE/3h7mVun0OcF4QySsWkRwhOLjsA==
X-Google-Smtp-Source: ALg8bN4UohzZprrwOSIFwCjXeIxWqeqXfs2mv6fgb/KSAgWY07Kqp5XQG5jPJKoU3b58tYp9OgXF6o7RKYVgHo5pGZQ=
X-Received: by 2002:a02:c943:: with SMTP id u3mr3543948jao.96.1548315361508;
 Wed, 23 Jan 2019 23:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com>
In-Reply-To: <20190123234817.GE1257@redhat.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 24 Jan 2019 08:35:49 +0100
Message-ID: <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Olof Johansson <olof@lixom.net>, Dave Airlie <airlied@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai,
        Arnd Bergmann <arnd@arndb.de>, fbarrat@linux.ibm.com,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Top post, because new argument.

There's lots of really good technical arguments for having the
userspace component of a driver stack that spans both kernel and
userspace open too. For me, that's not really the important argument.

I care about open source, I'm not interested in blobs (beyond that
they're useful for reverse engineering). I think the upstream
community should care about open source, and by and large it very much
does: We haven't merged ndiswrapper, or the nvidia shim, or anything
like that to make running blobs in the kernel easier. And at least in
the case of the one traditional driver subsystem where 90% of the
driver lives in userspace, we also care about that part being open.

Anything else is imo just a long-term dis-service to the community of
customers, other vendors, ... Adapting a famous quote: If you're ok
with throwing away some long term software freedom for a bit of short
term hardware support you'll get neither.

So if someone propose to merge some open source kernel driver that
requires piles of closed source userspace to be any use at all, I'm
just not interested. And if the fpga folks have merged fpga drivers
without at least a basic (non-optimizing) RTL compiler, then that was
a grave mistake. That doing this is also technically a bad idea (for
all the reasons already discussed) is just the icing on the top for
me.

And to tie this back to the technical discussion, here's a scenario
that's bound to happen:
1. vendor crams their open source driver into upstream, with full blob user=
space
2. vendor gets bored (runs low on money, accidentally fired the entire
old team, needs to do more value add, whatever, ...) rewrites the
entire stack
3. vendor crams their new&completely incompatible open source stack
into upstream
4. upstream is now unvoluntarily stuck maintaining 2 drivers for the
exact same thing, and we can't fix anything of that because if you
touch one side of the stack without undertstanding the other part
you're guaranteed to create regressions (yes this is how this works
with gpu drivers, we've learned this the hard way)
5. repeat

Hence for these technical reasons you'll then end up with a subsystem
that only the vendor can touch, and hence also the vendor can abandon
at will. Not like drivers/gpu, where customers, consulting shops,
students, ... routinely can&do add new features to existing drivers.

This is not a winning move.

Cheers, Daniel

On Thu, Jan 24, 2019 at 12:48 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Jan 23, 2019 at 03:40:25PM -0800, Olof Johansson wrote:
> > On Wed, Jan 23, 2019 at 3:20 PM Jerome Glisse <jglisse@redhat.com> wrot=
e:
> > >
> > > On Wed, Jan 23, 2019 at 03:04:33PM -0800, Olof Johansson wrote:
> > > > On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> wro=
te:
> > > > >
> > > > > On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.com>=
 wrote:
> > > > > >
> > > > > > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.com=
> wrote:
> > > > > > >
> > > > > > > Adding Daniel as well.
> > > > > > >
> > > > > > > Dave.
> > > > > > >
> > > > > > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.com>=
 wrote:
> > > > > > > >
> > > > > > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmai=
l.com> wrote:
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > For those who don't know me, my name is Oded Gabbay (Kern=
el Maintainer
> > > > > > > > > for AMD's amdkfd driver, worked at RedHat's Desktop group=
) and I work at
> > > > > > > > > Habana Labs since its inception two and a half years ago.
> > > > > > > >
> > > > > > > > Hey Oded,
> > > > > > > >
> > > > > > > > So this creates a driver with a userspace facing API via io=
ctls.
> > > > > > > > Although this isn't a "GPU" driver we have a rule in the gr=
aphics
> > > > > > > > drivers are for accelerators that we don't merge userspace =
API with an
> > > > > > > > appropriate userspace user.
> > > > > > > >
> > > > > > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open=
-source-userspace-requirements
> > > > > > > >
> > > > > > > > I see nothing in these accelerator drivers that make me thi=
nk we
> > > > > > > > should be treating them different.
> > > > > > > >
> > > > > > > > Having large closed userspaces that we have no insight into=
 means we
> > > > > > > > get suboptimal locked for ever uAPIs. If someone in the fut=
ure creates
> > > > > > > > an open source userspace, we will end up in a place where t=
hey get
> > > > > > > > suboptimal behaviour because they are locked into a uAPI th=
at we can't
> > > > > > > > change.
> > > > > > > >
> > > > > > > > Dave.
> > > > > >
> > > > > > Hi Dave,
> > > > > > While I always appreciate your opinion and happy to hear it, I =
totally
> > > > > > disagree with you on this point.
> > > > > >
> > > > > > First of all, as you said, this device is NOT a GPU. Hence, I w=
asn't
> > > > > > aware that this rule might apply to this driver or to any other=
 driver
> > > > > > outside of drm. Has this rule been applied to all the current d=
rivers
> > > > > > in the kernel tree with userspace facing API via IOCTLs, which =
are not
> > > > > > in the drm subsystem ?  I see the logic for GPUs as they drive =
the
> > > > > > display of the entire machine, but this is an accelerator for a
> > > > > > specific purpose, not something generic as GPU. I just don't se=
e how
> > > > > > one can treat them in the same way.
> > > > >
> > > > > The logic isn't there for GPUs for those reason that we have an
> > > > > established library or that GPUs are in laptops. They are just wh=
ere
> > > > > we learned the lessons of merging things whose primary reason for
> > > > > being in the kernel is to execute stuff from misc userspace stack=
s,
> > > > > where the uAPI has to remain stable indefinitely.
> > > > >
> > > > > a) security - without knowledge of what the accelerator can do ho=
w can
> > > > > we know if the API you expose isn't just a giant root hole?
> > > > >
> > > > > b) uAPI stability. Without a userspace for this, there is no way =
for
> > > > > anyone even if in possession of the hardware to validate the uAPI=
 you
> > > > > provide and are asking the kernel to commit to supporting indefin=
itely
> > > > > is optimal or secure. If an open source userspace appears is it t=
o be
> > > > > limited to API the closed userspace has created. It limits the fu=
ture
> > > > > unnecessarily.
> > > > >
> > > > > > There is no way that "someone" will create a userspace
> > > > > > for our H/W without the intimate knowledge of the H/W or withou=
t the
> > > > > > ISA of our programmable cores. Maybe for large companies this r=
equest
> > > > > > is valid, but for startups complying to this request is not rea=
listic.
> > > > >
> > > > > So what benefit does the Linux kernel get from having support for=
 this
> > > > > feature upstream?
> > > > >
> > > > > If users can't access the necessary code to use it, why does this
> > > > > require to be maintained in the kernel.
> > > > >
> > > > > > To conclude, I think this approach discourage other companies f=
rom
> > > > > > open sourcing their drivers and is counter-productive. I'm not =
sure
> > > > > > you are aware of how difficult it is to convince startup manage=
ment to
> > > > > > opensource the code...
> > > > >
> > > > > Oh I am, but I'm also more aware how quickly startups go away and
> > > > > leave the kernel holding a lot of code we don't know how to valid=
ate
> > > > > or use.
> > > > >
> > > > > I'm opening to being convinced but I think defining new userspace
> > > > > facing APIs is a task that we should take a lot more seriously go=
ing
> > > > > forward to avoid mistakes of the past.
> > > >
> > > > I think the most important thing here is to know that things are
> > > > likely to change quite a bit over the next couple of years, and tha=
t
> > > > we don't know yet what we actually need. If we hold off picking up
> > > > support for hardware while all of this is ironed out, we'll miss ou=
t
> > > > on being exposed to it, and will have a very tall hill to climb onc=
e
> > > > we try to convince vendors to come into the fold. It's also not bee=
n a
> > > > requirement for the other two drivers we have merged, as far as I c=
an
> > > > tell (CAPI and OpenCAPI) so the cat's already out of the bag.
> > > >
> > > > I'd rather not get stuck in a stand-off needing the longterm soluti=
on
> > > > to pick up the short term contribution. That way we can move over t=
o a
> > > > _new_ API once there's been a better chance of finding common groun=
ds
> > > > and once things settle down a bit, instead of trying to bring some
> > > > larger legacy codebase for devices that people might no longer care
> > > > much about over to the newer APIs.
> > > >
> > > > It's better to be exposed to the HW and drivers now, than having
> > > > people build large elaborate out-of-tree software stacks for this.
> > > > It's also better to get them to come and collaborate now, instead o=
f
> > > > pushing them away until things are perfect.
> > > >
> > > > Having a way to validate and exercise the userspace API is importan=
t,
> > > > including ability to change it if needed. Would it be possible to o=
pen
> > > > up the lowest userspace pieces (driver interactions), even if some
> > > > other layers might not yet be, to exercise the device/kernel/usersp=
ace
> > > > interfaces without "live" workload, etc?
> > >
> > > Yes and to exercise the userspace API you need at very least to
> > > know the ISA so that you can write program for the accelerator.
> > > You also need to know the set of commands the hardware has. The
> > > ioctl and how to create a userspace that interact with the kernel
> > > is the easy part, the hard part is the compiler.
> > >
> > > So if we want any kind of freedom to play with the UAPI, enhance
> > > it or change it in anyway we must be free to build program for the
> > > device ourself.
> > >
> > > I believe that the GPU sub-system requirement are a good guideline
> > > to follow and the only exception with drivers/ that i am aware of
> > > is the fpga. Everything else in driver as either an open source
> > > userspace, expose a common API (like network) or is so simple that
> > > anyone can write a userspace for it.
> >
> > Once we have a common framework I agree that we need enough tools to
> > exercise everything needed. I don't agree that this includes full
> > sources to everything. We don't expect this for most PCIe cards today
> > either.
>
> We do expected this today except for FPGA, i do not know any single
> pcie device with upstream driver that we do not know how to program.
> Biggest chunk of PCIE devices are straightforward (network, sound,
> media, ...).
>
> So in effect today the lowest common denominator is open source user
> space or device API is so simple that user space is obvious (various
> media device).
>
> >
> > If the GPU subsystem is to be followed, I fear that we will end up
> > with Nvidia-equivalent vendors from day 1, where they will just build
> > a bigger and bigger software stack on the side instead of joining in,
> > and someone will need to best-effort bridge the gap by reverse
> > engineering. I don't want that situation long-term, which is why I
> > think it's reasonable to be more relaxed during the early days with
> > upfront, clear, expectations for the longer term that hardware/kernel
> > interfaces need to be exercisable.
>
> I think the other way around, allowing people to push upstream driver
> with no open source user space and people loose any motivation to
> work on open sourcing their userspace. Not being upstream is painful
> enough that they will get pressure to go upstream and if upstream
> means open source userspace then they have to comply.
>
> >
> > > For any complex device that execute program we should really enforce
> > > the open source userspace so that we can properly audit the driver
> > > as otherwise we only have half of the story with no idea what the
> > > other half might implies.
> >
> > What you're demanding is open userspace _and_ firmware. Since without
> > firmware sources, you can't audit any on-chip behavior either (in
> > reality, most commands passed down are likely parsed by said
> > firmware).
>
> No i do not ask for firmware. If we have any doubt about what the firm-
> ware can let through then we can lock down the ioctl ie parse commands
> from userspace and only allow kernel to write sanitize command to
> command queue. By auditing here i mean being able to understand the
> overall flow that is expected from program so from that program flow
> we can work on what is the best UAPI with minimum overhead to achieve
> that program flow the most efficiently. Sorry if that was not clear.
>
> Cheers,
> J=C3=A9r=C3=B4me



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
