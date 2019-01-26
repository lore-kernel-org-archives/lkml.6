Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC28DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A875A21908
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548536659;
	bh=7i0WMu3uVIRhptRBIe5hWOeWOLcrUDxzbBgeAEBi+ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KK0j5F1eFqCalkdaxHy9/wBK7qTMeMppF1SYRvvVR6lu7ocg8jzpPqHdCXCw6M7SQ
	 vE/LHE7GR0P3quGBUjYn9DljUOMccPG+khjIwbn+dJrErAupzftn1WCRC2Bq8LMarN
	 zufrQuMNCfvrQ0e8nEEjt0vPsFK49/rNBZIKBcmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAZVES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:04:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfAZVER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:04:17 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C1120989;
        Sat, 26 Jan 2019 21:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548536656;
        bh=7i0WMu3uVIRhptRBIe5hWOeWOLcrUDxzbBgeAEBi+ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aqwi3VMBHGFqwKK92N8lprjr83JX6B8yxSm+yaMyBve213qeLQajv918gG4ELmAiT
         O4S+V5KOl/On/qwEOsRiNKju6KzFuvnRPQZuFB2Ffg2kYQ8dqyhKwmlcO84vcNYAq4
         eLKtx8LgyvZ4cX45kTaUv8pLdYcgs8uNfE+tY4XM=
Date:   Sat, 26 Jan 2019 21:04:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Add device tree binding documentation for
 MAX44009
Message-ID: <20190126210411.1efcde38@archlinux>
In-Reply-To: <7201ee3e0e1c119fa521ed33793be96eaa0eb159.1548529751.git.bobbyeshleman@gmail.com>
References: <3de73cb366285113e0e7c2e1938d15b7c3981891.1548529751.git.bobbyeshleman@gmail.com>
        <7201ee3e0e1c119fa521ed33793be96eaa0eb159.1548529751.git.bobbyeshleman@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2019 11:16:21 -0800
Robert Eshleman <bobbyeshleman@gmail.com> wrote:

> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
Looks good to me.  As we are going for a v3 due to patch 1, plenty
of time for others to comment.

Thanks,

Jonathan
> ---
>  .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
> new file mode 100644
> index 000000000000..b287d7732e37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
> @@ -0,0 +1,25 @@
> +* MAX44009 Ambient Light Sensor
> +
> +Required properties:
> +
> +- compatible: should be "maxim,max44009"
> +- reg: the I2C address of the device (default is <0x4a>)
> +
> +Optional properties:
> +
> +- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
> +  IRQ_TYPE_EDGE_FALLING.
> +
> +Refer to interrupt-controller/interrupts.txt for generic interrupt client
> +node bindings.
> +
> +Example:
> +
> +max44009: max44009@4a {
> +	compatible = "maxim,max44009";
> +	reg = <0x4a>;
> +
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
> +};
> +

