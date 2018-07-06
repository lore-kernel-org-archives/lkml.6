Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E07C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40F23C4E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="orbRiIVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D40F23C4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934019AbeGFRi5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933633AbeGFRiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:38:54 -0400
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com [209.85.214.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D924E23D1F;
        Fri,  6 Jul 2018 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530898734;
        bh=eVICEtmIZ2Xbgi20rpTJ3m9PvqDp+ekx6UHaiI11pqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=orbRiIVXAhKZkYyZuVOIxS+KRntouQ8GScizDdT1mo8ThBli3nVefc+WFdr9hPazD
         URFU+BN+FLsy+E9aOm1+mMrCe2J/70YOn/6ebJvBSKFKQXNzGatmi6EYalbQ4ILSQZ
         BBwh/XL1ruNlxE4trOabC2sF3emMmgklIDaTnco4=
Received: by mail-it0-f49.google.com with SMTP id p185-v6so18206500itp.4;
        Fri, 06 Jul 2018 10:38:53 -0700 (PDT)
X-Gm-Message-State: APt69E1ijtKXqAzUVQn18tf4RNe3pkApj5ygzZrFb0tdvVRisHfcQ5Jb
        3NwE0Nfsy9YOOg2A88LEfwJ69itJMRFWnxYlQg==
X-Google-Smtp-Source: AAOMgpeQMca6Twofl0fI1ziwd4EKMW/fNfZmGhSWAxGaIUQEHtruJ5wp1ABpy3FWlAPa+xA1TI8ZwxVTabZkszisU7s=
X-Received: by 2002:a24:41e9:: with SMTP id b102-v6mr8462543itd.19.1530898733202;
 Fri, 06 Jul 2018 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180704123638.GA30535@arbeit> <20180705213019.GA12792@rob-hp-laptop>
 <20180706062147.GA1950@arbeit>
In-Reply-To: <20180706062147.GA1950@arbeit>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 6 Jul 2018 11:38:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGn=iTbD+qDasyNN8qpPzsTWp0ZQSK68GaDPx1OBG9xw@mail.gmail.com>
Message-ID: <CAL_JsqLGn=iTbD+qDasyNN8qpPzsTWp0ZQSK68GaDPx1OBG9xw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: hx711: add clock-frequency property in DT
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:22 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> Hi Rob,
>
> please see explanation below. Thanks.
>
> Rob Herring <robh@kernel.org> schrieb am Thu, 05. Jul 15:30:
> > On Wed, Jul 04, 2018 at 02:36:38PM +0200, Andreas Klinger wrote:
> > > Add clock-frequency property for hx711 ADC
> > >
> > > This is the frequency of PD_SCK. It affects only the high value duration
> > > since low value duration is not relevant and we are not able to switch
> > > faster than the minimum duration specified.
> > >
> > > After PD_SCK goes high DOUT is read just before PD_SCK goes down again.
> > > This is necessary because of parasitic capacities on the wiring.
> >
> > s/capacities/capacitance/
>
> I'll change.
>
> >
> > >
> > > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > index b3629405f568..4bee51d536e1 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > > @@ -8,11 +8,21 @@ Required properties:
> > >             See Documentation/devicetree/bindings/gpio/gpio.txt
> > >   - avdd-supply:    Definition of the regulator used as analog supply
> > >
> > > +Optional properties:
> > > + - clock-frequency:        Frequency of PD_SCK
> > > +                   This setting affects the duration of the high value
> > > +                   phase of the clock (PD_SCK). The low value phase is
> > > +                   not affected since it is not relevant for the
> > > +                   measurement.
> >
> > That's not how frequency works. The high time should be equal to the low
> > time. If you have parasitic capacitance affecting the rise time, then it
> > is going to affect the fall time too.
> >
> > Perhaps there could be some reason not to have a square wave, but I
> > didn't see one in the datasheet.
>
> When PD_SCK goes high the ADC sets DOUT to the corresponding value. Only after a
> rising edge DOUT is set. The falling edge doesn't matter.

When bit-banging yes, but the simplest h/w implementation would shift
data on one edge and sample on the other.

> The parasitic capacitance is occuring only on DOUT line, but not on PD_SCK. The
> difference is that PD_SCK is driven by the microcontroller, and DOUT by the ADC.

Maybe for you, but for someone else's design? I just don't want to see
the binding evolving fixing one problem at a time.

> So after i set the rising edge on PD_SCK i have to wait until DOUT reaches its
> value. Datasheet says this can take at maximum 0.1 us. This might be true, but
> without wiring between ADC and microcontroller. With wiring of a 10 m cable i
> saw 1 us on the oscilloscope.
>
> If required i can post a screenshot of the oscilloscope.
>
> The code which is executed in the driver on PD_SCK during low value takes much
> more than the requested 0.2 us (measured 0.56 us). Of course i can make it a
> square wave with equal low and high time, but i don't see it's needed and it'll
> slow down the communication speed.
>
> Out of my frequency generator i can get a rectangular waveform with different
> low and high times and it's still called frequency. A don't have another
> expression for it.

Yes, but the frequency is not 1/(high time) as you defined. But I
wasn't expecting 2 orders of magnitude difference.

> Do you have a suggestion how to call this attribute in the DT if frequency is
> not suitable?

If you really want to not have 50% duty cycle, then of course you
would need to define an additional property.

> >
> > > +                   Minimum value allowed is 20 kHz because of maximum
> > > +                   high time of 50 microseconds.
> >
> > So 10kHz should be minimum.
> >
>
> Because the low time is very short (0.5 us) in comparison to the high time
> (50 us) in the actual waveform i neglected it.

Okay, that's not obvious.

Rob
