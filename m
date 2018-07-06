Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FAEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D88208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D88208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934235AbeGFUeo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:34:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40467 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGFUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:34:42 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so25702278oie.7;
        Fri, 06 Jul 2018 13:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlcJIGD9nPKaQ/n/ljDl72S+0gmTuP5WFGF6kKlZhPw=;
        b=ujyPHoGMU6VXJtklnGPbA7THIC6xi0CX/8O1TkpCc3Yf4DtvsXotI6cKdsyqKvx2O3
         1ZI15ccHDjZU2vJQIyNHMvKOMY8/wFwUBUhiQFc9Ym3MPQwW548OsSndai35RQ8LL7dn
         nMXNXyMitctpIBxwqpX86Z0D9sM9Wsh34HXqs/3t1UxErSb/KRp/auK0dsvLErGrsddk
         LMD1kyr56efvDYvlb+v3N2VCOhGrVRb9h5oyysPZ+eqJ/puja65SijI/ztCbW/ZpEIYb
         05bn0kUL2FNjzaVm47AG6AvE9V7WAXQjIttAOeYCRUOjwGqf63rvkot044mLlB3xRCIG
         zgoQ==
X-Gm-Message-State: APt69E3EfoABNzPOPP0cLuubbbj3jYRbuNJze9ycWOf9Ylm9+qs4pPU+
        9JjhYTdcsn1WmScmsQEJYA==
X-Google-Smtp-Source: AAOMgpcPSp7ykLQNmi1MQ2Mk3qB/4i0t+iXk/oCykG1caU4e7tfsjeQaNLumCVf1BHv0GvkbcwOA+w==
X-Received: by 2002:aca:3787:: with SMTP id e129-v6mr261509oia.39.1530909281550;
        Fri, 06 Jul 2018 13:34:41 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h124-v6sm5876077oif.15.2018.07.06.13.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:34:40 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:34:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com, wd@denx.de,
        sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v2 2/2] iio: light: Add device tree binding for vishay
 vcnl4035
Message-ID: <20180706203439.GA30529@rob-hp-laptop>
References: <20180628123021.1628338-1-pn@denx.de>
 <20180629153802.1639514-1-pn@denx.de>
 <20180629153802.1639514-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629153802.1639514-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:38:02PM +0200, Parthiban Nallathambi wrote:
> Adding device tree binding for vcnl4035 and vendor
> prefix for Vishay Intertechnology
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  .../devicetree/bindings/iio/light/vcnl4035.txt        | 19 +++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4035.txt b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> new file mode 100644
> index 000000000000..7ffdc0246300
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4035.txt
> @@ -0,0 +1,19 @@
> +VISHAY VCNL4035 -  Ambient Light and proximity sensor
> +
> +Link to datasheet: https://www.vishay.com/docs/84251/vcnl4035x01.pdf
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4035"
> +	-reg: I2C address of the sensor, should be 0x60
> +	- interrupt-parent: should be the phandle for the interrupt controller

Don't need to document this as it could be in a parent node.

> +	- interrupts: interrupt mapping for GPIO IRQ (level active low)
> +
> +Example:
> +
> +vcnl4035@60 {

light-sensor@60

> +	compatible = "vishay,vcnl4035";
> +	reg = <0x60>;
> +	interrupt-parent = <&gpio4>;
> +	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 7cad066191ee..3cc46d5735a9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -395,6 +395,7 @@ v3	V3 Semiconductor
>  variscite	Variscite Ltd.
>  via	VIA Technologies, Inc.
>  virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> +vishay	Vishay Intertechnology, Inc
>  vivante	Vivante Corporation
>  vocore VoCore Studio
>  voipac	Voipac Technologies s.r.o.
> -- 
> 2.14.4
> 
