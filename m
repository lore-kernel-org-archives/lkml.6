Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D9C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41FF21711
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41FF21711
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeFXN3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:29:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFXN3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:29:46 -0400
Received: from localhost ([2.166.249.57]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MJkO4-1fVybz2FvA-0018N5; Sun, 24 Jun 2018 15:29:03 +0200
Date:   Sun, 24 Jun 2018 15:28:59 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: hx711: add data-ready-delay-ns property in DT
Message-ID: <20180624132858.GA2296@imap.1und1.de>
References: <20180623185420.GA17842@arbeit>
 <20180624141048.7628eaac@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624141048.7628eaac@archlinux>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:y2K/o9gEk8XAxeAexWpFDbvvrhDTa/m5BQZ2WcEiz1LV/ya93K1
 4WTlIbUOKjNstvejnrT8SRt09wnQ1h22cKlb6kONS9yFVswcz2P5PS/FSF8UaltgzW+g79B
 vNcK9xezVG2U+Mm2aAgXYCagRMuW1iZWYK+8A2c0iCFYGtdgr2bYkM5cGZg7sFlDhn/5vYJ
 EIkVxLTcdyL9zRoO/N68g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G7pSkKFD+7Y=:qFnj9/wyEAKXkgd2MvItNT
 auoGcI3dYo9r4srl3fEQwhBCicKYesfqtICFPuoBz4myCN/nQ/Uv/ZPaHFOqtJfhQlAGkRmQD
 xRm7MOKkXAU8/x31EhbqnmYA4uZBJw+0sqxb4IC8y/aLfCGvqVFEtylIF4YMm6zxZU1GBr963
 BbeWgxDe12PmjC8QTXHHDahuQdaumGDqzsraUNuI4jfb86P2P1NhhSMHz/+R4aGcM39veAH2Z
 bZCuHCPNC/4uM4QmIEPuSMpesY3RKJPQNrtOZg4DQbME3vwIvs/e+H/KgFSRFGAZUU+oC5j2P
 OmZ1ul9ML2SlibxPgMRkdAv7mgb3A0GE8J7MckEmo8Otjz/i0qmdT+MPuxVNUU6BtMGUoDZi4
 FZRmxJu20/54g9i4vGo1i/iprU2HawxiZllj/rWwP/LltIK5JiBZSUCOzQy/2UuDyy5pAltAj
 /mDnTsVbnkL8fWXIn/ZEKyT5OoGkUkXWQjioxn4XBiVF6qFeknpJXDkiVD/DB8rAvBrICi8xs
 V7kEfGFnrXABsrFl2aPjO04lMVgyGyi+uvan5gZcb4bEVJo0r+ki9ZU9qMUL7rERBnmCWXkJg
 p3vnN6A905Eg1sZZ7qmKJHtAtkNq/p2ZDxWVbm2CfWVbhKzdUZoyLljNV7Au1aHbxwIuamfwX
 CtKgByLgItlyuimp5A6J5Ev3Yw5EBqYQvRtppUAi44wV+t5NDZ5z8Th43XZYIok+MDQ0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Jonathan Cameron <jic23@kernel.org> schrieb am Sun, 24. Jun 14:10:
> On Sat, 23 Jun 2018 20:54:21 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > add data-ready-delay-ns property for hx711 ADC
> > this is the delay after rising PD_SCK until DOUT is read and assumed to be
> > ready
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> One unconnected change.  I'm not sure it's wrong as such but it should not
> be in this patch.
> 
> > ---
> >  Documentation/devicetree/bindings/iio/adc/avia-hx711.txt | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > index b3629405f568..8c9bcaa4d750 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> > @@ -8,11 +8,18 @@ Required properties:
> >  		See Documentation/devicetree/bindings/gpio/gpio.txt
> >   - avdd-supply:	Definition of the regulator used as analog supply
> >  
> > +Optional properties:
> > + - data-ready-delay-ns:	additional delay in nanoseconds between rising of
> > +			PD_SCK until DOUT is ready
> > +			should be less then maximum PD_SCK high time which
> > +			is 50000 in the datasheet
> > +
> >  Example:
> > -weight@0 {
> > +weight {

The device tree compiler (dtc) gives a warning if there is no reg = <...>
setting. That's why i changed it to be without @0.

Should i create an individual patch for this change in this series or
create another patch which is unrelated to this series?

Andreas

> 
> Change has nothing to do with this patch...
> 
> >  	compatible = "avia,hx711";
> >  	sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> >  	dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> >  	avdd-suppy = <&avdd>;
> > +	data-ready-delay-ns = <1000>;
> >  };
> >  
> 

-- 
