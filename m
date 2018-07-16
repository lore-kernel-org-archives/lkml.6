Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3D2208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPls9sbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3D2208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeGPOXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbeGPOXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:23:36 -0400
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1947C21480;
        Mon, 16 Jul 2018 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531749361;
        bh=/t0/yvLOvWaRg3Q9WRBG2KK/EgtQJ3amusQiweBjiEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPls9sbYgbYbHo8qd2B2zHf1jdRtsw28aQFa7QeJLLPBu8yFrKfz0ramMarY7vlHH
         wwSM80tV3JYQ6F9uPg1d+7mwRYatSuMaizpRSIKyGXM3Qp2rtk8448uvFFGVO7HT7D
         34k/O19So5/wbm3XIGPB328h+yIou9gr5jXbZJuM=
Received: by mail-io0-f177.google.com with SMTP id q19-v6so37868826ioh.11;
        Mon, 16 Jul 2018 06:56:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlGlssDq1fxss2RKwnOl5qqXYE+EIuYs/Uu5owsHezj7atsbs8VS
        t+VtRLplt+xBjscV0tU4QXkAbC1iQwCDfKiK5A==
X-Google-Smtp-Source: AAOMgpcgS2DWyPDSdud82XrSkqVJ9FLZ0otEDrdy3HPIyJwuL+jyu6GSxSBcezNejd3Ug70lNO8guWEVeDQDtYK3k9c=
X-Received: by 2002:a5e:c90e:: with SMTP id z14-v6mr41242631iol.268.1531749360352;
 Mon, 16 Jul 2018 06:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org> <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
In-Reply-To: <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Jul 2018 07:55:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
Message-ID: <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi Rob, Ben,
>
> I've replied to you both inline below, hopefully it's clear enough from t=
he context.
>
> On Fri, 13 Jul 2018, at 10:25, Benjamin Herrenschmidt wrote:
> > On Thu, 2018-07-12 at 09:11 -0600, Rob Herring wrote:
> > > On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrot=
e:
> > > >
> > > > Hi Rob,
> > > >
> > > > Thanks for the response.
> > > >
> > > > On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > > > > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > > > > Baseboard Management Controllers (BMCs) are embedded SoCs that =
exist to
> > > > > > provide remote management of (primarily) server platforms. BMCs=
 are
> > > > > > often tightly coupled to the platform in terms of behaviour and=
 provide
> > > > > > many hardware features integral to booting and running the host=
 system.
> > > > > >
> > > > > > Some of these hardware features are simple, for example scratch
> > > > > > registers provided by the BMC that are exposed to both the host=
 and the
> > > > > > BMC. In other cases there's a single bit switch to enable or di=
sable
> > > > > > some of the provided functionality.
> > > > > >
> > > > > > The documentation defines bindings for fields in registers that=
 do not
> > > > > > integrate well into other driver models yet must be described t=
o allow
> > > > > > the BMC kernel to assume control of these features.
> > > > >
> > > > > So we'll get a new binding when that happens? That will break
> > > > > compatibility.
> > > >
> > > > Can you please expand on this? I'm not following.
> > >
> > > If we have a subsystem in the future, then there would likely be an
> > > associated binding which would be different. So if you update the DT,
> > > then old kernels won't work with it.
> >
> > What kind of "subsystem" ? There is almost no way there could be one
> > for that sort of BMC tunables. We've look at several BMC chips out
> > there and requirements from several vendors, BIOS and system
> > manufacturers and it's all over the place.
>
> Right - This is the fundamental principle backing these patches: There wi=
ll never be a coherent subsystem catering to any of what we want to describ=
e with these bindings.

I never said they would. Saying "do not integrate well into other
driver models YET" implies at some point they will. No point in
beating this any further, just remove "yet"...

> > > > I feel like this is an argument of tradition. Maybe people have
> > > > been dissuaded from doing so when they don't have a reasonable use-
> > > > case? I'm not saying that what I'm proposing is unquestionably
> > > > reasonable, but I don't want to dismiss it out of hand.
> > >
> ...
> > >
> > > It comes up with system controller type blocks too that just have a
> > > bunch of random registers.
>
> This matches the situation at hand.
>
> > > Those change in every SoC and not in any
> > > controlled or ordered way that would make describing the individual
> > > sub-functions in DT worthwhile.
>
> "Not worthwhile" is what I'm pushing back against for our use cases. I th=
ink they are narrow and limited enough to make it worthwhile.
>
> Obviously we want to avoid describing these things *badly* - you mentione=
d the clock bindings - so I'm happy to hash out what the right representati=
on should be. But I struggle to think the solution is not describing some o=
f our hardware features at all.
>
> >
> > So what's the alternative ? Because without something like what we
> > propose, what's going to happen is /dev/mem ... that's what people do
> > today.
>
> Yep. And I've outlined in the cover letter what I think are the advantage=
s of what I'm proposing over /dev/mem. It's not an incredible gain, but has=
 several of nice-to-have properties.
