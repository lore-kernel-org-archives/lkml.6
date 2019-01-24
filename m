Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3C4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64042085A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/1qKXJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfAXJtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:49:24 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41928 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:49:23 -0500
Received: by mail-vk1-f193.google.com with SMTP id t127so1177286vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=edL6gANzfUqCP5zJC1ZPwnwWRzzIauP3aoC9kOt4V6g=;
        b=p/1qKXJJhZM6kSob7SG1W65kvrhGBeSKGxiq3XzWS17PEWbLBkt8oGN2ZoF353s0XC
         bReH4Hd3iPjYEbm/NGkL0LVbnRagNuJD2Czv10FOyi1JHPnDgIAKdzcrFkaW/8T+m9ro
         HRDL0Fst2ipU+lrLUlo83BoEabyo50RQuXlZ/YISLbWOtqLyu26K7QdJJqRG7uPxuq+B
         kgKMxCGC94QnHBVNZ5ptE7gjixPiCampe2Gn5SuukQxeqCzNS6OIiIQ9S+gYuY+BGri2
         txxq0VRqMjVBwHYxjD/jhk8OKWx/RP5MMOdrlLr0kD2Su+pJ9d+Nospu3WaXOA8rk2e/
         3mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=edL6gANzfUqCP5zJC1ZPwnwWRzzIauP3aoC9kOt4V6g=;
        b=CfGZ32ffIhyyiMIHXnVXnLFJjgQD2tc84W6e7hy2Jk1A69dP2njfxnkyCMWuVoZVjl
         KYFCd25y/xsaLGpqPy97qTZQTWaA/JH+lwkMPjoXCC4+9LAuSlmZDM/wSYiai08hvm8c
         AbrOmw+DLG9leLte06H4y1bSCrQ2PgpPt+6sFmumy3yw+xLmTyGWSm5CFsirR35+2lBZ
         YLqOrjVj9lw+vgPOFf7F9DM2Jyk6PrNZ8aQOCsTdE4hp549CO3EuqzGOCsFxBCaCXqev
         RCwppJQJRT7dW1PCpd1eyJqwkNxn5yVbSrZk0Xa8q/9MTmZNAtfS0dELMg8A20e7z5Lx
         O2fg==
X-Gm-Message-State: AJcUukdIwBpI2EKx6kzBn1nG6gEInXZ0dzbRr7eQ+2ZcVClQMg70D4ee
        TJidVrl9k++xVD6pVnMEud6TrJcORo6r2hnFmAg=
X-Google-Smtp-Source: ALg8bN40/hKPtms7iXK1FAz7XVO0cQgamzBSULzseFaYGOGKDJrFLj2D0+6WmZCmPVvNtYgyEdIA4B9mu1Sh1oUK4ao=
X-Received: by 2002:a1f:b248:: with SMTP id b69mr2315779vkf.30.1548323361250;
 Thu, 24 Jan 2019 01:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
 <CAPM=9tybcYSR_xu773W-cV1JfFg1Rcb9NajXhZd+zfZE8+XMRg@mail.gmail.com>
 <CAFCwf12FGkc3hDtgeFCn4Z4cgjL8wAf+SRkWqA+04WtuaEdpBA@mail.gmail.com>
 <CAPM=9tx3M6i44AL4hkt740Q35T4djz=-bjWDP4FVngOR0kcwag@mail.gmail.com>
 <CAOesGMg-_K_KJFtxyZJFbM+p1N5UfeUwvXmxkj+DRtNSj7Bosw@mail.gmail.com>
 <20190123232052.GD1257@redhat.com> <CAOesGMhU6wzX=sBC0iqDrzBYinP8POp=9-d4oEQoaNee-dU1zQ@mail.gmail.com>
 <20190123234817.GE1257@redhat.com> <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHPNPJGxyHt46wwNGwdoZkLez9Cf7hAZ1sXh8=w56OUOQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 24 Jan 2019 11:50:51 +0200
Message-ID: <CAFCwf10fvFAXQCGXpJHdf2bBOEJ9ZXZvoUgH9JWbNOtnmELBmg@mail.gmail.com>
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Olof Johansson <olof@lixom.net>,
        Dave Airlie <airlied@gmail.com>,
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

Hi Daniel and Jerome,
I know I won't be able to convince you but I want to say that I think
your arguments for full userspace open source are not really
technical.

IMHO, an open-source, thin runtime that provides code to operate ALL
the uAPI the driver exports + commitment to only using this library as
the interface to the driver is good enough for the issue of uAPI
breakage. And that thing I can provide.

