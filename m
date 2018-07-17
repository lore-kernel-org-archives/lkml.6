Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172EECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Z0gJXNsP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1W2WKpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C286020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeGRADR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:03:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38003 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbeGRADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:03:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 86E5521A21;
        Tue, 17 Jul 2018 19:28:19 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Tue, 17 Jul 2018 19:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=fS8pziHKcKRm6V9XorgCUhq/d2mKA
        AiSs9IRoVrRo5o=; b=Z0gJXNsPspp4Ooi1BjOykWgZVPTZb5LXUIPYQ9QZh2Az6
        HBPAS5tIyxT0JJdMz0r6gVkLQH8PE/EOfyo2reTZsHhOKCqD8IWpo5jJCERqrWPE
        d05BJo2S4a+0r3dB5XscDR6NbwSdrShhtTup2u5KhE53GTpNNUWdWn4x0ByXVGNn
        Y+iCoy2AAC1Qx4WzoBZUxYbGZdlJWIkmJPclCAvPAPk/4cmYdnAZm3MtBSuuC3+e
        dLs9mSSDQuQdhwEu48nb5zL8Jz37dplcV0mtHhkGsYM6gOeRIxZ9mk9b2cn0kO1G
        IhezIFBhGjSD8R9/KnfFRA96BijBTP9LSm0dVf89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fS8pzi
        HKcKRm6V9XorgCUhq/d2mKAAiSs9IRoVrRo5o=; b=F1W2WKptIhpMX7OHMPKuyg
        6G67YFpLiUP16QG08r1vxZfni3GW8QFEc1/vwYjLdAMcqC2klqZnaM+azca3CyG5
        gTM0/loRfwQxMR5HMkN5H6+52+OuSsbeflpY5I0OoRkiJo+OrKySzNAujGfZj//C
        qofe9uSxSsbZS0DNJkexADUVJnxOuZAYj3ffzdbItAGBSgOLcxBo0faHjrbahrW/
        btV9u/FymB0Yo6hfTj8HpvR1PUv5TBGPTLzsTnmkXzxvfQSJotMHl+0l7pYgy+VN
        rDrjkfZdgC4wcHX1ijYNcyU4VZYGFROLh3tjD+6Zuk/R0C4o/XQTw3hsEGaW+57Q
        ==
X-ME-Proxy: <xmx:kntOWweAu55eQJb-m438r0QDVg8nx3au7I-UU-1aSM5dGJ0bXiKkZQ>
    <xmx:kntOWybDmFcfKaKkOFyowmtmMmdw3AQympzKX5YZfudtL_Qjmx2ghQ>
    <xmx:kntOWzWEQY4568jICGbBCc0Vz36naWExSFZgxi0-NqCEe5E1HjTWhQ>
    <xmx:kntOW0hmTy8cNSW4IK_oOQvg5tI8tJaTatVdIHnWs1NaNC-ZNrzZTQ>
    <xmx:kntOWxUoq9JOtgkd0WtmCJ9bHL68hMxhLrPZbkP_hCL3XSX3eNGQ0Q>
    <xmx:k3tOW_QeVkaPTJnXNoQjLadXfdmO565FxJ6S0r0XUgLlPjqjPUUwuQ>
X-ME-Sender: <xms:kntOWwJM3SgvOv5LlalFQ5T7x6u2S9p8ZYDpM18C1B-dpWHR9rntVg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 6FEF79E111; Tue, 17 Jul 2018 19:28:18 -0400 (EDT)
Message-Id: <1531870098.3337969.1444201888.2476205D@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
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
In-Reply-To: <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
Date:   Wed, 18 Jul 2018 08:58:18 +0930
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, at 14:26, Benjamin Herrenschmidt wrote:
> On Mon, 2018-07-16 at 07:55 -0600, Rob Herring wrote:
> > If that data is one set per SoC, then i'm not that concerned having
> > platform-specific data in the driver. That doesn't mean the driver is
> > not "generic". It's still not clear to me in this thread, how much of
> > this is board specific, but given that you've placed all the data in
> > an SoC dtsi file it seems to be all per SoC.
> 
> So Rob, I think that's precisely where the disconnect is.
> 
> I think we all (well hopefully) agree that those few tunables don't fit
> in any existing subystem and aren't likely to ever do (famous last
> words...).
> 
> Where we disagree is we want to make this parametrized via the DT, and
> you want us to hard wire the list in some kind of SoC driver for a
> given SoC family/version.
> 
> The reason I think hard wiring the list in the driver is not a great
> solution is that that list in itself is prone to variations, possibly
> fairly often, between boards, vendors, versions of boards, etc...
> 
> We can't know for sure every SoC tunable (out of the gazillions in
> those chips) are going to be needed for a given system. We know which
> ones we do use for ours, and that's a couple of handfuls, but it could
> be that Dell need a slightly different set, and so might Yadro, or so
> might our next board revision for that matter.
> 
> Now, updating the device-tree in the board flash with whatever vendor
> specific information is needed is a LOT easier than getting the kernel
> driver constantly updated. The device-tree after all is there to
> reflect among other things system specific ways in which the SoC is
> wired and configured. This is rather close...

Not sure this helps, but I feel that the proposal pretty closely matches what's described in Documentation/devicetree/bindings/mfd/mfd.txt. It's intended that nodes using the bindings I'm proposing are children of a 'compatible = "syscon", "simple-mfd"' node (this is the case with the features we're hoping to describe for our SoC). I should explicitly call that out.

But to go on, "simple-mfd" is effectively an alias of "simple-bus", which means its intended to match child node compatibles to drivers provided by the kernel. If we shouldn't be describing minor features of a SoC in the devicetree, doesn't this invalidate the case for simple-mfd? What is the *correct* use of simple-mfd? When is it not used to expose minor features in set of "miscellaneous system registers"? Why doesn't this proposed case fit?

Cheers,

Andrew
