Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6BBC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B05220869
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549127575;
	bh=mKkYrcDRCZK6vi4IUz1PeXhVZ5SIiQanZCGwD+JfiqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RCfZfdDlMw36TUgLa+9DDX0ucoAnTrsxKcUf0T9DLKyJt6c9vQ1hzL0eF71Tdtww/
	 htYMnWuH3deubB9i0zeQrtmILYikaShd0U7E0vrFw/phVThTCKMLm9ZZdDfsvn5a3Y
	 2LtF/7o2WG1Fccv5ZioknUm9+D9A4TayHkLOzTDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBBRMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:12:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfBBRMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 12:12:53 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D242083B;
        Sat,  2 Feb 2019 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549127572;
        bh=mKkYrcDRCZK6vi4IUz1PeXhVZ5SIiQanZCGwD+JfiqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RYwwlF3JkaJj5DDOI316E1r7zGnQA3dk8EbQIRY2tLv3xx2gfV4EJX1roHRPc96pc
         rK7CfJh9QI3OUNKBX2zU3pPO5F9b7HVIaANMlYWECLABl88iaUiAr3xhk+JpP8TG3z
         1zAS6GII8drWC1yLjey1lJPJvcoHThdRfwFEqvjU=
Date:   Sat, 2 Feb 2019 17:12:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        johan@kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190202171247.0d0fc122@archlinux>
In-Reply-To: <20190201215759.14569-4-tduszyns@gmail.com>
References: <20190201215759.14569-1-tduszyns@gmail.com>
        <20190201215759.14569-4-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Feb 2019 22:57:59 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add device tree support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Hi Tomasz,

Sorry, I clearly didn't look at this in enough detail on earlier versions.
I think the set gpio is rather device specific so should have a vendor
prefix.

I would also like to get an opinion on the generic name from the devicetree
maintainers before we start to standardise on it.

Thanks,

Jonathan

> ---
>  .../iio/chemical/plantower,pms7003.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> new file mode 100644
> index 000000000000..cbad95480e04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> @@ -0,0 +1,20 @@
> +* Plantower PMS7003 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "plantower,pms7003"
> +- vcc-supply: phandle to the regulator that provides power to the sensor
> +
> +Optional properties:
> +- set-gpios: phandle to the GPIO connected to the SET line

Hmm. This is a somewhat 'unusual' one so should probably have a vendor prefix.

> +- reset-gpios: phandle to the GPIO connected to the RESET line

reset is common and clear in meaning, so vendor prefix probably not appropriate.
> +
> +Refer to serial/slave-device.txt for generic serial attached device bindings.
> +
> +Example:
> +
> +&uart0 {
> +	air-pollution-sensor {
> +		vcc-supply = <&reg_vcc5v0>;
> +		compatible = "plantower,pms7003";
> +	};
> +};

