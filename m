Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4658C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2EA21479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve7etCE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2EA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeKLANY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbeKLANX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:13:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B10208A3;
        Sun, 11 Nov 2018 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541946281;
        bh=S84olWzloA2eL/TKcUTClryXE2HKtkSQH5HjLz3BSOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ve7etCE7vQVESlqxjmP+G8SUjcbIz9WX6mG7jAKfGFuEjwI2Rf/o1LOhyAHOUSS7L
         bXVI1ZOnxrzg1RmVc+eIgxoX3fKOPO68I+Xp8ikp1lKMRroJGvn35QkTlTJCNr6eBS
         jja6F+iAJvl3JT3txWhaGQHma/aYDbx4ZNsZqhJs=
Date:   Sun, 11 Nov 2018 14:24:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: magnetometer: Add DT support for PNI RM3100
Message-ID: <20181111142435.136f420e@archlinux>
In-Reply-To: <20181108092749.12167-3-songqiang1304521@gmail.com>
References: <20181108092749.12167-1-songqiang1304521@gmail.com>
        <20181108092749.12167-3-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 17:27:48 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> new file mode 100644
> index 000000000000..497c932e9e39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> @@ -0,0 +1,20 @@
> +* PNI RM3100 3-axis magnetometer sensor
> +
> +Required properties:
> +
> +- compatible : should be "pni,rm3100"
> +- reg : the I2C address or SPI chip select number of the sensor.
> +
> +Optional properties:
> +
> +- interrupts: data ready (DRDY) from the chip.
> +  The interrupts can be triggered on level high.
> +
> +Example:
> +
> +rm3100: rm3100@20 {
> +	compatible = "pni,rm3100";
> +	reg = <0x20>;
> +	interrupt-parent = <&gpio0>;
> +	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +};

