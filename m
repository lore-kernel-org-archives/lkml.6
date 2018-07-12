Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkkNNSrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C6F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbeGLPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732491AbeGLPVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:21:36 -0400
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B131E2147C;
        Thu, 12 Jul 2018 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531408297;
        bh=JCqI/gbzWvOjvSBohrB6pHc2JZjRhWgsFPMirplG2xM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WkkNNSrf2CFVjs8EUz2gKxFcZ6Jv8ddJY88UvNt7UAW2GNH5sULInV51h6zqQ1/q5
         zYVx56BsNDdoZ4GtW68gihOzaLy9khbvkj0qFrgZ+3BUlSMvfC1LNGNNtVDcOOsYLh
         ebPsB4i+zk9bBgUpyo9Zh+ah2kOaEVpkalHBIAhg=
Received: by mail-it0-f49.google.com with SMTP id a195-v6so7295668itd.3;
        Thu, 12 Jul 2018 08:11:37 -0700 (PDT)
X-Gm-Message-State: AOUpUlH1pJfu0+6bMdlxHiBMlwetv/haLUBK18YPueVvuGZ6h1xPL8Gy
        B9mIn6PoZxlVU7QGR3yt33aZPdgjJraHrJ4YGg==
X-Google-Smtp-Source: AAOMgpfPuLP/sxhEivVFfJdYWhcTJKjTy1SMCuWDUFHl2KpvIa4a9Fj9DNWdEcAx7npttF0TIsWAjYPzj61M4/+ZhVQ=
X-Received: by 2002:a24:9284:: with SMTP id l126-v6mr1701869itd.18.1531408297070;
 Thu, 12 Jul 2018 08:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
In-Reply-To: <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Jul 2018 09:11:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
Message-ID: <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi Rob,
>
> Thanks for the response.
>
> On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > Baseboard Management Controllers (BMCs) are embedded SoCs that exist =
to
> > > provide remote management of (primarily) server platforms. BMCs are
> > > often tightly coupled to the platform in terms of behaviour and provi=
de
> > > many hardware features integral to booting and running the host syste=
m.
> > >
> > > Some of these hardware features are simple, for example scratch
> > > registers provided by the BMC that are exposed to both the host and t=
he
> > > BMC. In other cases there's a single bit switch to enable or disable
> > > some of the provided functionality.
> > >
> > > The documentation defines bindings for fields in registers that do no=
t
> > > integrate well into other driver models yet must be described to allo=
w
> > > the BMC kernel to assume control of these features.
> >
> > So we'll get a new binding when that happens? That will break
> > compatibility.
>
> Can you please expand on this? I'm not following.

If we have a subsystem in the future, then there would likely be an
associated binding which would be different. So if you update the DT,
then old kernels won't work with it.


> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >
> > > Since RFC v1:
> > >
> > > * Add a commit message
> > > * Minor changes to documented labels
> > >
> > >  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   6 +
> > >  2 files changed, 258 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-c=
trl.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt=
 b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > > new file mode 100644
> > > index 000000000000..2c869fcc7ef2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > > @@ -0,0 +1,252 @@
> > > +BMC Miscellaneous Control Interfaces
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Baseboard Management Controllers (BMCs) often have an array of hardw=
are
> > > +features that need to be described but are awkward to sensibly expos=
e.
> > > +
> > > +This bindings document provides a generic mechanism for describing s=
uch
> > > +features, covering read-only (RO), read-modify-write (RMW) and
> > > +write-1-set/write-1-clear (W1SC) semantics.
> >
> > If we wanted a generic mechanism for single register bits/fields in DT,
> > we'd have one already.
>
> I feel like this is an argument of tradition. Maybe people have been diss=
uaded from doing so when they don't have a reasonable use-case? I'm not say=
ing that what I'm proposing is unquestionably reasonable, but I don't want =
to dismiss it out of hand.

One of experience. The one that stands out is clock bindings.
Initially we were doing a node per clock modelling which could end up
being 100s of nodes and is difficult to get right (with DT being an
ABI).

It comes up with system controller type blocks too that just have a
bunch of random registers. Those change in every SoC and not in any
controlled or ordered way that would make describing the individual
sub-functions in DT worthwhile.

>
> > A node per register bit doesn't scale.
>
> It isn't meant to scale in terms of a single system. Using it extensively=
 is very likely wrong. Separately, register-bit-led does pretty much the sa=
me thing. Doesn't the scale argument apply there? Who is to stop me from at=
taching an insane number of LEDs to a system?

Review.

If you look, register-bit-led is rarely used outside of some ARM, Ltd.
boards. It's simply quite rare to have MMIO register bits that have a
fixed function of LED control.

> Obviously if there are lots of systems using it sparingly and legitimatel=
y then maybe there's a scale issue, but isn't that just a reality of differ=
ent hardware designs? Whoever is implementing support for the system is goi=
ng to have to describe the hardware one way or another.
>
> >
> > Maybe this should be modelled using GPIO binding? There's a line there
> > too as whether the signals are "general purpose" or not.
>
> I don't think so, mainly because some of the things it is intended to be =
used for are not GPIOs. For instance, take the DAC mux I've described in th=
e patch. It doesn't directly influence anything external to the SoC (i.e. i=
t's certainly not a traditional GPIO in any sense). However, it does *indir=
ectly* influence the SoC's behaviour by muxing the DAC internally between:
>
> 0. VGA device exposed on the host PCIe bus
> 1. The "Graphics CRT" controller
> 2. VGA port A
> 3. VGA port B

And this mux control is fixed in the SoC design?

>
> Maybe this could be modelled by pinmux, but then we still need some way t=
o expose the mux functions to userspace for selection (userspace needs to t=
ransition arbitrarily between at least options 0 and 1 at runtime), at whic=
h point we haven't achieved much beyond adding a whole heap of infrastructu=
re in the chain.
>
> Given 0 and 1, maybe exposing attributes in relevant drivers would be rea=
sonable, except 0 isn't exposed on the SoC's internal bus so there is no dr=
iver on the BMC-side to do so. Taking into account 2 and 3 are also purely =
hardware paths further dashes the idea, as the configuration doesn't really=
 "belong" to the Graphics CRT device more than it belongs anywhere else, ex=
cept for the fact that there isn't anywhere else to expose it.
>
> Further, the BMC's kernel can't make the decision as to when to switch th=
e mux as it knows nothing of the host's state. The BMC userspace is control=
ling the host's boot state and so *does* know when to flip the switch. Fina=
lly, the mux is in separate IP to the CRT or VGA blocks: It lives in the Sy=
stem Control Unit.
>
> My current point of view is the DAC mux field is effectively its own devi=
ce, and we need to control it from userspace, so we need some way to descri=
be it (i.e. not ignore it) in order for its capability to be exposed.
>
> I'm fully aware what I'm proposing isn't awesome as it's not providing an=
y real abstraction, but the problem(s) at hand also seem to defy abstractio=
n, and in order to avoid a plethora of bespoke bindings I thought it was re=
asonable to define something generic.
>
> All-in-all I appreciate the suggestion, but assuming you agree with my re=
asoning above do you have thoughts on other alternatives?

Seems the controls are more fixed than I first thought. All the data
you have here could simply be within a driver. Help me understand what
functions are fixed (in the SoC) and which ones vary by board. Only
what's changing per board really needs to go into DT.

Rob
