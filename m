Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEFBECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D845E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFkSuzfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D845E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIYCMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeIYCMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:12:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BAA2087A;
        Mon, 24 Sep 2018 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537819733;
        bh=vSeF3cFPebkDmYwy0e7NoFNbxoQ0onhcdBlPruPCBqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UFkSuzfo7PrPmzEIk2PX17unrBaMaYeX2LZa2JITjPWKCZcUHmByIP6UqhbFyh2SJ
         GgvnlzmnH+LtC728kfByg+KWAvmtKlHz5DnHa7qpmfQuQjrK1SHcipN/XoAQmzuneR
         7Dfn5k6lL7VcFdMsaV2OMVQItBbolghX0YvrhzOI=
Date:   Mon, 24 Sep 2018 21:08:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ryang <decatf@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add device tree
 binding documentation
Message-ID: <20180924210849.373f765e@archlinux>
In-Reply-To: <20180922205754.6100-1-decatf@gmail.com>
References: <20180922205754.6100-1-decatf@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 16:57:53 -0400
ryang <decatf@gmail.com> wrote:

> Document device tree bindings for ROHM BH1750 ambient light sensor driver.
> 
> Signed-off-by: ryang <decatf@gmail.com>
The devicetree maintainers haven't yet had a chance to look at this
so we may well still get feedback from them.  As I'm not planning on a
pull request for a few days I'll apply this to the tree I push out
as testing for the autobuilders to play with.  The advantage if this
is that isn't a non rebasing tree so I can add acks if they come in
before I push it out as togreg ready for a pull request.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/light/bh1750.txt   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/bh1750.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.txt b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> new file mode 100644
> index 000000000000..468350cc7af6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/bh1750.txt
> @@ -0,0 +1,18 @@
> +ROHM BH1750 - ALS, Ambient light sensor
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +    "rohm,bh1710"
> +    "rohm,bh1715"
> +    "rohm,bh1721"
> +    "rohm,bh1750"
> +    "rohm,bh1751"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +bh1750@23 {
> +	compatible = "rohm,bh1750";
> +	reg = <0x23>;
> +};

