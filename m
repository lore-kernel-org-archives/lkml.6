Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84BECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C2C20857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 01:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Qlln+qLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BR0zGx/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C2C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeGSCh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 22:37:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59049 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731098AbeGSCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 22:37:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E6B5321AE8;
        Wed, 18 Jul 2018 21:57:14 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Wed, 18 Jul 2018 21:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=FADGPYhbP+fHYI9EJbb3chU050AUT
        CPuk5jUmbBl1X8=; b=Qlln+qLY8qUuWJuDzsnu9z29JmhIgNVBFkxcGfkoZnPVF
        E7wshXQxbzj2Xz77zP5Say6gSTNBcw0b0NEcFWXDRcjNMFsMcE1Il6py+cfUAxLG
        +w6TbeeP4Ujno7QIAmzQ58ni4sqhq9mIJshj86Z8fKgHFDF1abug5ytssfUA+cTC
        lMLxkNS6kUvAsRmjO+2l18yDtVzmdl4eSok/Pjdupg55R4JjgH6TR9EO+BzATSrE
        tVEyO6oRUAvY7gDMTsZxDQN91u3aUQjgYPb7mUoJgireR2cMymg70YQ2jgFwZZRp
        JUvpZnezEV9F1BDNy07MbkqQZKCRqexhX+sUnC0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FADGPY
        hbP+fHYI9EJbb3chU050AUTCPuk5jUmbBl1X8=; b=BR0zGx/F6aaN7T/0ojXinG
        V5uZEowE5h0CT6bn4y1QjR7+9ai3XW4zwb2OwQ6hjVb8j++cr3weXPKeMJFS226D
        ESeK1yacIj8wzad+wSxQwlJWZasTDHQmiUvWmEaEZLiW8sm/73WCAYGZmIAT29yV
        nE6m4wg1Z0msMbkMPA4H3aKUDogpxw2wYk/XiTizsw6PaHtgOJ54YWrlqmAJcZou
        WRSQ8VMt1P0r0m1DolGllhpfGgkXFoS3dLgWIHgBkAxbxf3Z7B7ALy+mYQ/T/2Gt
        glWu37lSuJFgldZB9GuvBa7gyQ/rW2L6eUho14II/KKYhUY+51d+skzbB9w4jQVw
        ==
X-ME-Proxy: <xmx:-e9PW-MdmrXqBzd9mwlwvn8CeABHE4i-aiTIEzHyGfyP4_3pkmO5rw>
    <xmx:-e9PWxXlDflznnpLj66bUoPetsAcc8bpTX3k26z6k2wWIqa4Qf2bDQ>
    <xmx:-e9PWzKlxR5FXUJIrr6jLeFxxSrgzM6YJwrEYqsmuwk0TLWrj-e1aQ>
    <xmx:-e9PW8rYNJk6RDlHgXuM-7L9xmOBG4ZiLiPpveGikMFWX-HrygTYsQ>
    <xmx:-e9PW6ybfOcqbPZrnXEWiZW0pPezwfmZZCtC6T2q4BZXk5apyJhS2w>
    <xmx:-u9PW37NH3sQD7BFIIh1SHA34OQzFcYnK0zC58sD31m2ny6MKiUN-w>
X-ME-Sender: <xms:-e9PW18er40v9KvylKUU7D0R3ONqUEzI5uX3HEv3fFfsWabfvw5oMw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 924159E0DC; Wed, 18 Jul 2018 21:57:13 -0400 (EDT)
Message-Id: <1531965433.2133841.1445577960.5C709A63@webmail.messagingengine.com>
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
X-Mailer: MessagingEngine.com Webmail Interface - ajax-e74bb3a0
In-Reply-To: <CAL_Jsq+YdcBe+VYBAZPvK-X9gwJyhzP4m6hAx59+2Nz0JzsKug@mail.gmail.com>
Date:   Thu, 19 Jul 2018 11:27:13 +0930
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <1531870098.3337969.1444201888.2476205D@webmail.messagingengine.com>
 <CAL_Jsq+YdcBe+VYBAZPvK-X9gwJyhzP4m6hAx59+2Nz0JzsKug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, at 04:37, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 5:28 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > On Tue, 17 Jul 2018, at 14:26, Benjamin Herrenschmidt wrote:
> > > On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> > > > If that data is one set per SoC, then i'm not that concerned having
> > > > platform-specific data in the driver. That doesn't mean the driver is
> > > > not "generic". It's still not clear to me in this thread, how much of
> > > > this is board specific, but given that you've placed all the data in
> > > > an SoC dtsi file it seems to be all per SoC.
> > >
> > > So Rob, I think that's precisely where the disconnect is.
> > >
> > > I think we all (well hopefully) agree that those few tunables don't fit
> > > in any existing subystem and aren't likely to ever do (famous last
> > > words...).
> > >
> > > Where we disagree is we want to make this parametrized via the DT, and
> > > you want us to hard wire the list in some kind of SoC driver for a
> > > given SoC family/version.
> > >
> > > The reason I think hard wiring the list in the driver is not a great
> > > solution is that that list in itself is prone to variations, possibly
> > > fairly often, between boards, vendors, versions of boards, etc...
> > >
> > > We can't know for sure every SoC tunable (out of the gazillions in
> > > those chips) are going to be needed for a given system. We know which
> > > ones we do use for ours, and that's a couple of handfuls, but it could
> > > be that Dell need a slightly different set, and so might Yadro, or so
> > > might our next board revision for that matter.
> > >
> > > Now, updating the device-tree in the board flash with whatever vendor
> > > specific information is needed is a LOT easier than getting the kernel
> > > driver constantly updated. The device-tree after all is there to
> > > reflect among other things system specific ways in which the SoC is
> > > wired and configured. This is rather close...
> >
> > Not sure this helps, but I feel that the proposal pretty closely matches what's described in Documentation/devicetree/bindings/mfd/mfd.txt. It's intended that nodes using the bindings I'm proposing are children of a 'compatible = "syscon", "simple-mfd"' node (this is the case with the features we're hoping to describe for our SoC). I should explicitly call that out.
> 
> IMO, any binding that has only those compatibles is not correct and a
> specific compatible is needed. We should be able identify a specific
> h/w block.

I didn't intend for that to get interpreted quite as literally, so apologies for that. We do have h/w-block-specific compatibles in there too. The point was to demonstrate that we're dealing (at this point, only) with mfds/syscons.

> 
> > But to go on, "simple-mfd" is effectively an alias of "simple-bus", which means its intended to match child node compatibles to drivers provided by the kernel. If we shouldn't be describing minor features of a SoC in the devicetree, doesn't this invalidate the case for simple-mfd? What is the *correct* use of simple-mfd? When is it not used to expose minor features in set of "miscellaneous system registers"? Why doesn't this proposed case fit?
> 
> I'm no fan of simple-mfd either. I think it is abused and often a sign
> of bad binding design.

Ah, yes, this is a familiar feeling when reflecting on things I've done in the past. Hence trying to understand how to use it right.

> The general problem with MFD bindings is people
> define child nodes based on what drivers they happen to have for some
> OS. DT is not the only way to instantiate drivers. Child nodes are
> really only needed when you have resources per child that need to be
> defined. For example, if the MFD has an interrupt controller and
> interrupts to sub-blocks or sub-blocks have their own clocks.
> "simple-mfd" was for when the parent node has no driver or the child
> nodes have no dependency on the parent.

Thanks for the clarification, I'll keep that in mind going forward.

Andrew
