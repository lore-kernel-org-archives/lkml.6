Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A020ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91A920BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="PnuP8Zap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWjUj07l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91A920BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbeGQBec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:34:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56387 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730302AbeGQBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:34:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BD35121D22;
        Mon, 16 Jul 2018 21:04:31 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Mon, 16 Jul 2018 21:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=PTbRfd6sR87qUDKTTg4pC6QkxogtB
        T3HcauQ1KDMBqs=; b=PnuP8ZapHZUMtE1EuZnfVJK8svGpRBoQnEnH0y6+TG+fD
        gE0gU/X3x9AvJM4MrKqtvoeZiRFuzGs70anTek/VxmKOdFIqpbuVRaXZofVBCxD7
        aeMXPwEXfEzSYnpqyVJqTC3YLt8Zyur8REcGW52097HS+zdXlZIUZJgIkPub6TXA
        NSJTYT2DGAzr80uJC9uYtEA31kTor3ecyOh7QbudvcKsQp4XTfW/kcAxVUExJReR
        e0qF5f+rpUoJDgg74VEvGjHIIVSmFCd1+735r3w7igvToeFDm9uHG9lSOYJM6daV
        lTYHKjBlizut535zX2ypFDtP6mJF1o9JPYXRQ3eHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PTbRfd
        6sR87qUDKTTg4pC6QkxogtBT3HcauQ1KDMBqs=; b=MWjUj07lF2eX+XFcs/ddZe
        z4kXGHjJZdabwfCnd9HqXdXuodweshNH7Wh6VAJgexHHtf2txn5u2wrayspWtCmH
        YhQL2eJ/1/CslPKnTXaijkaWL2911nCNdPwZnDJlDPsR8RJ0bmqTvQfDxg4fdk4e
        ximB1RDc2G5904hXjC6EjLTBclVFDKvG+ckCBved1dbrLjeNbiBsyPVXPXYldAdf
        icpQSK5AmeJccYVe0GhCUZDkPCXTTshcLqaUPidcb0xEp4prTominXCo9ObidibY
        R1rTt1vdvHXc6jiBDuwQQhA/EB4Mz1yjWDVdrFo5hcjr4b3ioMbcpN9Bjy1mSwYw
        ==
X-ME-Proxy: <xmx:nkBNW11y_sbiDSc65uBcr0aUhz8TKkZvuT2Cz6FY44CxQK9_HetO8Q>
    <xmx:nkBNW9o72TEpZBPKK_TC2tr6Y3Nel684wI3WwZ8f7s9sySpLfQD99A>
    <xmx:nkBNW8M-CBY3RAdXnq_NwSu2i_st6PzHZuc7VCW0m_8avWapoqr3HA>
    <xmx:nkBNW-ojUDNXfrC3B8XMlA3FKdt6VLCpZsgOSyVQTzET5BDVbb7dQg>
    <xmx:nkBNW_uHkBH71JSCVSqeoq8tirex64sl5-nsjVlixKY-4bgEgUsbTQ>
    <xmx:n0BNWyu4AC9XWaY55pOoJcYjpeq-DLSjTEYN-RVepGp71G6lJvkO6g>
X-ME-Sender: <xms:nkBNW5dzbBt9i5-N01tf1N2OhPy03x4_G5Eo8OEL3GFpGEm2otu3QA>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id C24749E10A; Mon, 16 Jul 2018 21:04:30 -0400 (EDT)
Message-Id: <1531789470.3129371.1442980448.3B48B4EC@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-957169fa
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
In-Reply-To: <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
Date:   Tue, 17 Jul 2018 10:34:30 +0930
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, at 23:25, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 12:31 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Hi Rob, Ben,
> >
> > I've replied to you both inline below, hopefully it's clear enough from the context.
> >
> > On Fri, 13 Jul 2018, at 10:25, Benjamin Herrenschmidt wrote:
> > > On Thu, 2018-07-12 at 09:11 -0600, Rob Herring wrote:
> > > > On Wed, Jul 11, 2018 at 6:54 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Thanks for the response.
> > > > >
> > > > > On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> > > > > > On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > > > > > > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > > > > > > provide remote management of (primarily) server platforms. BMCs are
> > > > > > > often tightly coupled to the platform in terms of behaviour and provide
> > > > > > > many hardware features integral to booting and running the host system.
> > > > > > >
> > > > > > > Some of these hardware features are simple, for example scratch
> > > > > > > registers provided by the BMC that are exposed to both the host and the
> > > > > > > BMC. In other cases there's a single bit switch to enable or disable
> > > > > > > some of the provided functionality.
> > > > > > >
> > > > > > > The documentation defines bindings for fields in registers that do not
> > > > > > > integrate well into other driver models yet must be described to allow
> > > > > > > the BMC kernel to assume control of these features.
> > > > > >
> > > > > > So we'll get a new binding when that happens? That will break
> > > > > > compatibility.
> > > > >
> > > > > Can you please expand on this? I'm not following.
> > > >
> > > > If we have a subsystem in the future, then there would likely be an
> > > > associated binding which would be different. So if you update the DT,
> > > > then old kernels won't work with it.
> > >
> > > What kind of "subsystem" ? There is almost no way there could be one
> > > for that sort of BMC tunables. We've look at several BMC chips out
> > > there and requirements from several vendors, BIOS and system
> > > manufacturers and it's all over the place.
> >
> > Right - This is the fundamental principle backing these patches: There will never be a coherent subsystem catering to any of what we want to describe with these bindings.
> 
> I never said they would. Saying "do not integrate well into other
> driver models YET" implies at some point they will. No point in
> beating this any further, just remove "yet"...

