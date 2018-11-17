Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46506C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8120868
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="C87hDjzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD8120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeKQNoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:44:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45976 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbeKQNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:44:30 -0500
Received: by mail-io1-f65.google.com with SMTP id w7so10908203iom.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 19:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnAwtWg28pS52MFFX6UK6keC0Ht3HGAZcKi384UsGP0=;
        b=C87hDjzZns7pTuLgyUDCzfkWfI/l9DCOvsOgPq7sio5IKTuSMoxBQGVciUAyOCt+CS
         tQdgCHHA91FlrSbDCOeQzoZZ6DxMlJMvuxONSyrdYOa3QdIsewuf2IVgt7G3pr8E5Qu/
         71yuDWWZr3+rfIzj0E5sFz6RD5JMzCUYl8cVPYLsDMAVGa36S3qxmHrQwdn+Bx9U43Ax
         OToePeDwJhnxBF+5zOccOM7t2u/fRwXb2HkBaQmptU2boChDwUaFWjwIHeMs3ZaVW5DQ
         DOJed+HyVVtLm1t5dmg8kVVYS4Ca4R4PYUBWo00Vbc1f7f174upxW37XtTVJ9DHI4d/e
         FYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnAwtWg28pS52MFFX6UK6keC0Ht3HGAZcKi384UsGP0=;
        b=RmfWJwR2hXvq2hHvzvwEZnc6b4UvUOFEk/wrlNfi0yeKEMNHozIgCNT2D6zqYVkAhu
         xfmPy6/Hu1t4umgute9dprt8i91BgbvbQaZhBJ6i2TLJcEIaoVkLgWuWKbcOiM051z1Z
         YOLY+1S9KILLfQETOi/MTuWkUQJs7s/cWrm1bagsFvWkcG54Jk/MBhh9uhVzCSHrLsVA
         9AOyCOErQc1QYbRvxUtuBV7Y3Jz8gQ3Ekflruj6fmdCXwjywfBmr47gf0fLRPJClpuOW
         tsILloQvoVX77lzBIJiIhNWRy9QW/zUMjgTb8HuVh0aAP/EwIPoa5MbF07RAP4c9o5sm
         qbkA==
X-Gm-Message-State: AGRZ1gKQoDVaoNwn99Npabpl6l22el/OK2F8oRFPo9KJ8QRx+bEhO4u8
        ujfgAhj6JoqkAVty5siCxztNt0EVeu84cA8lvjJzKA==
X-Google-Smtp-Source: AFSGD/W2bp8UfJLupWwxugEjvXWwFsSaLA5/rMRWHiij/aTbvfohxY8+eXuH2uy0svWiTaZ83N2jENO3igcJIcFhWX0=
X-Received: by 2002:a6b:abc6:: with SMTP id u189-v6mr9764928ioe.229.1542425361177;
 Fri, 16 Nov 2018 19:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
 <20181109220044.24843-5-matheus.bernardino@usp.br> <20181111114848.266d3937@archlinux>
In-Reply-To: <20181111114848.266d3937@archlinux>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 17 Nov 2018 01:29:09 -0200
Message-ID: <CAHd-oW4_Lp3-1toTeMmx4qBozfYZ6=7oPUa0BVG05OgjhnFm-w@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings:iio:resolver: Add docs for ad2s90
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com,
        Victor Colombo <victorcolombo@gmail.com>, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:48 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri,  9 Nov 2018 20:00:42 -0200
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> > This patch adds the device tree binding documentation for the ad2s90
> > resolver-to-digital converter.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  .../bindings/iio/resolver/ad2s90.txt          | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > new file mode 100644
> > index 000000000000..b42cc7752ffd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
> > @@ -0,0 +1,26 @@
> > +Analog Devices AD2S90 Resolver-to-Digital Converter
> > +
> > +https://www.analog.com/en/products/ad2s90.html
> > +
> > +Required properties:
> > +  - compatible : should be "adi,ad2s90"
> > +  - reg : SPI chip select number for the device
> > +  - spi-max-frequency : set maximum clock frequency, must be 830000
> > +  - spi-cpol and spi-cpha : must be defined to enable SPI mode 3
>
> As the part only works in mode 3, my gut feeling is that this belongs
> in the driver, not here.  Rob, what do you think?
>

For this patch, I assumed the part only worked in mode 3 based on the
driver's code that set this at probe. But today I carefully looked for
it at the datasheet and now I'm unsure. It is never said, explicitly,
which SPI mode ad2s90 works with. But looking at the diagram that
shows the expected pins signals at each communication moment, it seems
to me that this chip can either work in mode 0 (CPOL=0, CPHA=0) or
mode 3 (CPOL=1, CPHA=1). Could someone help me to confirm this? And if
that is the case, them the SPI mode setting should be left in DT, as
adc/mcp320x and dac/ti-dac082s085 do, right?

Also, when I thought that ad2s90 only worked in mode 3, I wrote this
patch based on the dt-binding docs for the adxl345 accelerometer,
which only works in mode 3 but lets this setting to DT not in the
driver. Do you think, perhaps, it is wrong in adxl345, them?

Thanks,
Matheus.

> > +
> > +Note about max frequency:
> > +    Chip's max frequency, as specified in its datasheet, is 2Mhz. But a 600ns
> > +    delay is expected between the application of a logic LO to CS and the
> > +    application of SCLK, as also specified. And since the delay is not
> > +    implemented in the spi code, to satisfy it, SCLK's period should be at most
> > +    2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which gives
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
