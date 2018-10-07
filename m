Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA7C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126FE20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y3TkYwh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126FE20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJGWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeJGWZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:25:48 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A918320841;
        Sun,  7 Oct 2018 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538925493;
        bh=PE3/6sfnnWWhm8oWlbLk/w/cz7s0w072AhLkGd7g3hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y3TkYwh660vsKX8GQWlfjA1Hb7DdHkQw6wZG+maT+eQfyvlIR0AVBiaJbCY36g68c
         qdBLv75PrKcNTM8ar/k3vJutIndisUwfI6VOXqurvGu/lrFHHvqSrCrCQzq/k66jX4
         yQybQI//lBWrSQ1xvFrf9rLmnWyDc21IC6BL8h1o=
Date:   Sun, 7 Oct 2018 16:18:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: Add PNI RM3100 device tree binding.
Message-ID: <20181007161808.44a61d45@archlinux>
In-Reply-To: <20181002143812.3661-3-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-3-songqiang1304521@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Oct 2018 22:38:11 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
>  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pn=
i,rm3100.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm310=
0.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> new file mode 100644
> index 000000000000..4677690fc5d0
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
> +  The interrupts can be triggered on rising edges.
=46rom Phil's response this appears to be incorrect and
it's actually a level sensitive interrupt.
I haven't checked the data sheet to confirm this.

That'll bring all sorts of pain if you have a host that can only
do edge sensitive so I'm hoping that's not true for you
(edge sensitive only interrupts on hosts are pretty unusual
though it cause me a lot of problems when I started out
with IIO years ago :(

The docs aren't super clear on this.  The subtlety is
whether there is a guaranteed 'low' time between reading the
data and it going high again due to another reading.  This usually
only matters if you are running very quickly though so may be
fine here.

This will only become relevant with continuous mode if you
add support for that later (I think!)

Jonathan

> +
> +Example:
> +
> +rm3100: rm3100@20 {
> +	compatible =3D "pni,rm3100";
> +	reg =3D <0x20>;
> +	interrupt-parent =3D <&gpio0>;
> +	interrupts =3D <4 IRQ_TYPE_EDGE_RISING>;
> +};