If at a later time habana will decide to throw it all away (not going
to happen while I'm here), then its habana's problem. Not the kernel.
In that case, I would argue that the kernel shouldn't accept a new
driver from habana. But as long as we keep API compatibility, I don't
see any harm.

I'm not convinced by your request to open the ISA of the programmable
cores. How is that relevant to the kernel driver. I don't even do
anything with those cores. The uAPI I export isn't related whatsoever
to those cores.

I honestly think that if your position is accepted by the Linux kernel
community, companies building AI accelerators won't go near the
kernel. They will simply go down the path Nvidia has gone, which is to
have an out-of-tree kernel driver + big closed userspace. That's a
totally sustainable path from business POV (see Nvidia's dominance in
GPU and deep learning). I don't see how that will serve any of us. I
would think we want to lure companies into open sourcing their code,
and you don't do that by saying: "if you don't open your entire code
base, don't bother to open any part of it".

Thanks,
Oded

On Thu, Jan 24, 2019 at 9:36 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrot=
e:
>
> Hi all,
>
> Top post, because new argument.
>
> There's lots of really good technical arguments for having the
> userspace component of a driver stack that spans both kernel and
> userspace open too. For me, that's not really the important argument.
>
> I care about open source, I'm not interested in blobs (beyond that
> they're useful for reverse engineering). I think the upstream
> community should care about open source, and by and large it very much
> does: We haven't merged ndiswrapper, or the nvidia shim, or anything
> like that to make running blobs in the kernel easier. And at least in
> the case of the one traditional driver subsystem where 90% of the
> driver lives in userspace, we also care about that part being open.
>
> Anything else is imo just a long-term dis-service to the community of
> customers, other vendors, ... Adapting a famous quote: If you're ok
> with throwing away some long term software freedom for a bit of short
> term hardware support you'll get neither.
>
> So if someone propose to merge some open source kernel driver that
> requires piles of closed source userspace to be any use at all, I'm
> just not interested. And if the fpga folks have merged fpga drivers
> without at least a basic (non-optimizing) RTL compiler, then that was
> a grave mistake. That doing this is also technically a bad idea (for
> all the reasons already discussed) is just the icing on the top for
> me.
>
> And to tie this back to the technical discussion, here's a scenario
> that's bound to happen:
> 1. vendor crams their open source driver into upstream, with full blob us=
erspace
> 2. vendor gets bored (runs low on money, accidentally fired the entire
> old team, needs to do more value add, whatever, ...) rewrites the
> entire stack
> 3. vendor crams their new&completely incompatible open source stack
> into upstream
> 4. upstream is now unvoluntarily stuck maintaining 2 drivers for the
> exact same thing, and we can't fix anything of that because if you
> touch one side of the stack without undertstanding the other part
> you're guaranteed to create regressions (yes this is how this works
> with gpu drivers, we've learned this the hard way)
> 5. repeat
>
> Hence for these technical reasons you'll then end up with a subsystem
> that only the vendor can touch, and hence also the vendor can abandon
> at will. Not like drivers/gpu, where customers, consulting shops,
> students, ... routinely can&do add new features to existing drivers.
>
> This is not a winning move.
>
> Cheers, Daniel
>
> On Thu, Jan 24, 2019 at 12:48 AM Jerome Glisse <jglisse@redhat.com> wrote=
:
> >
> > On Wed, Jan 23, 2019 at 03:40:25PM -0800, Olof Johansson wrote:
> > > On Wed, Jan 23, 2019 at 3:20 PM Jerome Glisse <jglisse@redhat.com> wr=
ote:
> > > >
> > > > On Wed, Jan 23, 2019 at 03:04:33PM -0800, Olof Johansson wrote:
> > > > > On Wed, Jan 23, 2019 at 2:45 PM Dave Airlie <airlied@gmail.com> w=
rote:
> > > > > >
> > > > > > On Thu, 24 Jan 2019 at 08:32, Oded Gabbay <oded.gabbay@gmail.co=
m> wrote:
> > > > > > >
> > > > > > > On Thu, Jan 24, 2019 at 12:02 AM Dave Airlie <airlied@gmail.c=
om> wrote:
> > > > > > > >
> > > > > > > > Adding Daniel as well.
> > > > > > > >
> > > > > > > > Dave.
> > > > > > > >
> > > > > > > > On Thu, 24 Jan 2019 at 07:57, Dave Airlie <airlied@gmail.co=
m> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gm=
ail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hello,
> > > > > > > > > >
> > > > > > > > > > For those who don't know me, my name is Oded Gabbay (Ke=
rnel Maintainer
> > > > > > > > > > for AMD's amdkfd driver, worked at RedHat's Desktop gro=
up) and I work at
> > > > > > > > > > Habana Labs since its inception two and a half years ag=
o.
> > > > > > > > >
> > > > > > > > > Hey Oded,
> > > > > > > > >
> > > > > > > > > So this creates a driver with a userspace facing API via =
ioctls.
> > > > > > > > > Although this isn't a "GPU" driver we have a rule in the =
graphics
> > > > > > > > > drivers are for accelerators that we don't merge userspac=
e API with an
> > > > > > > > > appropriate userspace user.
> > > > > > > > >
> > > > > > > > > https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#op=
en-source-userspace-requirements
> > > > > > > > >
> > > > > > > > > I see nothing in these accelerator drivers that make me t=
hink we
> > > > > > > > > should be treating them different.
> > > > > > > > >
> > > > > > > > > Having large closed userspaces that we have no insight in=
to means we
> > > > > > > > > get suboptimal locked for ever uAPIs. If someone in the f=
uture creates
> > > > > > > > > an open source userspace, we will end up in a place where=
 they get
