Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F9C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C32720839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIKSS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:18:56 -0400
Received: from shell.v3.sk ([90.176.6.54]:42259 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKSS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:18:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A315CB2367;
        Tue, 11 Sep 2018 15:19:35 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JRUEHE8ENPvS; Tue, 11 Sep 2018 15:19:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C0C21B2669;
        Tue, 11 Sep 2018 15:19:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B1sVBxoqUI6W; Tue, 11 Sep 2018 15:19:32 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D1B47B2367;
        Tue, 11 Sep 2018 15:19:31 +0200 (CEST)
Message-ID: <3ab50e5f4c647229b575bc5de5e80f9ed80ac938.camel@v3.sk>
Subject: Re: [PATCH 1/4] dt-bindings: mrvl,mmp-timer: add clock
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Date:   Tue, 11 Sep 2018 15:19:30 +0200
In-Reply-To: <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
References: <20180910113031.42634-1-lkundrak@v3.sk>
         <20180910113031.42634-2-lkundrak@v3.sk>
         <CAL_JsqKgJFZnpuv7rW6ovxMKi4Q2AngWxKa=CMR_Y+xD5Oh3GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 10:21 -0500, Rob Herring wrote:
> On Mon, Sep 10, 2018 at 6:30 AM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > 
> > The timer needs the timer clock to be enabled, otherwise it stops
> > ticking.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/mrvl,mmp-
> > timer.txt b/Documentation/devicetree/bindings/timer/mrvl,mmp-
> > timer.txt
> > index 9a6e251462e7..a2ede0bd12ca 100644
> > --- a/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
> > @@ -4,10 +4,12 @@ Required properties:
> >  - compatible : Should be "mrvl,mmp-timer".
> >  - reg : Address and length of the register set of timer
> > controller.
> >  - interrupts : Should be the interrupt number.
> > +- clocks : Should contain a single entry describing the clock
> > input.
> 
> So now pxa910 and pxa168 dts files have errors because they are
> missing a required clock.

Ah, right. Sorry. Will make it optional then.

A brief look at 16x datasheet suggests that the "fast clock" source
circuitry needs to be enabled in the PMU, whereas the internal "32.768"
might not be. Perhaps the timer clk is always enabled in PMU, or the
slow clock is used on those platforms? No idea.

> Plus somehow other MMP2 platforms either
> worked without a clock or have been broken.

I don't have a MMP2 datasheet, but if things work the same as on a 16x,
then mach-mmp/time.c indeed chooses the fast timer.

The DT MMP2 platform certainly is certainly broken*. Not sure about the
BSP-based platforms.

* in other ways too: even when the missing clock is worked around with
  "clk_ignore_unused" the wrong rate gets chosen and the timer runs too
  slow. (Fix posted recently.)

> You can't add new required properties to a binding. That breaks
> backward compatibility.

Should I make an effort to make the driver look up and enable the clock
on MMP2 even if it doesn't find the clock property in DT?

It won't work otherwise, which is why I thought I can't break it
further (I didn't notice that the same binding and driver are used on
PXA168 and PXA910).

> Rob

Thank you,
Lubo

> > 
> >  Example:
> >         timer0: timer@d4014000 {
> >                 compatible = "mrvl,mmp-timer";
> >                 reg = <0xd4014000 0x100>;
> >                 interrupts = <13>;
> > +               clocks = <&coreclk 2>;
> >         };
> > --
> > 2.17.1
> > 

