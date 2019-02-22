Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F12C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05794206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550856047;
	bh=D8EnPKFR3X8dzJ/hoAnOfEHNaI7qH+KTOpbB7ztyhOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XTOidriB39ESptmPIBILMW2pxDWb8Bv+ImnD1M4DdsfpCoSJHZP0fH+Yyt3cor8Mg
	 7sraNLpv7Xp9EH1Xk05+dFby4DBq24xCePkn/LCMFx33bWGy2e9xronEV7ktMIaHTd
	 /O6QETV9j7vNoWRE8w87LioP1QfxQPFcVK579Zqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBVRUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:20:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43489 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVRUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:20:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so2463845ota.10;
        Fri, 22 Feb 2019 09:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+6PQVz+hofPrn+IpfsdSIwY94GTB3FGTaHYrCEjmOiA=;
        b=But9dFO9zSPs7tAwm24/v8OuYnn/fWcXMAfwKJthmJkHY26cNAxCFhlWimR51hn5VL
         ZHnraKhf08T5YgcBJBbVboAgBxRZCCXa5T7SkL0EFO4qao4gAqyemu7dh1dASn2+IQJl
         GEwHI6h+b3xH4vLKdauz/IXj5rL1B/kaUgrdUNtnaIgrF0Wztz21wcXz865tBsEJusjY
         ON8Nw2tvnbz8Ka/HCy8X0X9VypkvsjaGEUX4YM/TwDwD5ZIcregjgdW8JD7aaaSzqQsp
         XH4JLy7QOUZdguGb4NfV6y2R4xvG15V/COjx4RP27c/g5NXGz9McduQf9sMs3BB7IVDW
         Q9uw==
X-Gm-Message-State: AHQUAuaMs8+bboJBzH2kYxfqAKTF3wyfyLBjaPj3Xxb+ZMRr+vaBORkz
        mc3xiewnGqXuXb3mwRsA1g==
X-Google-Smtp-Source: AHgI3IaFicSapSdUOw0ukucd7Ph64OsJkdeg/IrILayZItk+kliq+QxtIGogA86jGKSjYE50zFwsrQ==
X-Received: by 2002:a9d:7f10:: with SMTP id j16mr3369379otq.297.1550856044187;
        Fri, 22 Feb 2019 09:20:44 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm738561otf.73.2019.02.22.09.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:20:43 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:20:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add Stingray USB PHY binding
 document
Message-ID: <20190222172042.GA6792@bogus>
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
 <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:04:00PM +0530, Srinath Mannam wrote:
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
> index 0000000..da19236
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> @@ -0,0 +1,62 @@
> +Broadcom Stingray USB PHY
> +
> +Required properties:
> + - compatible : should be one of the listed compatibles
> +	- "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
> +	- "brcm,sr-usb-hs-phy" has a single HS PHY.
> + - reg: offset and length of the PHY blocks registers
> + - address-cells: should be 1
> + - size-cells: should be 0
> +
> +Sub-nodes:
> +  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
> +
> +Sub-nodes required properties:
> + - reg: required for brcm,sr-usb-phy model PHY.
> +	reg value 0 is HS PHY and 1 is SS PHY.
> + - phy-cells: generic PHY binding; must be 0
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> +
> +Example:
> +	usbphy0: usb-phy@0 {
> +		compatible = "brcm,sr-usb-combo-phy";
> +		reg = <0x00000000 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usb0_phy0: phy@0 {
> +			reg = <0>;
> +			#phy-cells = <0>;
> +		};
> +
> +		usb0_phy1: phy@1 {
> +			reg = <1>;
> +			#phy-cells = <0>;
> +		};

Again, you don't need child nodes here. There are not any per child 
resources. Clients can refer to <&usbphy0 1> just as easily as 
<&usb0_phy1>. This is why we have #phy-cells.

Rob
