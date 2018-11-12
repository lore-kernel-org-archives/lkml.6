Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97030C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A671223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A671223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbeKLVzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:55:17 -0500
Received: from mx.socionext.com ([202.248.49.38]:21942 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbeKLVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:55:17 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 12 Nov 2018 21:02:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 3E80060062;
        Mon, 12 Nov 2018 21:02:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 12 Nov 2018 21:02:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id D7AFD4035E;
        Mon, 12 Nov 2018 21:02:16 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id AC05E120497;
        Mon, 12 Nov 2018 21:02:16 +0900 (JST)
Date:   Mon, 12 Nov 2018 21:02:16 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset description
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
References: <1541775663.4112.48.camel@pengutronix.de> <CAK7LNAQGftPMLkQk-tU4R6Jtw9W6npka+Br+2wyyZicAgwDvRg@mail.gmail.com>
Message-Id: <20181112210215.2DB6.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for some comments and pointing out.

On Sat, 10 Nov 2018 01:14:06 +0900 <yamada.masahiro@socionext.com> wrote:

> On Sat, Nov 10, 2018 at 12:02 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> >
> > Hi Kunihiko,
> >
> > On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> > > Add compatible strings for reset control of AHCI core implemented in
> > > UniPhier SoCs. The reset control belongs to AHCI glue layer.
> > >
> > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > ---
> > >  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > index f63c511..ea00517 100644
> > > --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> > > @@ -133,6 +133,9 @@ Required properties:
> > >      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
> > >      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
> > >      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> > > +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> > > +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> > > +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI
> >
> > Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
> > reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
> > add a common compatible?
> 
> 
> As far as I could guess, he just happened to find the same driver code
> could be reused for other hardware.
> 
> Theoretically, this can happen anywhere since
> a reset controller is just a set of registers
> each bit of which is connected to a reset line.
> 
> If you added a super-generic compatible like "simple-reset",
> I would agree with
> "socionext,uniphier-pro4-usb3-reset", "simple-reset"
> since this is a pattern.

I think it's more generic to define simple-reset with parent clock/reset
control without both SoC and device names.

However, such parent clocks/resets strongly depends on SoC, 
so I think it's difficut to lead generic definition in this case.

If we add generic compatible string, I also add "simple-reset".


> However,
> "socionext,uniphier-pro4-glue-reset" is kind of a halfway house
> where it is SoC-specific, but still ambiguous.

Surely, it might be hard to understand that pro4-glue-reset is SoC-specific
but for generic-device.


> > Something like:
> > "socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
> > "socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI
> >
> > That way if more places turn up where the glue layer reset is used,
> > you can add them without patching the driver every time.
> 
> 
> This is a trade-off between "patch the driver"
> and "potential change of the binding".

Adding "glue-reset" is usable for devices having same parent clocks/resets as
usb3/ahci, and we can add the devices without patches.

However, if the device needs other parent clocks/resets for the same SoC,
we can't add "glue-reset" and we might add patches for the device as a result.
In this case, the "glue-reset" will become difficult to understand.


> There is no real hardware like pro4-glue-reset.
>
> I am guessing this is a part of syscon or something,
> but I cannot find any explanation in a bigger picture.
> 
> So, I cannot judge this further more.

Since it's hard to lead the best result,
currently I'd like to suggest the current compatibles, with "simple-reset"
if necessary.

Thank you,

---
Best Regards,
Kunihiko Hayashi


