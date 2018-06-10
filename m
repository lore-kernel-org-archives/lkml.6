Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XRiPG6saHVtEMwAAmS7hNA
	; Sun, 10 Jun 2018 12:34:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 91489608BA; Sun, 10 Jun 2018 12:34:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zmN5k34X"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0FD6A604D4;
	Sun, 10 Jun 2018 12:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FD6A604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbeFJMeL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753451AbeFJMeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:34:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F8620660;
        Sun, 10 Jun 2018 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528634049;
        bh=FZdpxTaNysHjmfUpSMgEIFQ9h+hiX87odS6q8B1HfHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zmN5k34XJvVJ9saTGMWGj0LWbjDmvB6wugwovMXccz+0KLpkKhHrTFiZ5qk9WUx69
         5TP1Xi4F7lvNSpM1ZXEslqeCT8szuPPArXgDHcSoLQ0Z6tqiz4W2TIUIhZ2EZFRddw
         Ty6PFITrEE1R+W7cHMig000r/+pGjmCSHdN7kwt0=
Date: Sun, 10 Jun 2018 13:34:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 7/9] dt-bindings: iio: adc: at91-sama5d2_adc: add
 channel specific consumer info
Message-ID: <20180610133403.533cfe38@archlinux>
In-Reply-To: <20180522122319.GN22971@rfolt0960.corp.atmel.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-8-git-send-email-eugen.hristev@microchip.com>
        <20180522122319.GN22971@rfolt0960.corp.atmel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 14:23:19 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Tue, May 22, 2018 at 10:52:37AM +0300, Eugen Hristev wrote:
> > Added defines for channel consumer device-tree binding
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > ---
> >  .../devicetree/bindings/iio/adc/at91-sama5d2_adc.txt     |  9 +++++++++
> >  include/dt-bindings/iio/adc/at91-sama5d2_adc.h           | 16 ++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >  create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > index 6469a4c..4a3c1d4 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> > @@ -21,6 +21,14 @@ Optional properties:
> >    - dmas: Phandle to dma channel for the ADC.
> >    - dma-names: Must be "rx" when dmas property is being used.
> >    See ../../dma/dma.txt for details.
> > +  - #io-channel-cells: in case consumer drivers are attached, this must be 1.
> > +  See <Documentation/devicetree/bindings/iio/iio-bindings.txt> for details.
> > +
> > +Properties for consumer drivers:
> > +  - Consumer drivers can be connected to this producer device, as specified
> > +  in <Documentation/devicetree/bindings/iio/iio-bindings.txt>
> > +  - Channels exposed are specified in:
> > +  <dt-bindings/iio/adc/at91-sama5d2_adc.txt>
> >  
> >  Example:
> >  
> > @@ -38,4 +46,5 @@ adc: adc@fc030000 {
> >  	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_BOTH>;
> >  	dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
> >  	dma-names = "rx";
> > +	#io-channel-cells = <1>;
> >  }
> > diff --git a/include/dt-bindings/iio/adc/at91-sama5d2_adc.h b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> > new file mode 100644
> > index 0000000..70f99db
> > --- /dev/null
> > +++ b/include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * This header provides constants for configuring the AT91 SAMA5D2 ADC
> > + */
> > +
> > +#ifndef _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
> > +#define _DT_BINDINGS_IIO_ADC_AT91_SAMA5D2_ADC_H
> > +
> > +/* X relative position channel index */
> > +#define AT91_SAMA5D2_ADC_X_CHANNEL		24
> > +/* Y relative position channel index */
> > +#define AT91_SAMA5D2_ADC_Y_CHANNEL		25
> > +/* pressure channel index */
> > +#define AT91_SAMA5D2_ADC_P_CHANNEL		26
> > +
> > +#endif
> > -- 
> > 2.7.4
> >   
