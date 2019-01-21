Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA833C2F42E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B78920823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548083663;
	bh=G64vV7dvXWzO/o7csCBWeO8I2p//Zg1uxVApHZY7Zyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H3kxdqW3uOnyLFjWdz/qBwXUlHz3X3DSWeEGlCn6nhG5zQBSaLmLSHIIS1hnR/KwP
	 eYNXp+5EPSRdyAqFAk+mFJYKlTscr8/Y33Wtq54CB1iMAqC9uT3UmjW2CoXuivVeMd
	 7f+vxvrB2CfI2pTDLqtb4itgdiRfqllqpvZqGJoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfAUPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:14:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40321 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbfAUPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:14:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so20792256oth.7;
        Mon, 21 Jan 2019 07:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7cQwgOzwHTBBe9OigdSs64Xc124Ms5HIy14iq0hpOUI=;
        b=Kt3FOfHT1XC5J5E34Rq+7/fT3YapA43iY9nhqTYnVnnkQsgaf47shXynQroJOz6RzY
         skkMFlUK6blTBtiuzBMKfDuPA4Qz5liCHyFMzQXNlyzS6Uc5IaSDcTCY7tDs03GcUkdj
         1i7WuLAEsNxMYXo4MfFs4jMFTUnE2/X3LBYN9mhZCrnfRqmwm9rveJc2qX36G88IdHKu
         CZbauCRUSuwDP+r8zMPqaGByK0yuu4mlSKMkphhzJ/uwqlgtfswk9zrASvEYFtLY+qAP
         IT3W0zwxrRPKEIC/g+fjooniSisIIKpEfMU1xVS4pX7zBhXkiXoB1ams2eYXQCVqnIQn
         csjQ==
X-Gm-Message-State: AJcUukfb1SMpwMo0wFxtb5kNiYj+gom6SoiM9Lnjthpv0gT8B5MyLrv1
        CqFr+4MQLMxdxPLi81ghdg==
X-Google-Smtp-Source: ALg8bN5uAkH+3RwXqkO0lWKozlSPvPSVjOpROU5sHqfkA/AYRjBUYRui9Ynrpo2cp5iVzbCU74mqeg==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr18894101otk.209.1548083658578;
        Mon, 21 Jan 2019 07:14:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm6098113oie.37.2019.01.21.07.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:14:18 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, hdegoede@redhat.com, tony@atomide.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190121151417.GA19238@bogus>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 08:22:26PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible

This is not what I said. I gave you the exact text to put.

> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..4305770
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,43 @@
> +MediaTek musb DRD/OTG controller
> +-------------------------------------------
> +
> +Required properties:
> + - compatible      : should be "mediatek,mtk-musb"
> + - reg             : specifies physical base address and size of
> +                     the registers
> + - interrupts      : interrupt used by musb controller
> + - interrupt-names : must be "mc"
> + - phys            : PHY specifier for the OTG phy
> + - dr_mode         : should be one of "host", "peripheral" or "otg",
> +                     refer to usb/generic.txt
> + - clocks          : a list of phandle + clock-specifier pairs, one for
> +                     each entry in clock-names
> + - clock-names     : must contain "main", "mcu", "univpll"
> +                     for clocks of controller
> +
> +Optional properties:
> + - extcon          : external connector for VBUS and ID pin changes detection,
> +                     needed when supports dual-role mode

Again, do not use extcon in new bindings.

> + - vbus-supply     : reference to the VBUS regulator, needed when supports
> +                     dual-role mode
> + - power-domains   : a phandle to USB power domain node to control USB's
> +                     MTCMOS
> +
> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb",
> +		     "mediatek,mtk-musb";
> +	reg = <0 0x11200000 0 0x1000>;
> +	interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "mc";
> +	phys = <&u2port2 PHY_TYPE_USB2>;
> +	vbus-supply = <&usb_vbus>;
> +	extcon = <&extcon_usb>;
> +	dr_mode = "otg";
> +	clocks = <&pericfg CLK_PERI_USB0>,
> +		 <&pericfg CLK_PERI_USB0_MCU>,
> +		 <&pericfg CLK_PERI_USB_SLV>;
> +	clock-names = "main","mcu","univpll";
> +	power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
