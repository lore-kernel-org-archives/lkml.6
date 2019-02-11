Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E799AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E2721874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfBKUWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:22:20 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53318 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfBKUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:22:19 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id E6BEB9E749A;
        Mon, 11 Feb 2019 20:22:16 +0000 (GMT)
Date:   Mon, 11 Feb 2019 20:22:14 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        johan@kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: chemical: pms7003: add device
 tree support
Message-ID: <20190211202214.0b6146a5@archlinux>
In-Reply-To: <20190209173609.13220-4-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
        <20190209173609.13220-4-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:36:09 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add device tree support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

I'll be doing a pull request pretty soon on this given where we are
in the cycle.  If anyone has last minute reviews, there is still a little
time.

Thanks,

Jonathan

> ---
>  .../iio/chemical/plantower,pms7003.txt        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt b/Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
> new file mode 100644
> index 000000000000..7b5f06f324c8
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
> +- plantower,set-gpios: phandle to the GPIO connected to the SET line
> +- reset-gpios: phandle to the GPIO connected to the RESET line
> +
> +Refer to serial/slave-device.txt for generic serial attached device bindings.
> +
> +Example:
> +
> +&uart0 {
> +	air-pollution-sensor {
> +		compatible = "plantower,pms7003";
> +		vcc-supply = <&reg_vcc5v0>;
> +	};
> +};