>
> >
> > > > > A node per register bit doesn't scale.
> > > >
> > > > It isn't meant to scale in terms of a single system. Using it
> > > > extensively is very likely wrong. Separately, register-bit-led does
> > > > pretty much the same thing. Doesn't the scale argument apply there?
> > > > Who is to stop me from attaching an insane number of LEDs to a
> > > > system?
> > >
> > > Review.
> > >
> > > If you look, register-bit-led is rarely used outside of some ARM, Ltd=
.
> > > boards. It's simply quite rare to have MMIO register bits that have a
> > > fixed function of LED control.
> >
> > Well, same here, we hope to review what goes upstream to make it
> > reasonable. Otherwise it doens't matter. If a random vendor, let's say
> > IBM, chose to chip a system where they put an insane amount of cruft in
> > there, it will only affect those systems's BMC and the userspace stack
> > on it.
> >
> > Thankfully that stack is OpenBMC and IBM is aiming at having their
> > device-tree's upstream, thus reviewed, thus it won't happen.
> >
> > *Anything* can be abused. The point here is that we have a number,
> > thankfully rather small, maybe a dozen or two, of tunables that are
> > quite specific to a combination (system vendor, bmc vendor, system
> > model) which control a few HW features that essentially do *NOT* fit in
> > a subsystem.
>
> Exactly. I tried to head off the abuse vector by requiring that uses be l=
isted in the bindings document, and thus enforce some level of review. It m=
ight not be the most effective approach at the end of the day, but at least=
 it is something.
>
> >
> > For everything that does, we have created proper drivers (and are doing
> > more).
> >
> >
> > > > Obviously if there are lots of systems using it sparingly and
> > > > legitimately then maybe there's a scale issue, but isn't that just
> > > > a reality of different hardware designs? Whoever is implementing
> > > > support for the system is going to have to describe the hardware
> > > > one way or another.
> > > >
> > > > >
> > > > > Maybe this should be modelled using GPIO binding? There's a line =
there
> > > > > too as whether the signals are "general purpose" or not.
> > > >
> > > > I don't think so, mainly because some of the things it is intended =
to be used for are not GPIOs. For instance, take the DAC mux I've described=
 in the patch. It doesn't directly influence anything external to the SoC (=
i.e. it's certainly not a traditional GPIO in any sense). However, it does =
*indirectly* influence the SoC's behaviour by muxing the DAC internally bet=
ween:
> > > >
> > > > 0. VGA device exposed on the host PCIe bus
> > > > 1. The "Graphics CRT" controller
> > > > 2. VGA port A
> > > > 3. VGA port B
> > >
> > > And this mux control is fixed in the SoC design?
> >
> > This specific family of SoC (Aspeed) support those 4 configurations.
> > How they need to be configured at runtime depends on the combination of
> > system vendor and system model, along with in some cases the need to
> > switch it at runtime.
> >
> > This is just one example. Another one is the handful of scratch
> > registers that need to be populated with the "right" values for the
> > host system BIOS, VGA BIOS and VGA driver. (The host bits access them
> > via LPC IO space).
> >
> > The host system BIOS will read some basic config info there before its
> > IPMI stack is up (and some BIOSes already rely on that). The VGA BIOS
> > will get some strapping info and panel info. The VGA driver (which is
> > already upstream, has been for a long time) will look for other things
> > in some of these guys, such as connector configuration.
> >
> > Andrew, if it helps, we could put together a list of what we typically
> > need on an OpenPower system today. That would give people like Rob a
> > better idea of what this is all about.
>
> It's primarily what I've outlined at the bottom of the bindings document,=
 though the use cases aren't provided there as they are a bit out-of-scope.=
 So the SuperIO and VGA scratch registers, plus the DAC mux. A bunch of tun=
able things.
>
> OpenPOWER platforms make use of the SuperIO scratch registers to convey c=
onfiguration information from the BMC to the host. Information provided inc=
ludes low-level control of the host firmware initialisation process, UART a=
nd logging configuration, and the strategy for handling errors (crash vs lo=
g). This is all an "arbitrary" contract between the BMC userspace and the h=
ost firmware, i.e. different platforms/firmware could lay out the same info=
rmation in different ways or communicate entirely different information alt=
ogether. The BMC kernel shouldn't care about any of it, other than provide =
sensible access to the hardware.
>
> Again on OpenPOWER systems using the ASPEED BMC SoCs running OpenBMC, the=
 BMC uses the VGA scratch registers to sense initialisation of the host gra=
