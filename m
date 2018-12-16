Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E25EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE94217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544967350;
	bh=W8AISbphBQAC5NHYB15Oq1ceqTuNjgy/iySOrSIXAQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DNC485X+X6FxsdYLW2NL8l6ZNyCYkORQsBBs19vPXF36CsmjIyoaxeIzDb5Hzt8nk
	 en7iBY3/jsjnUfOfoxL/xX9qN04wYqBqf0AUT8eU7Kb2yzEdZNzegZq16ycY1GQI4v
	 I2EflnxHxPmkMKBAD7Z9Pj1OBRHgmYkD4lRD0E7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeLPNft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbeLPNft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:35:49 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24C81217F9;
        Sun, 16 Dec 2018 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544967348;
        bh=W8AISbphBQAC5NHYB15Oq1ceqTuNjgy/iySOrSIXAQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qg7dxpc+19n43T0kOF0BI9QbsNTJM+KC9gyKbw2xfLsW/WW/QtgFOQz2DTRFFp+uI
         MGpIsX2s9ZAxgTNaW5ATyzaYx5wTrb/RrLWKDgmHnXxkHs71YNUsuZKIBrP6TFb8eu
         DWeukV7/9b6iTLHZowtLnMx37XoDtlphx/9YZkTk=
Date:   Sun, 16 Dec 2018 13:35:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: Re: [PATCH v3 3/3] iio: chemical: sgp30: add device tree support
Message-ID: <20181216133543.5c560f71@archlinux>
In-Reply-To: <20181213144418.24965-1-andreas.brauchli@sensirion.com>
References: <20181213144418.24965-1-andreas.brauchli@sensirion.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 15:44:18 +0100
Andreas Brauchli <a.brauchli@elementarea.net> wrote:

> Add device tree support for Sensirion SGP30/SGPC3 gas sensors.
> 
> Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note this missed (by about a week) the cut off for the current
cycle, so this will be in the second one of the new year.

Jonathan

> ---
>  .../bindings/iio/chemical/sensirion,sgp30.txt     | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
> new file mode 100644
> index 000000000000..5844ed58173c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
> @@ -0,0 +1,15 @@
> +* Sensirion SGP30/SGPC3 multi-pixel Gas Sensor
> +
> +Required properties:
> +
> +  - compatible: must be one of
> +    "sensirion,sgp30"
> +    "sensirion,sgpc3"
> +  - reg: the I2C address of the sensor
> +
> +Example:
> +
> +gas@58 {
> +	compatible = "sensirion,sgp30";
> +	reg = <0x58>;
> +};

