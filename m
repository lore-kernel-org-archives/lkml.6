Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A376C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0A4217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550510546;
	bh=tFy6+URDfK8niojjjXxzt4OkbTx8Jy2zPvaZo8CCj+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bE9LXJJDu09pdcVXzyvj5Pb0SDv28Sx/vCa+rEJKsaCL/ZE9FKbQL5l1AZTlpE+40
	 Vi2QAD9WQG1bpoWACjZEK1hmbi2JaocaLHTJn+alMxrPh55oDUb9g5aMndTqePmhZA
	 HvvdUDYPKbVth0YVj/+vEYqcv4vuy8owLTC4OF2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388575AbfBRRWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:22:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35865 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBRRWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:22:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id v62so20690847otb.3;
        Mon, 18 Feb 2019 09:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMbz42vrY0PgKSiWNYOOkhkrmrulMiLMIGIK0ymUynU=;
        b=F6D9ALYbtRcwya0W/9HjIs2OIIoqqQMh3Hudlbc/Ts08lw5ZzYxOZfhamGnuM/sRKg
         YZu2CY10BXtQXC/SfosLCIOHKPfkoBfQfYvNirXPduL86p7q1i5I7V3tlLVspl/qM88O
         ZkGdKVjqXhXWM3RSyCimIIOUuGThrGK40ssO9KeRyd5zGTW/RmBgNpDOfPKWByAHI+oD
         I5KppMFyU2f4AGLdjDNiDfkVJXuugoICVJ9xT38EM9OpDDIWLIgGEMX7HL1NG0rOlTni
         l7px6POruzcQqVIjGgKZ8tZoXnmc15Jj3yWnt/bhM2WJWodmFYjLZaLC4tO2TAQWJ7qh
         8+Qg==
X-Gm-Message-State: AHQUAuaW7eP0tSDBdHGlcEkcdsvf1d4VztM93+O3F6UpT/5MZ4dk/Tfv
        y0dlBH9LZT3znJRzpwdGoQ==
X-Google-Smtp-Source: AHgI3IZq2hxmJzlga2d3MPSU5F9LxoOCvzIfm0eng6JAOUcxGKwFc6NYMLO+AflZg0UV0E0Fp4E5kw==
X-Received: by 2002:a05:6830:1255:: with SMTP id s21mr12710955otp.18.1550510542992;
        Mon, 18 Feb 2019 09:22:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w202sm6664709oie.48.2019.02.18.09.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 09:22:22 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:22:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: Add Stingray USB PHY binding
 document
Message-ID: <20190218172221.GA20334@bogus>
References: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
 <1549474347-7224-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549474347-7224-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:02:25PM +0530, Srinath Mannam wrote:
> Add DT binding document for Stingray USB PHY.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> new file mode 100644
> index 0000000..bfe1367
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> @@ -0,0 +1,62 @@
> +Broadcom Stingray USB PHY
> +
> +Required properties:
> + - compatible : should be one of the listed compatibles
> +	- "brcm,sr-usb-phy"
> +	- "brcm,sr-usb-phy-v2"

SoC specific compatibles are preferred. Version numbers can be used but 
should follow some documented scheme and be meaningful. What we don't 
want is just Linux developers making up numbering.

> + - reg: offset and length of the PHY blocks registers
> + - address-cells: should be 1
> + - size-cells: should be 0
> +
> +Sub-nodes:
> +  Each port's PHY should be represented as a sub-node.
> +
> +Sub-nodes required properties:
> + - reg: required for brcm,sr-usb-phy model phy.
> +	reg value 0 is HS phy and 1 is SS phy.
> + - phy-cells: generic PHY binding; must be 0
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +	usbphy0: usb-phy@0 {
> +		compatible = "brcm,sr-usb-phy";
> +		reg = <0x00000000 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb0_phy0: phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;

Unless there's DT resources for each child node, you don't need these. 
Just make #phy-cells 1 in the parent.

Rob
