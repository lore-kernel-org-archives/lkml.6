Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B5C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990E42086C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbeLPMQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 07:16:37 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:54344 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeLPMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 07:16:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 98FA59E7478;
        Sun, 16 Dec 2018 12:16:33 +0000 (GMT)
Date:   Sun, 16 Dec 2018 12:16:31 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181216121631.5b30831f@archlinux>
In-Reply-To: <20181210212702.4160ff1f@archlinux>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
        <348cbe2abbe256b66ed830bd1abb9fc50bf4d10e.1544292845.git.marcelo.schmitt1@gmail.com>
        <20181210212702.4160ff1f@archlinux>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 21:27:02 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 8 Dec 2018 16:19:59 -0200
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Add a devicetree documentation for the ad5933 and ad5934 impedance
> > converter, network analyzer.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> > Co-Developed-by: Gabriel Capella <gabriel@capella.pro>  
> Device tree binding patches need to also go to the DT maintainers and list
> for review.
> 
> This looks fine to me but they are the specialists in these!
> 
> +cc Rob, Mark and DT list.

Long enough I think.  This will be in my tree in a fashion I can rebase for
a week or so anyway so please still feel free to comment.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
> Jonathan
> > ---
> >  .../iio/impedance-analyzer/ad5933.txt         | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> > new file mode 100644
> > index 000000000000..5ff38728ff91
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> > @@ -0,0 +1,26 @@
> > +Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
> > +
> > +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
> > +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
> > +
> > +Required properties:
> > + - compatible : should be one of
> > +		"adi,ad5933"
> > +		"adi,ad5934"
> > + - reg : the I2C address.
> > + - vdd-supply : The regulator supply for DVDD, AVDD1 and AVDD2 when they
> > +   are connected together.
> > +
> > +Optional properties:
> > +- clocks : external clock reference.
> > +- clock-names : must be "mclk" if clocks is set.
> > +
> > +Example for a I2C device node:
> > +
> > +	impedance-analyzer@0d {
> > +		compatible = "adi,adxl345";
> > +		reg = <0x0d>;
> > +		vdd-supply = <&vdd_supply>;
> > +		clocks = <&ref_clk>;
> > +		clock-names = "mclk";
> > +	};  
> 

