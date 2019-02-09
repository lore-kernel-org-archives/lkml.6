Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F5C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343782177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hlZz8aa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBIAKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:10:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40263 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBIAKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:10:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so8845269oth.7;
        Fri, 08 Feb 2019 16:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6WKgZeMxEaINbTBOzkZUeDkqTpOtQlFXaqrcFdu2ZY=;
        b=hlZz8aa77STNBi+Rg1ezvuj3hxsnoBIKfRl1P1/pIw0ug70LOMk3+C+ryL1o30JCHX
         hnB5q4DRhPXiJqIgPr25TONKF3+JIJyU7PxcKNamdQwp7i2qF0iSwAMxwbRdNmWnBMMY
         JsK7DhaPGV7TIMBVCwEVFopHyx9zneALBDiMq7cauOSEw28GTPdGozIg8Ic9dxAS80dB
         aUiufdN/OLjZ2n6V1PEMi53vw4AT4ctqk73F+9y7FzAusJ89gU0rxx6BSgFXuEiQQPik
         8hja2xL5+MpOX9ibXEZ5RIyN0hjGhTKiPeJXripnSrPf6nmcYbctkB1aO29dOUQ1M6Ni
         E74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6WKgZeMxEaINbTBOzkZUeDkqTpOtQlFXaqrcFdu2ZY=;
        b=oFgheJ+bzAE8et36QKKSESU826UmEWHkralMNpMSICqCrv5++3fLLkrWLqKssaYv+V
         aOsyulzEOUPtTHskQ5MNlDFFrH6t1sy8P/KBShCGs4CezujfehzqngbL+PBY/RdcYqGl
         LoJAu+/e7z2wgYwAbWk3t74gcIvmKe2IhDCOxYHrL766p37tXVAgtZZQYcpEx4J3DL9v
         ekMDiHw3EGeCm5lYCgDL8hrCx5aaLganTE4k6rFOanCgmlsTWmjwoR7wJMS9QVU2i5vY
         mk123W0lNgvqM/3d6Vb/oB763jM2Xk5VrZdcQV5Nta7YhI5a+4RuO8+sp+QY0/fU9KeN
         Z8gw==
X-Gm-Message-State: AHQUAuaWBE5olCxYg/1NDN+twDmKbafTnYESVg1xHqLr7Ya2B4gC+bOF
        1qhnJ8pnkRZM0W81x6xgcIeO9eJ2ryJSkJfl3as=
X-Google-Smtp-Source: AHgI3IZDtAaNNot/GDW3p1K+BBxlqA8EqCYrGQ8qdj5RNl973F1xE7BDIi44a/pEBvhVDltspqVcYYgUuqTld4ni+gs=
X-Received: by 2002:a05:6830:1387:: with SMTP id d7mr5250231otq.148.1549671037132;
 Fri, 08 Feb 2019 16:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-2-martin.blumenstingl@googlemail.com> <20190206223057.GB4719@piout.net>
In-Reply-To: <20190206223057.GB4719@piout.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 9 Feb 2019 01:10:26 +0100
Message-ID: <CAFBinCDwLyuPh-2t8LuOUf+5cpS2Tbft=4qX6uq4WsEFtvPhCw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: rtc: add device-tree bindings for the
 Amlogic Meson RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
        ccaione@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 6, 2019 at 11:31 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> On 19/01/2019 15:43:31+0100, Martin Blumenstingl wrote:
> > The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
> > have a built-in RTC block.
> > It has the following inputs:
> > - an 32.768kHz crystal oscillator
> > - an interrupt line
> > - a reset line
> > - 0.9V voltage input
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > [resurrected patches from Ben after 2 years]
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> > new file mode 100644
> > index 000000000000..23df3cf2dd73
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> > @@ -0,0 +1,32 @@
> > +* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
> > +
> > +Required properties:
> > +- compatible: should be one of the following describing the hardware:
> > +     * "amlogic,meson6-rtc"
> > +     * "amlogic,meson8-rtc"
> > +     * "amlogic,meson8b-rtc"
> > +     * "amlogic,meson8m2-rtc"
> > +
> > +- reg: physical register space for the controller's memory mapped registers.
> > +- interrupts: the interrupt line of the RTC block.
> > +- clocks: reference to the external 32.768kHz crystal oscillator.
> > +- vdd-supply: reference to the power supply of the RTC block.
> > +- resets: reset controller reference to allow reset of the controller
> > +
> > +Optional properties:
> > +- #address-cells: should be 1 to address the internal non-volatile memory
> > +- #address-cells: should be 1 to reference the internal non-volatile memory
>
> Shouldn't that one be #size-cells ?
indeed, thanks for spotting!


Martin
