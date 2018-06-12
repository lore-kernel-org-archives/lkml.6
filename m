Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DE1FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC35208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC35208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933225AbeFLSVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:21:38 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33241 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeFLSVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:21:36 -0400
Received: by mail-yw0-f196.google.com with SMTP id u124-v6so7840950ywg.0;
        Tue, 12 Jun 2018 11:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhQXaXF5wSLcJ2LVkRx0Cmo+X4Ij+SiXJi5p9zLmuR8=;
        b=XBfm7Y6gLIBVgjvJnT1CgPmpVoHmtIqdyVjVIirHiNnjQRFqeyVofhBJ0I6ii944YZ
         CZ6UHENqKuI59UrpiBsyrZNsiTcbXnxqAvoScBuslTM8rqjkVi8J5ICTmp+vm4dQUfoC
         KRGL+CtU0k54DkSypEyAAXdVtUMW2QaBMfdFxf2qo6AbU072bA1XVgUsB06P0Q5X6xTj
         PKkub6emhKNPKwS/JfuGGo1FcR0Qav5xQg4pw02roLuS8YKK8KPN/LpF5J8pvqhSFrLl
         7FdRfnIovFv3JhdS80DrfDv+BP+SI8cVMVBuiza+ZQ6P1RCOWwhCFylZeM4HBX9iDEyx
         hUDQ==
X-Gm-Message-State: APt69E2ZYO37DrbyBx0bUZQ4/2Odpemx2ojA0vsuJDaSuTEOK/oZ+TdP
        XGKvB9Am66YJXtRF9Hcn2w==
X-Google-Smtp-Source: ADUXVKKSQKzyeDMdAYFi8FJwoSmZgTp4Am+tEzyoIJA8y6Zw9h457xB2Lap7B736dOkJ0CCMILJTFQ==
X-Received: by 2002:a81:8687:: with SMTP id w129-v6mr716342ywf.69.1528827695581;
        Tue, 12 Jun 2018 11:21:35 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p81-v6sm294346ywb.71.2018.06.12.11.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:21:34 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:21:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, Michael.Hennerich@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: Add docs for AD5758 DAC
Message-ID: <20180612182133.GA3118@rob-hp-laptop>
References: <1528377065-647-1-git-send-email-stefan.popa@analog.com>
 <20180610145923.3b767ad4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610145923.3b767ad4@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 02:59:23PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Jun 2018 16:11:05 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Hmm. The first part number I've ever googled where the top hit has
> been a flight number. 
> Rio de Janeiro to Campinas is apparently on time today.
> 
> > ---
> > Changes in v2:
> > 	- Nothing changed, just to follow the patch set version.
> > 
> >  .../devicetree/bindings/iio/dac/ad5758.txt         | 84 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 85 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > new file mode 100644
> > index 0000000..75fff6c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
> > @@ -0,0 +1,84 @@
> > +Analog Devices AD5758 DAC device driver
> > +
> > +Required properties for the AD5758:
> > +	- compatible: Must be "adi,ad5758"
> > +	- reg: SPI chip select number for the device
> > +	- spi-max-frequency: Max SPI frequency to use (< 50000000)
> > +	- spi-cpha: is the only mode that is supported
> > +
> > +Optional properties:
> > +
> > + - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
> > +		   The following values are currently supported:
> > +		   	* 0: DC-to-DC converter powered off
> > +			* 1: DPC current mode
> Perhaps expand those acronyms?
> Dynamic Power Control  and perhaps a bit of explanation so people
> who are ready DT files don't have to go find the data sheet to have
> some idea of what these are?
> 
> Otherwise, binding is fine.
> 
> > +			* 2: DPC voltage mode
> > +			* 3: PPC current mode
> > +
> > + - adi,dc-dc-ilim: The dc-to-dc converter current limit
> > +		   The following values are currently supported [mA]:
> Unit should be in the name.
> adi,dc-dc-ilim_ma

Yes, but don't use '_' and follow what is in property-units.txt.
