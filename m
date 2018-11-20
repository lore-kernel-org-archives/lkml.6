Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41377C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A7220870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0VnC7FiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A7220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeKUKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:06:35 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46050 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbeKUKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:06:34 -0500
Received: by mail-io1-f66.google.com with SMTP id w7so2706456iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPpQ2Kn1OGbTxdtSvJ0PbMqBr2D3VS8I+QDfhP0a3tw=;
        b=0VnC7FiFytM8G8LLAX+n8VtpjsFEeU/9hI686O//pr8ube0/5iVFwH2ZmBtMk2Hxy6
         KGpU2S0gXsdI+/on7CW5PWf6JzDWWICACZWzvQacp/VPsN5OxS2/hgKljJEI3vtGHOfD
         HBnlFwFV451ll8EAHrRRTTOvvwTOP7eAaQXMW6eAVhTASa2zRsLYqTbje1+QK/08SOp0
         76kDvOAPkzDnklgGiMPeorCypXBSxe8KtiZiIuH8Sd3S/liSDaQtPrDMyUZErBGRoQKZ
         NcW94EwLJelS10nTM9HJ7pX6aiN2d5JJf4LBu9OvcyrMxYVPIfd9St8MHayK/FUvlpq5
         BK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPpQ2Kn1OGbTxdtSvJ0PbMqBr2D3VS8I+QDfhP0a3tw=;
        b=dJtkHBd35WobGQRzoDCIjJO2zIiuD3ZUNCHYvTWvIk1lwwMylWisKC6qFLRmXd4ibV
         OGfLmwnSWGUv21rNBcclRlKfDlRVjHTxIsRZFb8quwK6Sw5I5Ky1RdzQgLK5fG2DN1Ap
         RKptC1jeXX8XCvVDwWicVCTILHOf+9pRR1VyIuVYTfr1+wZuN4iyPQk1PK3Gaq2wpt3e
         Xan7/ZUaAYBpTN/26Ba4l4C459eHoUcfmzSvGD3E8ar4zUy0pTJU1zGNDfOaFGizBAS8
         irhIGJhYxlO+fxdhP89mFER0l8D864R6+EH56JFaqfu9kVszzMw7WBOWS+Yrnp24mfsR
         ea2g==
X-Gm-Message-State: AA+aEWZ4NpB9ngRN8KI8RrQCt3wnrPDrYNhfC+5dH5HYl3mvaqj5hcKQ
        VLd8SUqTLKsnAF4+QLeza+hctf2RMD262tSGeRF2bA==
X-Google-Smtp-Source: AFSGD/X3iJN+gkXxWL+KQ4DMCktTECT7V/IDmEevT7sLQ044uYx4lXV3JtXg+/4UdPc3Xne5WlRDeP8nU5mAri7oYac=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr3086324ior.169.1542756890102;
 Tue, 20 Nov 2018 15:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
 <20181118042540.12697-5-matheus.bernardino@usp.br> <563614e00314ba92b9513645a82fde06504a42d5.camel@analog.com>
In-Reply-To: <563614e00314ba92b9513645a82fde06504a42d5.camel@analog.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 20 Nov 2018 21:34:38 -0200
Message-ID: <CAHd-oW7vvk+gvk787OS29XP+O=Gf93raczuxiYJ9XSuWDJEu7A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
To:     Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, kernel-usp@googlegroups.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:22 AM Ardelean, Alexandru
<alexandru.Ardelean@analog.com> wrote:
>
> On Sun, 2018-11-18 at 02:25 -0200, Matheus Tavares wrote:
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> >
>
> One minor comment inline.
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > Changes in v2:
> >  - Rewritten 'spi-cpol and spi-cpha' item to say that the device can
> >  work in either mode (0,0) or (1,1) and explain how they should be
> >  specified in DT.
> >
> >  .../bindings/iio/resolver/ad2s90.txt          | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > new file mode 100644
> > index 000000000000..594417539938
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > @@ -0,0 +1,28 @@
> > +Analog Devices AD2S90 Resolver-to-Digital Converter
> > +
> > +https://www.analog.com/en/products/ad2s90.html
> > +
> > +Required properties:
> > +  - compatible: should be "adi,ad2s90"
> > +  - reg: SPI chip select number for the device
> > +  - spi-max-frequency: set maximum clock frequency, must be 830000
> > +  - spi-cpol and spi-cpha:
> > +        Either SPI mode (0,0) or (1,1) must be used, so specify none or
> > both of
> > +        spi-cpha, spi-cpol.
> For SPI properties it's a good idea to also reference the document for SPI
> bindings.
> Something like:
>     See for more details:
>      Documentation/devicetree/bindings/spi/spi-bus.txt
>

Thanks, Alex! I'll add that for v3.

Also, can you confirm AD2S90 works in both spi mode 0 and 3? It's not
explicitly stated in the datasheet, but that's what it seemed to me
and some colleagues.

Thanks,
Matheus

> > +
> > +Note about max frequency:
> > +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a
> > 600ns
> > +    delay is expected between the application of a logic LO to CS and
> > the
> > +    application of SCLK, as also specified. And since the delay is not
> > +    implemented in the spi code, to satisfy it, SCLK's period should be
> > at most
> > +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which
> > gives
> > +    roughly 830000Hz.
> > +
> > +Example:
> > +resolver@0 {
> > +     compatible = "adi,ad2s90";
> > +     reg = <0>;
> > +     spi-max-frequency = <830000>;
> > +     spi-cpol;
> > +     spi-cpha;
> > +};
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/563614e00314ba92b9513645a82fde06504a42d5.camel%40analog.com.
> For more options, visit https://groups.google.com/d/optout.