> > > > > > > > > suboptimal behaviour because they are locked into a uAPI =
that we can't
> > > > > > > > > change.
> > > > > > > > >
> > > > > > > > > Dave.
> > > > > > >
> > > > > > > Hi Dave,
> > > > > > > While I always appreciate your opinion and happy to hear it, =
I totally
> > > > > > > disagree with you on this point.
> > > > > > >
> > > > > > > First of all, as you said, this device is NOT a GPU. Hence, I=
 wasn't
> > > > > > > aware that this rule might apply to this driver or to any oth=
er driver
> > > > > > > outside of drm. Has this rule been applied to all the current=
 drivers
> > > > > > > in the kernel tree with userspace facing API via IOCTLs, whic=
h are not
> > > > > > > in the drm subsystem ?  I see the logic for GPUs as they driv=
e the
> > > > > > > display of the entire machine, but this is an accelerator for=
 a
> > > > > > > specific purpose, not something generic as GPU. I just don't =
see how
> > > > > > > one can treat them in the same way.
> > > > > >
> > > > > > The logic isn't there for GPUs for those reason that we have an
> > > > > > established library or that GPUs are in laptops. They are just =
where
> > > > > > we learned the lessons of merging things whose primary reason f=
or
> > > > > > being in the kernel is to execute stuff from misc userspace sta=
cks,
> > > > > > where the uAPI has to remain stable indefinitely.
> > > > > >
> > > > > > a) security - without knowledge of what the accelerator can do =
how can
> > > > > > we know if the API you expose isn't just a giant root hole?
> > > > > >
> > > > > > b) uAPI stability. Without a userspace for this, there is no wa=
y for
> > > > > > anyone even if in possession of the hardware to validate the uA=
PI you
> > > > > > provide and are asking the kernel to commit to supporting indef=
initely
> > > > > > is optimal or secure. If an open source userspace appears is it=
 to be
> > > > > > limited to API the closed userspace has created. It limits the =
future
> > > > > > unnecessarily.
> > > > > >
> > > > > > > There is no way that "someone" will create a userspace
> > > > > > > for our H/W without the intimate knowledge of the H/W or with=
out the
> > > > > > > ISA of our programmable cores. Maybe for large companies this=
 request
> > > > > > > is valid, but for startups complying to this request is not r=
ealistic.
> > > > > >
> > > > > > So what benefit does the Linux kernel get from having support f=
or this
> > > > > > feature upstream?
> > > > > >
> > > > > > If users can't access the necessary code to use it, why does th=
is
> > > > > > require to be maintained in the kernel.
> > > > > >
> > > > > > > To conclude, I think this approach discourage other companies=
 from
> > > > > > > open sourcing their drivers and is counter-productive. I'm no=
t sure
> > > > > > > you are aware of how difficult it is to convince startup mana=
gement to
> > > > > > > opensource the code...
> > > > > >
> > > > > > Oh I am, but I'm also more aware how quickly startups go away a=
nd
> > > > > > leave the kernel holding a lot of code we don't know how to val=
idate
> > > > > > or use.
> > > > > >
> > > > > > I'm opening to being convinced but I think defining new userspa=
ce
> > > > > > facing APIs is a task that we should take a lot more seriously =
going
> > > > > > forward to avoid mistakes of the past.
> > > > >
> > > > > I think the most important thing here is to know that things are
> > > > > likely to change quite a bit over the next couple of years, and t=
hat
> > > > > we don't know yet what we actually need. If we hold off picking u=
p
> > > > > support for hardware while all of this is ironed out, we'll miss =
out
> > > > > on being exposed to it, and will have a very tall hill to climb o=
nce
> > > > > we try to convince vendors to come into the fold. It's also not b=
een a
> > > > > requirement for the other two drivers we have merged, as far as I=
 can
