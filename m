Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A609C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283E421836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544957169;
	bh=0JjTDN6qr3Tce59/pmuEfIq6nCbGef6ybs32eZvbMAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KYcdzcbcLGjR1M3QsvnOy/27DFLj6lD9PMPzaJqWG/sXzY3Mw3rd/tX/EdaWuFPya
	 5knif5Fy47V7iwCbyiySLc3B0wsQg8VKoxcYw11oCHbGPlPwOn6jdhGfJNmpkCi3zC
	 WiOx+MClB9m6eeVL2U2CCVNKPVTtTUPU3HhCMi5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeLPKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 05:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbeLPKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 05:46:07 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20AF2086C;
        Sun, 16 Dec 2018 10:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544957167;
        bh=0JjTDN6qr3Tce59/pmuEfIq6nCbGef6ybs32eZvbMAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rlgYujXdU8aR9QYZrLPaMHXbGcaaP3O+8yr6xx+EmDtZFW9QXbzM4PIuT3XjLWgW1
         knS2PNa6jdQuMeXymlDWeFnLBAVzNRmlMTbVUF5uQbiIZkG2ZRrLLot4fUdeK/PJnt
         tRZIMJJ+szM7CemPjSM1kiH+N2F6/uekRF7iF8xI=
Date:   Sun, 16 Dec 2018 10:46:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: iio: accel: mma8452: add optional
 power supply property
Message-ID: <20181216104600.32d90291@archlinux>
In-Reply-To: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
References: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 05:13:14 +0000
Anson Huang <anson.huang@nxp.com> wrote:

> The accelerometer's power supply could be controlled by regulator
> on some platforms, add optional property "vdd/vddio" power supply
> to let device tree to pass phandles to the regulators to driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

I'll not be pushing this out as non rebasing for a week or so
hence plenty of time to add additional reviews.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/accel/mma8452.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> index 2100e9a..e132394 100644
> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> @@ -20,6 +20,10 @@ Optional properties:
>    - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
>  		     interrupt line in use.
>  
> +  - vdd-supply: phandle to the regulator that provides vdd power to the accelerometer.
> +
> +  - vddio-supply: phandle to the regulator that provides vddio power to the accelerometer.
> +
>  Example:
>  
>  	mma8453fc@1d {

