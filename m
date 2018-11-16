Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FCB2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2oRO3EPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FCB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbeKQEwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:52:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeKQEwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:52:14 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3718720869;
        Fri, 16 Nov 2018 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542393523;
        bh=DrldKMhIgrhuGyXS6DpXoJAxDNiy9Mba8OkWY0OOFGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2oRO3EPAVMbK/jHArnRHj3GxkNbiJd1qD9+AkFNuWa2skQZVcBevV72GUoD+OXJWA
         zmUTzs9MAw6MOLMkNN2kzalKSMZx9D9xu8Tbm4i8OvH2RdL5qNRU1M4qH7lRPnzjQk
         um0rJ4uJJ3TM68YxFI4GmL7kASTEXUOi0+OXUx4E=
Date:   Fri, 16 Nov 2018 18:38:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181116183838.6a079255@archlinux>
In-Reply-To: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 13:21:01 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> There are several ADC drivers that depend on the same device tree
> bindings. Rather than continue to duplicate the properties, this patch
> adds a common adc binding document that can be referenced. For beginning,
> only two properties are documented.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks very sensible to me, but as we are looking at a some generalization
here, I'd like an Ack from Rob if possible (as he suggested it I think :)

Thanks,

Jonathan

> ---
> Changes in v2, v3:
> 	- N/A.
> Changes in v4:
> 	- Added this commit.
> Changes in v5:
> 	- Nothing changed.
> 
>  Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
> new file mode 100644
> index 0000000..5bbaa33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
> @@ -0,0 +1,23 @@
> +Common ADCs properties
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

