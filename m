Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F39C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0862620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544477230;
	bh=xzuAk5MgjGWBpwKkJOg5g452En9rpJvZbkfl2qy+jYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YPL9oQ8kBfszmY78jQSTuEtBdKNPZ862WYJJ+IzLRKRtmHfBRekOMWw+CFJNm3l7q
	 M6vgEIvsGE3zQgwjY/95xI261+t8WKFCv2wu05Ahsqdin1ZWzCfdfUckruxIn2TlbQ
	 Xrbc2rnlvSiZOdjyc8R90nfG+8TJgAPHphFs7Odc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0862620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeLJV1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbeLJV1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:27:08 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2F220821;
        Mon, 10 Dec 2018 21:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544477227;
        bh=xzuAk5MgjGWBpwKkJOg5g452En9rpJvZbkfl2qy+jYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JHbWgKZO/XklrHtkrkq1Zpbo8lbMy/WqjhDaBMrnmjNi1huNUlbAHi94OboRBx2RM
         oHbckakq3x005HJDSaubQzgMUdIAdHYH6vbi50uFXcjIRg3vJ0EKKPWAETmI0Gboz1
         AvfepVeUhY+LmMXmIKGsP4FPKMkMsBTSbHObDhB8=
Date:   Mon, 10 Dec 2018 21:27:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181210212702.4160ff1f@archlinux>
In-Reply-To: <348cbe2abbe256b66ed830bd1abb9fc50bf4d10e.1544292845.git.marcelo.schmitt1@gmail.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
        <348cbe2abbe256b66ed830bd1abb9fc50bf4d10e.1544292845.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 16:19:59 -0200
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Add a devicetree documentation for the ad5933 and ad5934 impedance
> converter, network analyzer.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
Device tree binding patches need to also go to the DT maintainers and list
for review.

This looks fine to me but they are the specialists in these!

+cc Rob, Mark and DT list.

Jonathan
> ---
>  .../iio/impedance-analyzer/ad5933.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> new file mode 100644
> index 000000000000..5ff38728ff91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
> @@ -0,0 +1,26 @@
> +Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
> +
> +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
> +https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
> +
> +Required properties:
> + - compatible : should be one of
> +		"adi,ad5933"
> +		"adi,ad5934"
> + - reg : the I2C address.
> + - vdd-supply : The regulator supply for DVDD, AVDD1 and AVDD2 when they
> +   are connected together.
> +
> +Optional properties:
> +- clocks : external clock reference.
> +- clock-names : must be "mclk" if clocks is set.
> +
> +Example for a I2C device node:
> +
> +	impedance-analyzer@0d {
> +		compatible = "adi,adxl345";
> +		reg = <0x0d>;
> +		vdd-supply = <&vdd_supply>;
> +		clocks = <&ref_clk>;
> +		clock-names = "mclk";
> +	};

