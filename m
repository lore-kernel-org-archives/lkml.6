Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301B8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A920880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84A920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIZC5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:57:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44693 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZC5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:57:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id u74-v6so1359938oia.11;
        Tue, 25 Sep 2018 13:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L3qpSPhnRUzzT/9HvPYo3BTHZAfU21DU5TeTbcdqHu4=;
        b=URYWHOoss6dDU8LjPFNfeFS3OstUOrhFHHGiavRJBz/peI7/3Cu9AV/A9qm/nXGcpV
         uDZHxxg6ClriHw3/Qu+O3skdEx/vWfgITKOLvpalbqIHRsqRKCmfYHkxyG5lgqaZd0Iy
         Kf8zaO298gwlS7MvcUgFb9jmL+KX+CXoVhHVBSzAxKZI/Ze7oldhVDazaDbV9f5Ia0jm
         5TRwmg6ugqlH3PFlt+QFuQOO2Qcl5+2qasjQORijROh9tMk3i+V8MvFRDFONYlD25uFN
         bsEm1G2tpdkmTfDl55n4v+CzPl9QfxFeDDTOM+0ogwzauAHGBhiM2BkDoPFPlMGLkm1n
         pcTg==
X-Gm-Message-State: ABuFfoi3cCZHAaqu+Qa4ESjQriiQYHeyR9oIQh/GepLd07+jKvfSBOFU
        DEfXambSa82YlFo8U2lRrkZVldWasw==
X-Google-Smtp-Source: ACcGV62OQ+TmGIc34vuo88TXyvkY9OZypIpdaBAjZIQ3ZauO6B0yXaPbmacvNd3y9U/gSiasRqN2vQ==
X-Received: by 2002:aca:42c4:: with SMTP id p187-v6mr1724521oia.306.1537908495841;
        Tue, 25 Sep 2018 13:48:15 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q39-v6sm1208052otb.36.2018.09.25.13.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:48:14 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:48:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/8] dt-binding: mtd: Document gpio-addr-flash
Message-ID: <20180925204813.GA6450@bogus>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
 <20180905143643.9871-9-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905143643.9871-9-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:36:43PM +0200, Ricardo Ribalda Delgado wrote:
> Add documentation for gpio-addr-flash. This binding allow creating
> flash devices that are paged using GPIOs.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  .../bindings/mtd/gpio-addr-flash.txt          | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> new file mode 100644
> index 000000000000..4279e8cad09b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> @@ -0,0 +1,46 @@
> +Memory Mapped flash with some address lines addressed using GPIOs
> +
> +Handle the case where a flash device is mostly addressed using physical
> +line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
> +to a 2MiB memory range and use the GPIOs to select a particular range.
> +
> + - compatible : "cfi-gpio-addr-flash"
> + - reg : Address range of the mtd chip that is memory mapped, this is,
> +   on the previous example 2MiB.
> + - bank-width : Width (in bytes) of the bank.  Equal to the
> +   device width times the number of interleaved chips.
> + - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
> +   is going to be probed. If omitted, assumed to be equal to "cfi_probe".

Why not just a bool prop for jedec mode? As-is, the '_probe' part is 
redundant.

> + - #address-cells, #size-cells : Must be present if the device has
> +   sub-nodes representing partitions (see below).  In this case
> +   both #address-cells and #size-cells must be equal to 1.

Perhaps most importantly, where's 'gpios' property?

> +
> +The device tree may optionally contain sub-nodes describing partitions of the
> +address space. See partition.txt for more detail.
> +
> +Example:
> +
> +	cfi_flash_0: cfi_flash {

flash@300000

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "cfi-gpio-addr-flash";
> +		bank-width = <2>;
> +		reg = < 0x00300000 0x00200000 >;
> +		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
> +		partition@0 {

All these under a partitions node is now recommended.

> +			reg = < 0x0 0x200000 >;
> +			label = "Golden Bitstream";
> +		};
> +		partition@200000 {
> +			reg = < 0x200000 0x200000 >;
> +			label = "User Bitstream";
> +		};
> +		partition@400000 {
> +			reg = < 0x400000 0x200000 >;
> +			label = "V4L Controls";
> +		};
> +		partition@600000 {
> +			reg = < 0x600000 0x200000 >;
> +			label = "Production Data";
> +		};
> +	} ;
> -- 
> 2.18.0
> 
