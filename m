Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF94FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C649821905
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfAaOdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:33:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44439 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:33:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2454582lfe.11;
        Thu, 31 Jan 2019 06:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAI3iAGxTIvgVC1skHcS3IaLf6SHSz14WV+Xwa/qpPM=;
        b=f3JzS/+52NBZCQ6dh+DT9ngZmySS9xI2E0/sX4z/SYt0geR6RmWWJMstaFGxuNiyOW
         AVkWf4FW0+uqsHU5hquIKNrj3r3wn9erpkkxwJFoTWw0Ze6raN8bx6LCDQG9B23Un5vx
         3iMUENlZvS0I3SGQob6/rY+sAyzi5zVNqgsSVpsQeGa+xIMgx5sRtVEpD47VaGmEOEQm
         D23HvfioKMAkoEzFhUdnLbTxwjIzZdh9shYahFJU9uNStsoAR+Kg3U3R9z8ZhebPJEUK
         UM+/ERrLqHqY6gzBqlE+7pcUsiTwpzQTh/NkPOHDTJwr8RugEiAQHiY0ktVkDL8uE11s
         XBSg==
X-Gm-Message-State: AJcUukfwx14BzVWTPti1vScrzooU+qRfzaIF4wfUNVUxuCoDVW/4tayQ
        gDnwN1szD99APn45coMsvc/nvTR853P4L9XCYAZhh0jS
X-Google-Smtp-Source: ALg8bN4i2Y2lC1DfUcQyx/YPP/7NYEwg97uQuLiOt5lxc3108rXRTVYLmR6/KP4MxmW6x4GQhOjvCKxkkXTpBoiRhPM=
X-Received: by 2002:a19:9e11:: with SMTP id h17mr27175229lfe.73.1548945201032;
 Thu, 31 Jan 2019 06:33:21 -0800 (PST)
MIME-Version: 1.0
References: <20190128094931.4430-1-ricardo@ribalda.com> <20190128094931.4430-2-ricardo@ribalda.com>
 <20190130170723.GA24708@bogus>
In-Reply-To: <20190130170723.GA24708@bogus>
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
Date:   Thu, 31 Jan 2019 15:33:04 +0100
Message-ID: <CAPybu_0Pd4xNzhR2RAdegomckcMxHeM8t7uCrNCXY4CZz2bZZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio:dac:dac7612: device tree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

Thanks for your comments!

On Wed, Jan 30, 2019 at 6:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 28, 2019 at 10:49:31AM +0100, Ricardo Ribalda Delgado wrote:
> > Bindings for dac7612.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
> > ---
> >  .../bindings/iio/dac/ti,dac7612.txt           | 29 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> > new file mode 100644
> > index 000000000000..e1b8158fab35
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> > @@ -0,0 +1,29 @@
> > +* Texas Instruments Dual, 12-Bit Serial Input Digital-to-Analog Converter
> > +
> > +The DAC7612 is a dual, 12-bit digital-to-analog converter (DAC) with guaranteed
> > +12-bit monotonicity performance over the industrial temperature range.
> > +Is is programmable through an SPI interface.
> > +
> > +The internal DACs are loaded when the LOADDACS pin is pulled down.
> > +
> > +http://www.ti.com/lit/ds/sbas106/sbas106.pdf
> > +
> > +Required Properties:
> > +- compatible: Should be one of:
> > +             "ti,dac7612"
> > +             "ti,dac7612u"
> > +             "ti,dac7612b"
>
> What's the difference? I can only find 'u' and 'ub' variants and nothing
> about how those are different. So maybe just 1 string is enough?

dac7612 is how it is named on the datasheet commercial name.
dac7612u and dac7612ub being the variants. ub being slightly more
accurante. Shall I leave only 7612?
or keep the tree variants (fixing 7612b with 7612ub)?

Thanks!

>
> > +- reg: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +Optional Properties:
> > +- loaddacs-gpios: GPIO descriptor for the LOADDACS pin.
>
> Needs a 'ti' vendor prefix.
>
> > +- spi-*: Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +Example:
> > +
> > +     dac7612@1 {
>
> dac@1
>
> > +             compatible = "ti,dac7612";
> > +             reg = <0x1>;
> > +             loaddacs-gpios = <&msmgpio 25 GPIO_ACTIVE_LOW>;
> > +     };
> > +
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 30ba5435906b..e28e5afaae16 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14882,6 +14882,7 @@ M:    Ricardo Ribalda <ricardo@ribalda.com>
> >  L:   linux-iio@vger.kernel.org
> >  S:   Supported
> >  F:   drivers/iio/dac/ti-dac7612.c
> > +F:   Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> >
> >  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
> >  M:   Hans Verkuil <hverkuil@xs4all.nl>
> > --
> > 2.20.1
> >



-- 
Ricardo Ribalda
