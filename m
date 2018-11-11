Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B27C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65021104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeLCsnT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A65021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeKKVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:43:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKKVnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:43:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0345320871;
        Sun, 11 Nov 2018 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541937294;
        bh=mRBA81kVA/IEwzF4599vYfonGTa0bjeKL/OfE7Hy/gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XeLCsnT9/MPQKEHd3QuiHAbcSV1qlfGMKbV2b3ngqBxymvwOUVq9hRNSQ6+8DBrmm
         0v0X5V2oZ5ym5zLJAt7KURmnZTDrKrxLzyLVH49h0KgMJShH7gSkYJTwzMjV+hCYqP
         by/5CnRlB87KSrBQQk3h21pFleXmHaghDio+wDjU=
Date:   Sun, 11 Nov 2018 11:54:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181111115449.14c415cb@archlinux>
In-Reply-To: <1541778055-7629-1-git-send-email-stefan.popa@analog.com>
References: <1541778055-7629-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 17:40:55 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> There are several ADC drivers that depend on the same device tree
> bindings. Rather than continue to duplicate the properties, this patch
> adds a common adc binding document that can be referenced. For beginning,
> only two properties are documented.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hi Stefan,

Looks good to me.  Given the 'generic' nature of this one though I would
like to leave some time for Rob and other devicetree specialists to sanity
check it.

Thanks,

Jonathan

> ---
> Changes in v2, v3:
> 	- N/A.
> Changes in v4:
> 	- Added this commit.
> 
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
> new file mode 100644
> index 0000000..1e3cc21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
> @@ -0,0 +1,25 @@
> +Common ADCs properties
> +
> +This binding is a work-in-progress
> +
> +Optional properties for child nodes:
> +- bipolar : Boolean, if set the channel is used in bipolar mode.
> +- diff-channels : Differential channels muxed for this ADC. The first value
> +		specifies the positive input pin, the second value the negative
> +		input pin.
> +
> +Example:
> +	adc@0 {
> +		compatible = "some,adc";
> +		...
> +		channel@0 {
> +			bipolar;
> +			diff-channels = <0 1>;
> +			...
> +		};
> +
> +		channel@1 {
> +			diff-channels = <2 3>;
> +			...
> +		};
> +	};

