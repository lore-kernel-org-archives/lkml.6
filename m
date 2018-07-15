Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A727ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190D4208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kziFl8TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190D4208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeGOJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeGOJVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:21:30 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5820882;
        Sun, 15 Jul 2018 08:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531645157;
        bh=v6D9XAbs0ytIya3u1Y5qjQm1RMy+e7Eeu+o7mZ42TuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kziFl8TG3jTwJ5tiH/ww+nRnznqd98UEeJi+tQso24mAJxvah29dCl8o7xIxFXeV2
         9xlgh11cgP+vL5IPWLPeTFK0e27ADHR/GSU7fj2nBwwRAIgFdJI9geJe8/bJZACThL
         j8EO2xEmvnopHQ2JsmpKhGJnRiCQktlZAuJJtzFw=
Date:   Sun, 15 Jul 2018 09:59:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: remove unused options from
 device tree documentation
Message-ID: <20180715095912.03628b43@archlinux>
In-Reply-To: <20180711013345.22951-1-masneyb@onstation.org>
References: <20180711013345.22951-1-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 21:33:45 -0400
Brian Masney <masneyb@onstation.org> wrote:

> There are several options in the device tree documentation that are
> no longer relevant for the current in-kernel bmp280 driver so this patch
> removes them.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Fair enough I guess - though this may confuse anyone looking at
new docs and running an old kernel with the misc driver still there.

Applied to the togreg branch of iio.git
> ---
>  Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> index c7198a03c906..abcab02504fb 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> @@ -8,10 +8,6 @@ Required properties:
>    "bosch,bme280"
>  
>  Optional properties:
> -- chip-id: configurable chip id for non-default chip revisions
> -- temp-measurement-period: temperature measurement period (milliseconds)
> -- default-oversampling: default oversampling value to be used at startup,
> -  value range is 0-3 with rising sensitivity.
>  - interrupt-parent: should be the phandle for the interrupt controller
>  - interrupts: interrupt mapping for IRQ
>  - reset-gpios: a GPIO line handling reset of the sensor: as the line is
> @@ -24,9 +20,6 @@ Example:
>  pressure@77 {
>  	compatible = "bosch,bmp085";
>  	reg = <0x77>;
> -	chip-id = <10>;
> -	temp-measurement-period = <100>;
> -	default-oversampling = <2>;
>  	interrupt-parent = <&gpio0>;
>  	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>  	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;