> > > > > tell (CAPI and OpenCAPI) so the cat's already out of the bag.
> > > > >
> > > > > I'd rather not get stuck in a stand-off needing the longterm solu=
tion
> > > > > to pick up the short term contribution. That way we can move over=
 to a
> > > > > _new_ API once there's been a better chance of finding common gro=
unds
> > > > > and once things settle down a bit, instead of trying to bring som=
e
> > > > > larger legacy codebase for devices that people might no longer ca=
re
> > > > > much about over to the newer APIs.
> > > > >
> > > > > It's better to be exposed to the HW and drivers now, than having
> > > > > people build large elaborate out-of-tree software stacks for this=
.
> > > > > It's also better to get them to come and collaborate now, instead=
 of
> > > > > pushing them away until things are perfect.
> > > > >
> > > > > Having a way to validate and exercise the userspace API is import=
ant,
> > > > > including ability to change it if needed. Would it be possible to=
 open
> > > > > up the lowest userspace pieces (driver interactions), even if som=
e
> > > > > other layers might not yet be, to exercise the device/kernel/user=
space
> > > > > interfaces without "live" workload, etc?
> > > >
> > > > Yes and to exercise the userspace API you need at very least to
> > > > know the ISA so that you can write program for the accelerator.
> > > > You also need to know the set of commands the hardware has. The
> > > > ioctl and how to create a userspace that interact with the kernel
> > > > is the easy part, the hard part is the compiler.
> > > >
> > > > So if we want any kind of freedom to play with the UAPI, enhance
> > > > it or change it in anyway we must be free to build program for the
> > > > device ourself.
> > > >
> > > > I believe that the GPU sub-system requirement are a good guideline
> > > > to follow and the only exception with drivers/ that i am aware of
> > > > is the fpga. Everything else in driver as either an open source
> > > > userspace, expose a common API (like network) or is so simple that
> > > > anyone can write a userspace for it.
> > >
> > > Once we have a common framework I agree that we need enough tools to
> > > exercise everything needed. I don't agree that this includes full
> > > sources to everything. We don't expect this for most PCIe cards today
> > > either.
> >
> > We do expected this today except for FPGA, i do not know any single
> > pcie device with upstream driver that we do not know how to program.
> > Biggest chunk of PCIE devices are straightforward (network, sound,
> > media, ...).
> >
> > So in effect today the lowest common denominator is open source user
> > space or device API is so simple that user space is obvious (various
> > media device).
> >
> > >
> > > If the GPU subsystem is to be followed, I fear that we will end up
> > > with Nvidia-equivalent vendors from day 1, where they will just build
> > > a bigger and bigger software stack on the side instead of joining in,
> > > and someone will need to best-effort bridge the gap by reverse
> > > engineering. I don't want that situation long-term, which is why I
> > > think it's reasonable to be more relaxed during the early days with
> > > upfront, clear, expectations for the longer term that hardware/kernel
> > > interfaces need to be exercisable.
> >
> > I think the other way around, allowing people to push upstream driver
> > with no open source user space and people loose any motivation to
> > work on open sourcing their userspace. Not being upstream is painful
> > enough that they will get pressure to go upstream and if upstream
> > means open source userspace then they have to comply.
> >
> > >
> > > > For any complex device that execute program we should really enforc=
e
> > > > the open source userspace so that we can properly audit the driver
> > > > as otherwise we only have half of the story with no idea what the
> > > > other half might implies.
> > >
> > > What you're demanding is open userspace _and_ firmware. Since without
> > > firmware sources, you can't audit any on-chip behavior either (in
> > > reality, most commands passed down are likely parsed by said
> > > firmware).
> >
> > No i do not ask for firmware. If we have any doubt about what the firm-
> > ware can let through then we can lock down the ioctl ie parse commands
> > from userspace and only allow kernel to write sanitize command to
> > command queue. By auditing here i mean being able to understand the
> > overall flow that is expected from program so from that program flow
> > we can work on what is the best UAPI with minimum overhead to achieve
> > that program flow the most efficiently. Sorry if that was not clear.
> >
> > Cheers,
> > J=C3=A9r=C3=B4me
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
