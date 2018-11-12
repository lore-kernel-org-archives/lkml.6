Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD83E223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD83E223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbeKMAPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:15:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46753 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeKMAPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:15:25 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gMD65-00084b-74; Mon, 12 Nov 2018 15:21:49 +0100
Message-ID: <1542032506.3440.5.camel@pengutronix.de>
Subject: Re: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 12 Nov 2018 15:21:46 +0100
In-Reply-To: <20181112210215.2DB6.4A936039@socionext.com>
References: <1541775663.4112.48.camel@pengutronix.de>
         <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
         <20181112210215.2DB6.4A936039@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2018-11-12 at 21:02 +0900, Kunihiko Hayashi wrote:
> Hi,
> 
> Thank you for some comments and pointing out.
> 
> On Sat, 10 Nov 2018 01:14:06 +0900 <yamada.masahiro@socionext.com> wrote:
> 
> > On Sat, Nov 10, 2018 at 12:02 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > > 
> > > Hi Kunihiko,
> > > 
> > > On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> > > > Add compatible strings for reset control of AHCI core implemented in
> > > > UniPhier SoCs. The reset control belongs to AHCI glue layer.
> > > > 
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > > index f63c511..ea00517 100644
> > > > --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > > +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > > @@ -133,6 +133,9 @@ Required properties:
> > > >      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
> > > >      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
> > > >      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> > > > +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> > > > +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> > > > +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
> > > 
> > > Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
> > > reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
> > > add a common compatible?
> > 
> > As far as I could guess, he just happened to find the same driver code
> > could be reused for other hardware.

Ok, in that case never mind. I just assumed that this could be a case of
glue layer building blocks being reused by the hardware engineers, since
the driver reuses the same clock names for USB3 and AHCI both on Pro4
and on PXs2.

> > Theoretically, this can happen anywhere since
> > a reset controller is just a set of registers
> > each bit of which is connected to a reset line.
> > 
> > If you added a super-generic compatible like "simple-reset",
> > I would agree with
> > "socionext,uniphier-pro4-usb3-reset", "simple-reset"
> > since this is a pattern.
> 
> I think it's more generic to define simple-reset with parent clock/reset
> control without both SoC and device names.
> 
> However, such parent clocks/resets strongly depends on SoC, 
> so I think it's difficut to lead generic definition in this case.
> 
> If we add generic compatible string, I also add "simple-reset".

There is no "simple-reset" binding definition. As soon as there are SoC
specific clocks, it's not really generic anymore.

> > However,
> > "socionext,uniphier-pro4-glue-reset" is kind of a halfway house
> > where it is SoC-specific, but still ambiguous.
> 
> Surely, it might be hard to understand that pro4-glue-reset is SoC-specific
> but for generic-device.

I agree.

> > > Something like:
> > > "socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
> > > "socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI
> > > 
> > > That way if more places turn up where the glue layer reset is used,
> > > you can add them without patching the driver every time.
> > 
> > 
> > This is a trade-off between "patch the driver"
> > and "potential change of the binding".
> 
> Adding "glue-reset" is usable for devices having same parent clocks/resets as
> usb3/ahci, and we can add the devices without patches.
> 
> However, if the device needs other parent clocks/resets for the same SoC,
> we can't add "glue-reset" and we might add patches for the device as a result.
> In this case, the "glue-reset" will become difficult to understand.

Then let's not bother with it.
I made the suggestion without knowing the full picture.

> > There is no real hardware like pro4-glue-reset.
> > 
> > I am guessing this is a part of syscon or something,
> > but I cannot find any explanation in a bigger picture.
> > 
> > So, I cannot judge this further more.
> 
> Since it's hard to lead the best result,
> currently I'd like to suggest the current compatibles,

That is fine with me.

> with "simple-reset" if necessary.

Not necessary.

best regards
Philipp
