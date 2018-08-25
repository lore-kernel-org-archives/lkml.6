Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD9C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666E42147E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXEtEhAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666E42147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeHYMFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYMFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:05:37 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4879E20C51;
        Sat, 25 Aug 2018 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535185645;
        bh=YJZVJoU8D3SaYwoFqvwofJCt/D5k5xKmU7bhrzFxSXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gXEtEhAUsTLxka4BGKrzjDVQqVIT0pKs4aMz4jPU6TS3+lFM2gtfcKuMf6pJVjR8a
         23hYeqpCU3XqLrZDBUdiAdo7eUcPXKr+zr0FPgvKEFvy/0X3AKIzQhbPfDd2+Wco9y
         zkUatCCfpAIyzpCV9ESqFnQQIvg0ehvxypUJPEUU=
Date:   Sat, 25 Aug 2018 09:27:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: dac: add bindings for ltc1660
Message-ID: <20180825092720.0cb8fbb6@archlinux>
In-Reply-To: <20180822192518.GA694@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
        <20180821193126.15733-2-marcus.folkesson@gmail.com>
        <20180822192518.GA694@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 21:25:18 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> On Tue, Aug 21, 2018 at 09:31:25PM +0200, Marcus Folkesson wrote:
> > LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
> > with eight individual channels.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> Rob, sorry I missed your tag.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing
to be largely ignored by the autobuilders.

Thanks,

Jonathan

> 
> > ---
> > 
> > Notes:
> >     v2:
> >     	- rename file, ltc166x -> ltc1660
> > 
> >  .../devicetree/bindings/iio/dac/ltc1660.txt         | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > new file mode 100644
> > index 000000000000..c5b5f22d6c64
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
> > @@ -0,0 +1,21 @@
> > +* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
> > +
> > +Required properties:
> > + - compatible: Must be one of the following:
> > +		"lltc,ltc1660"
> > +		"lltc,ltc1665"
> > + - reg: SPI chip select number for the device
> > + - vref-supply: Phandle to the voltage reference supply
> > +
> > +Recommended properties:
> > + - spi-max-frequency: Definition as per
> > +	 Documentation/devicetree/bindings/spi/spi-bus.txt.
> > +	 Max frequency for this chip is 5 MHz.
> > +
> > +Example:
> > +dac@0 {
> > +	compatible = "lltc,ltc1660";
> > +	reg = <0>;
> > +	spi-max-frequency = <5000000>;
> > +	vref-supply = <&vref_reg>;
> > +};
> > -- 
> > 2.11.0.rc2
> >   

