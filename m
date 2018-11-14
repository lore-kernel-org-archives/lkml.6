Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B603822419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B603822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeKNU77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:59:59 -0500
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:42958 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728141AbeKNU76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:59:58 -0500
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 9755D634C7D;
        Wed, 14 Nov 2018 12:57:12 +0200 (EET)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1gMsrA-0005fE-DU; Wed, 14 Nov 2018 12:57:12 +0200
Date:   Wed, 14 Nov 2018 12:57:12 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: media: i2c: Fix external clock frequency
 for OV5645
Message-ID: <20181114105712.j5jkspfasujiyqzs@valkosipuli.retiisi.org.uk>
References: <20181114103935.24559-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114103935.24559-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On Wed, Nov 14, 2018 at 04:09:35PM +0530, Manivannan Sadhasivam wrote:
> Commit "4adb0a0432f4 media: ov5645: Supported external clock is 24MHz"
> modified the external clock frequency to be 24MHz instead of the
> 23.88MHz in driver. Hence, make the same change in corresponding bindings
> doc and mention the acceptable tolerance.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> index fd7aec9f8e24..b155583469a4 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> @@ -8,7 +8,8 @@ Required Properties:
>  - compatible: Value should be "ovti,ov5645".
>  - clocks: Reference to the xclk clock.
>  - clock-names: Should be "xclk".
> -- clock-frequency: Frequency of the xclk clock.
> +- clock-frequency: Frequency of the xclk clock. Should be 24MHz with 1%
> +                   acceptable tolerance.

DT bindings are for documenting the hardware, not the driver implementation.
The sensor supports a range AFAIU, not a specific frequency.

The bit below seems good.

>  - enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
>    to the hardware pin PWDNB which is physically active low.
>  - reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> @@ -37,7 +38,7 @@ Example:
>  
>  			clocks = <&clks 200>;
>  			clock-names = "xclk";
> -			clock-frequency = <23880000>;
> +			clock-frequency = <24000000>;
>  
>  			vdddo-supply = <&camera_dovdd_1v8>;
>  			vdda-supply = <&camera_avdd_2v8>;
> -- 
> 2.17.1
> 

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
