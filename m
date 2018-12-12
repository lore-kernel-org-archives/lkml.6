Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17EEC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D3620851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544634272;
	bh=RGd5sItPu2V2cSmpAXaNI9TfO6umVQl4F6hBOZfXOsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wt5gAuSIVBrHgqZvoE52/427UlgZSQjJPhrTwBY1s4COgfotsomgB8CoDVU58YKrR
	 f3ENJvOZIJP9YUe2ZLST6POrDj9G3rLdyt9qKcWWWld8IuS2/cXhtZnijzCebhkQx5
	 ksLmnOmMZBJeEyegMA8eHf5SBO7KoUHXxE8BE6gY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D3620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbeLLREb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbeLLREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:04:31 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EB62080F;
        Wed, 12 Dec 2018 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544634270;
        bh=RGd5sItPu2V2cSmpAXaNI9TfO6umVQl4F6hBOZfXOsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mk31a5lMTvTNZ/OFSFAovnUYulKiHQd/kjpYPyyn0JTh89vr0gCXDcLlkVSBlGzME
         bbEQRKq07KsSBZmqO9U+cQnUpumtFNNLCIUtTZsliOAqd9jAh2NZqKW5rLa9RQsEtm
         ClBWmnYf0v5Ic4dPGs9hd2gs4eHHttJsD5hZzAaQ=
Date:   Wed, 12 Dec 2018 17:04:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Message-ID: <20181212170425.49658e0c@archlinux>
In-Reply-To: <1544504196-30277-1-git-send-email-Anson.Huang@nxp.com>
References: <1544504196-30277-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 05:02:39 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> According to datasheet, the isl29018 has "vddd/vdda" power
> supply, the "vdda" and "vddd" MUST be shorted externally,
> and isl29023/isl29035 ONLY has "vdd" power supply, so just
> one regulator is needed for the driver, update the power
> supply name with "vdd" according to datasheet to avoid
> confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Given the discussion on v4 I am assuming this should be dropped.
Shout if I'm missing something.

Jonathan

> ---
> ChangeLog since V4:
> 	Since ONLY isl29018 has two power supplies and they are MUST shorted externally, so they can be
> 	treated as one power supply as well, remove "vdda" power supply and ONLY update the "vcc" with
> 	"vdd" according to datasheet.
> ---
>  Documentation/devicetree/bindings/iio/light/isl29018.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.txt b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> index b9bbde3..c4c4e9e 100644
> --- a/Documentation/devicetree/bindings/iio/light/isl29018.txt
> +++ b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> @@ -15,7 +15,7 @@ Optional properties:
>    Refer to interrupt-controller/interrupts.txt for generic interrupt client
>    node bindings.
>  
> -  - vcc-supply: phandle to the regulator that provides power to the sensor.
> +  - vdd-supply: phandle to the regulator that provides power to the sensor.
>  
>  Example:
>  

