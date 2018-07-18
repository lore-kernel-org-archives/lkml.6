Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B503AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525782084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="biAB1exQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525782084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeGRTrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeGRTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:47:05 -0400
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 529D52084E;
        Wed, 18 Jul 2018 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531940869;
        bh=y1tMQlwlBl2NKACtOQcj/0QE6EkhO4X8N4GANq0OXys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=biAB1exQsgvuf9JHnO7GBLEW4sO+a2eDWAqbZ2A0sChfAC/CFRobWkxY7Hy8fXkgf
         WBbto35e3snf8wNBZkIjvoWEBY/bOKwC7aiyD2a4jgCRnRjcoN6mT8vHp8b6jL0BHp
         Zn1Dgqq9cexP8SIWuUmBDFeM6hKZf7xTVzYdm8Hs=
Received: by mail-io0-f170.google.com with SMTP id v26-v6so5000438iog.5;
        Wed, 18 Jul 2018 12:07:49 -0700 (PDT)
X-Gm-Message-State: AOUpUlHTrSJgHI3nJr4eURR9GWdFVn8mrKPCOeuABH7zYN/czoPp4idd
        Phtvfk0+nGYp1kEfZfcYReFP2zibmWtNWM89Mw==
X-Google-Smtp-Source: AA+uWPzEzZfHxX7vW+mkLp1vFNAcsWfuwihlKVeH8QhI1uMmSVeZYRegC/h7FgAvmbAZRawxGvUUHCNi3vfhzir2NVk=
X-Received: by 2002:a5e:c90e:: with SMTP id z14-v6mr6305101iol.268.1531940868777;
 Wed, 18 Jul 2018 12:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org> <1531870098.3337969.1444201888.2476205D@webmail.messagingengine.com>
In-Reply-To: <1531870098.3337969.1444201888.2476205D@webmail.messagingengine.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jul 2018 13:07:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+YdcBe+VYBAZPvK-X9gwJyhzP4m6hAx59+2Nz0JzsKug@mail.gmail.com>
Message-ID: <CAL_Jsq+YdcBe+VYBAZPvK-X9gwJyhzP4m6hAx59+2Nz0JzsKug@mail.gmail.com>
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

On Tue, Jul 17, 2018 at 5:28 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> On Tue, 17 Jul 2018, at 14:26, Benjamin Herrenschmidt wrote:
> > On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> > > If that data is one set per SoC, then i'm not that concerned having
> > > platform-specific data in the driver. That doesn't mean the driver is
> > > not "generic". It's still not clear to me in this thread, how much of
> > > this is board specific, but given that you've placed all the data in
> > > an SoC dtsi file it seems to be all per SoC.
> >
> > So Rob, I think that's precisely where the disconnect is.
> >
> > I think we all (well hopefully) agree that those few tunables don't fit
> > in any existing subystem and aren't likely to ever do (famous last
> > words...).
> >
> > Where we disagree is we want to make this parametrized via the DT, and
> > you want us to hard wire the list in some kind of SoC driver for a
> > given SoC family/version.
> >
> > The reason I think hard wiring the list in the driver is not a great
> > solution is that that list in itself is prone to variations, possibly
> > fairly often, between boards, vendors, versions of boards, etc...
> >
> > We can't know for sure every SoC tunable (out of the gazillions in
> > those chips) are going to be needed for a given system. We know which
> > ones we do use for ours, and that's a couple of handfuls, but it could
> > be that Dell need a slightly different set, and so might Yadro, or so
> > might our next board revision for that matter.
> >
> > Now, updating the device-tree in the board flash with whatever vendor
> > specific information is needed is a LOT easier than getting the kernel
> > driver constantly updated. The device-tree after all is there to
> > reflect among other things system specific ways in which the SoC is
> > wired and configured. This is rather close...
>
> Not sure this helps, but I feel that the proposal pretty closely matches =
what's described in Documentation/devicetree/bindings/mfd/mfd.txt. It's int=
ended that nodes using the bindings I'm proposing are children of a 'compat=
ible =3D "syscon", "simple-mfd"' node (this is the case with the features w=
e're hoping to describe for our SoC). I should explicitly call that out.

IMO, any binding that has only those compatibles is not correct and a
specific compatible is needed. We should be able identify a specific
h/w block.

> But to go on, "simple-mfd" is effectively an alias of "simple-bus", which=
 means its intended to match child node compatibles to drivers provided by =
the kernel. If we shouldn't be describing minor features of a SoC in the de=
vicetree, doesn't this invalidate the case for simple-mfd? What is the *cor=
rect* use of simple-mfd? When is it not used to expose minor features in se=
t of "miscellaneous system registers"? Why doesn't this proposed case fit?

I'm no fan of simple-mfd either. I think it is abused and often a sign
of bad binding design. The general problem with MFD bindings is people
define child nodes based on what drivers they happen to have for some
OS. DT is not the only way to instantiate drivers. Child nodes are
really only needed when you have resources per child that need to be
defined. For example, if the MFD has an interrupt controller and
interrupts to sub-blocks or sub-blocks have their own clocks.
"simple-mfd" was for when the parent node has no driver or the child
nodes have no dependency on the parent.

Rob