phics driver in the host's boot process. When the BMC userspace detects the=
 host VGA driver is up we switch the DAC mux from the BMC CRT device to the=
 host VGA device so that the host is now driving the VGA output. Non-OpenPO=
WER OpenBMC configurations may do something entirely different, or not do a=
nything at all with the hardware, so as above, it's not really the job of t=
he BMC kernel to be involved in any of this, other than to provide sensible=
 access to userspace.
>
> There are a number of other switches that control the availability of ASP=
EED BMC hardware features to the host system that also don't fit any partic=
ular subsystem and so will use these bindings, but our (OpenPOWER/OpenBMC) =
current uses are what's described above.
>
> Dell also suggested they had some use-cases that aligned with the intent =
of the bindings, but I don't know what they had in mind. Eugene (on Cc) can=
 elaborate.
>
> >
> > > >
> > > > Maybe this could be modelled by pinmux, but then we still need some
> > > > way to expose the mux functions to userspace for selection
> > > > (userspace needs to transition arbitrarily between at least options
> > > > 0 and 1 at runtime), at which point we haven't achieved much beyond
> > > > adding a whole heap of infrastructure in the chain.
> > > >
> > > > Given 0 and 1, maybe exposing attributes in relevant drivers would
> > > > be reasonable, except 0 isn't exposed on the SoC's internal bus so
> > > > there is no driver on the BMC-side to do so. Taking into account 2
> > > > and 3 are also purely hardware paths further dashes the idea, as
> > > > the configuration doesn't really "belong" to the Graphics CRT
> > > > device more than it belongs anywhere else, except for the fact that
> > > > there isn't anywhere else to expose it.
> > > >
> > > > Further, the BMC's kernel can't make the decision as to when to
> > > > switch the mux as it knows nothing of the host's state. The BMC
> > > > userspace is controlling the host's boot state and so *does* know
> > > > when to flip the switch. Finally, the mux is in separate IP to the
> > > > CRT or VGA blocks: It lives in the System Control Unit.
> > > >
> > > > My current point of view is the DAC mux field is effectively its
> > > > own device, and we need to control it from userspace, so we need
> > > > some way to describe it (i.e. not ignore it) in order for its
> > > > capability to be exposed.
> > > >
> > > > I'm fully aware what I'm proposing isn't awesome as it's not
> > > > providing any real abstraction, but the problem(s) at hand also
> > > > seem to defy abstraction, and in order to avoid a plethora of
> > > > bespoke bindings I thought it was reasonable to define something
> > > > generic.
> > > >
> > > > All-in-all I appreciate the suggestion, but assuming you agree with
> > > > my reasoning above do you have thoughts on other alternatives?
> > >
> > > Seems the controls are more fixed than I first thought. All the data
> > > you have here could simply be within a driver.
>
> Rob: A driver for what though? One unique to this particular mux? That fe=
els overly specific when we can generalise the concept to cover a wider ran=
ge of use-cases.

Not unique. Just instead of populating the structs you have in the
driver from DT, define them in the driver and attach them to
match->data ptr.

> > > Help me understand what
> > > functions are fixed (in the SoC) and which ones vary by board. Only
> > > what's changing per board really needs to go into DT.
>
> I think this last sentence identifies a difference in our starting points=
, so I'd like to explore that. Blocks of functionality might move around in=
side the SoC as well, so don't we need a way to describe those functions ap=
propriately?

Yes, if the blocks have well defined boundaries and functions. Blocks
like a UART for example do. Various pieces dumped into system
controllers generally don't IME.

> And from there describe how the SoC integrates the functions, and then de=
scribe how a board integrates the SoC? This all composes, and the problem a=
t the end of the day comes down to what we want to view as a point of abstr=
action, right?

Yes. It's a judgement call as to how much we try to describe in DT. To
use clocks again, a clock divider, mux, or gate all seem like well
defined functions which could be (and were) described in DT, but we
learned that doesn't really work. We're still converting platforms
that did it that way...

> It seems ideal to me that the metadata about hardware features resides in=
 the description of the relevant system (DT, for a function, a SoC or a boa=
rd), otherwise don't we wind up with crazy, unfocused, monolithic drivers f=
or things like system controllers? (There's MFD/syscon, but having used it =
previously I'm still grappling with the benefit over some of the weirdness =
it injects into devicetree - maybe I did it wrong.) Or alternatively, a gen=
eric driver that's choc full of platform-specific data covering the platfor=
ms that require it?

If that data is one set per SoC, then i'm not that concerned having
platform-specific data in the driver. That doesn't mean the driver is
not "generic". It's still not clear to me in this thread, how much of
this is board specific, but given that you've placed all the data in
an SoC dtsi file it seems to be all per SoC.

Rob
