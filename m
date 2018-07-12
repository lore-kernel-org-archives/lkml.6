Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A62CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CABF2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="AIcqAb8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pUEW8aFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CABF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbeGLBIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:08:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42203 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733236AbeGLBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:08:07 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2018 21:08:06 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3873421A1E;
        Wed, 11 Jul 2018 20:53:51 -0400 (EDT)
Received: from web4 ([10.202.2.214])
  by compute4.internal (MEProxy); Wed, 11 Jul 2018 20:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=uLn9GHxnZtd1o4rJizfytLDFt1Uim
        dVN+4xholBSImo=; b=AIcqAb8TyM6hr9jjgmepB7jC+DGCd/FLQ6IXfnS9fJnO/
        j7OZjCeHMeVRcFz/6aLxgPaOBy18xjRIkijBG3u9dHYFhE7WhKyN8M61hZrGIOaT
        TgOUTGFjcHQBGgRC6HvkSDG+WmpTjOtFI9wrqIvYaMOEFH+6eOvbSX8a30iPpVOc
        a93LcFXTVh8shVARxWnBaq+OhBlJpDEbcPw6DHDgZhbWIqvuT28iWWEFga3MNxVl
        XbWJ52wEIupkELatAkiAOBRf/8qUP1uigg27BVS5766ovC7+Ot4Md6DDyAgwppAL
        xBrHnVmdR7n+Id5EzwZCE8vU5ebOwXdKWINJj0L2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=uLn9GH
        xnZtd1o4rJizfytLDFt1UimdVN+4xholBSImo=; b=pUEW8aFC5ULFaN4MxgbB42
        ziDbTPskfezXY2pG719u2cpKEEq8apWJ336pMhmtDLC8B9fzbzaRYeGwykMyitMr
        OwcO1LVCOGnG6jKvtIpR7bvHavWCDDgNtr3mzdPQMxkPsrrjA+/mTNh09oCHEs6A
        L4Zd0Purh0uZabVfDs6hRMOfrjNqxIbvGwfzWbK/8TJZfE5z87S1eQS25c5dgVNa
        HvuSoPuT4lMLvhl4/XquY+/pjz8LZc/FIBkee3D9yaLWQU/Hk0GiNB8TPcZVl5KT
        S3rKv+D/TcFVRuR7a6RpoaoQtnqs2OK0Cv+9OKI6bBi50vKLZTYm6w/SAhqVCFtQ
        ==
X-ME-Proxy: <xmx:nqZGW92m-EpXjkABQDJXhXvzYBSEvfhTK4Qg-zwL2Pklq8o5vrF28g>
    <xmx:nqZGW5EACYGcSTKyXfObgqfUjBFrgax62ceVSNiV0OdvYRtefq9aAw>
    <xmx:nqZGWzR8ygn3qCI4i_TSaZk056frhix3rmq3ttJLBXxwWCaq6NMYww>
    <xmx:nqZGW39ONijfRW12S9TZqJBVhkxI-r-5feoB6kYZfd_1Wa2n1JhFzg>
    <xmx:nqZGW1EkwSzOkKzG88W2Wwh7B9vC2LdSnotfT4t9LZMkDv7vh4Sc5g>
    <xmx:n6ZGW8HgalA9l-CJoRnw2f2mcx0h8kVMlWW1nhyfhj-tiT4bzYolcg>
X-ME-Sender: <xms:nqZGW6j4e-GhbncSfhUEE21awLbsFs8FtL2FIfo-2-h-7ASTeW6u4Q>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 2B934BA4CF; Wed, 11 Jul 2018 20:53:50 -0400 (EDT)
Message-Id: <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        gregkh@linuxfoundation.org, Eugene.Cho@dell.com,
        a.amelkin@yadro.com, stewart@linux.ibm.com,
        benh@kernel.crashing.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-957169fa
In-Reply-To: <20180711200450.GB17291@rob-hp-laptop>
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Date:   Thu, 12 Jul 2018 10:23:50 +0930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the response.

