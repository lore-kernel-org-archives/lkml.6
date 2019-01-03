Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F57EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69B721479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546556076;
	bh=1gUjY9BZjRTRbmp7iSzVzBJKVBQ2LYhd6TRyCJz9QsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q/SBg/Peihpt66YBnA4c2ZyX+1ZggTXB20ytHNyM3u+kOFOmy127RhC7abDMAIAqf
	 oBdrRN5JboW5fqbIi4mmyhn71Tjf/icvZFlZQdYugk8yGms2F0/e6ibx/Emg6IfSep
	 coa1AcOdcYMOgAIgOaB/zha8e8FDDelYTmfbVJmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfACWyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfACWye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:54:34 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8BF21479;
        Thu,  3 Jan 2019 22:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546556073;
        bh=1gUjY9BZjRTRbmp7iSzVzBJKVBQ2LYhd6TRyCJz9QsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MN8zygtMTxrwiOr+MO4URY22EuAYdLMFD04ps4mJ8KA6LyYr3A1wSfghicUJeIR1b
         wkyruPwXjEk6DqHU213zBsXzl2cIiALnK5h1k90BjoKi3Z/o2tHINe0HaP0aDKXqTR
         uSPVhXs2godGMqmBZSU5rBkot8Ay/Suq8ztusD+4=
Received: by mail-qk1-f171.google.com with SMTP id 189so20582042qkj.8;
        Thu, 03 Jan 2019 14:54:33 -0800 (PST)
X-Gm-Message-State: AJcUukeK7ThLTWzeL4q1mKJGnRUWKDbNdkPgJoLv51l3pMw5U42owd4m
        MGjukaap/vmGRT/UO8AFmwKJaPJ3rt0TMpst/g==
X-Google-Smtp-Source: ALg8bN5m6v9H/I4NQUee5O8gyS7jB37kPxSC9DSxW8g42WmQLn7hSJ0PKamZOTpOPWLhJGvESVaiqy+Fwl9TfWgSoN8=
X-Received: by 2002:a37:7682:: with SMTP id r124mr46179392qkc.79.1546556072321;
 Thu, 03 Jan 2019 14:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20181221013409.14324-1-f.fainelli@gmail.com> <20181221013409.14324-2-f.fainelli@gmail.com>
 <20190103174117.GA6613@bogus> <2a54c2cf-5595-ade5-fb29-40e8b6d3133e@gmail.com>
 <20190103191915.GB6613@bogus> <bcfe4df0-8928-90e2-6460-1391320af9be@gmail.com>
In-Reply-To: <bcfe4df0-8928-90e2-6460-1391320af9be@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Jan 2019 16:54:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
Message-ID: <CAL_JsqKpFYnnAY-feAeJ-Va5yS7JH34FOzvBmTi4gMV=kjbCVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 1:31 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/3/19 11:19 AM, Rob Herring wrote:
> > On Thu, Jan 03, 2019 at 10:53:25AM -0800, Florian Fainelli wrote:
> >> On 1/3/19 9:41 AM, Rob Herring wrote:
> >>> On Thu, Dec 20, 2018 at 05:34:08PM -0800, Florian Fainelli wrote:
> >>>> Add a binding document for the Broadcom STB reset controller, also known
> >>>> as SW_INIT-style reset controller.
> >>>>
> >>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>> ---
> >>>>  .../devicetree/bindings/reset/brcm,reset.txt  | 27 +++++++++++++++++++
> >>>>  1 file changed, 27 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/reset/brcm,reset.txt b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>> new file mode 100644
> >>>> index 000000000000..6e5341b4f891
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/reset/brcm,reset.txt
> >>>> @@ -0,0 +1,27 @@
> >>>> +Broadcom STB SW_INIT-style reset controller
> >>>> +===========================================
> >>>> +
> >>>> +Broadcom STB SoCs have a SW_INIT-style reset controller with separate
> >>>> +SET/CLEAR/STATUS registers and possibly multiple banks, each of 32 bit
> >>>> +reset lines.
> >>>> +
> >>>> +Please also refer to reset.txt in this directory for common reset
> >>>> +controller binding usage.
> >>>> +
> >>>> +Required properties:
> >>>> +- compatible: should be brcm,brcmstb-reset
> >>>> +- reg: register base and length
> >>>> +- #reset-cells: must be set to 1
> >>>> +
> >>>> +Example:
> >>>> +
> >>>> +  reset: reset-controller@8404318 {
> >>>> +          compatible = "brcm,brcmstb-reset";
> >>>> +          reg = <0x8404318 0x30>;
> >>>
> >>> Based on this address, should this be a sub-node of something else? Or
> >>> not even a sub-node and just make the parent be a reset provider?
> >>
> >> The reset controller is part of a larger "sundry" node which has a
> >> collection of functionality, from pinmux/pinctrl, reset controller,
> >> spare bits, chicken bits, anything the designers forgot to put somewhere
> >> else and decided to put there.
> >>
> >> If there is one thing consistent though is that given a set of 32-bit
> >> register groups, they have a self contained functionality such that you
> >> can break up the larger "sundry" space into smaller sub-blocks which
> >> have one an only one functionality. Do you think this warrants a
> >> different representation in Device Tree?
> >
> > With pinctrl in the mix, you're going to need sub-nodes anyways. So just
> > define what this is a sub-node of.
>
> pinctrl is not necessarily something I want the kernel to control, since
> we have a high level scripting language without our bootloader that
> makes sure pinctrl is properly configured from early boot on all the way
> to the kernel, and preserved across suspend/resume states.
> pinctrl-single does work, and was occasionally used. Everything else is
> typically muxes that the kernel does not need to touch/see/be aware of.

That's good. I'd rather see more platforms do that rather than have
the kernel handle it. OTOH, bootloaders often use DT too, so maybe who
handles pin muxing is irrelevant.

> > Also, I'd prefer to have complete example for the "sundry" node and
> > child nodes than partial examples spread across the tree.
>
> I am afraid I can't provide that example because the sundry node is
> really changing from chip to chip, and there is a gazillion of things in
> there that the kernel typically does not even touch, like
> pinmuxing/pinctrl, various mux selections etc. I could provide the
> following example if that is what you are requesting?:
>
>
> sun-top-ctrl: simple-bus@8404000 {
>         compatible = "brcm,brcmstb-sun-top-ctrl", "simple-bus";
>         reg = <0x8404000 0x708>;
>
>         reset: reset-controller@318 {
>                 compatible = "brcm,brcmstb-reset";
>                 reg = <0x318 0x30>;
>                 #reset-cells = <1>;
>         };
> };
>
> Would that be what you expect to see?

The problem is with this alone, you should just move #reset-cells to
the parent and remove the child node. That's all you really need from
a DT perspective. But if this is really a separate block that's reused
from chip to chip, then a separate node is fine. Typically in these
situations, I just can't tell whether it's that or just the
convenience of creating nodes for every kernel driver.

Rob