Right, there should have been a comma before 'yet'. Sorry for the confusion.

*snip*

> > > > >
> > > > > Maybe this could be modelled by pinmux, but then we still need some
> > > > > way to expose the mux functions to userspace for selection
> > > > > (userspace needs to transition arbitrarily between at least options
> > > > > 0 and 1 at runtime), at which point we haven't achieved much beyond
> > > > > adding a whole heap of infrastructure in the chain.
> > > > >
> > > > > Given 0 and 1, maybe exposing attributes in relevant drivers would
> > > > > be reasonable, except 0 isn't exposed on the SoC's internal bus so
> > > > > there is no driver on the BMC-side to do so. Taking into account 2
> > > > > and 3 are also purely hardware paths further dashes the idea, as
> > > > > the configuration doesn't really "belong" to the Graphics CRT
> > > > > device more than it belongs anywhere else, except for the fact that
> > > > > there isn't anywhere else to expose it.
> > > > >
> > > > > Further, the BMC's kernel can't make the decision as to when to
> > > > > switch the mux as it knows nothing of the host's state. The BMC
> > > > > userspace is controlling the host's boot state and so *does* know
> > > > > when to flip the switch. Finally, the mux is in separate IP to the
> > > > > CRT or VGA blocks: It lives in the System Control Unit.
> > > > >
> > > > > My current point of view is the DAC mux field is effectively its
> > > > > own device, and we need to control it from userspace, so we need
> > > > > some way to describe it (i.e. not ignore it) in order for its
> > > > > capability to be exposed.
> > > > >
> > > > > I'm fully aware what I'm proposing isn't awesome as it's not
> > > > > providing any real abstraction, but the problem(s) at hand also
> > > > > seem to defy abstraction, and in order to avoid a plethora of
> > > > > bespoke bindings I thought it was reasonable to define something
> > > > > generic.
> > > > >
> > > > > All-in-all I appreciate the suggestion, but assuming you agree with
> > > > > my reasoning above do you have thoughts on other alternatives?
> > > >
> > > > Seems the controls are more fixed than I first thought. All the data
> > > > you have here could simply be within a driver.
> >
> > Rob: A driver for what though? One unique to this particular mux? That feels overly specific when we can generalise the concept to cover a wider range of use-cases.
> 
> Not unique. Just instead of populating the structs you have in the
> driver from DT, define them in the driver and attach them to
> match->data ptr.

Okay, I'll prototype it.

> 
> > > > Help me understand what
> > > > functions are fixed (in the SoC) and which ones vary by board. Only
> > > > what's changing per board really needs to go into DT.
> >
> > I think this last sentence identifies a difference in our starting points, so I'd like to explore that. Blocks of functionality might move around inside the SoC as well, so don't we need a way to describe those functions appropriately?
> 
> Yes, if the blocks have well defined boundaries and functions. Blocks
> like a UART for example do. Various pieces dumped into system
> controllers generally don't IME.
> 
> > And from there describe how the SoC integrates the functions, and then describe how a board integrates the SoC? This all composes, and the problem at the end of the day comes down to what we want to view as a point of abstraction, right?
> 
> Yes. It's a judgement call as to how much we try to describe in DT. To
> use clocks again, a clock divider, mux, or gate all seem like well
> defined functions which could be (and were) described in DT, but we
> learned that doesn't really work. We're still converting platforms
> that did it that way...
> 
> > It seems ideal to me that the metadata about hardware features resides in the description of the relevant system (DT, for a function, a SoC or a board), otherwise don't we wind up with crazy, unfocused, monolithic drivers for things like system controllers? (There's MFD/syscon, but having used it previously I'm still grappling with the benefit over some of the weirdness it injects into devicetree - maybe I did it wrong.) Or alternatively, a generic driver that's choc full of platform-specific data covering the platforms that require it?
> 
> If that data is one set per SoC, then i'm not that concerned having
> platform-specific data in the driver. That doesn't mean the driver is
> not "generic". It's still not clear to me in this thread, how much of
> this is board specific, but given that you've placed all the data in
> an SoC dtsi file it seems to be all per SoC.

Right, the features we want to expose are part of the SoC, not the board it sits on. The distinction was that different boards (or even different software payloads on the same board) could use them in vastly different ways, though that mainly affects how they're treated inside the kernel and at the kernel/userspace interface rather than at the devicetree level.

Cheers,

Andrew
