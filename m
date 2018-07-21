Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2865ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E27120858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyZBujVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E27120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeGURJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 13:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbeGURJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 13:09:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F7920854;
        Sat, 21 Jul 2018 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532189791;
        bh=u3rdW/EbjwRlHKkpkrRMNbj9Jm8TJYPzyLAG3lZ4tsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HyZBujVXiztpbEcagMXxWQwvf/Df5RN78dNO6h8BVTW3uGiipdJeDvur3bw8gsT7+
         URGdD9NnihTGfrsz5zTgODQnmrN1lXJKUsEptKE2xM4LJWlxk2J8CZY0Wb/JVMEhhd
         nVeLJY2opSznSJVhknO1oQOOvEvKAsG/01hwG9w4=
Date:   Sat, 21 Jul 2018 17:16:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <arnaud.pouliquen@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: sigma-delta-modulator: fix
 unit-address in example
Message-ID: <20180721171626.69fb20cf@archlinux>
In-Reply-To: <1532011910-11641-1-git-send-email-fabrice.gasnier@st.com>
References: <1532011910-11641-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 16:51:50 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Device tree compiler gives a warning if a device node has "@"
> but no reg property.
> Fix the example in iio: adc: sigma-delta-modulator.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
to be completely ignored by the autobuilders.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> index ba24ca7..59b92cd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> @@ -7,7 +7,7 @@ Required properties:
>  
>  Example node:
>  
> -	ads1202: adc@0 {
> +	ads1202: adc {
>  		compatible = "sd-modulator";
>  		#io-channel-cells = <0>;
>  	};