On Thu, 12 Jul 2018, at 05:34, Rob Herring wrote:
> On Wed, Jul 11, 2018 at 03:01:19PM +0930, Andrew Jeffery wrote:
> > Baseboard Management Controllers (BMCs) are embedded SoCs that exist to
> > provide remote management of (primarily) server platforms. BMCs are
> > often tightly coupled to the platform in terms of behaviour and provide
> > many hardware features integral to booting and running the host system.
> > 
> > Some of these hardware features are simple, for example scratch
> > registers provided by the BMC that are exposed to both the host and the
> > BMC. In other cases there's a single bit switch to enable or disable
> > some of the provided functionality.
> > 
> > The documentation defines bindings for fields in registers that do not
> > integrate well into other driver models yet must be described to allow
> > the BMC kernel to assume control of these features.
> 
> So we'll get a new binding when that happens? That will break 
> compatibility.

Can you please expand on this? I'm not following.

> 
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > 
> > Since RFC v1:
> > 
> > * Add a commit message
> > * Minor changes to documented labels
> > 
> >  .../bindings/misc/bmc-misc-ctrl.txt           | 252 ++++++++++++++++++
> >  MAINTAINERS                                   |   6 +
> >  2 files changed, 258 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > new file mode 100644
> > index 000000000000..2c869fcc7ef2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
> > @@ -0,0 +1,252 @@
> > +BMC Miscellaneous Control Interfaces
> > +====================================
> > +
> > +Baseboard Management Controllers (BMCs) often have an array of hardware
> > +features that need to be described but are awkward to sensibly expose.
> > +
> > +This bindings document provides a generic mechanism for describing such
> > +features, covering read-only (RO), read-modify-write (RMW) and
> > +write-1-set/write-1-clear (W1SC) semantics.
> 
> If we wanted a generic mechanism for single register bits/fields in DT, 
> we'd have one already.

I feel like this is an argument of tradition. Maybe people have been dissuaded from doing so when they don't have a reasonable use-case? I'm not saying that what I'm proposing is unquestionably reasonable, but I don't want to dismiss it out of hand.

> A node per register bit doesn't scale.

It isn't meant to scale in terms of a single system. Using it extensively is very likely wrong. Separately, register-bit-led does pretty much the same thing. Doesn't the scale argument apply there? Who is to stop me from attaching an insane number of LEDs to a system?

Obviously if there are lots of systems using it sparingly and legitimately then maybe there's a scale issue, but isn't that just a reality of different hardware designs? Whoever is implementing support for the system is going to have to describe the hardware one way or another.

> 
> Maybe this should be modelled using GPIO binding? There's a line there 
> too as whether the signals are "general purpose" or not.

I don't think so, mainly because some of the things it is intended to be used for are not GPIOs. For instance, take the DAC mux I've described in the patch. It doesn't directly influence anything external to the SoC (i.e. it's certainly not a traditional GPIO in any sense). However, it does *indirectly* influence the SoC's behaviour by muxing the DAC internally between:

0. VGA device exposed on the host PCIe bus
1. The "Graphics CRT" controller 
2. VGA port A
3. VGA port B

Maybe this could be modelled by pinmux, but then we still need some way to expose the mux functions to userspace for selection (userspace needs to transition arbitrarily between at least options 0 and 1 at runtime), at which point we haven't achieved much beyond adding a whole heap of infrastructure in the chain.

Given 0 and 1, maybe exposing attributes in relevant drivers would be reasonable, except 0 isn't exposed on the SoC's internal bus so there is no driver on the BMC-side to do so. Taking into account 2 and 3 are also purely hardware paths further dashes the idea, as the configuration doesn't really "belong" to the Graphics CRT device more than it belongs anywhere else, except for the fact that there isn't anywhere else to expose it.

Further, the BMC's kernel can't make the decision as to when to switch the mux as it knows nothing of the host's state. The BMC userspace is controlling the host's boot state and so *does* know when to flip the switch. Finally, the mux is in separate IP to the CRT or VGA blocks: It lives in the System Control Unit.

My current point of view is the DAC mux field is effectively its own device, and we need to control it from userspace, so we need some way to describe it (i.e. not ignore it) in order for its capability to be exposed.

I'm fully aware what I'm proposing isn't awesome as it's not providing any real abstraction, but the problem(s) at hand also seem to defy abstraction, and in order to avoid a plethora of bespoke bindings I thought it was reasonable to define something generic.

All-in-all I appreciate the suggestion, but assuming you agree with my reasoning above do you have thoughts on other alternatives?

Cheers,

Andrew
