Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E83C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FDA20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FDA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeKYTuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 14:50:18 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34518 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeKYTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 14:50:18 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id C9B7B9E76F8;
        Sun, 25 Nov 2018 08:59:40 +0000 (GMT)
Date:   Sun, 25 Nov 2018 08:59:39 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: sps30: add device tree support
Message-ID: <20181125085939.421523d6@archlinux>
In-Reply-To: <20181124221415.10081-4-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
        <20181124221415.10081-4-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018 23:14:15 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add device tree support for Sensirion SPS30 particulate
> matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
one comment inine, around the fact we are trying to move
to generic names in DT where ever possible.  Now we don't
have a suitable one (IIRC) yet so time to make one up ;)

+CC Rob for his input on that.
> ---
>  .../bindings/iio/chemical/sensirion,sps30.txt        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> new file mode 100644
> index 000000000000..6eee2709b5b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.txt
> @@ -0,0 +1,12 @@
> +* Sensirion SPS30 particulate matter sensor
> +
> +Required properties:
> +- compatible: must be "sensirion,sps30"
> +- reg: the I2C address of the sensor
> +
> +Example:
> +
> +sps30@69 {
We should define a generic type.  Rob, what would work for this
one?

particlesensor@69?

> +	compatible = "sensirion,sps30";
> +	reg = <0x69>;
> +};

